#!/bin/bash 

curl -X POST  http://dpi-manager.mediaiqdigital.com/svc/act/v1.0.0/activation -H 'authorization:  Bearer eyJhbGciOiJSUzI1NiJ9.eyJleHAiOjE3NDA5OTU5NjksInNjb3BlIjpbIk5BIl0sImF1ZCI6WyJkcGktbWFuYWdlciJdLCJqdGkiOiI4YjJjYzgzOS1hYjkyLTQ4MDUtOWNkNy02MTM2MGMxZWU4ZjgiLCJjbGllbnRfaWQiOiJkcGktbWFuYWdlci1jbGllbnQifQ.RqKc4GNTsMV1URxB_EQwTcCiVEb-aq9ePgaMRUEs0sQ_NE0dbf151dk6LikBlV7ZBfv0rBTi0Ah6ZQzrr7RYz_75-k0C9NCA_zNu77FwicM4Uohj484nqbM5tHHM1o6HYj0I1ek3A_dlONdgfr7S0XG-XaYJoNyyKrIi17hoEPC080eZM-_HcJOXEHcQiMQXJzbfZ6XPli4GIonMgOhVd2il8SsB4-4hFmRdmBJVM75APCL80Ym3uNPQq8PL5vzPm3UgyAsVhxjcHfE_RLDWd0tzV3rFwPFhEIvXkaSDp8GtkgJ_3XWBdTJMQWk0GXWSWgBLCUBDR3irY6eTouBMYA' -H 'cache-control: no-cache' -H 'content-type: application/json' -H 'postman-token: 7ec8e38e-b935-2a1f-d47e-a4cbf2309943' -d '{"id": "12863221-UK_Westgate_Postcode",
"connection":{
"connection_protocol": "s3",
"platform": "s3",
"authmethod":"secret",
"status": "VALID",
"version":10,
"credential_details": {
"access_key":"AKIAIVW7UHPXSHE5W42Q",
"secret_key": "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",
"bucket": "miq-activation"
																																			}
																																		},
																																		"metadata": {
																																		"content_type":"tsv",
																																		"query_mapping": {
																																		"message": "Please check modifiers as well.",
																																		"delete_on_apn": "true"
																																	},

																																	"schema": [{
																																	"name": "feature"
																																},{
																																"name": "segmentId"
																															},{
																															"name": "modifierValue"
																														},{
																														"name": "dataCenter"
																													},{
																													"name": "isAutomatic"
																												},{
																												"name":"featureValue"
																											},{
																											"name": "ttl"
																										}]
																									},
																									"resource_type": "REMOTE",
																									"resource":"UK_Westgate_Postcode"
																								}'


																		
