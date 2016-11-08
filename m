Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Nov 2016 08:14:08 +0100 (CET)
Received: from mail-sn1nam02on0047.outbound.protection.outlook.com ([104.47.36.47]:57249
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992029AbcKHHOAQHI9f (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Nov 2016 08:14:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=0XiH1/My1ueDoVVpcJwIw9hqloj7Yi6YDUjuwfh9omI=;
 b=MtE2pGimA14VK/T/9zcaSUyyPJFT1gxDj7I1iYqgEquo4kZ8U66sz6gplIwFnhVcnfaeUCPZYIBzuBlCQxeLMDXJ2994gNjxpehfa51Cj3bKcOyoNVh1gIDZ4iW5yfIY2cWW8QjbRAPEPKOjE702qhXgzvNImZEx9Zg9n5Xs3Zc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jan.Glauber@cavium.com; 
Received: from hardcore (46.223.65.110) by
 CY1PR07MB2585.namprd07.prod.outlook.com (10.167.16.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.649.16; Tue, 8 Nov 2016 07:13:51 +0000
Date:   Tue, 8 Nov 2016 08:13:37 +0100
From:   Jan Glauber <jan.glauber@caviumnetworks.com>
To:     Paul Burton <paul.burton@imgtec.com>
CC:     <linux-i2c@vger.kernel.org>, <linux-mips@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Wolfram Sang <wsa@the-dreams.de>, <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] i2c: octeon: Fix register access
Message-ID: <20161108071337.GA4601@hardcore>
References: <20161107200921.30284-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20161107200921.30284-1-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [46.223.65.110]
X-ClientProxiedBy: VI1PR10CA0027.EURPRD10.PROD.OUTLOOK.COM (10.165.230.37) To
 CY1PR07MB2585.namprd07.prod.outlook.com (10.167.16.135)
X-MS-Office365-Filtering-Correlation-Id: 1206137e-6052-4f8f-28dc-08d407a6cb74
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2585;2:ZECdfkLfuFWD0qiD0CPSMiv0t+wY5H2Dg8BNoA3p3CZ5liLVcHXDSPwbvPMlHlDKP13oSD5aTaG8JuN5+pLPBVwM/DwMQ7FULO0l9HQ3ohxxreV77PyY+7JHCItWlkH8C3kb1RWbzHBFdbOv7vo8XLm368KtYdj/FCciHJfVVTV7/Fmb5jnWr5zUoEacMRZEN6lOaHfdYhBvgUWU4u0Z/Q==;3:bDKkEw10WPE413qQbXLj6wHlWj4kX8Ne6zIs+9GHcXfJFMYBsDCNtpHjv5BaXLY/+9gRNJSf1t39MKTvc04ihqbkUITOQtQby0oOakmTBOEiPYkUyNzRVTg3S/qCCrhLDRey4+RbRBl/WrKe0rDBFQ==;25:9lyJKQ9Oyc2KlIZOSMYuxNZ3DnVUcDOOzp5oN12xFtIWY4tzLg1SWi0v6KSXTL13GBmxrZAGrNG7V4lsPLahsaS8Wh6A7yl+HL7I1UWzCQv+7SgbFEwbYa0Bdg6TP/hz4lXf4S6GeKz3bN9MGGr66nzU7YmIsQWGffZnJO850ONY2wu0xN75s+4vgghj1wDRlJ7oO8CeqwW4+DaHx7p6aP1WINbKYHwAvNbf7/HdaL/Jw6HqIyuEsSVDIqYNVj5XEj0cQRSn9Uytm5NC+wQjjU8PSSs3zib5VRRRuTmHIsx4b/r9iOL1jkUE+oxsjgDIBgCuasMA5EfCBf18/6zGowoo78c/cQ2H2WS/tywV1y0PU6CF7XPj+TJrjT1g19PshZdrKEsVMYs9I0DcTGLo4nom+7JbcCrtfvGbHBj22fNQgBIMtZ/sZ+GWXtJiaM+N
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:CY1PR07MB2585;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2585;31:bQ8gwn85+AMTN7zflrtIUHm97ndjdqgTB+yvyDLPCe39WBHI4/xyFhfFaIV2Te6witpiwRjv/Tue2rjSaQY92lFkyw09E3nDqBK62+QYg0bHm+R+t5X2Ia7zTEnyv+bACRMfVEYxekxQQpLjd6Aw21YkNYSrgUJdD7mGeCzdRfzdLFZDt8XjYUvqVzqZqNl2N1AgIMWflOYQkAcwO4FsDyexD3l6x4mQ0bwQA2qpbcqGS+yPDfk+Iuk5fzzcTZ1EiqJPopBf/5fpXQUljs+ZRQ==;20:h0EiFLgoRBzCMfdRc5/wQ8QvNJ2bjgic2MIXiBGQppLipnPCD0cmvi3SM0GileSyqyvObxZzRBcDc1tTcIpFLX7O2HslJBZChYnWrONfoQjGGR25NH2xvs7HSbFWOg3KD2yV3fuXgkyKzr47AUFxTGitY0zZ9apsGDgFYhuTFPi9KsqkIQ10/eDCAlLZ8Sdd/78jI9Mg3VTo8WGPG4MObHZPwoKKyNSetL35D6QtllIWJ9NuQDT3rTafRvu6TE267m3lRbuyeJ9Tdo9iM7ZrMD5KG/gA4UGlAVmvYxA9HWiOhgcdGB4LjsStzHNwqA9ygm+CmNdeAu3y5+mV7Sa4F6NgiU/7t1pZP1j+4LRKI+bwXWFuKhX3t9yAxLXcOt4Eb8Lp4NvM/rFfTs909pX+xsHYNPRHsdgHigzjKw23cctHCya30GBaTy/sQYYIruT4J6oR63y1dHF6NNtIpjvStHzFt6sRrN4YSgArL8PABknkVBgNw2GGG3g4VwnT1du4H8zGUejkunFMYc1MDgz34Id6+VtgxuEgkeFK7/kNNR0jAK9lS97vUo7oa2uUdImxAVFxZJvJKixyoiHncAhqOjRwJ6fvs+/za2AMR24cat0=
X-Microsoft-Antispam-PRVS: <CY1PR07MB2585813811571E8517856ABC91A60@CY1PR07MB2585.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(788757137089);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001);SRVR:CY1PR07MB2585;BCL:0;PCL:0;RULEID:;SRVR:CY1PR07MB2585;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2585;4:UFZSy6qQPg8/fHI+jQWKRpwIP7bh27rCy7H9FC4BySAxu3HyiahtW7LC1pAi/xvx+c7zS7M6X9iRM/OY7ivtM2oNh76pVf/A0KqxkmDTXExCpuMnW8BEmv9dZ67+x6J9MyeLrXFSXR/6vPaqTQmpInA0z6/e5mBQeFGJ6V8DLRU6P/cKQDH/cyEf4LZXMDcsPxCfrMkBdXGtAxnRanRaiCEdfPSWoM2xYysLew6KGazxsk6No/ywWRFNKTDMGrpvUAF5C77iRLWpIaek/1bTrcAgSK7Tvb4KSrnh6SOBcVXhKW5pTL4T+SrvFgYVv0woVHoXfNJJu6O7u00j3YGPs8IS9FX0ohVQIMs8CHIimbbXQvmp8H531Zrf8NOlg0ZNoiMHLc09HGjSfNNcNI9eqYaZS6Lie1ZkWkfSzPT5Qdht7Q6MgALNLnGSpnWV08vBXfSeY70PL16DU+7KXTizDQoo5+yy1OPKnbEixw3DpQs=
X-Forefront-PRVS: 01208B1E18
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(189002)(199003)(24454002)(1076002)(97736004)(42882006)(8676002)(47776003)(189998001)(68736007)(81156014)(76176999)(50986999)(81166006)(6916009)(97756001)(54356999)(101416001)(33716001)(586003)(77096005)(305945005)(105586002)(23726003)(6116002)(83506001)(3846002)(5660300001)(33656002)(106356001)(50466002)(2950100002)(4001350100001)(6666003)(9686002)(7736002)(2906002)(4326007)(66066001)(7846002)(46406003)(92566002)(42186005)(110136003)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR07MB2585;H:hardcore;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR07MB2585;23:zLlthlkJbCPe5EceKynMpgNPwvGxA/enZsBbM7/iT?=
 =?us-ascii?Q?YtvI8BOqlXn8H1Puc5wCgxHqWOMmhh5J6RjeMoisSf1zQZ14K9v15uE7wm8W?=
 =?us-ascii?Q?JHku0nXuJTnC/V/M40FTCFirOIsOfGjZoKmidQzs90k2qA1qwJmU5E/Bu2DK?=
 =?us-ascii?Q?Hb5asOcXnJWgc//XH7Jyx0Oqtyoooz8ttD5An7085g/0JUUlebDIa1MrzBaO?=
 =?us-ascii?Q?cTlYJFqP4Xp7Z/G9OOh7fEJPki4XOfwOzRAppWbvHTZQtyN+QH3b4STpOvi6?=
 =?us-ascii?Q?ay/ImwMbHilc/6robvDlrtnbgLmuwajDc9Dx9daJ/sx325U/O7G2MDlCtA3W?=
 =?us-ascii?Q?FNUtq3n+7cI8Ya8zDvyFWpw5SwhsxHwWNT2fESZavz7I2b+sKo361VKa3kx7?=
 =?us-ascii?Q?rcuFAiSVWYIU7BS9kheuYCg8sRSVso3Xdh+UrEH+NSIrnqj5IoH11QcAoz8W?=
 =?us-ascii?Q?yJDGU9Mul3bGDiJUH39a/9paFKuBmG6v4i1XzfiEIzT1Bpz+R1efg9Ouvsej?=
 =?us-ascii?Q?bdXLYZUQ4XSZvqia4fY7uyj62yzDdxrTzKspNY7iVJlt9zG0MSZw2hX2Tga8?=
 =?us-ascii?Q?NLWwI2gkPLawDkFvkm36NzZfNgumwTyRUvPtLxzuVUSU3cucIVrfRNB71PJM?=
 =?us-ascii?Q?5C2nrxGScO1ZHUH0TdiFXmuZXsKkD1cfwVe+RITRLE51zfJpDUCSpFMbcvTK?=
 =?us-ascii?Q?SYBCcaU3J7bZZi9LWqWOYFaOSwC97x4Q0skVCC+FsdZcl3vz01z7Vvd9d2xa?=
 =?us-ascii?Q?sUBsGisYSmoEIMDJMbHJjHlgVYN2pE72p5BKmc7InxFJIqmJofrBa7dEnL6a?=
 =?us-ascii?Q?FKSJF+Ap6x4KQUmVayRpHMiJf3Dbd0ygyWLdFfXBKgbWCv+S9Imrt/5yZYsl?=
 =?us-ascii?Q?RXgSg/Z70Q/oe+HzfuA4ONjHV9+vSRKXjwkqzcoukAon4//PZip2RYM8RiNk?=
 =?us-ascii?Q?20G+8cZ/opIvoN86ZZa0Td9JGeNsuuwZD5RuNDLjviQncuunyXK2HYYWJ8eM?=
 =?us-ascii?Q?jMctT/iEa16ZjEVWs8Tb/L1Q4KkFrvqaTQB4XIJ07p/yIVXj5ylY3vHSm93l?=
 =?us-ascii?Q?W8I3W9sYXEDUIrOgSveExk87s3OEjxf7QboCYACbfJIHRZa01GGIxPCDM2UD?=
 =?us-ascii?Q?IMocAs2J4GuM+7/txC60fglYJiyiFbd+sWUyZ5QjJ8ldiZT4XbtaN/vjElk3?=
 =?us-ascii?Q?/y1BrWpAELk4OI=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2585;6:VCkvCI+nE+Yp/0vOXZwXP6FlCnWXw4NVSgT8aveG2bZDUpUyp/XA9OBzxJDZgGAQzEw1vFY5n/Nnno9Zjqh3aly6PUudkKhhmbf9rfgFljLR3IH1zM/pdJoGLMKpVTa+afGARpoxFyQS/mbMMQtIPnUDmuqojU+L+Pa0YsiGuRAmebS6jmeRCX8FLI928oLZSU6GYABeRjiYuo4SNzO1JA74CYBFZ8/6MQTqsJsItBj/Xq5pAGtjNcQt64+lqMrQP2X0tl4naXbGl+6q8FiuUN73VSvrcT2GLtTVlxvuJ61LTPamSChgXaBEObuVrkYa;5:MoOzH4snGlI8JX3/f7x4O+nCRN5Mn7lQWbkS+tQp8f3hejr3Dv5ZLf9qfsAoTmDSiGlGWSORS9kZPCbl6qUfsCgaKfLww85o9/cpHmLjcz2UIRGzrBxwHn4WukWwESJBm+HEXleMCfhl4ip3erC8rewkct/YlkU2gFWbLEn2J8U=;24:qIuyPOMu4lj0BpTgO6VlY19hQUYmhwvJHCZxK554ywnAhuyOiIXGFLRXAsOADnbj+qn3c1gVMaOjTePP1TGVfgbmpvEu6ZNJrzh9WUYQK6g=;7:KCxMfFCWuaowDnGqw/92jCXTO6gu/WSqRErueg6B5bxf32ntk78/E3rICjbfOsfA7VJticmViIyoKDs4zW0GX5I3vihWw8evmmemwcbwDn2c1Dd7pbBPexQfnQlla4gZPiBovAYEWFYYyuu1NxgWAhNuZxBloySvuR1JUoTaUfWFisObakY9VxYp9sO8Tuhgg23zsfOPSqhDfn3Fpu1PwWolbyogaYAhGB/neTvV6fyA+XRYZLW1HA9ZI4cGLgOFA6x3gW8MQ+hcU4MhVn7PVJ/nRy8xPSGF2g1qnNG3BcDcgshP5EphfbPrNgXo8OxzBmyew4BZkrvvGDilgDCo184wSFY0rIptPyH7VGOJU8A=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2016 07:13:51.0931 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2585
Return-Path: <Jan.Glauber@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55723
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jan.glauber@caviumnetworks.com
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

On Mon, Nov 07, 2016 at 08:09:20PM +0000, Paul Burton wrote:
> Commit 70121f7f3725 ("i2c: octeon: thunderx: Limit register access
> retries") attempted to replace potentially infinite loops with ones
> which will time out using readq_poll_timeout, but in doing so it
> inverted the condition for exiting this loop.
> 
> Tested on a Rhino Labs UTM-8 with Octeon CN7130.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Jan Glauber <jglauber@cavium.com>
> Cc: David Daney <david.daney@cavium.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-i2c@vger.kernel.org
> 
> ---

Acked-by: Jan Glauber <jglauber@cavium.com>

Thanks for spotting this. I think this should go into stable too for
4.8, so adding Cc: stable@vger.kernel.org.

>  drivers/i2c/busses/i2c-octeon-core.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-octeon-core.h b/drivers/i2c/busses/i2c-octeon-core.h
> index 1db7c83..d980406 100644
> --- a/drivers/i2c/busses/i2c-octeon-core.h
> +++ b/drivers/i2c/busses/i2c-octeon-core.h
> @@ -146,8 +146,9 @@ static inline void octeon_i2c_reg_write(struct octeon_i2c *i2c, u64 eop_reg, u8
>  
>  	__raw_writeq(SW_TWSI_V | eop_reg | data, i2c->twsi_base + SW_TWSI(i2c));
>  
> -	readq_poll_timeout(i2c->twsi_base + SW_TWSI(i2c), tmp, tmp & SW_TWSI_V,
> -			   I2C_OCTEON_EVENT_WAIT, i2c->adap.timeout);
> +	readq_poll_timeout(i2c->twsi_base + SW_TWSI(i2c), tmp,
> +			   !(tmp & SW_TWSI_V), I2C_OCTEON_EVENT_WAIT,
> +			   i2c->adap.timeout);
>  }
>  
>  #define octeon_i2c_ctl_write(i2c, val)					\
> @@ -173,7 +174,7 @@ static inline int octeon_i2c_reg_read(struct octeon_i2c *i2c, u64 eop_reg,
>  	__raw_writeq(SW_TWSI_V | eop_reg | SW_TWSI_R, i2c->twsi_base + SW_TWSI(i2c));
>  
>  	ret = readq_poll_timeout(i2c->twsi_base + SW_TWSI(i2c), tmp,
> -				 tmp & SW_TWSI_V, I2C_OCTEON_EVENT_WAIT,
> +				 !(tmp & SW_TWSI_V), I2C_OCTEON_EVENT_WAIT,
>  				 i2c->adap.timeout);
>  	if (error)
>  		*error = ret;
> -- 
> 2.10.2
