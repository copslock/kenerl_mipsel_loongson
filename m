Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Dec 2017 12:38:22 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:48793 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990424AbdLALiOEEf1i convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 1 Dec 2017 12:38:14 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1412.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Fri, 01 Dec 2017 11:35:44 +0000
Received: from MIPSMAIL01.mipstec.com ([fe80::5c93:1f20:524d:a563]) by
 MIPSMAIL01.mipstec.com ([fe80::5c93:1f20:524d:a563%13]) with mapi id
 14.03.0361.001; Fri, 1 Dec 2017 03:35:21 -0800
From:   Miodrag Dinic <Miodrag.Dinic@mips.com>
To:     James Hogan <James.Hogan@mips.com>
CC:     David Daney <ddaney@caviumnetworks.com>,
        Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Aleksandar Markovic <Aleksandar.Markovic@mips.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        DengCheng Zhu <DengCheng.Zhu@mips.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Douglas Leung <Douglas.Leung@mips.com>,
        "Frederic Weisbecker" <frederic@kernel.org>,
        Goran Ferenc <Goran.Ferenc@mips.com>,
        Ingo Molnar <mingo@kernel.org>,
        James Cowgill <James.Cowgill@imgtec.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
Thread-Index: AQHTYtCGiXJpn3ndkEa756uEAr0gK6Mf1f6AgAPtqzaACYORgP//qhpmgAF4BCw=
Date:   Fri, 1 Dec 2017 11:35:20 +0000
Message-ID: <48924BBB91ABDE4D9335632A6B179DD6A8D2C2@MIPSMAIL01.mipstec.com>
References: <1511272574-10509-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <dda5572e-0617-3427-7a90-07b3cf43d808@caviumnetworks.com>
 <48924BBB91ABDE4D9335632A6B179DD6A8CFEA@MIPSMAIL01.mipstec.com>,<20171130100957.GG5027@jhogan-linux.mipstec.com>,<48924BBB91ABDE4D9335632A6B179DD6A8D102@MIPSMAIL01.mipstec.com>
In-Reply-To: <48924BBB91ABDE4D9335632A6B179DD6A8D102@MIPSMAIL01.mipstec.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [82.117.201.26]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-BESS-ID: 1512128142-452060-20058-256019-13
X-BESS-VER: 2017.14.1-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.21
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.187473
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.20 PR0N_SUBJECT           META: Subject has letters 
        around special characters (pr0n) 
        0.01 BSF_SC0_SA_TO_FROM_DOMAIN_MATCH META: Sender Domain Matches Recipient Domain 
X-BESS-Outbound-Spam-Status: SCORE=0.21 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, PR0N_SUBJECT, BSF_SC0_SA_TO_FROM_DOMAIN_MATCH
X-BESS-BRTS-Status: 1
Return-Path: <Miodrag.Dinic@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61260
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

Hi everyone,

just a note, even though we started discussion on V2 version of this patch, an up to date V3 version is available at :
https://patchwork.kernel.org/patch/10068871/

It contains spelling check fixes.

Thank you.

Kind regards,
Miodrag

________________________________________
From: Miodrag Dinic
Sent: Thursday, November 30, 2017 2:06 PM
To: James Hogan
Cc: David Daney; Aleksandar Markovic; linux-mips@linux-mips.org; Aleksandar Markovic; Andrew Morton; DengCheng Zhu; Ding Tianhong; Douglas Leung; Frederic Weisbecker; Goran Ferenc; Ingo Molnar; James Cowgill; Jonathan Corbet; linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org; Marc Zyngier; Matt Redfearn; Mimi Zohar; Paul Burton; Paul E. McKenney; Petar Jovanovic; Raghu Gandham; Ralf Baechle; Thomas Gleixner; Tom Saeger
Subject: RE: [PATCH v2] MIPS: Add nonxstack=on|off kernel parameter

Hi James,

> > We do have PT_GNU_STACK flags set correctly, this feature is required to
> > workaround CPU revisions which do not have RIXI support.
>
> RIXI support can be discovered programatically from CP0_Config3.RXI
> (cpu_has_rixi in asm/cpu-features.h), so I don't follow why CPUs without
> RIXI would require a kernel parameter.

The following patch introduced change in behavior with regards to
stack & heap execute-ability :
commit 1a770b85c1f1c1ee37afd7cef5237ffc4c970f04
Author: Paul Burton <paul.burton@imgtec.com>
Date:   Fri Jul 8 11:06:20 2016 +0100

    MIPS: non-exec stack & heap when non-exec PT_GNU_STACK is present

    The stack and heap have both been executable by default on MIPS until
    now. This patch changes the default to be non-executable, but only for
    ELF binaries with a non-executable PT_GNU_STACK header present. This
    does apply to both the heap & the stack, despite the name PT_GNU_STACK,
    and this matches the behaviour of other architectures like ARM & x86.

    Current MIPS toolchains do not produce the PT_GNU_STACK header, which
    means that we can rely upon this patch not changing the behaviour of
    existing binaries. The new default will only take effect for newly
    compiled binaries once toolchains are updated to support PT_GNU_STACK,
    and since those binaries are newly compiled they can be compiled
    expecting the change in default behaviour. Again this matches the way in
    which the ARM & x86 architectures handled their implementations of
    non-executable memory.

    Signed-off-by: Paul Burton <paul.burton@imgtec.com>
    Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
    Cc: Maciej Rozycki <maciej.rozycki@imgtec.com>
    Cc: Faraz Shahbazker <faraz.shahbazker@imgtec.com>
    Cc: Raghu Gandham <raghu.gandham@imgtec.com>
    Cc: Matthew Fortune <matthew.fortune@imgtec.com>
    Cc: linux-mips@linux-mips.org
    Patchwork: https://patchwork.linux-mips.org/patch/13765/
    Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

....

When kernel is detecting the type of mapping it should apply :

fs/binfmt_elf.c:
...
        if (elf_read_implies_exec(loc->elf_ex, executable_stack))
                current->personality |= READ_IMPLIES_EXEC;
...

this effectively calls mips_elf_read_implies_exec() which performs a check:
...
        if (!cpu_has_rixi) {
                /* The CPU doesn't support non-executable memory */
                return 1;
        }

        return 0;
}

This will in turn make stack & heap executable on processors without RIXI, which are practically all processors with MIPS ISA R < 6.

We would like to have an option to override this and force non-executable mappings for such systems.

Kind regards,
Miodrag
________________________________________
From: James Hogan
Sent: Thursday, November 30, 2017 11:09 AM
To: Miodrag Dinic
Cc: David Daney; Aleksandar Markovic; linux-mips@linux-mips.org; Aleksandar Markovic; Andrew Morton; DengCheng Zhu; Ding Tianhong; Douglas Leung; Frederic Weisbecker; Goran Ferenc; Ingo Molnar; James Cowgill; Jonathan Corbet; linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org; Marc Zyngier; Matt Redfearn; Mimi Zohar; Paul Burton; Paul E. McKenney; Petar Jovanovic; Raghu Gandham; Ralf Baechle; Thomas Gleixner; Tom Saeger
Subject: Re: [PATCH v2] MIPS: Add nonxstack=on|off kernel parameter

On Thu, Nov 30, 2017 at 09:34:15AM +0000, Miodrag Dinic wrote:
> Hi David,
>
> Sorry for a late response, please find answers in-lined:
>
> > > If this parameter is omitted, kernel behavior remains the same as it
> > > was before this patch is applied.
> >
> > Do other architectures have a similar hack?
> >
> > If arm{,64} and x86 don't need this, what would make MIPS so special
> > that we have to carry this around?
>
> Yes, there are similar workarounds. Just a couple lines above
> nonxstack description in the documentation there are :
>       noexec          [IA-64]
>
>       noexec          [X86]
>                       On X86-32 available only on PAE configured kernels.
>                       noexec=on: enable non-executable mappings (default)
>                       noexec=off: disable non-executable mappings
> ...
>
>       noexec32        [X86-64]
>                       This affects only 32-bit executables.
>                       noexec32=on: enable non-executable mappings (default)
>                               read doesn't imply executable mappings
>                       noexec32=off: disable non-executable mappings
>                               read implies executable mappings
>
> > >
> > > This functionality is convenient during debugging and is especially
> > > useful for Android development where non-exec stack is required.
> >
> > Why not just set the PT_GNU_STACK flags correctly in the first place?
>
> We do have PT_GNU_STACK flags set correctly, this feature is required to
> workaround CPU revisions which do not have RIXI support.

RIXI support can be discovered programatically from CP0_Config3.RXI
(cpu_has_rixi in asm/cpu-features.h), so I don't follow why CPUs without
RIXI would require a kernel parameter.

Cheers
James

>
> Kind regards,
> Miodrag
> ________________________________________
> From: David Daney [ddaney@caviumnetworks.com]
> Sent: Tuesday, November 21, 2017 9:53 PM
> To: Aleksandar Markovic; linux-mips@linux-mips.org
> Cc: Miodrag Dinic; Aleksandar Markovic; Andrew Morton; DengCheng Zhu; Ding Tianhong; Douglas Leung; Frederic Weisbecker; Goran Ferenc; Ingo Molnar; James Cowgill; James Hogan; Jonathan Corbet; linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org; Marc Zyngier; Matt Redfearn; Mimi Zohar; Paul Burton; Paul E. McKenney; Petar Jovanovic; Raghu Gandham; Ralf Baechle; Thomas Gleixner; Tom Saeger
> Subject: Re: [PATCH v2] MIPS: Add nonxstack=on|off kernel parameter
>
> On 11/21/2017 05:56 AM, Aleksandar Markovic wrote:
> > From: Miodrag Dinic <miodrag.dinic@mips.com>
> >
> > Add a new kernel parameter to override the default behavior related
> > to the decision whether to set up stack as non-executable in function
> > mips_elf_read_implies_exec().
> >
> > The new parameter is used to control non executable stack and heap,
> > regardless of PT_GNU_STACK entry. This does apply to both stack and
> > heap, despite the name.
> >
> > Allowed values:
> >
> > nonxstack=on  Force non-exec stack & heap
> > nonxstack=off Force executable stack & heap
> >
> > If this parameter is omitted, kernel behavior remains the same as it
> > was before this patch is applied.
>
> Do other architectures have a similar hack?
>
> If arm{,64} and x86 don't need this, what would make MIPS so special
> that we have to carry this around?
>
>
> >
> > This functionality is convenient during debugging and is especially
> > useful for Android development where non-exec stack is required.
>
> Why not just set the PT_GNU_STACK flags correctly in the first place?
>
> >
> > Signed-off-by: Miodrag Dinic <miodrag.dinic@mips.com>
> > Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
> > ---
> >   Documentation/admin-guide/kernel-parameters.txt | 11 +++++++
> >   arch/mips/kernel/elf.c                          | 39 +++++++++++++++++++++++++
> >   2 files changed, 50 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index b74e133..99464ee 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -2614,6 +2614,17 @@
> >                       noexec32=off: disable non-executable mappings
> >                               read implies executable mappings
> >
> > +     nonxstack       [MIPS]
> > +                     Force setting up stack and heap as non-executable or
> > +                     executable regardless of PT_GNU_STACK entry. Both
> > +                     stack and heap are affected, despite the name. Valid
> > +                     arguments: on, off.
> > +                     nonxstack=on:   Force non-executable stack and heap
> > +                     nonxstack=off:  Force executable stack and heap
> > +                     If ommited, stack and heap will or will not be set
> > +                     up as non-executable depending on PT_GNU_STACK
> > +                     entry and possibly other factors.
> > +
> >       nofpu           [MIPS,SH] Disable hardware FPU at boot time.
> >
> >       nofxsr          [BUGS=X86-32] Disables x86 floating point extended
> > diff --git a/arch/mips/kernel/elf.c b/arch/mips/kernel/elf.c
> > index 731325a..28ef7f3 100644
> > --- a/arch/mips/kernel/elf.c
> > +++ b/arch/mips/kernel/elf.c
> > @@ -326,8 +326,47 @@ void mips_set_personality_nan(struct arch_elf_state *state)
> >       }
> >   }
> >
> > +static int nonxstack = EXSTACK_DEFAULT;
> > +
> > +/*
> > + * kernel parameter: nonxstack=on|off
> > + *
> > + *   Force setting up stack and heap as non-executable or
> > + *   executable regardless of PT_GNU_STACK entry. Both
> > + *   stack and heap are affected, despite the name. Valid
> > + *   arguments: on, off.
> > + *
> > + *     nonxstack=on:   Force non-executable stack and heap
> > + *     nonxstack=off:  Force executable stack and heap
> > + *
> > + *   If ommited, stack and heap will or will not be set
> > + *   up as non-executable depending on PT_GNU_STACK
> > + *   entry and possibly other factors.
> > + */
> > +static int __init nonxstack_setup(char *str)
> > +{
> > +     if (!strcmp(str, "on"))
> > +             nonxstack = EXSTACK_DISABLE_X;
> > +     else if (!strcmp(str, "off"))
> > +             nonxstack = EXSTACK_ENABLE_X;
> > +     else
> > +             pr_err("Malformed nonxstack format! nonxstack=on|off\n");
> > +
> > +     return 1;
> > +}
> > +__setup("nonxstack=", nonxstack_setup);
> > +
> >   int mips_elf_read_implies_exec(void *elf_ex, int exstack)
> >   {
> > +     switch (nonxstack) {
> > +     case EXSTACK_DISABLE_X:
> > +             return 0;
> > +     case EXSTACK_ENABLE_X:
> > +             return 1;
> > +     default:
> > +             break;
> > +     }
> > +
> >       if (exstack != EXSTACK_DISABLE_X) {
> >               /* The binary doesn't request a non-executable stack */
> >               return 1;
> >
>
>
