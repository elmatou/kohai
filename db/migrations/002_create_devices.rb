Sequel.migration do
  up do
    create_table :devices do
      primary_key :id
      String :class_name, null: false
      String :create_options, null: false
      DateTime :created_at, default: Sequel::CURRENT_TIMESTAMP, :index=>true
    end
  end

  down do
    drop_table(:devices)
  end
end
