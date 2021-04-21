3.times do |index|  
  Task.create!( 
    title: "測試任務_#{index}", 
    notes: "測試內容_#{index}", 
    start_time: 1.day.ago, 
    end_time: 3.day.ago
  )
end