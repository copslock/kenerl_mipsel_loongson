Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jul 2016 23:50:15 +0200 (CEST)
Received: from mail-sn1nam02on0086.outbound.protection.outlook.com ([104.47.36.86]:52688
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992186AbcGYVuCWZhEk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Jul 2016 23:50:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=tJEpDnPffOpzQY/YOpcCBKrvluPViTRVucSLXGaKp2o=;
 b=BCPJUXFpYwRWWBPWgRDpVNDjRwcs+ge4QC9ELgp+cYPpNIkqi6tQ8E8ApiTiyCDuZ00hJqcH0ZI++lRsUdjVKqU2T7igdkvQFTo/dlfdH5hTdLoDYBw9QIEmtC4av1GU23DpdV1OiPTmu+aQWF3/zlVZIGNUJPSmUQouhCawsO4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from dl.caveonetworks.com (50.233.148.158) by
 BN4PR07MB2129.namprd07.prod.outlook.com (10.164.63.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.549.15; Mon, 25 Jul 2016 21:49:53 +0000
Message-ID: <5796897F.8050007@caviumnetworks.com>
Date:   Mon, 25 Jul 2016 14:49:51 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        "Steven J. Hill" <sjhill@bethel-hill.org>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] MIPS: Octeon: Improve USB reset code for OCTEON II.
References: <57967A2C.3020002@bethel-hill.org> <20160725211545.GB17344@blackmetal.musicnaut.iki.fi>
In-Reply-To: <20160725211545.GB17344@blackmetal.musicnaut.iki.fi>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.158]
X-ClientProxiedBy: BN1PR07CA0074.namprd07.prod.outlook.com (10.255.193.49) To
 BN4PR07MB2129.namprd07.prod.outlook.com (10.164.63.11)
X-MS-Office365-Filtering-Correlation-Id: 7733f713-0274-4251-8c5a-08d3b4d59ccd
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2129;2:weuF5khiIgYqI1I1o4Lnk0D0II7Noco+n6XW7GAA6ydjL8VWiRezdUQMfkLHU/WvyrjJLhK1JBzwN9F0w092rvSUNpPHE/53se0b1b/NObZIJoLUAr5rxdKQLdZgzwp6WxO2ORpIzpBQRb8BadDuwfguuab4/JkIq9rnGIKvIu20+JVO09gewnw33l41nQ6G;3:wG+4n4zZpStzS/KGXlyx3Jemky60TkIgdGE63mPynghVA0O0gt7g92sd7goZIsnTn8TF9UFxv0n9DjEUTQLH7Tt9a/alVHHd4QDZarbGJKvXopWBJNQzouJQOBpKP7JE;25:6lCL3tIabD0kG4o9+2/cnC3oqcJFfIKNRxxjlOnoeUCSv5xEu1S03hk6+Pg7wDfRXQpfLQ2E19XvB8dDDFwB/mxwS+Ds2VMSAL+yLW7lm2H5NHy8rn4E+HafZkDJcraHPg16dndvpYb+QhtmnJJ2qpcINrQqJfpta2a1cXwIKadqIXYV9tPH5hNcf8OuPKy0l5Vbqr6i2mZSgZK/bHDzpcAycrXMXc4tPAfvypea/NjrQSu4Em7rXuLRUmiJCATNIxsX0YQgEy/E/O2EGCgqnQ3jxMHhMEmPMTGItaMmtKurx5rYUIz0W1Rf154hcrmV2PV3HAstfLKmJw4emf5fKE7F2ilBFtX5JL4cSRTX1yDY739T1X9WBXR6AxoJym7CMOWGM3atHRnahGXMpIE+Vnbb5M9cGSTDxxj1Ci6wyrs=;31:BfvlC0H+Gc3f5RdH5LGzR24ynAqjuTnw6NrVysLbUb+npdBs/tbTeOlgcGMqFi9/r6lD//IWtBhMIzYPCG0l9cbc5khx4CllUsutkQuq0pnQHFl8Apm4GNPEKhmm5hzhwF1zgK/FMOjpVZoAuXW3bMucCEwtCTS6w4rYJ/GqBsvLUEImoNvRotcmmGn/e0TFk6mF7RdAS/pghe3nsd74BA==
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BN4PR07MB2129;
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2129;20:8nxY4v+10QbMLE6+OrrKw0SVudCnyX47vADftbrrH6LgJu/VYsu4SpZaT7a+DuRWq+1JMSPPsROAoQiIqV5DD2cejYMtBqO1RBrHod6/JBj5J6hwwP5TDmt0z3v/IOllwqIxuFmGtQAjWQZ+LVBmsU7usQq0kz5+pHStds1hrUwDM7Uq8gLqwpoxGKp7ofQVwc4DDJITBTT02VGwh568PVd2/cLx0jPn4NUKSMnARRo5+FNMt3BaV/3zbnkp5xe9rGvdtCBKsYlVDhzXUxmeGuVe5+dP8m/VV62fCswVeEuhvM9PFVtKqD7JHU3i52aJ+wX8Gij7XHBmdv+tUP77glUXZkWyMCd5q24HXsNJ96ze4XgbCvQ0YuBQm1S0jS20b0wGoL5oFf815zl8UqvZWO6BYVmQ6HBvGe/78hupb+TCAC7NiZ4O3q6+P1tmQ1+XYnN7FquF0czHVVW9BU35MWDngthpFmOnNA0QusRlQKfzfxFwmX/7imHfn4mQUOsx3CyLS098ukNLHsNaNet2DSC6rNRwKAmeIJwV8CNWZV0KEBXPCNRZZoSyXcKH1LM86QQbTxhMym4vib2gnWGLVZ1AxZT+FQXJslv7wc6Zg+s=
X-Microsoft-Antispam-PRVS: <BN4PR07MB212993C36468F92E342B2098970D0@BN4PR07MB2129.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(2401047)(8121501046)(5005006)(3002001)(10201501046);SRVR:BN4PR07MB2129;BCL:0;PCL:0;RULEID:;SRVR:BN4PR07MB2129;
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2129;4:b7/eLzRWt5U0/as8oz33XMgLB8tPE+Wcwgq9ar/3oR5OVuQYzeAR8kpuiYzC99nRr6XqAiuiwtr/IviPoEUrs2mvgxc8SZVVRuXVg2E3xXkJFkfBUwgskj7LyBgXZXpLV2dkJcZgnVHoIRiu5LwkF3cHBmLe16nXQJNgI4AeACUSmMYJ8nkjDJKtTdnbowsKAqc53Da4SoECqFIgYQSa7XIaZMGDVuee5QzBIk10IEUTW/Lj80DGnQ+sw1O1RNmNcpIq15tdtfP6HPvahKc/BXYhjRYVLhjELzERGM/8f1clD0jNichtWBJI+6H86UJHjzUnWXz9ISJe2MLZLx4KnZZsYDhi2vGOht6exXPfwQ/a/3dW1s4p2a9F/MQ1AZ8f
X-Forefront-PRVS: 0014E2CF50
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(199003)(24454002)(189002)(377454003)(68736007)(586003)(4326007)(92566002)(189998001)(107886002)(5001770100001)(4001350100001)(97736004)(3846002)(6116002)(81156014)(8676002)(2950100001)(81166006)(59896002)(305945005)(7736002)(7846002)(77096005)(105586002)(80316001)(4001430100002)(33656002)(230700001)(50466002)(69596002)(65956001)(64126003)(47776003)(36756003)(106356001)(83506001)(54356999)(2906002)(66066001)(65816999)(42186005)(101416001)(65806001)(99136001)(23756003)(53416004)(50986999)(87266999)(76176999);DIR:OUT;SFP:1101;SCL:1;SRVR:BN4PR07MB2129;H:dl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;BN4PR07MB2129;23:xc3RvuBop3XYM6jl/fofeWDqUIMN8QuQuDhe5Iv?=
 =?iso-8859-1?Q?U8QQCZAodX+P/FmZkzP9x1B95rgZBivVlvEBTP6vfGnyisjMd9RFquoaUS?=
 =?iso-8859-1?Q?qtnjs7ioI4N8eOGRqm+c+mVWdOd3dVcLwNL29VqiHDYJY7ks3hoea+ylyt?=
 =?iso-8859-1?Q?1RhRlq1AdGkKvQqXNKoyCxZQXflGEufBBmh4MgNvPwrLDDuxSEOgd5ywm2?=
 =?iso-8859-1?Q?wdy6cPHJgyzXdIG1URJu0xJDgdqT5BHj0ut62bVM5pUJzhAh+ww0D/ffQm?=
 =?iso-8859-1?Q?zbrcgOBo3dwYFyyymhbd4xYOg1AFnDfo07swvtiWk0eowa1OGu05TA2ag/?=
 =?iso-8859-1?Q?dcsfFfHeHzN/o3K7jxLaqXa/XDnQlFFpJDFLJIFazQilGDaYbAHb0497Yx?=
 =?iso-8859-1?Q?/MXvJMiepVk4BRbB6zmsmqb/EU3PNb5HEDtpH1ABaB2BqGKQdJgdpZ1Xmq?=
 =?iso-8859-1?Q?OGozUkBUkARuYxq0gLjcDAOQX1kpcCbrE/V4JZQRVs1ppVwr1OBJiFS+xH?=
 =?iso-8859-1?Q?d34AVcxh2aznLWyiT2IZOAtXLWyfYjmDzmekOeomYQvnc7KsFFBb78+Cmu?=
 =?iso-8859-1?Q?Iqi7mBjqCgRW4RE32esoUE3fwZvEFVJue9xjzNWBlpAXp2FzMDe+9u2FM9?=
 =?iso-8859-1?Q?mkzc90XMN7D1DEC3R1elNO4WtDNiRRejq0n25ndJy14RssCN3z1jw+znPL?=
 =?iso-8859-1?Q?dO0jPfQW12o13fZJa2NUnOFUMyKPuwYfgMuYdouGMBtCNikJQ8Z7mtguCE?=
 =?iso-8859-1?Q?1dFXuQ8OhwS2wrWawFHbAxtidYuHEBbMEweD3SdXBAvE546QHkpt/jdQwN?=
 =?iso-8859-1?Q?bzLP9O6LC6C7D8DpxsxxF1kwinHdZ2VXHPtOM8lDeAsyTpELSeqxReUDam?=
 =?iso-8859-1?Q?gOa/U8DOzQbFevXBHsuYit8eoZbeNjMhYAxbXLuuCAXTe5E+nALnznc8wi?=
 =?iso-8859-1?Q?4tSW5Az5YrBAQKlYSKbGFBYR9GHY/M9Zc2a2qZHGT3oJqm5sUwC20335ij?=
 =?iso-8859-1?Q?g6vC+CEHy3F1Euc5IrNa3CJsQl9THmoMMLEnTPMnbNu6sZw1K3cjbzMCqJ?=
 =?iso-8859-1?Q?eMpLrVl0N4npyY5vOm2NHVOG9v4HL9hhi0f4wsuk33pz8+ssWeTYdRuZ+I?=
 =?iso-8859-1?Q?X4KitX31A8X2IAxeo6jeQKxIvElICjGlHqVfMB2QtCbjVx7e6TVyJNF+rk?=
 =?iso-8859-1?Q?BNcvEbDVb4RPG09LAtvBRx9t7xSbldhRjByrb1R4MOVSSdC+7DnyiZVQ8u?=
 =?iso-8859-1?Q?avxSoX+DT0z85nOkKs99uHO8YHpDr401XGDj55JJgwFk1GgftOE8l5E5sW?=
 =?iso-8859-1?Q?zwmRgDEunX+eKL876v2EA/7JqcnstVotJT+2ozQfzQWynoLCjST4RKs6G5?=
 =?iso-8859-1?Q?Tz1c6qIc=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2129;6:v20yj9T7Oig6DMscdQiQF4+DFu4QOpsdj6XEZF+BZRSCSYm3XThafssIvaA275ZtEKhP7eY85ktvFeDUQ7e/US0TmAC4/VXtDh7c9wF/MHJ1VW+WU8pGgi2ApuZ8b5Os2YkeQjEejfk7xFfOxAsztiwPqfDMto+GWf+XyPwWfawey73NgLvK21Q5ei4nks/J30GSL6IfoeLbNoKqbV4ymnnFdWRd/9cylbz16p9j1AMpkQXP68ric7vXPPaFbbdqQ6iXVEd4tUd7nY7xrAqS2/S8dYs1LVBJoYH8JhoAvJA=;5:bTppbmRJx/A/gSk9v1r61SQGNWBwWc9x7pgQiAv+VyB2MhwwjEXKGi9n4NWQe3BDqkroViQq2JCkZ4v/IgZBFvVcpOoguClKvnV3KwF+ZacOO84vVvz5JQEpr4wTRvob9r0SnhIahs319pAi9qzqmA==;24:GVA56rTgpQZnkGg/+J4QgKUPmk9F7EfXqjNVrUAf9wfngAhYRUwgeFQHpZODFQXnVzEM2rgaC8Oy0sRvT4Gn3XU7I3RuYXAwDS0uB1+H8u0=;7:QeePZrOrBJ8nnv4xe/R/a3IsmCJeNP0qxK7LMS+g0J9H9dHeSToqSWudwm2G8p+hmi8z4P6Vskiwg8lku9lUoCZKJjAReC0HjssOZqe9bKAUmwoM5KVtT2ZlB70L2HshODeEgw+gtzke86Pic/MWRjcZydKaoU734iM95hoHNOO2O4XNALIcHBkUDO0sXvbWYLIhCb0+smm861ACCMGHVTH5ik+PT1JJuaOGXURDAQW/nANbR2RGY0lRNI+FjL6u
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2016 21:49:53.5987 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN4PR07MB2129
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54377
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

On 07/25/2016 02:15 PM, Aaro Koskinen wrote:
> Hi,
>
> On Mon, Jul 25, 2016 at 03:44:28PM -0500, Steven J. Hill wrote:
>> -	.dma_mask_64	= 1,
>> +	/*
>> +	 * We can DMA from anywhere. But the descriptors must be in
>> +	 * the lower 4GB.
>> +	 */
>> +	.dma_mask_64	= 0,
>
> Is this change really related to USB reset code?

In a word ... no.

It is still needed though on systems with 4GB or more of RAM.

Steven, can you split the patch in two?   One patch with the reset 
enhancements, and a second with this change to restrict the DMA mask.

Thanks,
David.
