import sdk from '@crossmarkio/sdk';
 
let { request, response, createdAt, resolvedAt } = await sdk.methods.signInAndWait();
 
// log address
console.log(response.data.address);