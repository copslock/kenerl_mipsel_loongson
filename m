Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jun 2015 02:09:59 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27007952AbbFAAJfIych4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Jun 2015 02:09:35 +0200
Date:   Mon, 1 Jun 2015 01:09:35 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Joshua Kinard <kumba@gentoo.org>
cc:     Linux MIPS List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: IP27: R14000: Unexpected General Exception in
 cpu_set_fpu_fcsr_mask()
In-Reply-To: <556943D9.7020502@gentoo.org>
Message-ID: <alpine.LFD.2.11.1506010025410.22908@eddie.linux-mips.org>
References: <556943D9.7020502@gentoo.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47754
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Sat, 30 May 2015, Joshua Kinard wrote:

> MMC:
> 2A 000: *** General Exception on node 0
> 2A 000: *** EPC: 0xa800000000022178 (0xa800000000022178)
> 2A 000: *** Press ENTER to continue.
> 2A 000: POD MSC Unc> why
> 2A 000:  EPC    : 0xa800000000022178 (0xa800000000022178)
> 2A 000:  ERREPC : 0xffffffffbfc00ee0 (0xc00000001fc00ee0)
> 2A 000:  CACERR : 0x00000000d6d7ff21
> 2A 000:  Status : 0x0000000024407c80
> 2A 000:  BadVA  : 0x0000000000000000 (0x0)
> 2A 000:  RA     : 0xa8000000008771cc (0xa8000000008771cc)
> 2A 000:  SP     : 0xa80000000081be00
> 2A 000:  A0     : 0x00000000000051a1
> 2A 000:  Cause  : 0x000000000000c03c (INT:87------ <Float Pt. Exc>)
> 2A 000:  Reason : 242 (Unexpected General Exception.)
> 2A 000:  POD mode was called from: 0xc00000001fc027ec (0xc00000001fc027ec)
> 2A 000: POD MSC Unc>
> 
> Address 0xa800000022178 centers around line 85 in 4.1.0-rc4's
> arch/mips/cpu-probe.c:
> 
> 85:         write_32bit_cp1_register(CP1_STATUS, fcsr0);
>     a80000000002216c:       3c020003        lui     v0,0x3
>     a800000000022170:       3445ffff        ori     a1,v0,0xffff
>     a800000000022174:       00851024        and     v0,a0,a1
> --> a800000000022178:       44c2f800        ctc1    v0,$31
>     a80000000002217c:       00000000        nop
> 
> Looks like cpu_set_fpu_fcsr_mask() was added in April sometime:
> 
> http://git.linux-mips.org/cgit/ralf/linux.git/commit/arch/mips/kernel/cpu-probe.c?id=9b26616c8d9dae53fbac7f7cb2c6dd1308102976

 Thanks for your report and the accurate details!

> Not sure what else can be gleaned.  Seems this version of the R14K (v1.4)
> doesn't like that FCSR mask.  Don't recall the Octane complaining about this,
> but I'll try to double-check tomorrow.  It's got a newer rev of R14K silicon.
> Might be an errata.

 Nope, it looks to me like sloppy firmware leaving IEEE 754 exception 
cause and enable bits set behind in FCSR.  Upon writing them back with the 
same values an FPE exception is triggered as per the semantics of the CTC1 
instruction (we have some issues elsewhere with that, e.g. try writing
~0 to $fsr manually under GDB in a program that uses the FPU and then
resuming execution).  I overlooked this possibility.  So it looks to me 
like we need to mask the enables out here and leave the state of FCSR 
clobbered after r/w mask probing.

 Can you please try this diagnostic patch and report the value of FCSR 
printed ("FCSR is:"), and also tell me if the exception has now gone too?  

 I'll submit the final fix, properly annotated, if your testing confirms 
my diagnosis.

 Thanks,

  Maciej

linux-mips-fcsr-mask-fix.diff
Index: linux-org-test/arch/mips/kernel/cpu-probe.c
===================================================================
--- linux-org-test.orig/arch/mips/kernel/cpu-probe.c	2015-06-01 00:43:32.000000000 +0100
+++ linux-org-test/arch/mips/kernel/cpu-probe.c	2015-06-01 00:52:00.714647000 +0100
@@ -80,6 +80,8 @@ static inline void cpu_set_fpu_fcsr_mask
 	__enable_fpu(FPU_AS_IS);
 
 	fcsr = read_32bit_cp1_register(CP1_STATUS);
+	pr_info("FCSR is: %08lx\n", fcsr);
+	fcsr &= ~mask;
 
 	fcsr0 = fcsr & mask;
 	write_32bit_cp1_register(CP1_STATUS, fcsr0);
