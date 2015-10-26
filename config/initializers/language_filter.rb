$safe_filter = LanguageFilter::Filter.new()
$safe_filter.matchlist = File.join(Rails.root,"/dictionaries/nonos.yml")
$safe_filter.replacement = :garbled


@edgy_filter = LanguageFilter::Filter.new()
@edgy_filter.matchlist = File.join(Rails.root,"/dictionaries/edgy_nonos.yml")
@edgy_filter.replacement = :garbled
