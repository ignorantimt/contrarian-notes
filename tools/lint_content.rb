#!/usr/bin/env ruby
# frozen_string_literal: true

require "date"
require "yaml"

POST_PATTERN = %r{\A_posts/\d{4}-\d{2}-\d{2}-.+\.(?:md|markdown)\z}
REQUIRED_FIELDS = %w[title description tags].freeze
CONTENT_GLOBS = ["_posts/*.{md,markdown}", "_drafts/*.{md,markdown}"].freeze

errors = []
slugs = {}

Dir.glob(CONTENT_GLOBS).sort.each do |path|
  source = File.read(path, encoding: "UTF-8")
  match = source.match(/\A---\s*\n(.*?)\n---\s*\n/m)

  unless match
    errors << "#{path}: missing YAML front matter"
    next
  end

  begin
    data = YAML.safe_load(
      match[1],
      permitted_classes: [Date, Time],
      aliases: true
    ) || {}
  rescue Psych::SyntaxError => e
    errors << "#{path}: invalid YAML (#{e.message.lines.first.strip})"
    next
  end

  REQUIRED_FIELDS.each do |field|
    value = data[field]
    errors << "#{path}: missing #{field}" if value.nil? || value.respond_to?(:empty?) && value.empty?
  end

  if path.start_with?("_posts/")
    errors << "#{path}: published filename must match YYYY-MM-DD-slug.md" unless POST_PATTERN.match?(path)
    errors << "#{path}: published posts require date" unless data.key?("date")
  end

  tags = data["tags"]
  errors << "#{path}: tags must be a non-empty YAML list" unless tags.is_a?(Array) && tags.any?

  description = data["description"].to_s.strip
  errors << "#{path}: description should be 20-180 characters" unless description.length.between?(20, 180)

  slug = File.basename(path).sub(/\A\d{4}-\d{2}-\d{2}-/, "").sub(/\.(?:md|markdown)\z/, "")
  if slugs.key?(slug)
    errors << "#{path}: duplicate slug '#{slug}' (already used by #{slugs[slug]})"
  else
    slugs[slug] = path
  end

  errors << "#{path}: contains known typo '蒂尔特尔'" if source.include?("蒂尔特尔")
end

if errors.any?
  warn errors.map { |error| "ERROR: #{error}" }.join("\n")
  exit 1
end

puts "Content lint passed (#{slugs.length} files)."
