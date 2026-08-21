// Programa de teste em Rust para a Parte 1

fn calcular_media(nota1: f64, nota2: f64) -> f64 {
    let media = (nota1 + nota2) / 2.0;
    return media;
}

fn main() {
    let nome_aluno = "Carlos";
    let nota_prova1 = 8.5;
    let nota_prova2 = 7.0;
    let aprovado = true;

    let media_final = calcular_media(nota_prova1, nota_prova2);

    if media_final >= 7.0 && aprovado {
        println!("Aluno {} aprovado com media: {}", nome_aluno, media_final);
    } else {
        println!("Aluno em recuperação!");
    }
}