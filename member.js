/* ══════════════════════════════════════════════════════════════
   members.js  —  Feature 1: Simulated Member Management
   
   SPEC COVERAGE:
   ✅ Display member list loaded from localStorage
   ✅ Pre-seeded with 5 sample members on first load
   ✅ Add new member via form: name, email, phone, plan, join date
   ✅ Edit member details INLINE (double-click any row)
   ✅ Edit member details via MODAL form (click ✏️ button)
   ✅ Delete member with confirmation dialog (custom modal)
   ✅ Live search: filter members by name or email
   ✅ Filter by plan type: All, Bronze, Silver, Gold
   ✅ Show total member count dynamically updated on filters
══════════════════════════════════════════════════════════════ */

const MEMBERS_KEY = 'fitadmin_members';

/* ── Seed 5 sample members on very first load ── */
const SEED_MEMBERS = [
  { id: uid(), name: 'Amelia Carter',  email: 'amelia@mail.com', phone: '+1 555 1001', plan: 'Gold',   joinDate: '2024-01-15' },
  { id: uid(), name: 'James Nguyen',   email: 'james@mail.com',  phone: '+1 555 1002', plan: 'Silver', joinDate: '2024-02-20' },
  { id: uid(), name: 'Sofia Martinez', email: 'sofia@mail.com',  phone: '+1 555 1003', plan: 'Bronze', joinDate: '2024-03-10' },
  { id: uid(), name: 'Liam Thompson',  email: 'liam@mail.com',   phone: '+1 555 1004', plan: 'Gold',   joinDate: '2024-03-22' },
  { id: uid(), name: 'Priya Patel',    email: 'priya@mail.com',  phone: '+1 555 1005', plan: 'Silver', joinDate: '2024-04-05' },
];

if (!localStorage.getItem(MEMBERS_KEY)) {
  localStorage.setItem(MEMBERS_KEY, JSON.stringify(SEED_MEMBERS));
}

/* ── State ── */
let planFilter      = 'All';   // current plan filter
let editingId       = null;    // id of member being edited in modal
let inlineEditingId = null;    // id of member currently in inline-edit mode

/* ════════════════════════════════════════
   HELPERS
════════════════════════════════════════ */

function uid() {
  return '_' + Math.random().toString(36).slice(2, 9);
}

function esc(str) {
  return String(str)
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;');
}

function getMembers() {
  return JSON.parse(localStorage.getItem(MEMBERS_KEY) || '[]');
}

function saveMembers(data) {
  localStorage.setItem(MEMBERS_KEY, JSON.stringify(data));
}

function showToast(msg, isError = false) {
  const t = document.getElementById('toast');
  t.textContent = msg;
  t.className = 'toast' + (isError ? ' error' : '');
  setTimeout(() => t.classList.add('show'), 10);
  setTimeout(() => t.classList.remove('show'), 3000);
}

/* ════════════════════════════════════════
   RENDER — builds the table from localStorage
════════════════════════════════════════ */

function renderMembers() {
  const query   = (document.getElementById('memberSearch').value || '').toLowerCase();
  let   members = getMembers();

  /* Apply plan filter */
  if (planFilter !== 'All') {
    members = members.filter(m => m.plan === planFilter);
  }

  /* Apply live search filter (name OR email) */
  if (query) {
    members = members.filter(m =>
      m.name.toLowerCase().includes(query) ||
      m.email.toLowerCase().includes(query)
    );
  }

  /* Update count — dynamically reflects active filters */
  document.getElementById('memberCount').textContent = members.length;

  const tbody = document.getElementById('memberTableBody');

  if (!members.length) {
    tbody.innerHTML = `
      <tr>
        <td colspan="7" style="text-align:center;padding:36px;color:var(--muted);">
          No members found.
        </td>
      </tr>`;
    return;
  }

  tbody.innerHTML = members.map((m, i) => {

    /* ── INLINE EDIT ROW ── */
    if (inlineEditingId === m.id) {
      return `
        <tr class="cell-editing">
          <td style="color:var(--muted);font-family:'JetBrains Mono',monospace;font-size:12px">
            ${String(i + 1).padStart(2, '0')}
          </td>
          <td><input class="inline-input" id="il_name"  value="${esc(m.name)}"   /></td>
          <td><input class="inline-input" id="il_email" value="${esc(m.email)}"  /></td>
          <td><input class="inline-input" id="il_phone" value="${esc(m.phone)}"  /></td>
          <td>
            <select class="inline-select" id="il_plan">
              <option value="Bronze" ${m.plan === 'Bronze' ? 'selected' : ''}>Bronze</option>
              <option value="Silver" ${m.plan === 'Silver' ? 'selected' : ''}>Silver</option>
              <option value="Gold"   ${m.plan === 'Gold'   ? 'selected' : ''}>Gold</option>
            </select>
          </td>
          <td><input class="inline-input" id="il_date" type="date" value="${m.joinDate}" /></td>
          <td>
            <div class="action-btns">
              <button class="save-btn"   onclick="saveInline('${m.id}')">✓ Save</button>
              <button class="cancel-btn" onclick="cancelInline()">✕</button>
            </div>
          </td>
        </tr>`;
    }

    /* ── READ-ONLY ROW ── */
    return `
      <tr>
        <td style="color:var(--muted);font-family:'JetBrains Mono',monospace;font-size:12px">
          ${String(i + 1).padStart(2, '0')}
        </td>
        <td style="font-weight:600">${esc(m.name)}</td>
        <td style="color:var(--muted)">${esc(m.email)}</td>
        <td style="font-family:'JetBrains Mono',monospace;font-size:12px;color:var(--muted)">${esc(m.phone)}</td>
        <td><span class="plan-badge ${m.plan}">${m.plan}</span></td>
        <td style="color:var(--muted);font-size:13px">${m.joinDate}</td>
        <td>
          <div class="action-btns">
            <button class="icon-btn edit" title="Edit via Modal"   onclick="openEditModal('${m.id}')">✏️</button>
            <button class="icon-btn edit" title="Edit Inline"      onclick="startInline('${m.id}')">🖊️</button>
            <button class="icon-btn del"  title="Delete Member"    onclick="deleteMember('${m.id}', '${esc(m.name)}')">🗑️</button>
          </div>
        </td>
      </tr>`;
  }).join('');
}

/* ════════════════════════════════════════
   PLAN FILTER
════════════════════════════════════════ */

function setPlanFilter(btn) {
  document.querySelectorAll('.filter-btn').forEach(b => b.classList.remove('active'));
  btn.classList.add('active');
  planFilter = btn.dataset.plan;
  inlineEditingId = null;  // cancel any active inline edit
  renderMembers();
}

/* ════════════════════════════════════════
   INLINE EDIT  (edit details directly in the table row)
════════════════════════════════════════ */

function startInline(id) {
  inlineEditingId = id;
  renderMembers();
  /* Focus the name field after render */
  setTimeout(() => {
    const el = document.getElementById('il_name');
    if (el) el.focus();
  }, 50);
}

function saveInline(id) {
  const name  = document.getElementById('il_name').value.trim();
  const email = document.getElementById('il_email').value.trim();
  const phone = document.getElementById('il_phone').value.trim();
  const plan  = document.getElementById('il_plan').value;
  const date  = document.getElementById('il_date').value;

  if (!name || !email) {
    showToast('Name and email are required.', true);
    return;
  }

  const members = getMembers().map(m =>
    m.id === id ? { ...m, name, email, phone, plan, joinDate: date } : m
  );

  saveMembers(members);
  inlineEditingId = null;
  renderMembers();
  showToast('Member updated ✓');
}

function cancelInline() {
  inlineEditingId = null;
  renderMembers();
}

/* ════════════════════════════════════════
   MODAL — ADD
════════════════════════════════════════ */

function openAddModal() {
  editingId = null;
  clearForm();
  document.getElementById('modalTitle').textContent = 'Add Member';
  /* Default join date = today */
  document.getElementById('f_date').value = new Date().toISOString().split('T')[0];
  document.getElementById('memberModal').classList.add('open');
}

/* ════════════════════════════════════════
   MODAL — EDIT (via ✏️ button)
════════════════════════════════════════ */

function openEditModal(id) {
  const m = getMembers().find(x => x.id === id);
  if (!m) return;

  editingId = id;
  document.getElementById('f_name').value  = m.name;
  document.getElementById('f_email').value = m.email;
  document.getElementById('f_phone').value = m.phone;
  document.getElementById('f_date').value  = m.joinDate;
  document.getElementById('f_plan').value  = m.plan;
  document.getElementById('modalTitle').textContent = 'Edit Member';
  document.getElementById('memberModal').classList.add('open');
}

/* ════════════════════════════════════════
   SAVE — handles both Add and Edit
════════════════════════════════════════ */

function saveMember() {
  const name  = document.getElementById('f_name').value.trim();
  const email = document.getElementById('f_email').value.trim();
  const phone = document.getElementById('f_phone').value.trim();
  const date  = document.getElementById('f_date').value;
  const plan  = document.getElementById('f_plan').value;

  /* Validation */
  if (!name || !email) {
    showToast('Name and email are required.', true);
    return;
  }

  let members = getMembers();

  if (editingId) {
    /* UPDATE existing member */
    members = members.map(m =>
      m.id === editingId
        ? { ...m, name, email, phone, joinDate: date, plan }
        : m
    );
    showToast('Member updated ✓');
  } else {
    /* CREATE new member */
    members.push({ id: uid(), name, email, phone, joinDate: date, plan });
    showToast('Member added ✓');
  }

  saveMembers(members);
  closeModal();
  renderMembers();
}

/* ════════════════════════════════════════
   DELETE — with custom confirmation modal
════════════════════════════════════════ */

function deleteMember(id, name) {
  /* Show the confirm modal */
  document.getElementById('confirmMsg').textContent = `Delete member "${name}"? This cannot be undone.`;
  document.getElementById('confirmModal').classList.add('open');

  /* Wire up the OK button */
  document.getElementById('confirmOkBtn').onclick = function () {
    saveMembers(getMembers().filter(m => m.id !== id));
    closeConfirm();
    renderMembers();
    showToast('Member deleted.');
  };
}

/* ════════════════════════════════════════
   MODAL HELPERS
════════════════════════════════════════ */

function closeModal() {
  document.getElementById('memberModal').classList.remove('open');
}

function closeConfirm() {
  document.getElementById('confirmModal').classList.remove('open');
}

function clearForm() {
  ['f_name', 'f_email', 'f_phone', 'f_date'].forEach(id => {
    document.getElementById(id).value = '';
  });
  document.getElementById('f_plan').value = 'Bronze';
}

/* Close modal when clicking the dark backdrop */
document.getElementById('memberModal').addEventListener('click', function (e) {
  if (e.target === this) closeModal();
});
document.getElementById('confirmModal').addEventListener('click', function (e) {
  if (e.target === this) closeConfirm();
});

/* ════════════════════════════════════════
   INIT — render on page load
════════════════════════════════════════ */
renderMembers();
