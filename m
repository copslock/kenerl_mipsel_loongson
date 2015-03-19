Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Mar 2015 00:10:38 +0100 (CET)
Received: from mail-bl2on0095.outbound.protection.outlook.com ([65.55.169.95]:3649
        "EHLO na01-bl2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27008453AbbCSXKgdGbf0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 20 Mar 2015 00:10:36 +0100
Received: from dl.caveonetworks.com (64.2.3.194) by
 BLUPR0701MB1715.namprd07.prod.outlook.com (25.163.85.141) with Microsoft SMTP
 Server (TLS) id 15.1.112.19; Thu, 19 Mar 2015 23:10:25 +0000
Message-ID: <550B575D.8090908@caviumnetworks.com>
Date:   Thu, 19 Mar 2015 16:10:21 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Kamal Mostafa <kamal@canonical.com>
CC:     <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        <kernel-team@lists.ubuntu.com>,
        David Daney <david.daney@cavium.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 3.13.y-ckt 71/80] MIPS: Fix C0_Pagegrain[IEC] support.
References: <1426804568-2907-1-git-send-email-kamal@canonical.com> <1426804568-2907-72-git-send-email-kamal@canonical.com>
In-Reply-To: <1426804568-2907-72-git-send-email-kamal@canonical.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.194]
X-ClientProxiedBy: DM2PR07CA0024.namprd07.prod.outlook.com (10.141.52.152) To
 BLUPR0701MB1715.namprd07.prod.outlook.com (25.163.85.141)
Authentication-Results: canonical.com; dkim=none (message not signed)
 header.d=none;
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0701MB1715;
X-Forefront-Antispam-Report: BMV:1;SFV:NSPM;SFS:(10009020)(6009001)(377454003)(24454002)(51704005)(479174004)(575784001)(62966003)(92566002)(50986999)(2950100001)(77156002)(87266999)(65816999)(54356999)(76176999)(15975445007)(65956001)(23756003)(65806001)(66066001)(47776003)(64126003)(42186005)(110136001)(53416004)(40100003)(122386002)(83506001)(33656002)(19580395003)(19580405001)(87976001)(59896002)(36756003)(46102003)(50466002)(80316001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0701MB1715;H:dl.caveonetworks.com;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Antispam-PRVS: <BLUPR0701MB17150BEBAC833FB47D3F61AE9A010@BLUPR0701MB1715.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(601004)(5002010)(5005006);SRVR:BLUPR0701MB1715;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0701MB1715;
X-Forefront-PRVS: 052017CAF1
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2015 23:10:25.2207 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0701MB1715
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46466
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

On 03/19/2015 03:35 PM, Kamal Mostafa wrote:
> 3.13.11-ckt17 -stable review patch.  If anyone has any objections, please let me know.
>

Read the patch commentary.  It should only be applied to 3.17 and later.

So:  NACK.

> ------------------
>
> From: David Daney <david.daney@cavium.com>
>
> commit 9ead8632bbf454cfc709b6205dc9cd8582fb0d64 upstream.
>
> The following commits:
>
>    5890f70f15c52d (MIPS: Use dedicated exception handler if CPU supports RI/XI exceptions)
>    6575b1d4173eae (MIPS: kernel: cpu-probe: Detect unique RI/XI exceptions)
>
> break the kernel for *all* existing MIPS CPUs that implement the
> CP0_PageGrain[IEC] bit.  They cause the TLB exception handlers to be
> generated without the legacy execute-inhibit handling, but never set
> the CP0_PageGrain[IEC] bit to activate the use of dedicated exception
> vectors for execute-inhibit exceptions.  The result is that upon
> detection of an execute-inhibit violation, we loop forever in the TLB
> exception handlers instead of sending SIGSEGV to the task.
>
> If we are generating TLB exception handlers expecting separate
> vectors, we must also enable the CP0_PageGrain[IEC] feature.
>
> The bug was introduced in kernel version 3.17.
>
> Signed-off-by: David Daney <david.daney@cavium.com>
> Cc: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> Cc: linux-mips@linux-mips.org
> Patchwork: http://patchwork.linux-mips.org/patch/8880/
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> Signed-off-by: Kamal Mostafa <kamal@canonical.com>
> ---
>   arch/mips/mm/tlb-r4k.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
> index da3b0b9..d04fe4e 100644
> --- a/arch/mips/mm/tlb-r4k.c
> +++ b/arch/mips/mm/tlb-r4k.c
> @@ -429,6 +429,8 @@ void tlb_init(void)
>   #ifdef CONFIG_64BIT
>   		pg |= PG_ELPA;
>   #endif
> +		if (cpu_has_rixiex)
> +			pg |= PG_IEC;
>   		write_c0_pagegrain(pg);
>   	}
>
>
