Sequel.migration do
  up do
    create_table :meters do
      primary_key :id
      String :name
      Float :multiplier, default: 1, null: false
      String :unit
      TrueClass :totalizer, default: false
      String :source
      String  :buffer, text: true
      DateTime :created_at, default: Sequel::CURRENT_TIMESTAMP, :index=>true
    end

    create_table :indices do
      foreign_key :meter_id, :meters
      BigDecimal :value, size: [9, 3], null: false
      DateTime :created_at, default: Sequel::CURRENT_TIMESTAMP, :index=>true
      index :meter_id
    end
  end

  down do
    drop_table(:indices)
    drop_table(:meters)
  end
end
