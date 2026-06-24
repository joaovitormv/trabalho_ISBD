<?php

    header("Content-Type: text/html; charset=utf-8", true);

    $idRestaurante = "";
    $cnpjRestaurante = "";
    $nomeRestaurante = "";
    $logradouro = "";
    $cidade = "";
    $estado = "";
    $cep = "";
    $numero = "";
    $bairro = "";
    $complemento = "";

    $titulo_pagina = "Incluir Novo Restaurante";

    if (isset($_GET['id'])) {
        $idRestaurante = $_GET['id'];
        $titulo_pagina = "Editar Restaurante";

        include("config.php");
        $con = mysqli_connect($host, $login, $senha, $bd);

        $sql = "SELECT * FROM Restaurante WHERE idRestaurante = $idRestaurante";
        $resultado = mysqli_query($con, $sql);

        if ($dados = mysqli_fetch_assoc($resultado)) {
            $cnpjRestaurante = $dados['cnpjRestaurante'];
            $nomeRestaurante = $dados['nomeRestaurante'];
            $logradouro = $dados['logradouro'];
            $cidade = $dados['cidade'];
            $estado = $dados['estado'];
            $cep = $dados['cep'];
            $numero = $dados['numero'];
            $bairro = $dados['bairro'];
            $complemento = $dados['complemento'];
        }

        mysqli_close($con);
    }
?>

<!DOCTYPE html>
<html>

<head>
    <title><?php echo $titulo_pagina; ?></title>
</head>

<body>
    <h3 align="center"><?php echo $titulo_pagina; ?></h3>

    <form method="POST" action="salvar.php">

        <input type="hidden" name="idRestaurante" value="<?php echo $idRestaurante; ?>">

        <table border="0" align="center" width="50%">
            <tr>
                <td>Nome do Restaurante:</td>
                <td><input type="text" name="nomeRestaurante" value="<?php echo $nomeRestaurante; ?>" required></td>
            </tr>
            <tr>
                <td>CNPJ (apenas números):</td>
                <td><input type="text" name="cnpjRestaurante" value="<?php echo $cnpjRestaurante; ?>" maxlength="14"
                        required></td>
            </tr>
            <tr>
                <td>CEP:</td>
                <td><input type="text" name="cep" value="<?php echo $cep; ?>" maxlength="8" required></td>
            </tr>
            <tr>
                <td>Logradouro (Rua/Av):</td>
                <td><input type="text" name="logradouro" value="<?php echo $logradouro; ?>" required></td>
            </tr>
            <tr>
                <td>Número:</td>
                <td><input type="number" name="numero" value="<?php echo $numero; ?>" required></td>
            </tr>
            <tr>
                <td>Bairro:</td>
                <td><input type="text" name="bairro" value="<?php echo $bairro; ?>"></td>
            </tr>
            <tr>
                <td>Complemento:</td>
                <td><input type="text" name="complemento" value="<?php echo $complemento; ?>"></td>
            </tr>
            <tr>
                <td>Cidade:</td>
                <td><input type="text" name="cidade" value="<?php echo $cidade; ?>" required></td>
            </tr>
            <tr>
                <td>Estado (UF):</td>
                <td><input type="text" name="estado" value="<?php echo $estado; ?>" maxlength="2" required></td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <br>
                    <input type="submit" value="Salvar Dados">
                    <input type="button" value="Cancelar" onclick="location.href='index.php'">
                </td>
            </tr>
        </table>
    </form>
</body>

</html>