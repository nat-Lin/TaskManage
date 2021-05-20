user = User.find_by(name: 'test')
['undone', 'execute', 'finish'].each_with_index do |status, index|
  3.times do |t|
    user.tasks.create(
      title: "測試任務_#{status}_#{t}", 
      notes: "測試內容_#{status}_#{t}", 
      start_time: rand(4.days..5.days).seconds.ago,
      end_time: rand(-5.days..-4.days).seconds.ago,
      status: status
    )
  end
end