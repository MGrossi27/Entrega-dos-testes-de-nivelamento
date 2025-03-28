<template>
  <div class="container">
    <h1>Buscar Operadoras</h1>
    <div class="search-area">
      <input v-model="termoBusca" placeholder="Digite nome ou razão social" />
      <button @click="buscar">Buscar</button>
    </div>

    <table v-if="resultados.length">
      <thead>
        <tr>
          <th>Razão Social</th>
          <th>Nome Fantasia</th>
          <th>Registro ANS</th>
          <th>CNPJ</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(operadora, index) in resultados" :key="index">
          <td>{{ operadora.Razao_Social }}</td>
          <td>{{ operadora.Nome_Fantasia }}</td>
          <td>{{ operadora.Registro_ANS }}</td>
          <td>{{ operadora.CNPJ }}</td>
        </tr>
      </tbody>
    </table>

    <p v-else-if="buscou">Nenhum resultado encontrado.</p>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const termoBusca = ref('')
const resultados = ref([])
const buscou = ref(false)

const buscar = async () => {
  if (!termoBusca.value.trim()) return

  try {
    const res = await fetch(`http://localhost:5000/buscar?q=${termoBusca.value}`)
    resultados.value = await res.json()
    buscou.value = true
  } catch (error) {
    console.error('Erro ao buscar:', error)
  }
}
</script>

<style>
.container {
  max-width: 800px;
  margin: 40px auto;
  font-family: sans-serif;
}
.search-area {
  display: flex;
  gap: 10px;
  margin-bottom: 20px;
}
input {
  flex: 1;
  padding: 8px;
  font-size: 16px;
}
button {
  padding: 8px 16px;
  font-size: 16px;
}
table {
  width: 100%;
  border-collapse: collapse;
}
th, td {
  border: 1px solid #ccc;
  padding: 8px;
}
th {
  background-color: #1a1a1a;
}
</style>
