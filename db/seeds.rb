if Announcement.count.zero?
  Announcement.create(
    title: "Product has launched!",
    author_name: "admin",
    published_at: 1.week.ago,
    body: "This product has now launched! That's AMAZING!",
  )

  Announcement.create(
    title: "For a better world",
    author_name: "Thought Leader",
    published_at: 1.day.ago,
    body: "Let's make the world a better place - together! One announcement at a time.",
  )
end
