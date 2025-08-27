const bcrypt = require('bcrypt');
const express = require('express');
const db = require('./db');
const app = express();
const PORT = 3000;

// Middleware para ler JSON
app.use(express.json());

// Rota de teste
app.get('/', (req, res) => {
  res.send('API rodando');
});

//------------------------------------------------
// Rotas para usuários

// create 
app.post('/usuario', async (req, res) => {
  const { email, senha } = req.body;

  if (!email || !senha) {
    return res.status(400).json({ error: 'email e senha são obrigatórios' });
  }

  const senhaHash = await bcrypt.hash(senha, 10);

  try {
    const [result] = await db.query('INSERT INTO usuarios (email, senha) VALUES (?, ?)', [email, senhaHash]);
    res.status(201).json({ id: result.insertId});
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Erro ao salvar no banco' });
  }
});

// delete
app.delete('/usuario/:id', async(req, res) => {
  const { id } = req.params;

  try {
    const [result] = await db.query('DELETE FROM `usuarios` WHERE id = (?)', [id]);
    
    if(result.affectedRows === 0){
      return res.status(404).json( { error: 'usuário não encontrado' })
    }

    res.status(200).json({ message: 'usuário deletado' });

  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Erro ao salvar no banco' });
  }
})

// atualizar senha
app.patch('/usuario/:id', async(req, res) => {
  const { id } = req.params;
  const { senha } = req.body;

  if (!senha) {
    return res.status(400).json({ error: 'Nenhum dado para atualizar' });
  }

  const senhaHash = await bcrypt.hash(senha, 10);

  const [result] = await db.query(`UPDATE usuarios SET senha = (?) WHERE id = (?)`, [senhaHash, id]);
  
  if (result.affectedRows === 0) {
    return res.status(404).json({ error: 'Usuário não encontrado' });
  }

  res.status(200).json({ message: 'Senha atualizada com sucesso' });
})

// -------------------------------------------
// Rota para login de usuário

// login
app.post('/login', async(req, res) => {
  const { email, senha } = req.body;
  
  if(!email || !senha){
    return res.status(400).json({error: 'email e senha são obrigatórios'})
  }
  
  try{
    const [rows] = await db.query('SELECT id, email, senha FROM `usuarios` WHERE `email` = (?) ', [email]);
    
    if(rows.length == 0){
      return res.status(401).json({error: 'Usuário não encontrado'});
    }

    const usuario = rows[0];
    const senhaValida = await bcrypt.compare(senha, usuario.senha);

    if(!senhaValida){
      return res.status(401).json({ error: 'senha incorreta'});
    }

    res.status(200).json({id: usuario.id, email: usuario.email})

  }catch (err){
    console.error(err);
    res.status(500).json({ error: 'Erro ao consultar o banco de dados' });
  }
})

// start do servidor

app.listen(PORT, () => {
  console.log(`Servidor rodando em http://localhost:${PORT}`);
});
