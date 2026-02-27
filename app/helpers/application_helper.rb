module ApplicationHelper
  def category_icon_name(category_name)
    name = category_name.to_s.downcase

    return "wrench" if name.match?(/tool|hardware|repair|service|maintenance/)
    return "hammer" if name.match?(/build|construction|carpentry|wood|civil/)
    return "bolt" if name.match?(/electrical|wire|cable|power|light/)
    return "droplets" if name.match?(/plumb|water|pipe|bath|sanitary/)
    return "paintbrush" if name.match?(/paint|finish|coating/)
    return "shield-check" if name.match?(/safety|security|protection/)
    return "drill" if name.match?(/machine|equipment|industrial/)

    "package"
  end
end
