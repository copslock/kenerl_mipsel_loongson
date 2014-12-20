Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Dec 2014 02:19:02 +0100 (CET)
Received: from mail-bn1bon0072.outbound.protection.outlook.com ([157.56.111.72]:39058
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27009080AbaLTBS7TsKdu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 20 Dec 2014 02:18:59 +0100
Received: from dl.caveonetworks.com (64.2.3.194) by
 BN3PR0701MB1107.namprd07.prod.outlook.com (25.160.114.145) with Microsoft
 SMTP Server (TLS) id 15.1.36.22; Sat, 20 Dec 2014 01:18:50 +0000
Message-ID: <5494CE74.308@caviumnetworks.com>
Date:   Fri, 19 Dec 2014 17:18:44 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>, <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, David Daney <david.daney@cavium.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Subject: Re: [PATCH] MIPS: Fix C0_Pagegrain[IEC] support.
References: <1419038123-30270-1-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1419038123-30270-1-git-send-email-ddaney.cavm@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.194]
X-ClientProxiedBy: BY2PR07CA068.namprd07.prod.outlook.com (10.141.251.43) To
 BN3PR0701MB1107.namprd07.prod.outlook.com (25.160.114.145)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@caviumnetworks.com; 
X-Microsoft-Antispam: UriScan:;
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:;SRVR:BN3PR0701MB1107;
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004);SRVR:BN3PR0701MB1107;
X-Forefront-PRVS: 0431F981D8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(189002)(24454002)(164054003)(51704005)(377454003)(199003)(479174004)(2950100001)(42186005)(23756003)(19580405001)(64706001)(20776003)(66066001)(65956001)(65806001)(87976001)(47776003)(4396001)(50466002)(81156004)(105586002)(53416004)(107046002)(76176999)(68736005)(97736003)(31966008)(46102003)(62966003)(120916001)(101416001)(21056001)(19580395003)(83506001)(65816999)(40100003)(69596002)(106356001)(50986999)(36756003)(122386002)(33656002)(77156002)(54356999)(92566001)(99396003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR0701MB1107;H:dl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: caviumnetworks.com does not
 designate permitted sender hosts)
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:;SRVR:BN3PR0701MB1107;
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2014 01:18:50.0074 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0701MB1107
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44859
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


Ralf, I forgot to add it to the patch, but if you merge this, can you 
add a Cc: stable@... for the versions that have the patches that broke 
the XI feature?

Thanks,
David Daney

On 12/19/2014 05:15 PM, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
>
> If we are generating TLB exception expecting separate vectors, we must
> enable the feature.
>
> Cc: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>
> Very lightly tested, but it seems to make my XI and RI tests work on
> OCTEON II CPUs, which have the C0_Pagegrain[IEC] bit.
>
>   arch/mips/mm/tlb-r4k.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
> index e90b2e8..30639a6 100644
> --- a/arch/mips/mm/tlb-r4k.c
> +++ b/arch/mips/mm/tlb-r4k.c
> @@ -489,6 +489,8 @@ static void r4k_tlb_configure(void)
>   #ifdef CONFIG_64BIT
>   		pg |= PG_ELPA;
>   #endif
> +		if (cpu_has_rixiex)
> +			pg |= PG_IEC;
>   		write_c0_pagegrain(pg);
>   	}
>
>
