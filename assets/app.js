const state={items:[],lang:document.documentElement.lang.startsWith('zh')?'zh':'en'};
const $=s=>document.querySelector(s);
const esc=s=>String(s??'').replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]));
const text=(zh,en)=>state.lang==='zh'?zh:en;
function fmt(n){return new Intl.NumberFormat(state.lang==='zh'?'zh-CN':'en-US',{notation:n>=10000?'compact':'standard',maximumFractionDigits:1}).format(n||0)}
function render(){
 const q=$('#search').value.trim().toLowerCase(); const cat=$('#category').value; const sort=$('#sort').value;
 let xs=state.items.filter(r=>(!cat||r.category===cat)&&(!q||JSON.stringify(r).toLowerCase().includes(q)));
 xs.sort((a,b)=>sort==='score'?b.recommendation-a.recommendation:sort==='updated'?String(b.updated_at).localeCompare(String(a.updated_at)):b.stars-a.stars);
 $('#count').textContent=xs.length;
 $('#cards').innerHTML=xs.map((r,i)=>`<article class="card"><div class="cardhead"><div><div class="rank">#${i+1} · ${esc(r.category)}</div><h3><a href="${esc(r.url)}" target="_blank" rel="noopener">${esc(r.repo)}</a></h3></div><div class="stars">★ ${fmt(r.stars)}</div></div><p>${esc(state.lang==='zh'?r.focus_zh:r.focus_en)}</p><p class="muted"><b>${text('最适合：','Best for:')}</b> ${esc(state.lang==='zh'?r.best_zh:r.best_en)}</p><div class="tags">${(r.supports||[]).map(x=>`<span class="tag">${esc(x)}</span>`).join('')}</div><div class="proscons"><div><h4>${text('优势','Strengths')}</h4><ul>${(state.lang==='zh'?r.strengths_zh:r.strengths_en).map(x=>`<li>${esc(x)}</li>`).join('')}</ul></div><div><h4>${text('局限','Limitations')}</h4><ul>${(state.lang==='zh'?r.limits_zh:r.limits_en).map(x=>`<li>${esc(x)}</li>`).join('')}</ul></div></div><p class="meta">${text('许可证','License')}: ${esc(r.license)} · Forks ${fmt(r.forks)} · <span class="score">${r.recommendation.toFixed(1)}/5</span></p></article>`).join('');
}
async function main(){
 const base=location.pathname.includes('/en/')?'../':''; const res=await fetch(base+'data/repositories.json'); state.items=await res.json();
 const cats=[...new Set(state.items.map(x=>x.category))].sort(); $('#category').innerHTML=`<option value="">${text('全部类型','All categories')}</option>`+cats.map(x=>`<option>${esc(x)}</option>`).join('');
 $('#total').textContent=state.items.length; $('#starsTotal').textContent=fmt(state.items.reduce((s,x)=>s+(x.stars||0),0)); $('#skillsTotal').textContent=document.querySelectorAll('.skill-name').length; $('#updated').textContent=state.items.map(x=>x.last_checked).sort().at(-1)||'—';
 ['search','category','sort'].forEach(id=>$('#'+id).addEventListener(id==='search'?'input':'change',render)); render();
}
main().catch(e=>{$('#cards').innerHTML=`<p>${text('无法读取仓库数据：','Unable to load repository data:')} ${esc(e.message)}</p>`});
