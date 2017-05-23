Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 May 2017 23:42:36 +0200 (CEST)
Received: from mail-bn3nam01on0071.outbound.protection.outlook.com ([104.47.33.71]:26256
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994924AbdEWVm2kMwJc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 23 May 2017 23:42:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=XC00+M+FOdPOovx2I088McB7YHpvA39xbULjJSyY5hI=;
 b=VrFLt3Sk8XaEvJHgFQ/rRvrEfRLfMrSFFYm9EElPJtiziOi9rCmafpwrhMt3SeH7fRIDaMwfYYkTzywXK904O8SpIAo9ZNleWq/WTNEmaeV04JW6G40xn6/fC/Wlqv7Lmll5gXFn4GqzVljD4A82qc3yBABfp4KVoGClHGa159k=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=caviumnetworks.com;
Received: from ddl.caveonetworks.com (50.233.148.156) by
 BN6PR07MB3489.namprd07.prod.outlook.com (10.161.153.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1101.14; Tue, 23 May 2017 21:42:23 +0000
Subject: Re: [PATCH] MIPS: Octeon: Delete an error message for a failed memory
 allocation in octeon_irq_init_gpio()
To:     Joe Perches <joe@perches.com>,
        SF Markus Elfring <elfring@users.sourceforge.net>,
        linux-mips@linux-mips.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        David Daney <david.daney@cavium.com>,
        =?UTF-8?Q?Ralf_B=c3=a4chle?= <ralf@linux-mips.org>,
        "Steven J. Hill" <steven.hill@cavium.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <7995eb17-f2ec-54ad-f4d4-7b3dd8337d33@users.sourceforge.net>
 <1495565752.2093.69.camel@perches.com>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <b27dc33b-c9c8-fb41-7fbc-00cd18cf202b@caviumnetworks.com>
Date:   Tue, 23 May 2017 14:42:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <1495565752.2093.69.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BN6PR07CA0003.namprd07.prod.outlook.com (10.173.33.141) To
 BN6PR07MB3489.namprd07.prod.outlook.com (10.161.153.28)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR07MB3489:
X-MS-Office365-Filtering-Correlation-Id: ccdbc4aa-87a1-4f86-dc69-08d4a22499c9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(201703131423075)(201703031133081);SRVR:BN6PR07MB3489;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3489;3:fQBZ6enThCICJdXhRIsbwBNA63xFuq9/Z0Iu/Vgpvybdad3WtH1HjY/LH7JORx4COZGEn8YGxy/5cV6m4QoL3AQ1zm0zhoI/0Qx1Mz4IS5KqclJHVG2zudnxRJlVIfUzxA9WfUgGi1tnN7xZWvtaQRoF2pMOkaECY0AUrIGEtWP2SmM41layZcMLgvdZJOxBZEzzFTfnj8i7LNl6vG0lXLjnYsc6AENNHajZgTjUEqhpkeQUmWXTm24Cq1CKE4uK7F4Wcv/Y82MB7qjhPBpasmduVIwF/ydaqygRZhfU/ivQTXNCO5nEJX0S7khjg/eVYAlehiinCO/fT2xpCrVjXQ==;25:bvVek6nRi1pHHMbSNA7oeqLq8d2pO5yVJ1N9Eq+1zNzJxN3wFKkqLNSSTodO7GfhUCh2Ec7/PBl5hT3bnwvZmxnqechldlccp4TOloUsW8++v/EOmRx9QSkx8tvwQwvh4WV8OWkpj1/19znG4BwBk2BiNJBzPTFAdMdJ4opv9YWYo2UlDNELPh0xpuoRmP8qQm2b7RVgFKNAd1XKwUrKWHiG8MPEWuxrjPEANvczeXZ1SOx85RGYqQJzBHXjHd2WPszOvycvFdxA60gNCK9rLL4pmy7WcJdmwnrjlxpK0Ac4BddU0Nu1RV8xhivyWyWrwUYOWda36s+A2aCFvMPpOApTH/wA7deZq4iHehVf7qs1FumaZtb3hDyehkaDxYOy/HAG/HQRPbBP5vZXC71t32Zci1/Ywozzs0PaHkDd1fenDBxnuAEH/urk2VFd99sCW619HTVjBJSz/UHdrRRd6Wp2t7IEyZ/px58VEwvefZs=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3489;31:WqUDL9wVjfj+/PnaIb04ehrwqli8+J7FPp+zkpdSvlw9YtZxcCaybOl8OHCQCAzc4e5XOZ6OIK9HiEsSP3xg3RrwPxWjYqUX+rsTrDE5Bgt2idBLidgJpftg83sbIi2ETUznFLgtEi5VhrCSWD/q/esJLMgTggkxZkEODvNGTbMPrObUiW3A/va9UvUGJlL/GX2rdTA9zB5eno9W6jOWeeCwHHQGwzUciKlAvPHiclQ=;20:IRUS4HVMJrfWMwDwiDU2mKs6ZH38xTjK1C0s/9zqHkA8q33lTDnzOyPOHVC7jEWpE78LzKRWhHSCyobGq1d3Dr5bkGd6j767uszjgFNCFtzUBnB78zC01cTfSydf+uJc+FWMgfoA0glNGgze+HrreIZbUjTXyQUjqKPy1HTmCQDCS6hQR7sX7KCVTHnouPkKi5IVDGhYnoMjqAwCnQXvETK/AtkGxap0fLHaPW1iwCypIi2xI3qBZXqb0UblXbEg6jnZ1l/+BGRDn0g6XxGbuwBAxpjuptzPlaqFPTZfxXeKnoiVIbPJlgnfxyNIKYxDviVYifCoaBH5rvuGOliS5P7Mt02ffYm+jmfiwMac26f1DwF/WPbMpVvjmH0y1pglV5QEjwcZGaVUos+R6U5OGQYxJMFlbHzZ3gysZGrDzohvZ2DEqBvtUJrpKjYPQNI0CAEITBwCCtoM3HC2K4jXvah6Ik78KmUGCy0PeDDLsXxCKD6NH0qxUa/p5jfF+0NDDYZH2B/dZ2lUWpOrbspIICaT7OMI4dS74jjCpunqsK8LcGSzJtTQj1mSiGZUrLgB7i1HPD7fzJyzYbjAfi3j2cZJLbzGP9jDkSbLRcuRC6U=
X-Microsoft-Antispam-PRVS: <BN6PR07MB348921F540C1991B67674E3297F90@BN6PR07MB3489.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(42262312472803);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(601004)(2401047)(5005006)(8121501046)(3002001)(93006095)(10201501046)(6041248)(20161123560025)(20161123555025)(20161123564025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123558100)(6072148);SRVR:BN6PR07MB3489;BCL:0;PCL:0;RULEID:;SRVR:BN6PR07MB3489;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3489;4:iywTquZrWZDSH4rmkaxTh8csA9w2kIZWDKEpct846C1e+8G3ZauIAH6NqrtrQq/DZVClzb38qlHfvrFZrYvyRrxzL3D3NiPDFOg6o/cS4enl49yfHfrPM0gIJGFbHXkkQa6HbjwwIC0G8kPXABnOgrX5HatZEq+ZnzMWpZNdDmIiGtnnB4GUn4O9couIgWao4/suCM0bHjqUvBAEMVXyddXnqQAZdaFY/zJkmpyPdFyofxxl6yVW7loouaeWVtUFWNopqIu7HYIKBnM2Ii3gCK/PeBgWEqczC1g4BLC5k92HCVAbgXPPlzclL7/y0hfFSNVY5B3ja82g/rCJmlaFG2+tA7olupIXBcLeM0WdS2rTpsDxYT+vz8Ys1ncDkNA6BbfGroSpE6pef7+JiIYy/g4ZoWMVjamhe2VW7pKsb2rlEpo3uz/H04/FFW3+e8hb1lnU/zwH+ntBwp7SUssSB6aqBC0TzMYX/GKsBC8GMXYGABKi3AI79zMx7IhldBMRTN2TL12vZ6UMjU11ig4vjz/t40tet3riCBxl15+DvKESn8+5XBDMQOKnOZhHVLFSsG29GkVHYxDgWA1M1LhIhGIFOanJpDlnvIbdojMXQWDm720oMTrK5MrYdeum6IeUf/ky2wKheqTc6o0jrK0uGXWIzBJ9I/fNcQ14KJZZw1eoqkzDz3FK34RWNXuaL065vApq1+FhN76VPfJO37bf14jf4ugoGj/hqFDC+YQwXFcp1YStdG+38X2e0Pk0HKcA+yDyihLVY4+0e+T7RrzSIygZaZ75xmWjPExq8/yF3qTxJB6fJwbXNjLhPFP8YG68
X-Forefront-PRVS: 0316567485
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39400400002)(39410400002)(39840400002)(39450400003)(39850400002)(377424004)(24454002)(54534003)(377454003)(230700001)(6666003)(83506001)(53936002)(81166006)(50466002)(6506006)(53546009)(8676002)(5660300001)(6486002)(966005)(72206003)(33646002)(189998001)(4326008)(2950100002)(6116002)(3846002)(31696002)(23676002)(42882006)(7110500001)(6246003)(15650500001)(36756003)(38730400002)(478600001)(47776003)(10710500007)(4001350100001)(53416004)(42186005)(65956001)(31686004)(66066001)(305945005)(6306002)(2420400007)(2906002)(54356999)(50986999)(229853002)(76176999)(6512007)(25786009)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR07MB3489;H:ddl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjA3TUIzNDg5OzIzOjFPYlZXQTBiRU5WRUlLVWdhOG4rVHo1Qm1M?=
 =?utf-8?B?dGV0WkRYTUpQb255eloraUo2UWJuK3N1SGtBOG9mb1Y1aGV5Y3dWNGc1WDhF?=
 =?utf-8?B?S2NvWTNNaUN0Z3dDR2NaRTNOUkFRbWxUTVhjb3dWZ01VMHJxaXU2Sk5iTDZI?=
 =?utf-8?B?aytlUDBxUVMxdGEyUU5sbnhXT0tVS1hsdjVCdnp6dEpwNFBOaDVYbnZnMW83?=
 =?utf-8?B?dmV2eU1laGU2Q2JGOHo4dHhaTDJJM2JiUFRoYTJaSkhtb0t5M0s5aDNtanpL?=
 =?utf-8?B?eUhwR2VVbUMwSjdObUhlS0REYVNOSXM5WXkwMVBrKzg0QUFGOXBBdmRNQ0Fu?=
 =?utf-8?B?NWh0dnlFT3VWejA5T0t2MWdjNC91TERuL2hMMm9oS3p3VkxmalpMQnFoRkVj?=
 =?utf-8?B?UzFyNU5pT0RQczhYaUxYUzBPVjlqMDZRZ2h4N213NXlVa1ZLTUtTTEVLY1U0?=
 =?utf-8?B?d0gyNWhSNy9aUHhMdG9HOUJRZFQ5alZNOTdsK0RKVkQwSUpzL3BqM2FoalRR?=
 =?utf-8?B?TkRWQ0Zod2ozeklNTXBEOXdhWmdzOXR6ZUlXN2pxUElqakVjN0t6YVVjK0k0?=
 =?utf-8?B?WTBCMzdpbjRMUjBqaVNac1Y0S0JJZjVuZkN2aU5Sa28rR2lrOXdyVXlTdzMr?=
 =?utf-8?B?bGxOUVlzWUV4aVBxTzhDbko1NU1vcGtIbXVoSzlxNGsvYnNYbEhMeGVkSkdr?=
 =?utf-8?B?cEN0Nk0xRFhIM25kYnpZWjBsSytqUlRqSEt3Um9jMlM0MU9RSTZIdHg4Tmt2?=
 =?utf-8?B?OTlzd1l6czBhSUk4L2dBYnpDOElGMjgvTkkweUpxWC9PV3YyaEplMGRhY1Br?=
 =?utf-8?B?ZWZ6OGJLYzU3TzZyR2Nic2pqOS96K3R5UVRGa0p0Skk3R0xYME1hTEVDU3NZ?=
 =?utf-8?B?a3NueEExeCt1bUFKSGxHeHV3NWNYZVM4WktLUFNBcEFvR1dxQVQzQ0VOa2hX?=
 =?utf-8?B?dUNGWVVWNzNhWG96ZVNvek5zbXduRDdEUlZKSWxQdTRVdUFURG95Um5CNzF6?=
 =?utf-8?B?VkVxRlFHSWxBeERQQUp3c2ZIMmhKakdpYjlIanlMTFJDUHFLMVZ2OTdhWWdp?=
 =?utf-8?B?WmFrK1cxSkZod09IV3NCOE1rZnpyL1ZKRmVDcXNVQ0x3REtGZ2FGejl1RFZ6?=
 =?utf-8?B?RXZxZy9WZnU2dk41UFZHeFhKK0Z5SHVDSzZHUEQyUzJlSExocTF6YytRWlNu?=
 =?utf-8?B?L1lVajZmQlNhUkNRVEJpdlJiWjlyK3NtNStNbitKK1FnMmJhbkZDejRGQ3o3?=
 =?utf-8?B?ZXAyb2pFcktocmZmZ1hiODRTdXJTdWhhTGcwN3BzbkRUdStiWVhuT3pzN1hD?=
 =?utf-8?B?cHNzM2tDT3dWMDZsek8rVE5ScUxscHNmWlVnTk5TbTRDY3oxWHNnWkpOMkJv?=
 =?utf-8?B?Y0VYSTZyVytQSHAxbGN6aWpkbFZiS0lZU0U0UXJENkJRSmMra1hyTmpiTUVw?=
 =?utf-8?B?NDRTY3FYUVFZeGFoM1pScDNoVE0zdkNqNmkxdFlMK3VMeEttUjZ2Y01lTjVv?=
 =?utf-8?B?dFZNditDMTBtSk5zU3BBVGpSVllDQ3VmdUtqa1dVempia0ZxL1V1R2VaUkx5?=
 =?utf-8?B?YnRpY3BTRTlUQy96QjM3anNZZXFLR25qckVkRFRxbU13aU8rM3hTVS9qV0J3?=
 =?utf-8?B?cUltNVUzaW5LQ3c3eVVzOFZhakcrbkdkbSs2TEF2bllBekJwTTU1THJaZnZj?=
 =?utf-8?B?eVQ1Qk4wUDV4R0o4K0RFTURhdzJWMVIwNi9JRHM1eC9iZUlHeEcySnQ4aEVT?=
 =?utf-8?B?NEludi9PbFA1YnFvLytMd2FkbmEyekJkanZLZnNObkpOaG1zOUFaMEtHa1Yy?=
 =?utf-8?B?YlNuUHE3Q3Vsczd4dGFvVGlCcC9UMFVqZVlIcHFrM2tONmthM2dnNDRldEJB?=
 =?utf-8?B?TjJkTlFSWDd6MU9lbGYreDRXMndLQnpGa0Z5QWpJRDkyOCtVQWNZd014eG5j?=
 =?utf-8?B?dDRGcGxVUzVnPT0=?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3489;6:w65CSMMeNu7SRQ3fNVB9P8/G2U9b14/0pUyn9NIWE/yyKDGo0bjxgvsgARCvOb5RVl1HbpX89tlT2WfAhKWfVKXtP2Yz90N2Gf+Tr4AGj5sksr3nkwZ1taCF/BV43tRSzPAfC12Iaf0woxpZ96rquF/BS9FCHAMpN3DfoS5FYt+J1MEdMhISzpI2mNNqGmx0wZJhoTUExCdlf2/fLjgMmOZty3f4LhEtN4C4hhkeSoZgyF6STXAf7wyV7/aN4EPPrIWAdE68cf/X0mkX/L53UiUL+Vp9Vvcn3ENUD9U5OyOKkXKgnAsqAlkTrdMJ1QpayBx+vtqVllXwT8icn1wGoeXiXfJ+gT9CoTDRx0tTSuFeZ1QNjRCBYTe2hWyImMOeRZx82L/ooPHEgNuCau7Bd7wJs0rBf2P+XZrrFXmJ27pVAnDfOWoKxhEurcKnjCAfdpDKk8tgCtySIdrnAAOcHNdfTjb3qO2SP8BzCjTipox982SQl8nIg89V8WJf1PjT+oZyaQsKGrWZkT2XA+JjSw==;5:wEOE7Bi+ikTT9uqLq6nKasqi+lFFsPom9abLHHjpuilulBX7g0v4ESKfhTAmhqxYgLm9bwT6fPNphBLq9j7olBCTnMG9i1IGmAguQCQjAlJcY8sMbMhtM376yoNGv0Vn+gsilO69vQfNaOQ2X3yZVPtwxASx6i4e9OS9D6lPEE4=;24:0pzGvvYN0H2JwLBkIs2tI6DM3QSfu+0ATovpzxM8QDNGxorTxDMjWSclAxPSYkhVpEmXAZf84CbGh1l7agwpfsX/5mMWxke5yJwzZIRY2qg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3489;7:tl0IYklSzACEqf+SGS63j5WfLL6Hlde8DJB+YB9atCm/iDuKo5x03srH0FkQvL8FXPbJjMkn2IbB0WatR+Wv6ExWdBDAMFQm0twNvodJOrExWUxT2+mzTxiDOPRwu7wEYuDmXr/O1tC41M3zbGAHp4mL4/+kW6fGmImE+qe76YGRgSH5TKstkA8y3y2uhVJoi85lM2kIObsKNV/k7SieO4Jie94WhcUw5QGVmiWOjJE4PGmQY5wSdWip8DUzzaOutCCnRY56W9CPqWTNss59SPz1Tm84k1zVJq1mzkmLzicnf6XDTSIHqHKVvxh+zp2kgBmJLj8u+Q1sfyDcZRoq+w==
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2017 21:42:23.8110 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB3489
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57967
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Steven,

Take Joe Perches' patch, put a proper change log on it and test it.

Hopefully Joe will agree to a SoB and we will do that instead of the 
Markus Elfring thing.

Thanks,
David


On 05/23/2017 11:55 AM, Joe Perches wrote:
> On Tue, 2017-05-23 at 20:10 +0200, SF Markus Elfring wrote:
>> From: Markus Elfring <elfring@users.sourceforge.net>
>> Date: Tue, 23 May 2017 20:00:06 +0200
>>
>> Omit an extra message for a memory allocation failure in this function.
>>
>> This issue was detected by using the Coccinelle software.
>>
>> Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
>> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
>> ---
>>   arch/mips/cavium-octeon/octeon-irq.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
>> index c1eb1ff7c800..050c08ece5b6 100644
>> --- a/arch/mips/cavium-octeon/octeon-irq.c
>> +++ b/arch/mips/cavium-octeon/octeon-irq.c
>> @@ -1615,7 +1615,6 @@ static int __init octeon_irq_init_gpio(
>>   		irq_domain_add_linear(
>>   			gpio_node, 16, &octeon_irq_domain_gpio_ops, gpiod);
>>   	} else {
>> -		pr_warn("Cannot allocate memory for GPIO irq_domain.\n");
>>   		return -ENOMEM;
>>   	}
> 
> You really should reverse the test here and
> unindent the first block.
> 
> Again:  Don't be mindless.
>          Take the time to improve the code.
> ---
> diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octe
> index c1eb1ff7c800..2bdc750f2f2d 100644
> --- a/arch/mips/cavium-octeon/octeon-irq.c
> +++ b/arch/mips/cavium-octeon/octeon-irq.c
> @@ -1609,15 +1609,13 @@ static int __init octeon_irq_init_gpio(
>   	}
>   
>   	gpiod = kzalloc(sizeof(*gpiod), GFP_KERNEL);
> -	if (gpiod) {
> -		/* gpio domain host_data is the base hwirq number. */
> -		gpiod->base_hwirq = base_hwirq;
> -		irq_domain_add_linear(
> -			gpio_node, 16, &octeon_irq_domain_gpio_ops, gpiod);
> -	} else {
> -		pr_warn("Cannot allocate memory for GPIO irq_domain.\n");
> +	if (!gpiod)
>   		return -ENOMEM;
> -	}
> +
> +	/* gpio domain host_data is the base hwirq number. */
> +	gpiod->base_hwirq = base_hwirq;
> +	irq_domain_add_linear(gpio_node, 16,
> +			      &octeon_irq_domain_gpio_ops, gpiod);
>   
>   	/*
>   	 * Clear the OF_POPULATED flag that was set by of_irq_init()
> 
