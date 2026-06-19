<?php
    include("config.php");
    $con = mysqli_connect($host, $login, $senha, $bd);

    $idRestaurante = $_POST['idRestaurante'];
    $nomeRestaurante = $_POST['nomeRestaurante'];
    $cnpjRestaurante = $_POST['cnpjRestaurante'];
    $cep = $_POST['cep'];
    $logradouro = $_POST['logradouro'];
    $numero = $_POST['numero'];
    $bairro = $_POST['bairro'];
    $complemento = $_POST['complemento'];
    $cidade = $_POST['cidade'];
    $estado = $_POST['estado'];

    if (empty($idRestaurante)) {
        $sql = "INSERT INTO Restaurante (cnpjRestaurante, nomeRestaurante, logradouro, cidade, estado, cep, numero, bairro, complemento) 
                VALUES ('$cnpjRestaurante', '$nomeRestaurante', '$logradouro', '$cidade', '$estado', '$cep', $numero, '$bairro', '$complemento')";
    } else {
        $sql = "UPDATE Restaurante SET 
                    cnpjRestaurante = '$cnpjRestaurante', 
                    nomeRestaurante = '$nomeRestaurante', 
                    logradouro      = '$logradouro', 
                    cidade          = '$cidade', 
                    estado          = '$estado', 
                    cep             = '$cep', 
                    numero          = $numero, 
                    bairro          = '$bairro', 
                    complemento     = '$complemento' 
                WHERE idRestaurante = $idRestaurante";
    }

    mysqli_query($con, $sql);

    mysqli_close($con);

    header("Location: index.php");
    exit;
?>