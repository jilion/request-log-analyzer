amount = $arguments[:amount] || 10
puts
puts "Top #{amount} worst DB offenders - cumulative time"
puts "========================================================================"
print_table($summarizer, :total_db_time, amount)
