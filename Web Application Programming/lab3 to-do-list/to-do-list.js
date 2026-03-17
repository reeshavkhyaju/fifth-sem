const textInput = document.getElementById('text-input');
const form = document.getElementById('task-form');
const list = document.getElementById('taskList');

let tasks = [];

function loadTasks() {
    try { tasks = JSON.parse(localStorage.getItem('tasks')) || []; }
    catch { tasks = []; }
}

function saveTasks() { localStorage.setItem('tasks', JSON.stringify(tasks)); }

function update() { saveTasks(); renderTasks(); }

function createTaskElement(task, index) {
    const li = document.createElement('li');
    li.className = 'task' + (task.completed ? ' done' : '');

    const cb = document.createElement('input');
    cb.type = 'checkbox';
    cb.checked = !!task.completed;
    cb.addEventListener('change', () => {
        tasks[index].completed = cb.checked;
        update();
    });

    const span = document.createElement('span');
    span.className = 'task-text';
    span.textContent = task.text;
    span.title = 'Double-click to edit';

    const editBtn = document.createElement('button');
    editBtn.className = 'edit';
    editBtn.textContent = 'Edit';
    editBtn.addEventListener('click', () => {
        if (editBtn.textContent === 'Edit') {
            span.contentEditable = 'true';
            span.focus();
            editBtn.textContent = 'Save';
        } else {
            span.contentEditable = 'false';
            const newText = span.textContent.trim();
            if (!newText) tasks.splice(index, 1);
            else tasks[index].text = newText;
            editBtn.textContent = 'Edit';
            update();
        }
    });

    const delBtn = document.createElement('button');
    delBtn.className = 'delete';
    delBtn.textContent = 'Delete';
    delBtn.addEventListener('click', () => { tasks.splice(index, 1); update(); });

    li.append(cb, span, editBtn, delBtn);
    return li;
}

function renderTasks() {
    list.innerHTML = '';
    tasks.forEach((t, i) => list.appendChild(createTaskElement(t, i)));
}

function addTask(text) {
    const trimmed = (text || '').trim();
    if (!trimmed) { alert('Please enter a task'); return; }
    tasks.push({ text: trimmed, completed: false });
    update();
}

form.addEventListener('submit', (e) => {
    e.preventDefault();
    addTask(textInput.value);
    textInput.value = '';
    textInput.focus();
});

loadTasks();
renderTasks();