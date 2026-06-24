<?php
header("Content-Type: text/html; charset=utf-8", true);
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trabalho</title>
</head>

<body>
    <h3 align="center">Lista de restaurantes</h3>
    <form name="form1" method="POST" action="form_incluir.php">
        <table border="1" align="center" width="80%">
            <?php
            include("config.php");

            $con = mysqli_connect($host, $login, $senha, $bd);

            if ($con) {
                echo "<p>BD conectado</p>";
            } else {
                echo "<p>BD não conectado</p>";
            }

            $sql = "SELECT * FROM Restaurante";
            $tabela = mysqli_query($con, $sql);

            if (mysqli_num_rows($tabela) == 0) {

                ?>
                <tr>
                    <td align="center">Não há nenhum restaurante cadastrado.</td>
                </tr>
                <tr>
                    <td align="center"><input type="submit" value="Incluir Restaurante"></td>
                </tr>
                <?php
            } else {
                ?>
                <tr bgcolor="lightgrey">
                    <td width="15%">CNPJ</td>
                    <td width="25%">Nome</td>
                    <td width="45%">Endereço completo</td>
                    <td width="15%">Ações</td>
                </tr>
                <?php
                while ($dados = mysqli_fetch_assoc($tabela)) {
                    $endereco = $dados['logradouro'] . ", " . $dados['numero'];
                    if (!empty($dados['complemento'])) {
                        $endereco = $endereco . " - " . $dados['complemento'];
                    }
                    $endereco = $endereco . " - " . $dados['bairro'] . ". " . $dados['cidade'] . "/" . $dados['estado'];

                    ?>
                    <tr>
                        <td align="center"> <?php echo $dados['cnpjRestaurante']; ?> </td>
                        <td><strong> <?php echo $dados['nomeRestaurante']; ?> </strong></td>
                        <td> <?php echo $endereco; ?> </td>
                        <td align="center">
                            <input type="button" value="Editar"
                                onclick="location.href='form_incluir.php?id=<?php echo $dados['idRestaurante']; ?>'">
                            <input type="button" value="Excluir" 
                            onclick="if(confirm('Tem certeza que deseja excluir o restaurante <?php echo $dados['nomeRestaurante']; ?>?')) { location.href='excluir.php?id=<?php echo $dados['idRestaurante']; ?>'; }">
                        </td>
                    </tr>
                    <?php
                }

                ?>
                <tr bgcolor="lightgrey">
                    <td colspan="4" height="5"></td>
                </tr>
                <tr>
                    <td colspan="4" align="center"><input type="submit" value="Incluir Novo Restaurante"></td>
                </tr>
                <?php
            }
            mysqli_close($con);
            ?>
        </table>
    </form>


</body>

</html>