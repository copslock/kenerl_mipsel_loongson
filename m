Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Dec 2017 12:35:42 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:42026 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990411AbdLGLffCIU5K convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 7 Dec 2017 12:35:35 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx3.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Thu, 07 Dec 2017 11:34:18 +0000
Received: from MIPSMAIL01.mipstec.com ([fe80::5c93:1f20:524d:a563]) by
 MIPSMAIL01.mipstec.com ([fe80::5c93:1f20:524d:a563%13]) with mapi id
 14.03.0361.001; Thu, 7 Dec 2017 03:33:49 -0800
From:   Miodrag Dinic <Miodrag.Dinic@mips.com>
To:     Paul Burton <Paul.Burton@mips.com>,
        Maciej Rozycki <Maciej.Rozycki@mips.com>,
        Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
        Aleksandar Markovic <Aleksandar.Markovic@mips.com>
CC:     James Hogan <James.Hogan@mips.com>,
        David Daney <ddaney@caviumnetworks.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
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
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Petar Jovanovic <Petar.Jovanovic@mips.com>,
        Raghu Gandham <Raghu.Gandham@mips.com>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Tom Saeger" <tom.saeger@oracle.com>
Subject: RE: [PATCH v2] MIPS: Add nonxstack=on|off kernel parameter
Thread-Topic: [PATCH v2] MIPS: Add nonxstack=on|off kernel parameter
Thread-Index: AQHTYtCGiXJpn3ndkEa756uEAr0gK6Mf1f6AgAPtqzaACYORgP//qhpmgApEqwCAAAlBAIAAmFeR
Date:   Thu, 7 Dec 2017 11:33:47 +0000
Message-ID: <48924BBB91ABDE4D9335632A6B179DD6A8E6B2@MIPSMAIL01.mipstec.com>
References: <1511272574-10509-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <dda5572e-0617-3427-7a90-07b3cf43d808@caviumnetworks.com>
 <48924BBB91ABDE4D9335632A6B179DD6A8CFEA@MIPSMAIL01.mipstec.com>
 <20171130100957.GG5027@jhogan-linux.mipstec.com>
 <48924BBB91ABDE4D9335632A6B179DD6A8D102@MIPSMAIL01.mipstec.com>
 <alpine.DEB.2.00.1712061657520.4584@tp.orcam.me.uk>,<20171206182400.6va3pqdmgisbino7@pburton-laptop>
In-Reply-To: <20171206182400.6va3pqdmgisbino7@pburton-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [82.117.201.26]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-BESS-ID: 1512646456-298554-32346-69751-6
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.21
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.187716
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
X-archive-position: 61336
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

Hi Paul, David, Maciej,

thanks for taking interest in this topic and your valuable comments.
Aleksandar is currently on sick leave but I think I can address
all previous questions and concerns by answering to this Pauls last post:

> On Wed, Dec 06, 2017 at 05:50:52PM +0000, Maciej W. Rozycki wrote:
> >  What problem are you trying to solve anyway?  Is it not something that 
> > can be handled with the `execstack' utility?
> 
> The commit message states that for Android "non-exec stack is required".
> Is Android checking that then Aleksandar? If so, how? 

Android is using SELinux configured to disallow NX mappings by handling
the following sepolicy rules :
* Executable stack (execstack)
* Executable heap (execheap)
* File-based executable code which has been modified (execmod)
* All other executable memory (execmem)

Nice explanation can be found here:
https://android-review.googlesource.com/#/c/platform/bionic/+/145004/

> I presume what you
> actually want here is for the kernel to lie & indicate to whatever part
> of Android that performs this check that the stack is non-executable
> even when it is really executable?

Basically yes, because we do not have other options at this point.
And this kernel parameter should definitely not be used in a production
environments. Hopefully, any future MIPS Android device would have
CPU with RIXI.

> Is this aimed at the Android emulator? If so would it be possible to
> instead implement RIXI support & make the non-exec stack actually work?

This issue was indeed detected using Android emulator while testing the "Ranchu"
platform kernel we are trying to integrate in another series.

We could probably change the emulator and enable RIXI, but the whole point of using it
is to emulate real HW as close as possible (And detect issues which could be
found on real HW as well), so I would tend to keep it unmodified.
But if we do not come to a consensus regarding this patch, we would need to modify it.

For emulating android on different MIPS arch variants we are using the
following CPU emulations:
- For mips32[r1|r2][dsp] - we are using 74Kf - No RIXI
- For mips32r5[msa] - we are using P5600 - has RIXI
- For mips[32|64]r6[msa] - I6400 - has RIXI

The CI20 development board (lacks XI) would also be affected  by this issue and it has been running
Android for quite some time now. The kernel for CI20 which we are currently using
is 3.18 and it does NOT yet contain 1a770b85c1f1 ("MIPS: non-exec stack & heap when non-exec
PT_GNU_STACK is present").

The effect of not having some workaround like this in the kernel, would
be to run Android only in SELinux permissive mode.

> >  NB as someone has observed with programs that do not request a 
> > non-executable stack we actually propagate the execute permission to all 
> > data pages.  Is it not something we would want to handle differently?
> 
> It would of course be ideal to mark data/heap memory non-executable -
> the question is how should we know that it's safe to do so. The approach
> I took in 1a770b85c1f1 ("MIPS: non-exec stack & heap when non-exec
> PT_GNU_STACK is present") was to require the PT_GNU_STACK header in
> order to mark both stack & heap non-executable, for reasons outlined in
> its commit message:
> 
>   - I was told at the time that no MIPS tools were yet emitting
>     PT_GNU_STACK, so we wouldn't be changing the behaviour of any
>     existing binaries & thus wouldn't break any.
> 
>   - It matches the behaviour of both ARM & x86.
> 

For Android, Google placed PT_GNU_STACK header in crtend* and this effectively
makes all executables and libraries request NX stack:
https://android-review.googlesource.com/#/c/platform/bionic/+/40773/

The toolchain for Android was updated as well:
https://android-review.googlesource.com/#/c/platform/ndk/+/37140/

------------------

@David:

> All Cavium processors since OCTEON Plus (more than ten years ago)
> support RIXI.

Sure, I missed to mention Cavium. Than I suppose, Cavium would have no issues running Android.

> Also, this does nothing for multi-threaded programs where libc sets the
> permissions on the thread stacks.

I don't think Android bionic is doing anything similar, at least we
haven't seen any issues so far related to this.

> If you really need something, at a minimum, use the same parameter name
> that x86 uses.

Sure, I agree, this was my dilemma as well, we will update the parameter name
to be "noexec".

Kind regards,
Miodrag
________________________________________
From: Paul Burton [paul.burton@mips.com]
Sent: Wednesday, December 6, 2017 7:24 PM
To: Maciej Rozycki; Aleksandar Markovic; Aleksandar Markovic
Cc: Miodrag Dinic; James Hogan; David Daney; linux-mips@linux-mips.org; Andrew Morton; DengCheng Zhu; Ding Tianhong; Douglas Leung; Frederic Weisbecker; Goran Ferenc; Ingo Molnar; James Cowgill; Jonathan Corbet; linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org; Marc Zyngier; Matt Redfearn; Mimi Zohar; Paul E. McKenney; Petar Jovanovic; Raghu Gandham; Ralf Baechle; Thomas Gleixner; Tom Saeger
Subject: Re: [PATCH v2] MIPS: Add nonxstack=on|off kernel parameter

Hi Maciej, Aleksandar,

On Wed, Dec 06, 2017 at 05:50:52PM +0000, Maciej W. Rozycki wrote:
>  What problem are you trying to solve anyway?  Is it not something that
> can be handled with the `execstack' utility?

The commit message states that for Android "non-exec stack is required".
Is Android checking that then Aleksandar? If so, how? I presume what you
actually want here is for the kernel to lie & indicate to whatever part
of Android that performs this check that the stack is non-executable
even when it is really executable?

Is this aimed at the Android emulator? If so would it be possible to
instead implement RIXI support & make the non-exec stack actually work?

>  NB as someone has observed with programs that do not request a
> non-executable stack we actually propagate the execute permission to all
> data pages.  Is it not something we would want to handle differently?

It would of course be ideal to mark data/heap memory non-executable -
the question is how should we know that it's safe to do so. The approach
I took in 1a770b85c1f1 ("MIPS: non-exec stack & heap when non-exec
PT_GNU_STACK is present") was to require the PT_GNU_STACK header in
order to mark both stack & heap non-executable, for reasons outlined in
its commit message:

  - I was told at the time that no MIPS tools were yet emitting
    PT_GNU_STACK, so we wouldn't be changing the behaviour of any
    existing binaries & thus wouldn't break any.

  - It matches the behaviour of both ARM & x86.

Marking the heap non-executable by default would have advantages in that
we wouldn't need to worry about icache coherency for it in
set_pte_at()/__update_cache(), so one idea I had was that we could
possibly initially mark pages non-executable in the TLB & later enable
execution only if we take a TLBXI exception, with the assumption being
that in most cases we'll never try executing from the heap. That's not
an idea I've yet found the time to implement or measure the impact of
though.

Thanks,
    Paul
