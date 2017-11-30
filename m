Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Nov 2017 10:35:42 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:35398 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990492AbdK3JfcnK2VA convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 30 Nov 2017 10:35:32 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1412.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Thu, 30 Nov 2017 09:34:16 +0000
Received: from MIPSMAIL01.mipstec.com ([fe80::5c93:1f20:524d:a563]) by
 MIPSMAIL01.mipstec.com ([fe80::5c93:1f20:524d:a563%13]) with mapi id
 14.03.0361.001; Thu, 30 Nov 2017 01:34:16 -0800
From:   Miodrag Dinic <Miodrag.Dinic@mips.com>
To:     David Daney <ddaney@caviumnetworks.com>,
        Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Aleksandar Markovic <Aleksandar.Markovic@mips.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        DengCheng Zhu <DengCheng.Zhu@mips.com>,
        "Ding Tianhong" <dingtianhong@huawei.com>,
        Douglas Leung <Douglas.Leung@mips.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Goran Ferenc <Goran.Ferenc@mips.com>,
        Ingo Molnar <mingo@kernel.org>,
        James Cowgill <James.Cowgill@imgtec.com>,
        James Hogan <James.Hogan@mips.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "Matt Redfearn" <Matt.Redfearn@mips.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Paul Burton <Paul.Burton@mips.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Petar Jovanovic <Petar.Jovanovic@mips.com>,
        Raghu Gandham <Raghu.Gandham@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Saeger <tom.saeger@oracle.com>
Subject: RE: [PATCH v2] MIPS: Add nonxstack=on|off kernel parameter
Thread-Topic: [PATCH v2] MIPS: Add nonxstack=on|off kernel parameter
Thread-Index: AQHTYtCGiXJpn3ndkEa756uEAr0gK6Mf1f6AgAPtqzY=
Date:   Thu, 30 Nov 2017 09:34:15 +0000
Message-ID: <48924BBB91ABDE4D9335632A6B179DD6A8CFEA@MIPSMAIL01.mipstec.com>
References: <1511272574-10509-1-git-send-email-aleksandar.markovic@rt-rk.com>,<dda5572e-0617-3427-7a90-07b3cf43d808@caviumnetworks.com>
In-Reply-To: <dda5572e-0617-3427-7a90-07b3cf43d808@caviumnetworks.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [82.117.201.26]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-BESS-ID: 1512034456-452060-20055-147433-1
X-BESS-VER: 2017.14.1-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.20
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.187456
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.20 PR0N_SUBJECT           META: Subject has letters around special characters (pr0n) 
X-BESS-Outbound-Spam-Status: SCORE=0.20 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, PR0N_SUBJECT
X-BESS-BRTS-Status: 1
Return-Path: <Miodrag.Dinic@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61242
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Miodrag.Dinic@mips.com
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

Hi David,

Sorry for a late response, please find answers in-lined:

> > If this parameter is omitted, kernel behavior remains the same as it
> > was before this patch is applied.
> 
> Do other architectures have a similar hack?
> 
> If arm{,64} and x86 don't need this, what would make MIPS so special
> that we have to carry this around?

Yes, there are similar workarounds. Just a couple lines above
nonxstack description in the documentation there are :
	noexec		[IA-64]

	noexec		[X86]
			On X86-32 available only on PAE configured kernels.
			noexec=on: enable non-executable mappings (default)
			noexec=off: disable non-executable mappings
...

	noexec32	[X86-64]
			This affects only 32-bit executables.
			noexec32=on: enable non-executable mappings (default)
				read doesn't imply executable mappings
			noexec32=off: disable non-executable mappings
				read implies executable mappings

> > 
> > This functionality is convenient during debugging and is especially
> > useful for Android development where non-exec stack is required.
> 
> Why not just set the PT_GNU_STACK flags correctly in the first place?

We do have PT_GNU_STACK flags set correctly, this feature is required to
workaround CPU revisions which do not have RIXI support.

Kind regards,
Miodrag
________________________________________
From: David Daney [ddaney@caviumnetworks.com]
Sent: Tuesday, November 21, 2017 9:53 PM
To: Aleksandar Markovic; linux-mips@linux-mips.org
Cc: Miodrag Dinic; Aleksandar Markovic; Andrew Morton; DengCheng Zhu; Ding Tianhong; Douglas Leung; Frederic Weisbecker; Goran Ferenc; Ingo Molnar; James Cowgill; James Hogan; Jonathan Corbet; linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org; Marc Zyngier; Matt Redfearn; Mimi Zohar; Paul Burton; Paul E. McKenney; Petar Jovanovic; Raghu Gandham; Ralf Baechle; Thomas Gleixner; Tom Saeger
Subject: Re: [PATCH v2] MIPS: Add nonxstack=on|off kernel parameter

On 11/21/2017 05:56 AM, Aleksandar Markovic wrote:
> From: Miodrag Dinic <miodrag.dinic@mips.com>
>
> Add a new kernel parameter to override the default behavior related
> to the decision whether to set up stack as non-executable in function
> mips_elf_read_implies_exec().
>
> The new parameter is used to control non executable stack and heap,
> regardless of PT_GNU_STACK entry. This does apply to both stack and
> heap, despite the name.
>
> Allowed values:
>
> nonxstack=on  Force non-exec stack & heap
> nonxstack=off Force executable stack & heap
>
> If this parameter is omitted, kernel behavior remains the same as it
> was before this patch is applied.

Do other architectures have a similar hack?

If arm{,64} and x86 don't need this, what would make MIPS so special
that we have to carry this around?


>
> This functionality is convenient during debugging and is especially
> useful for Android development where non-exec stack is required.

Why not just set the PT_GNU_STACK flags correctly in the first place?

>
> Signed-off-by: Miodrag Dinic <miodrag.dinic@mips.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
> ---
>   Documentation/admin-guide/kernel-parameters.txt | 11 +++++++
>   arch/mips/kernel/elf.c                          | 39 +++++++++++++++++++++++++
>   2 files changed, 50 insertions(+)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index b74e133..99464ee 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2614,6 +2614,17 @@
>                       noexec32=off: disable non-executable mappings
>                               read implies executable mappings
>
> +     nonxstack       [MIPS]
> +                     Force setting up stack and heap as non-executable or
> +                     executable regardless of PT_GNU_STACK entry. Both
> +                     stack and heap are affected, despite the name. Valid
> +                     arguments: on, off.
> +                     nonxstack=on:   Force non-executable stack and heap
> +                     nonxstack=off:  Force executable stack and heap
> +                     If ommited, stack and heap will or will not be set
> +                     up as non-executable depending on PT_GNU_STACK
> +                     entry and possibly other factors.
> +
>       nofpu           [MIPS,SH] Disable hardware FPU at boot time.
>
>       nofxsr          [BUGS=X86-32] Disables x86 floating point extended
> diff --git a/arch/mips/kernel/elf.c b/arch/mips/kernel/elf.c
> index 731325a..28ef7f3 100644
> --- a/arch/mips/kernel/elf.c
> +++ b/arch/mips/kernel/elf.c
> @@ -326,8 +326,47 @@ void mips_set_personality_nan(struct arch_elf_state *state)
>       }
>   }
>
> +static int nonxstack = EXSTACK_DEFAULT;
> +
> +/*
> + * kernel parameter: nonxstack=on|off
> + *
> + *   Force setting up stack and heap as non-executable or
> + *   executable regardless of PT_GNU_STACK entry. Both
> + *   stack and heap are affected, despite the name. Valid
> + *   arguments: on, off.
> + *
> + *     nonxstack=on:   Force non-executable stack and heap
> + *     nonxstack=off:  Force executable stack and heap
> + *
> + *   If ommited, stack and heap will or will not be set
> + *   up as non-executable depending on PT_GNU_STACK
> + *   entry and possibly other factors.
> + */
> +static int __init nonxstack_setup(char *str)
> +{
> +     if (!strcmp(str, "on"))
> +             nonxstack = EXSTACK_DISABLE_X;
> +     else if (!strcmp(str, "off"))
> +             nonxstack = EXSTACK_ENABLE_X;
> +     else
> +             pr_err("Malformed nonxstack format! nonxstack=on|off\n");
> +
> +     return 1;
> +}
> +__setup("nonxstack=", nonxstack_setup);
> +
>   int mips_elf_read_implies_exec(void *elf_ex, int exstack)
>   {
> +     switch (nonxstack) {
> +     case EXSTACK_DISABLE_X:
> +             return 0;
> +     case EXSTACK_ENABLE_X:
> +             return 1;
> +     default:
> +             break;
> +     }
> +
>       if (exstack != EXSTACK_DISABLE_X) {
>               /* The binary doesn't request a non-executable stack */
>               return 1;
>
