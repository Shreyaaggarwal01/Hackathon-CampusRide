// Keep unfinished route forms on this device, separately for each local profile.
const draftFields=['from','fromCity','fromState','fromZip','to','toCity','toState','toZip','date','seats','radius','dFrom','dCity','dState','dZip','dTo','dToCity','dToState','dToZip','dDate','dTime','dCar','dColor','dSeats','dLuggage','dRadius','dPrice'];
function routeDraftKey(){return 'ridelink_route_draft:'+String(profileData.email||'local').trim().toLowerCase()}
let savedDraft={};try{savedDraft=JSON.parse(localStorage.getItem(routeDraftKey())||'{}')||{}}catch(e){}
for(const id of draftFields){let el=$(id);if(!el)continue;if(typeof savedDraft[id]==='string')el.value=savedDraft[id];el.addEventListener('input',saveRouteDraft);el.addEventListener('change',saveRouteDraft)}
function saveRouteDraft(){let draft={};for(const id of draftFields)if($(id))draft[id]=$(id).value;try{localStorage.setItem(routeDraftKey(),JSON.stringify(draft))}catch(e){}}
if(profileData.car&&!$('dCar').value)$('dCar').value=profileData.car;
if(profileData.color&&!$('dColor').value)$('dColor').value=profileData.color;
if(profileData.carPhoto){carImage=profileData.carPhoto;const note=document.createElement('p');note.className='note';note.textContent='Your saved car photo is available on this device. Upload a new one to replace it.';$('dPhoto').closest('.field').appendChild(note)}
$('radiusValue').textContent=$('radius').value+' miles';
const resetFiltersBeforeMemory=resetRideFilters;resetRideFilters=function(){resetFiltersBeforeMemory();saveRouteDraft()};

const clearSearch=document.createElement('button');clearSearch.type='button';clearSearch.className='secondary';clearSearch.textContent='Clear search';clearSearch.onclick=()=>resetRideFilters();$('search').insertAdjacentElement('afterend',clearSearch);
