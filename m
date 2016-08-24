Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Aug 2016 18:51:13 +0200 (CEST)
Received: from mail-bl2nam02on0084.outbound.protection.outlook.com ([104.47.38.84]:5664
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992160AbcHXQvFnDttO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Aug 2016 18:51:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=bDAUD0dOUCapvtMLi/zM1lVmErCEZaBmN05t+enHcF8=;
 b=LMGi3uHRrZJ34hIwJKxtEH/2zvbeKH/9F35WbYg5Rk/1eySXTl1oSJpsx+oEtM/yQRML+iMqA/1ku1HU+Gt9Wh64GtxZ0Ud3xHkr8ZCAFObIeyFg19wxkwqfyQ3t/icu14PmIxqhgxGAd1bqYtU6o3zmNQ/WsyQhiFDJNL9t4dE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from [10.0.0.4] (173.22.239.243) by
 CY1PR0701MB1097.namprd07.prod.outlook.com (10.160.145.16) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384) id
 15.1.557.21; Wed, 24 Aug 2016 16:50:56 +0000
Subject: Re: [PATCH] MIPS: OCTEON: mangle-port: fix build failure with VDSO
 code
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
References: <20160822220735.13865-1-aaro.koskinen@iki.fi>
 <57BB82F3.2030103@caviumnetworks.com>
CC:     David Daney <ddaney@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        <linux-mips@linux-mips.org>, Alex Smith <alex.smith@imgtec.com>
From:   "Steven J. Hill" <Steven.Hill@cavium.com>
Message-ID: <57BDD06C.6030004@cavium.com>
Date:   Wed, 24 Aug 2016 11:50:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <57BB82F3.2030103@caviumnetworks.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [173.22.239.243]
X-ClientProxiedBy: BN6PR06CA0020.namprd06.prod.outlook.com (10.175.123.158) To
 CY1PR0701MB1097.namprd07.prod.outlook.com (10.160.145.16)
X-MS-Office365-Filtering-Correlation-Id: 17c97e1f-f42f-44d8-6621-08d3cc3ed245
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1097;2:h1HpzG+FQFyiwXrD6bLb4Fsy8Nket+BLRAH0P2v3/LEyqR2bLL+Xlo4FRToMfHmrl0Kl9CHrTcGj+STcQLXK9hTA9JRLhVfxlWIRayC6bfv7It4kNIdi7dNW6fmRMxCYu2yyd3uGHNWPICZokKst81BRnlQ5S8oPwbd/Wxk60Wx8iE7CJfJYk0YaEwIFZ7UO;3:gsIHRUfasKwcWLfrdzCip128sYkyP20aX6eiRoHoHStVoT04g5OHBVtebpIGhHE9/dPMuNHVnMRyxFMESL13QFtcbqYDoaaPhpHwImiwQGEdjFA0Ar2FcvLfT3TlqMZQ;25:zAXBof96e6TqE86+/LENNJJDe7xOkRH8esyMHsKmRkFCWzHDNHGcxDyU8Qg8/RBkgVSOIEBmJNpt8aeR8SQgjODFUtovVEA8RPdcmuVRaR7zRfiT78NKb89jTruhAaZ74TqM2bkULacBztD15ot+WFb5otGKPMNe2apl634aFvp28wFSKi5GeXUPmasC1LLpJ3W9whFRdPI3H1g4NycbyUr9opvVHnsriVIEcsQk9nEjKO8TCBOCR/zcS6BBZrCiBkp3QiJ2dGlNhmW5JpV4aiMwgtE1/bLU9bbFTc70540dZpS9feJgnIU1lLA8tNcm4lGqUWxz3f2ZrHxNPwGxWFwZ6Oa5nomavbMUKkVk6TF1mC16tGGL4tUs5m4LaWnayoHzX++lZw6mTWQRRNbR2Zi2HkzYzSiC+7+s+4/XEaM=
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0701MB1097;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1097;31:86US3993YoUylvyV8OkbWHx+xg8Y3SQyKF6AX7zWTqXCJgsu41+93bYIG3dzLY4UpBB/QurpLRnR5KIuoNA7pEiYdD/pVCdXwArVgx+V24N5oqfO/rNfmpcAu+rEmjN660OycNDrdjUYGf7djzV0++FMqWndzDNCrepu4ry9peL1Vh/VaEAo2LSUqFRFcI0jmgSlE0ZebvKH6jYu91vt1vy4dKtwS7NqvFol9PHsbZM=;20:vGRi8s3GwlnxGNViEe4Kyr1Yb1Izy0eMSUPpuHIuE7S26idF8qYDMFM1TpjyH15CHpPIarUxfBdB0/4OGGEQzw3/177y2wS0Ihf/hV0zaGkAdS0FEyswiw1sxI0eKiUyr9Gp2QaMth4A2R0VpPPOq4N5uDQIEPjK0AYmiyeWs1CNHU0C5M4WxQZFs0aMVYX6//bBDaS7d2q/QHMcnKUhRD5zCJLhuXjWO+6xBdFQQLKigzkM9u3LjavUPCHBPcY3Pc0IRU5UWQOkbVOUzdSpStkC7pg0/vHAiwIvzXTNWReb04DoHmytVP3VlMM+6buYQj/0a4HOvrfU5Rd11aG2Yulwltm/HTOTWaeix+ebEFWNPcOtOVuin3DfW0a29wlPRFYklW2JX2ISzcQfrnII9OEBqx9NIWsHgLohMuB3Jro/7KCoh7bWkWXBxzqvq/Xt/VPcNGsYERvz9ADLSgW0nyRA4+4wRcu5kViuqhJnxdO/1IVXCMcfWE/lM0fCj1CJ
X-Microsoft-Antispam-PRVS: <CY1PR0701MB10973AFA62D92CB1CDD0AB3A80EA0@CY1PR0701MB1097.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001);SRVR:CY1PR0701MB1097;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0701MB1097;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1097;4:c26q01pP1fc6nbdh0ER4qvV+BB4GcRoGnexnpRKuVhwO2cU01NU5sFoBVV0y1rpkXrgfLoEjfrEt6f01UsQ3CDpOmL4LmUYNwLSp1f6IPPA7MNVoLGzaXPUR/1yQ2BLyzvIyCoc3FfcpPyOX/8g1iLIQZIo3GZYR6vpb407Nh13xrSuc94uEa0yHbAf76NdqU/JAYWbTo741Rlww0EG+YlrI7OZhqWbUHKumwYsOQ4VV+l9qphXO2ms2wfPQ+M+MK6xCV/pxbhSG4GmHm9XG6vtrW8UuVeVaWWsjn4JPrwmBq/EnWeIAxEzctwS8903gOiqkYKADk69zmD/CzljgEYn0bLKTTp0x80PQ9fKsmWVNlXkvTKDLjx9ryZG3yWVuu4obyp4IfiWwSsaYPBIQGQ==
X-Forefront-PRVS: 0044C17179
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(6049001)(7916002)(377454003)(24454002)(189002)(199003)(50986999)(50466002)(4326007)(110136002)(2950100001)(189998001)(77096005)(80316001)(19580405001)(23746002)(19580395003)(586003)(3846002)(230700001)(81166006)(81156014)(6116002)(8676002)(68736007)(2906002)(59896002)(86362001)(92566002)(64126003)(106356001)(105586002)(42186005)(4001350100001)(97736004)(36756003)(33656002)(76176999)(87266999)(65816999)(54356999)(65806001)(101416001)(65956001)(66066001)(7736002)(7846002)(83506001)(305945005)(5660300001)(47776003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0701MB1097;H:[10.0.0.4];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;CY1PR0701MB1097;23:RTTS0MOqEQOgVRfgzwOAslsbjbOWzGCnZY2?=
 =?Windows-1252?Q?HykszxtJhlKYE3BkgSZcAFnR4obJyQYZaSBgAu5fUFk3u794Sn0pNAVc?=
 =?Windows-1252?Q?NiIAOxYx2CoSTabVFODg9ziI9rwgQFe5xhrsSp52HqdQV5VDPywITOco?=
 =?Windows-1252?Q?GsRKakSsh/lMXEb1MjJ/mOuhBFku6VqWLrkiINldgpLw7GUyUF/cEvYf?=
 =?Windows-1252?Q?v0X9bkY2MUiFGhMBKQchnBlqNZHA9Si4qPb8t8aLoxjMmNSUaJXYW7XE?=
 =?Windows-1252?Q?/ck9fz5WxSEQ5U7zWjYVGu2U/YHtPFzcx4ohfRYsxiA/3p12OwDyKO3I?=
 =?Windows-1252?Q?l9jSkSuET7ev2QwL5fSIYeI2kCYdwCMl7iPgs37bqoCHuqV5a3/t9kk4?=
 =?Windows-1252?Q?LaTlZk9EVmb4PliJpgylcVc74HX1Z6w/zRig2i3RwMmZXsIMF01TI7nB?=
 =?Windows-1252?Q?fLU07iVHDheOiE4p7qHB9XhFF8DQnT3tknaqu9l1xNiKiH2Qe5iw9eX/?=
 =?Windows-1252?Q?EuRhALx+qCOw3gFlkDpiGTAac/eACiszMTem8yy4FJ6d/SWR1lf37Spr?=
 =?Windows-1252?Q?p+Fg2m5pu9CoN7wyuKBiNYHPZtkxTtBjDR/abcKCghDDW+Gmc1EAByEd?=
 =?Windows-1252?Q?2dy3DFBggBFe3nKU9GR8NoxHNq3+EyC0b8cYLxXBA8Jjmf5LAa0d8Rms?=
 =?Windows-1252?Q?C4XqYdVwvMwgF9ciVRUWJ0YoN/J2nK2XY1Td/7Je1J3GP7CfCDShNHTM?=
 =?Windows-1252?Q?FgOqOADa43LZXFGMJ/nnjtmnmBD+DbEkjm2hnk+SDUS8uQTorfUhJ847?=
 =?Windows-1252?Q?Vpg46R9PH4R6OeVU9Pswc+wkvZYRTJfWjEWnrAymnNQDQbTHeAtfjOG0?=
 =?Windows-1252?Q?u2dfoeRoaEsh8mwEUVIJ14pf4BGAb+w0JrzLWVKnC+i4XpVKKHpSjtux?=
 =?Windows-1252?Q?+wwYFxmWZMRKcAo6SC7xw56BXum7KBEFTrt5kvCjj6SFaskxl/xLD5Aj?=
 =?Windows-1252?Q?NDVTJtZ0m2RwOtxjX/sCTsv+YduHCrzyrN2ibNMDr6z9grJkygGc0Yl3?=
 =?Windows-1252?Q?/pbEtfj6LWebekVJEJ76CTSx90Omd327IsI6DbO0dwSfK6EZC4wNDtrM?=
 =?Windows-1252?Q?7Zx2NsFa3Hp0VrhQsV41Vaj/+Oo69hfbhKNdmoQ5+jV6UdGF94tnoLmr?=
 =?Windows-1252?Q?sTHp2OszViK++6fAlpG0Megpas8B4eZBC6KSyhOXRWJx2V/Aa75s0Wc5?=
 =?Windows-1252?Q?LHMugezLXFhXUXLM/jp+Dmdl9U2IZGOkUUp1TNUKaQD6Evp8S9H/46Md?=
 =?Windows-1252?Q?F0JDbU3LKuvm7mR2nu1ZiIwwgYCYmboX2FmZCztAo7zit3yKJcSAGbVW?=
 =?Windows-1252?Q?hL2C9dDSFDiZXaG7nWbQj3SQK/x1+nKKLe0Bq86vCxL5FjhRySxjq3XQ?=
 =?Windows-1252?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1097;6:FO+Q7sWiRbraIE7KVSqULMMrXwKShpEC1bHGC3Z+SOM5XTnZK37BOHDK7Bm8BpSTd6vqlZeSpfOpsVlcZZkvP28AHM6tfWZlYfDfFRmbdGtLbn1ttzPIdCX6AiSyyXYE4LK/LEjsqFL4dCB2md8yuT7odvXzqK3BA1qDooLWf46FNeBN/6Qyek58rIc0HXPNpjEEJvGT3cUi8WEcKTP5wQJDSAfod0MAJqLGZxPiZjoR5ysATLnrkQY8KUCwZrXuKEQ9wGy37tiN/vvgFUVrY1QOY0qedEth9VGECjP1PTs=;5:Rkza4wtsHwO5p+u+fFyP8jqgmhQ6sFVO5egSVgvkrl3ZFP2jO2L76UsTnwYR1O+mOHeZMEZuEbdLlQvxBpGW+KPkFpgNHW1PF4EE5EGp7jxdZo6nEZL3JkZN03mZxHJILSGAdCeiSJgzfcA7yOhGOw==;24:HC22RAHPdz/jkEKI5vx6HQqelgO/nIsDzDCjZQrbFmSlaRa89VTWUNmk3MZmXOueUVDevbPw4gdrU1kV7evHI7mTkuKZKkeD29Nne9+0ohw=;7:aEXP6i3jYHZAVvUlJLZKvs1sgj2q1N2mfsrS8VIo+6W1VyO7YfWHoDGi+Vxaq07eoHpO6qdYAuu5ZpkY2TSREkZOOJqI6n1NOHs+A2hxYdrnjCUKeR5fBKYhaKaIayrWyr+jY4UFj0I1SQ08FU8OT7HbMi62e7UEwKpc8e71TLgRqT4iMfghZ18gJVBxuZzZopkA6l8Yxtpg38PoyqTDWpognI38Ypg9XIbaaZ2KU3dI32hAJu2jeq+kMq0doz/n
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2016 16:50:56.7186 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0701MB1097
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54743
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@cavium.com
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

On 08/22/2016 05:55 PM, David Daney wrote:
>
> This looks like it should work.
>
> Steven, can you test this patch for us to get independent confirmation
> that it works?
>
> If testing shows that it is good, please add Acked-by: David Daney
> <david.daney@cavium.com>
>
Hey Aaro.

Patch tests out good. Go ahead add David's ack. Thanks.

Steve
