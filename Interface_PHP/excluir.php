<?php
    $idParaDeletar = $_GET['id'];

    include("config.php");
    $con = mysqli_connect($host, $login, $senha, $bd);

    $sql = "DELETE FROM Restaurante WHERE idRestaurante = $idParaDeletar";

    mysqli_query($con, $sql);

    mysqli_close($con);

    header("Location: index.php");
    exit;
?>