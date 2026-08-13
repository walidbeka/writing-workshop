function doPost(e){
const ss=SpreadsheetApp.getActiveSpreadsheet(),sh=ss.getSheetByName("Registrations")||ss.insertSheet("Registrations");
if(sh.getLastRow()===0)sh.appendRow(["Timestamp","Course","Name","Phone","Email","Age","City","Experience","Interest","Source"]);
const d=JSON.parse(e.postData.contents||"{}");
sh.appendRow([new Date(),d.course||"",d.name||"",d.phone||"",d.email||"",d.age||"",d.city||"",d.experience||"",d.interest||"",d.source||""]);
return ContentService.createTextOutput(JSON.stringify({ok:true})).setMimeType(ContentService.MimeType.JSON);
}