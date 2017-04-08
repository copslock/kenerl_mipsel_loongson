Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Apr 2017 11:14:38 +0200 (CEST)
Received: from mail-by2nam01on0069.outbound.protection.outlook.com ([104.47.34.69]:28961
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992143AbdDHJO34LEoQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 8 Apr 2017 11:14:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=s/oThK9sEIil8gu7O+BSZ5WiZEgN6WPKDzIL/V27Ojg=;
 b=KaGV/LisjITU902MYbBrpMnaKDWGU/UvWiJFggwVtLosTz8bSVgcA3Zzx8MGTOed3CUtIHMBn8Nh2pvm1rWVSfEsQ3LYn7bbRNwgkGUZyLJVmN5GacuXaMQfyGdZrdfXwiOMZGRJA4YsGdGt7XHjEFroq4mcI+96QIHvT4oLcvo=
Authentication-Results: iki.fi; dkim=none (message not signed)
 header.d=none;iki.fi; dmarc=none action=none header.from=caviumnetworks.com;
Received: from hardcore (46.5.206.242) by
 CY1PR07MB2585.namprd07.prod.outlook.com (10.167.16.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1005.10; Sat, 8 Apr 2017 09:14:20 +0000
Date:   Sat, 8 Apr 2017 11:14:02 +0200
From:   Jan Glauber <jan.glauber@caviumnetworks.com>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     "Steven J. Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, linux-mmc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v9] mmc: OCTEON: Add host driver for OCTEON MMC
 controller.
Message-ID: <20170408091402.GA2930@hardcore>
References: <836c0ca9-18f0-f6b5-bb79-8d0301d54154@cavium.com>
 <c1d0ccad-10e2-9d5d-8192-2bbd7d7357b3@cavium.com>
 <20170408001335.2eyajki3ujgomcz4@raspberrypi-3.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170408001335.2eyajki3ujgomcz4@raspberrypi-3.musicnaut.iki.fi>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [46.5.206.242]
X-ClientProxiedBy: AM5PR0701CA0056.eurprd07.prod.outlook.com (10.169.145.146)
 To CY1PR07MB2585.namprd07.prod.outlook.com (10.167.16.135)
X-MS-Office365-Filtering-Correlation-Id: 194b2c9f-c316-4c9d-94c6-08d47e5fa4f6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(201703131423075)(201703031133081);SRVR:CY1PR07MB2585;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2585;3:xWJqdR1js3u671E2HvMkgap3+cX7amMVADeUImMwju78YoTWR4u9i/JyjiVbW4sp++dJqU8y2BV/YHvDA5rmP3WJKd5M3+UbW1IjVGZYmQ5O6RVzBIdka5meGXf/XBw2l1PGUjKvfedhiYVmFgw/4o3l9nrw7I4/XPIcmHQSobL30GCUzVlcT1/di5sqiXX523gPloeEHYgeM32ksum4VqKtlRaEfsDzqvJR6NEgHkfgUrD9lsUo0V0/E1xDOQcNeXcjUwQhisoPr/58IqWVJjaycZ6ZgpZIw2nrmxTztSzOikCbjNxnPaJM0O5Qr+rev5KNj32fyiRuiKdYllByhw==;25:uB4gSl0mJ7IvLIRNranfTNSeFWlRzzhbIXcoNJMzxtuojx2Qq5MU96dp6ltVvMBDYEmJQQkW6iRs68GGCOitqfNPCNUC9XMT0XTVJj9/Y6VeRPIwffVdCmyN0FlEGCq4cqPaPiHHwCuXcvAUgjafHXg6I3VFrudke5UDVlxYV+X6j/1rzp8Wha5b3v3GozKA7YMLCxub2mbIcpDENvLN1faXGwKU46WwCp6Loa0iSh4AbXSwnThLsFwtuUtZeQBWdyf5kQEiY1+fNKjzUT6Usdh28Mkbr7BwjOV5u2YspCwVbWXu4tnPse12rJ+2CiWm+26d7JqsBKpFIXYG57Idm5j47U2imdzIL08MigkiWHpKlWD4P+8l03sx0dAoe9v9F12Gxp+Arl8BVFZvwwYPEBA+KsjDeKL7Z4o36pgieQ0wHuwov0niBC9KxBTXgoKV6qZ9a3GHhcRVToObrLgJaA==
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2585;31:VSVMh/w7Z3TdvGwIZeBeT5YA7uIA6JffgNHUqIfm00yHZBjo8MQN1qP6hpTGBTt/11RjyedPYKf4bpzsXwo6uPAaQR5f6ytATFcpZbr7SROFUUHlGNyBqMJ+5nBVATJjVJ2l3bjmBmYM0KD5OfE7so+ymsWIX4XvYjAXkYgGDm3N7zNe2vUe9cMg3vzRNadO1G5W0EjJccvspK1rHUf/YceEGvxY5uA9FfvwC5nsGCCbWyfNnYzBP+jLdpBsc6lc;20:aAzc1Rbe/8FYTk4IUEp+NZEnRS5G7igsyUQkccD0qASHzd5qD9kxlh21lzc1VWhnKKezhcImuXPZNQN6Y2jUMgRx6+u4mg2Zlsx+94js4wzcS5ycghK1BM1Jex8chsUcPB7o6ooa/T0l6bFkbQl6HALqcwbN/0w6w7Pa5GeWwYDDyQL56qs74ZfSSj81ZsHba4pJOCJhlUDnoQVGXlXDMXHyp3ghg+gm7jY2Vh8hHpnhQmO7uztmGvSmoGgfMwRkctq2JomgWFcz/JKtZlROc8WzeXy/V7FniOp3omCopMF8+h0tOZhohcPJkxpCXRsIuUImKZ5i4HhbKmYE2vnr/ci6SpxmzidKQi+vUxYMKzMITm9hIFg4loNejx5vdslrNA3ykAax9/GY7j2qhbVMF7IGgx5ZEbSsaVarnhGGsydIHAwMN9WIgI+jjCT0HkHkBXcuql9cwCoq+CVRGRhH2yxIwIZ/nSCIDNDe/Jc/ElVXA6QTN6/B2pZNC4fz521A8kZQrKydFC4enhD63pxs4uSnGw3Fcq/RDF/XX1MmQ6pkNNS35mqDp8gpE8nNSiLscbCBXUm5XN4aRvoWhouVhPSE26hQ6gFcnDIAJRB/2AY=
X-Microsoft-Antispam-PRVS: <CY1PR07MB25858CACCC4DF640756904F1910F0@CY1PR07MB2585.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(601004)(2401047)(8121501046)(5005006)(3002001)(93006095)(10201501046)(6041248)(201703131423075)(201702281528075)(201703061421075)(20161123564025)(20161123562025)(20161123555025)(20161123560025)(6072148);SRVR:CY1PR07MB2585;BCL:0;PCL:0;RULEID:;SRVR:CY1PR07MB2585;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2585;4:SN9jo6pl7r+O1UWIx8Z1M/V7ufaYJuz85oqYJWThKeSkfkKW+Iw7ExwOae0g/Lz0xDtfD8iQz4K06O6EsRU6uvMW+jNxlGlZjKYuT1XurUTyIepzWdChPzyFF154CvrA4LMvh0Jg6qAU543ZhoaVmw5iS72jMLfe4q5ntuFlqnjKwlfGJJLxk8RvFak4pAbirHfWgZqlu3VAa1gNreKRpKtSuZuiMiT1r3Gn9CyhQaPohjW+gbyqgeiD4BjOkWFia9L/8xm+cpCcqHb4AANIC//4oOOdHuy6I6zUW0HTkYA6ol9DwYcgCLkPBC3iuKEwJRmtFkStB7Sapf5mZKGEZSJw2KJ53+H/KqqQ9/HlouexgaYiB6hgum5hXFzB7Xs2yq/rNKbDmkoZu49/D3r5jY9MpYdfl6L98zZhtpG/SNOKpcesphidus9galK9pX9K2ZkXhANiAvEJ60fjE3lYU88qvyVE3/dQdrBBIaQg9YOoXUnWCa83nH7RZeaLGmgu3vodD+W1dO0xcOk1SBe+ahTxgAl7ICxkTSJCnSiTCyutJmBGJEx1PNF3nChfQ6xJpz8R7GaY0sY05EtYGKmtph0/4Vl3ujxW800UsoH2R0M27jXSpmgah93/0Zl0ofucQZtOjj2KW6blyMBvUTwe6vmV+ceF0iz8jYPldy2w+YeAJnWsKZGiafLkHI3XVDzi
X-Forefront-PRVS: 0271483E06
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39850400002)(39840400002)(39410400002)(39450400003)(39400400002)(377454003)(305945005)(6246003)(110136004)(5660300001)(33656002)(7736002)(47776003)(66066001)(2906002)(4326008)(42186005)(83506001)(53546009)(25786009)(6666003)(2950100002)(6916009)(42882006)(8676002)(229853002)(50466002)(81166006)(76176999)(50986999)(6496005)(54356999)(33716001)(55016002)(23726003)(54906002)(189998001)(6306002)(4001350100001)(107886003)(38730400002)(6116002)(3846002)(9686003)(1076002)(53936002)(18370500001)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR07MB2585;H:hardcore;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR07MB2585;23:Ypz7Rd/xhx9SoSaU0I3e2QlRYyVc5pf1c/YGqO2kx?=
 =?us-ascii?Q?yet4VD0jwSZmq8VtwNp18bzfbS5GTwTBIwE5B7O5EQmmGEuimT1OFXkoM7qD?=
 =?us-ascii?Q?DGDe7SW97sHcqr3IbHsU92J1gQdIR8pqAm3EegLF8sPNRc6ZYtxqxanN/857?=
 =?us-ascii?Q?zMFSpK1dEhxGl/ppC8EmeSElQNSSIZFkyATfn9I/76REbI/Q9LlNpnJSGTqK?=
 =?us-ascii?Q?tmZyO3UsqmaWQ9OfWqwLugZMHa4gbQH1zJyt/JR2lr9+RNMd4oL1gqFh08iv?=
 =?us-ascii?Q?OR/IgtR1UymiO4OmHJ6XaAaZmjeXpucrlp9UbiuAF76nEnO1Awim6HsRO3O7?=
 =?us-ascii?Q?ns6Xb6Sa8tmTdkce3cQrAUBWcJEY0bgi0LFVN9LhySRCjhx7jVVFZ2PxAnTX?=
 =?us-ascii?Q?WDIBih/+vvJZwFB1ZjDbThheeJpdmYMv7wqsfz54AGYOsnlT7cSvWXbGAU2C?=
 =?us-ascii?Q?IlS98dKCbBjaXDTM8t5PHmY7mlIvONuC6AuWK2jWttNxqI8W37u7k1LxDp5r?=
 =?us-ascii?Q?QRhrI7wwoK/Vtxr3SXZ/chYtOaGK+hR1XMtaqSiy9lEz7C90S8dGtmPJ3LZQ?=
 =?us-ascii?Q?d6wnjOI6yFxcTFUIFy/28Ens7bC2jEA1DvoPXLba+i22QMa04CkhHm9g2+Cv?=
 =?us-ascii?Q?Ym7p9rV10jukK9FZordStgxRTQEFbZ+udmh2tlGlKzBJPmDXmoTl4hUDE22I?=
 =?us-ascii?Q?HDSm2ZcPA0TvFEW/jQaN/YSIL63PXpVOTpmpOezax/u0WyAt/8yHat3BH86b?=
 =?us-ascii?Q?D7XuF2lsHUMa/dsI0zbhVWCXpL7DNfYgDu2dHKZpSerR9/u7y/WwCzoX7/pw?=
 =?us-ascii?Q?2651v6/EqI/Cr+0dDBBcJN+xBI3fYVCz+wa8Dw4Le2eI+FP6lKOp47/p24vD?=
 =?us-ascii?Q?z1qK7lnDomhtT5PsaOJZQejBJuFamSxYcz0hoynxBd3dTsvgaALeUw4lday1?=
 =?us-ascii?Q?a1R/zhW0SlUz1SuG7lJnxWIh7fzIGws8tF8lXVHV9WyY1ZmXgEPNIchx58Zz?=
 =?us-ascii?Q?wdJ6YtlrEzcnkaGcv4fgZUJdEM7j+tCnFBVfW0IKjgtl1Ylvbeo0twPCSNHz?=
 =?us-ascii?Q?kOlt+apIEf7uhtxqMN1zLBSv6BISr5oKJeI3dS/TbcEglq91ftE1nNqvHWU1?=
 =?us-ascii?Q?yyHalw6sBzXAep6K9SqquaRqSeAqpxhJXbaSWZD7TGwmtR4KSRHEDZyu5BRG?=
 =?us-ascii?Q?iICCeeijR5UY8Ta24uALcRAkFgMD43UXsRB+8zq2tNwFtY/kk1lgrGqPa/vs?=
 =?us-ascii?Q?reGaBXZ7ifh9MR1yE0=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2585;6:JPRipwKZxw2Z8JcotuAbn4Azgu7O1Zn/dG1akVrKzXxz6fmNGMOb9f/fFLVL0yx2d/VwNdGErLWC0JRiE1AlrdQ5kcpAgel9wfPOWsJb+TIH0VulH7+/ai8+f2cwr9jpD9yHM0Ai3e4HAJERAsj5oPkcpP4Vt7Urw+s7ySLqDeMb/zP76iyU8oaAjA/sOr65ttrX9baIPEjGHDqzQHj/IQdT8WZ6QjLy45DDbhfy+va8SeTsoL3hxO50tHQymLn6eAihLsQkzH360XFHwYziyRXZJAK6w7FRhLZShhc+UZicXYNehE4rZAEj7OTMuQx6ddpO3hmjxPg9l8oUWQh7wDQCsI1tT7ZUIBTTBwFnGBfFr2nkh2sEAZo9cDh7CzfASe13bQCbc2PEMgd2mg6o+rgrK2gjHjcpUjWpuCiH9gnxgv8GCJeFc7+96E1vlNL+VwDcQQkWA4KPqSGXxT04Gw==;5:NlRjruPl4IFYkZUSiMpVy2Xf+diqyGw2RcVKX58AAYpiDKlECG1Gdon3l4j14p4DwJwmPkCjq2LQZy94ZNbWA8/fUXjAwAn6UWKxQxJbFXpSZi6pFr++BQ/Ns/hmfTdqGRvcDw9K5AWq1LUcLvQ4VQ==;24:4lutkvDqFpIx1KxM9Pmdkn/3H73rtFtUhkuo67EwrqvUelI0jMyW4jPrwQpBn9MbjTcBf08sz8YLRqQD03M4ANNGfy6GPhx8CHJquzVCtXk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2585;7:XBiMpWE0Dv0dpL4YBbANUMrEcrY1/aubRgjPBlj3qqpYr3hCLoUoMFz1fL8OOSyMGI5tlx9F34KNjv3BNQzUAEn7Zolm1oor4h4zlkncx7FtYOaHaXqM8SFbpD80FQwIluMjL4daxuVK/PAlNrEfywyhdIGBWF3M+EZg1AEV5VGBRPrZ44zTJSSIsJPhmvyr696NddBKA6Rauh9NJn/w+h7/SbL+TzzqHcrsumcENxdIZACaP1AoMSUlNv9yY0hY5Z89W8VLXT+XDNhBUQnQfbeScWW+HKiKQEMiYotGO34l/FNDw3bxSq0THVove4GVbQKuljeSOwYvI5tEeJJmrg==
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2017 09:14:20.5966 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2585
Return-Path: <Jan.Glauber@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57622
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

On Sat, Apr 08, 2017 at 03:13:35AM +0300, Aaro Koskinen wrote:
> Hi,
> 
> On Mon, Oct 03, 2016 at 08:18:59PM -0500, Steven J. Hill wrote:
> > On 09/19/2016 03:24 PM, Steven J. Hill wrote:
> > > The OCTEON MMC controller is currently found on cn61XX and cn71XX
> > > devices. Device parameters are configured from device tree data.
> > > eMMC, MMC and SD devices are supported. Tested on Cavium CN7130.
> > > 
> > > Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
> > > Acked-by: David Daney <david.daney@cavium.com>
> > 
> > Have any MMC maintainers gotten a chance to review our driver now
> > that v4.8 is out? Thanks.
> 
> Also v4.9, v4.10 and v4.11 went by.

Hi Aaro,

we went through several new revisions of the driver in the meantime.

> I think you should resend the patch, to get this driver finally merged.

the last version (v13) was posted here (waiting for feedback from maintainer):

https://lkml.org/lkml/2017/3/30/683

Unfortunately I had to drop the Octeon changes from v13 as Steven
reported problems on some models with that.

--Jan

> A.
