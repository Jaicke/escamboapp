prawn_document do |pdf|
    pdf.text "Hello World"
    pdf.table @categories.collect{ |p| [p.id, p.description] }
end