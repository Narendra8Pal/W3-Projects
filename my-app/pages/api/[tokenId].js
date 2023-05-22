
//Base URI + TokenId
// Base URI = https://example.com/
// TokenID = 1

// tokenURI(1) = https://example.com/1
// tokenURI(2) = https://example.com/2

export default function handler (req, res) {
const tokenId = req.query.tokenId;
// res.status(200).json({
//     tokenId: tokenId,
// })

const name = `NFT Dev #${tokenId}`;
const description = "NFT Devs is my first collection on Open Sea isn't it crazy"
//image is uploaded on ipfs
const image = `https://ipfs.io/ipfs/QmQBHarz2WFczTjz5GnhjHrbUPDnB48W5BM2v2h6HbE1rZ/${tokenId}.png`

return res.json({
    name: name, 
    description: description,
    image: image,
})
}