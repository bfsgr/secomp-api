require 'test_helper'

class InscricaoTest < ActiveSupport::TestCase
  test "Inscrição correta" do
    i = Inscricao.new(
      nome: "João Siva",
      email: "example@example.com",
      cpf: "739.366.869-63",
      telefone: "(44) 99825-6300")
    assert i.save
  end

  test "Inscrição incorreta - Email não único" do
    Inscricao.create(
      nome: "João Siva",
      email: "example@example.com",
      cpf: "739.366.869-63",
      telefone: "(44) 99825-6300")

    i = Inscricao.new(
      nome: "João da Siva",
      email: "example@example.com",
      cpf: "401.766.664-78",
      telefone: "(44) 99899-6300")
    assert_not i.save
  end

  test "Inscrição incorreta - CPF não único" do
    Inscricao.create(
      nome: "João Siva",
      email: "example@example.com",
      cpf: "739.366.869-63",
      telefone: "(44) 99825-6300")
    i = Inscricao.new(
      nome: "João da Siva",
      email: "example1@example.com",
      cpf: "739.366.869-63",
      telefone: "(44) 99899-6300")
    assert_not i.save
  end

  test "Inscrição correta - com RA" do
    i = Inscricao.new(
      nome: "João Siva",
      email: "example@example.com",
      cpf: "739.366.869-63",
      telefone: "(44) 99825-6300",
      ra: "550077")
    assert i.save
  end

  test "Inscrição incorreta - Nome" do
    i = Inscricao.new(
      nome: "",
      email: "example@example.com",
      cpf: "739.366.869-63",
      telefone: "(44) 99825-6300")
    assert_not i.save
  end

  test "Inscrição incorreta - Email" do
    i = Inscricao.new(
      nome: "João Silva",
      email: "example@aaa@home.com",
      cpf: "739.366.869-63",
      telefone: "(44) 99825-6300")
    assert_not i.save
  end 
  test "Inscrição incorreta - CPF" do
    i = Inscricao.new(
      nome: "João Silva",
      email: "example@example.com",
      cpf: "739.367.869-63",
      telefone: "(44) 99825-6300")
    assert_not i.save
  end

  test "Inscrição incorreta - Telefone" do
    i = Inscricao.new(
      nome: "João Silva",
      email: "example@example.com",
      cpf: "739.366.869-63",
      telefone: "+1 (44) 99825-6300")  
    assert_not i.save
  end

  test "Inscrição incorreta - RA" do
    i = Inscricao.new(
      nome: "João Silva",
      email: "example@example.com",
      cpf: "739.366.869-63",
      telefone: "(44) 99825-6300",
      ra: "52")
    assert_not i.save
  end
end
