Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2017 21:00:42 +0100 (CET)
Received: from mail-cys01nam02on0068.outbound.protection.outlook.com ([104.47.37.68]:34944
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993889AbdAQUAfMtrAm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Jan 2017 21:00:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Te9Qze0ggGvE6fsvq2Qd4CCMvnqYvhpwOSyUd6Mysro=;
 b=WU2GimVXT7nlFZtpQOMGw2wv0yBC8gxvRoCxnlzJdFQl2YHb6Zgnc26u1mNaaTz3qEH6Te2IDxBSrEctrFiMvHMlLF+qK30SzN51uB3fYo1V077bIcDI+W42h3vt1A8QsjtQkb78erMF8ddvRf1S1tjMPJTuceYi+SpqxV+y95I=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 SN1PR07MB2144.namprd07.prod.outlook.com (10.164.47.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.845.12; Tue, 17 Jan 2017 20:00:26 +0000
Subject: Re: [PATCH 11/13] MIPS: octeon: avoid empty-body warning
To:     Arnd Bergmann <arnd@arndb.de>, Ralf Baechle <ralf@linux-mips.org>,
        "Hill, Steven" <Steven.Hill@caviumnetworks.com>
References: <20170117151911.4109452-1-arnd@arndb.de>
 <20170117151911.4109452-11-arnd@arndb.de>
CC:     <linux-mips@linux-mips.org>,
        Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>,
        Vineet Gupta <vgupta@synopsys.com>,
        <linux-kernel@vger.kernel.org>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <4d7895e9-5554-8cfa-f33f-37f84c1d26db@caviumnetworks.com>
Date:   Tue, 17 Jan 2017 12:00:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170117151911.4109452-11-arnd@arndb.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: MWHPR07CA0007.namprd07.prod.outlook.com (10.172.94.17) To
 SN1PR07MB2144.namprd07.prod.outlook.com (10.164.47.14)
X-MS-Office365-Filtering-Correlation-Id: 196c078c-dcfc-495e-3126-08d43f137b36
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:SN1PR07MB2144;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2144;3:lqqlbud/aj7AfvJGQfJU8K6Ea6gLaSPqvln1IIS4EXVcKmJOiZzbNvJMQpRun5NH1T6uMRzjDF5NSA4n3V2sfbMa2DlqniS2Cv3lEKr866LuA6U+U9DGlEQLgOVBw90X5dVQwdkBsJ5cAcT7HdrlC86lZZ+hcAzD7UMhAsA9Jfq0sBiz3FiqHZhJK6235DUSeOYh8uukM/77TAUoVzg6HdvNN7MZFoaD3G5f9lRLwtCOv+E//qVJirJDN65BRYD0JLkTTlG9ivJII+U9CZ1Dgg==
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2144;25:7RvGtBsbLDJ2hlrqIa1EKr6HpeZwkdpfyCZGlc7eAzx1iEXXk4nEkgHx6t8cxkesgrlf2Y8M1mGPjgaOM+5fN8jMyM96wu6AQ7dSHCDo8asGtmE/4jD0lJOmY2aLWU5db5sTEesnXXi9/UTWWOWgxnrBL6h1y4QYdCzOqf6DAu+qaZ7GylckQ+MuRgb656rIR1EjA6VYZsVpbFNyh9HYT1iWwPKp8NoA/pBo8SSPH5aARfxvS2+lQJMwRTEGHP/mgqweQhcz7TvbOzk5uPxZ7MtXzSkw4pBuj48S0zK+PNW3B7S3jFYoTJ5p3Yh8xm/NNtPELZpeHgiTYex6744v/39WxVkYFfsJN4HtCKYXr2LjzDJV2fkhhaiRFuJ0SIQwUDRw+vjdTlA5ms+yVzK9qFSAfeIj5D3pBiDEllmm6B6BvUquLoV/9lpIVQpIPbZ/tNM/up8eHlAGbWHggjhijtulWd8DNcXLBvXrV7s6mL8LVwwKLlmT8mMPgaAJEtv8wYw9G0ZJJJ5coJE20TFAnA1ZcxeROlXHyifmNtzNsvss5jj80T1+M1hmo7utIswHAbk5+cQw2qH+kIH2OW8C1ySy08Rtkgcy9DO8KtKxMv6gZakBiSZH0OotvsVU/fs1xe8QqwNjLWjn2fzGJL4gtjB/6Da3+BaOrX/XhpI8tLIRu8WpeOU8JlXJXLoZt4wD0KLjRJF3mFdfRfkzL77Pb8eJiYlWTgJY1PoNJpy6Mu5kE8hSw5MTxAR+AQBitCCChIXOLkb/nUAhmS7E6bomdS0vzWosnIC/+vd0+LoFuLc=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2144;31:PiDM/1yf12mRG6wajSlmDUp75OiUT0MO1Bwl7xojhFzQWvM+cCbAj/Taox+OyIdkGn5yq1XmsN8LAADi7aKPzvlNN0cesL0btWsubFp8t5GdX3wrkjJujtwBLkzFhWqeQiG4PX+wbOr+wMW33JJkwWZCdmVTVxTjT+1Fe4nv+mAqQiVAMvbjCl7TdEhuHEwRALgA3fNKaVxwfPT6HNPqTbuV+t2/lqLq95t6vbkd+6Jk0tYREBkqceFH9ABpx84C;20:zUBs/Mfr2IfLZbpWD3Vvh/NPb3dqslOnmWiRtMu/VB3vUCBUGZVpkFrTzQE7D/LC/dCjrOzuonE595S8utmmwOJs6BzGl0G2aQBxzdyg0wJmQTo59H/ClUrMzKFUMJwoxgD/VukrS1TFRwSA9Lyrxgm8SMi4yPcOXOTFcnmw8ohfHLBOK6ij6sC3SdxPXgpDmYuPRN3rdT+cS7EWtAKLMee4QuXXY1BNsbzcln8DcsHQ/r6JB2jDy27sphcXTZnnU5waSVwIGckEc2rWLFc0++Iv0xU4wbuGqT2N1IivkCgT+Fx4jSn9KjeIHRMnM37xyMPKhBb7B5Nu/duiMDJNMEOVk4FU4HtASTGEVckwPmXpP93j7uNSagVUpVgwmIZgpWeGpM8/EZqG6P97cXUoa5CWwFUCCfbX55AwWqMhkAKmIn2yGHmCPmCqLzMY8TLqx5ShzgLu1JV54Yr/lBaTCxAfxs6hAx0renYm8+1V+zoQiGY4dx2pYGo4Kj6FaTV9+IHjci4FQKRDz10547UR1OIOVUJpInl0SFEgtJg5CkItJ3Bm9T2dKd55S3kcpVTfyVq0ggpzZqB/5hWpX6WHTfuTegC7lWYxBVOM6iL/fx8=
X-Microsoft-Antispam-PRVS: <SN1PR07MB21447A042A4154C6377F9983977C0@SN1PR07MB2144.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(20558992708506);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001)(6041248)(20161123562025)(20161123564025)(20161123555025)(20161123558021)(20161123560025)(6072148);SRVR:SN1PR07MB2144;BCL:0;PCL:0;RULEID:;SRVR:SN1PR07MB2144;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2144;4:zeEnivusdZh8k4QVljQ1/Q2ukUYvCNhPYzqVvGwXk/ja+S4PrLTYgMT/4qJhGd/xlpCyn+QTwaKUGintQQYFSU8b03gF9GNToaerX/pOrqbspvzy7X3nZcSgvhjD2kgBWo5mgwY4g2zTwRv4hs6FnSEPRJO9ZC8ShHowjtnoBeag1BkAF1IoTftMhu/ar4gIWU4K8qT68d6cvLRKdNwyswDHDhjiFQESz/n6PU6t+lGvxJsJYqrRzs3dS7pz115/CmM0yw/XvIcg0h96lM6333tEdbuMtgvYEGimC6ebhDLi2qFMJWK59dai28puZHqbjpvACWIWZCi2NOXLoQu3yyBCaWIA/gNxOEUoqIMJ0nfRXmpUGa0SKACfouDErWVrT4xeXuCI8V+9ZTbE415Od7kme0uPgFPOyaZt3WnIYKDHAlzBsfz/o+ZTEb5fUxIdIVuNH9oG0gCHS6WkucasiR/CdKVF/dOYtGXAnEQd2e1bTu6cHmLUhLuoj5hUf4AgD5yg/HmQ3KSo5dsl4SOD7B0NC6Yw+FMwP5qKSdC17HwHX3eGn8XLueHJDncLoI5sq9ZxrkPil4c6vh8OMHYcL5UwCvhZBiXTcAp1jrQ2WMUhKUuk1x4kcw25OSZPDDeI04GarLf4+rnDNlcNsSmxZQ==
X-Forefront-PRVS: 01901B3451
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(39450400003)(189002)(24454002)(377454003)(199003)(6666003)(33646002)(42186005)(2950100002)(42882006)(68736007)(53416004)(50986999)(23746002)(65826007)(6862003)(101416001)(6512007)(5001770100001)(50466002)(106356001)(83506001)(105586002)(53936002)(76176999)(97736004)(189998001)(69596002)(6506006)(2906002)(54356999)(54906002)(4326007)(6636002)(92566002)(25786008)(64126003)(4001350100001)(229853002)(230700001)(31686004)(5660300001)(6486002)(38730400001)(6116002)(81156014)(3846002)(81166006)(305945005)(31696002)(36756003)(47776003)(7736002)(65956001)(8676002)(66066001)(65806001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB2144;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;SN1PR07MB2144;23:RN4VxvMHPY/Ii7XZX8JLgPVc4jWmmIgiaDxc3?=
 =?Windows-1252?Q?jpOJluwvkyTIy/8zmUXg7CotoqkSMCVPtd/pGQsEwHn6voSRxc4U1MdP?=
 =?Windows-1252?Q?AtAAHgFhE3k0I9bM/SqvcJid2rvbTjJb8xsTYSWmJbJamJTcrZiswGXz?=
 =?Windows-1252?Q?J87YCuLprLtzMv0vO28LswkCoWZA3q0aRSh706mOd00G4OjIxhQZudKN?=
 =?Windows-1252?Q?xJfTYUXSsOb5GAS/9WBy+AoXJE+vB+07ICppgEkaBwi/+KP5eZyhEeYB?=
 =?Windows-1252?Q?FyTxaRiUh7ESbQbKZ72Sl2BDoBTYbIWRe8rGCt0yHxgkB3+MIbMq8yTq?=
 =?Windows-1252?Q?y3RgveMNmWWMZmYobhKjoZ5Sj7LQqd923YfGHrVMf+GEub4rCjOU55sG?=
 =?Windows-1252?Q?WvrUqR8orSc148DeJOyaBSPbRGUKiyz3515Zz3BlpByTpHkSWcLbA2WY?=
 =?Windows-1252?Q?C5MXBrLZAMqEMwLMYlnnzfA2L9bNzO6cnuqYn/KIlQBAUmeQjuooZd5N?=
 =?Windows-1252?Q?G8UjfSL7buRR/4PfV4vcmVGq5jEB0S5t74esAHe4CdRye45vBGoYoGYu?=
 =?Windows-1252?Q?KGA7/+Ouo18+Nka9z1NcMe2GopBkUObiiqu6PX/KUBb8WrhGrph6ssx8?=
 =?Windows-1252?Q?efEIgDYMndB6BoBo5WDcK6o5kHfFG7CX0bvw36MIcVzUBL4/UyCksQec?=
 =?Windows-1252?Q?3IiKk8sYV4MFsp8aLjhRZ8PPtnYyougTDcXwGp9G3fYGIplcjXIGuTjR?=
 =?Windows-1252?Q?GSeh5UGPIC1/yCw428SJusippHa9Tf2KPagxcGO+6hjzTuwY43MA4hB7?=
 =?Windows-1252?Q?AGmMW8lTWAiD1znqP5JvWGTceINjbPNHO3N3VzNicn+lJuN9hHsopc7D?=
 =?Windows-1252?Q?TuIo3ge/4v1UMFWfmDfPtlZYm29alVmq57Sj4U5C8wQiXBDTmUeH47mG?=
 =?Windows-1252?Q?CxyilplqmFUYzagsQ0XlcmKymTkK5HK3/378v/5F9qfEcMYRwovKcNNM?=
 =?Windows-1252?Q?hJEDD31qqnoC1Bl3QA3GFEwmy3V5FZ42xzUNRgVXyB/iEVzobePfeyLX?=
 =?Windows-1252?Q?7PY2UiCUhUyqyeREU9IpSYj4ohmFRGiphV2zhEHRrQGeAYedHz47njx+?=
 =?Windows-1252?Q?iIzyFG1Yk1DoE+11LUV+8AFxeX+xaK3q4iNw76ZaukFkOx4Kv2gb2VwF?=
 =?Windows-1252?Q?ierh1u+nap331XWfrLYdIMTFWWGEyzTG8MeFBh1PCnJRHRbWadXMFVce?=
 =?Windows-1252?Q?ysYz2iQ6kPqYRuwtdFBnmGl4xYMWEiScs/qUy6v8QN+DxKL2bwhcXBRl?=
 =?Windows-1252?Q?5Z3ZKg7WwcmcCBMgcmcRQyQrkZCLBvRUvGK4G+eLcWQkTSV/PYvplvEV?=
 =?Windows-1252?Q?U4MlGvL/KhdIwSAT2ZYo5U+msqil6Tpi9RYJctSK45OjG9bpk9vjyAiW?=
 =?Windows-1252?Q?0XpLMIoFa39b9GF2l4WX/126AFALPtyzDwdIG6GsPx6YNF/i9ime8RB1?=
 =?Windows-1252?Q?GomfpOsT+B7ZOWAoKDZE5kJI0y1uf+MgT9xkA9YJJzDiDWu54LIX6Wmw?=
 =?Windows-1252?Q?2/glIijl5QeAks=3D?=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2144;6:rtAkU498EtnQyZwfYTV1jO9846ec+C26mQxWEMI6jvUpCxoyVCt5tIeODfPUB8YoOfI7mnmguPSpcxo0VLHQKgMLRGCy4zwP8jjGrsA/d9QrM8y8vR3px+XEQ1+Ddfp+GhF/AH1P1fr6PY4wJdagOFLxLzcBB2kVMQomau73A/0pY1jEhAosseHpkMnTmLT1Jzyn4xIWlHlDrN4BPkRmposI4poCTITuiylI9ja9HCw0kTO6pMdfveNF0cZZ4Wsur5RSDgwvJhzW+n/ciZ5usBmFSlWz9fvMixT3GHZ5mEkVYT7vS47gR7XD7dEBzLMkyqbOJPwnX7FxItLoRsBV/FS05waDR4uuWP9cik9y6KIXK6sG7xFmbHHPhHSSucZ37MNl4CwJr/zLFPY4nX7s2y+rMuROtEHBkENSOdRmYpI=;5:G4GVTClA4psbOAznCJrBUIooIRuNXRlAslxYrgKdYMQwAQStvOIyKebrqCsMIws4M1zaGF/hALtIR4T5eboJgyt5LZ6RknaAsZs9I/6T6u2yWAuwT21nYdpE0T4f6lOLLTb7nXyXhHxUSfVoSoSk0g==;24:71L24VrktEze2vkXwmJKDguDoIiWcesKK9TGh1QNKsGJ2V1Z67rkt1weY9eVvLvuIfbm+FdP8wIjxQ3jvLYWHGqlNy36hPYmVej/JskiNvg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2144;7:ScNJ5tvNxKrMjYJTLi+xehwYwQp8zu89CnTaUjUbJRLfP6dVO/yaMJc7L7eVy2tNwgZ+nrfMWpB9zkpQCumqSRL4epYpn5DEhhNqBgLv1omj2ljG3e1eeHVqTzFxgqErSyDCSp7IRr2835YoRlgwgawvon3RD8Ty+u/wHYJaOqAevvTIVJqtEiCS9jyav+Y1YHP8Y2Gm5T8aDbrQdHbjp/qFszpSMO7SSFaLQac5WTT/L01zxlyWr6PUEJM250DV6tZ61Ww6NbhcF+JJ0ic4GNjEgOFU5x1FxbpHM6iZJ0YNI8wYjE0Z4m1L4b/avn3tSBQkjmVSnJ34zxrY3cvwdKvkurqTNtXLOlKVEHC2Oc6psx9+dxAuuV3VE+ufgpM2hVYgA9DUl4Meg6QE7CDmbLhFo/E1Ximfl1w3ZKn1lgKZEY2QYVYUnXwPrbrzvCpR6xuG+JnGwT8YGTmOr2i4zQ==
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2017 20:00:26.3855 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB2144
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56369
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

On 01/17/2017 07:18 AM, Arnd Bergmann wrote:
> gcc-6 reports a harmless build warning:
>
> arch/mips/cavium-octeon/dma-octeon.c: In function 'octeon_dma_alloc_coherent':
> arch/mips/cavium-octeon/dma-octeon.c:179:3: error: suggest braces around empty body in an 'else' statement [-Werror=empty-body]
>
> We can fix this by rearranging the code slightly using the
> IS_ENABLED() macro.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: David Daney <david.daney@cavium.com>

Steven: Please test this patch.


Thanks,
David Daney

> ---
>  arch/mips/cavium-octeon/dma-octeon.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/arch/mips/cavium-octeon/dma-octeon.c b/arch/mips/cavium-octeon/dma-octeon.c
> index fd69528b24fb..1226965e1e4f 100644
> --- a/arch/mips/cavium-octeon/dma-octeon.c
> +++ b/arch/mips/cavium-octeon/dma-octeon.c
> @@ -164,19 +164,14 @@ static void *octeon_dma_alloc_coherent(struct device *dev, size_t size,
>  	/* ignore region specifiers */
>  	gfp &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
>
> -#ifdef CONFIG_ZONE_DMA
> -	if (dev == NULL)
> +	if (IS_ENABLED(CONFIG_ZONE_DMA) && dev == NULL)
>  		gfp |= __GFP_DMA;
> -	else if (dev->coherent_dma_mask <= DMA_BIT_MASK(24))
> +	else if (IS_ENABLED(CONFIG_ZONE_DMA) &&
> +		 dev->coherent_dma_mask <= DMA_BIT_MASK(24))
>  		gfp |= __GFP_DMA;
> -	else
> -#endif
> -#ifdef CONFIG_ZONE_DMA32
> -	     if (dev->coherent_dma_mask <= DMA_BIT_MASK(32))
> +	else if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
> +		 dev->coherent_dma_mask <= DMA_BIT_MASK(32))
>  		gfp |= __GFP_DMA32;
> -	else
> -#endif
> -		;
>
>  	/* Don't invoke OOM killer */
>  	gfp |= __GFP_NORETRY;
>
