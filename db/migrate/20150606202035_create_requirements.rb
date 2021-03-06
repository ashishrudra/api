class CreateRequirements < ActiveRecord::Migration
  def change
    create_table(:requirements, { id: :uuid }) do |t|
      t.integer(:ordering, { default: 0, null: false })
      t.string(:name, { null: false })
      t.text(:description)
      t.timestamps({ null: false })

      t.belongs_to(:deliverable, { type: :uuid, index: true, foreign_key: true })
    end

    add_index(:requirements, :ordering)
  end
end
