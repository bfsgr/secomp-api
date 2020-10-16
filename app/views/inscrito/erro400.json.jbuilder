json.status "400"
json.erros do
    json.merge! @inscricao.errors
end
