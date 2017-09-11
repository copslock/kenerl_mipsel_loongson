Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Sep 2017 17:17:57 +0200 (CEST)
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:39872 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991599AbdIKPRu6TQMC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Sep 2017 17:17:50 +0200
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 6B1463F498;
        Mon, 11 Sep 2017 17:17:49 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LKnV-727n9yf; Mon, 11 Sep 2017 17:17:44 +0200 (CEST)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 0D5394091A;
        Mon, 11 Sep 2017 17:17:39 +0200 (CEST)
Date:   Mon, 11 Sep 2017 17:17:38 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH v2] MIPS: Add basic R5900 support
Message-ID: <20170911151737.GA2265@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1709091313150.4331@tp.orcam.me.uk>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59986
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noring@nocrew.org
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

Hi Maciej,

Many thanks for your extensive review comments! I will work through them in
detail during the week. Regarding the submission:

>  Ralf may yet want to chime in, but overall I think that the way to move
> forward with your submission is to:
> 
> 1. Make the adjustments to this patch I have outlined above; dropping FPU
>    and 64-bit support for the time being in particular.
> 
> 2. Update cache handlers to use the correct R5900-specific cache op
>    encodings, presumably within the same patch.
> 
> 3. As Ralf has already reqested, add basic board support for the PS2
>    platform, including essential drivers that are required to boot, e.g.
>    serial, network; fancy stuff can be added gradually later on.
> 
> 4. Post the whole set of changes collected so far, properly split into
>    functionally self-contained changes, i.e. ones that build and can run
>    successfully run on actual hardware, for a reasonable definition of
>    success, e.g. patch #1 is this one, patch #2 is base board setup
>    infrastructure, patch #3 is interrupt support, patch #4 is timer
>    support, patch #5 is the serial driver, patch #6 is the network
>    driver, or suchlike.
> 
> We can then integrate these to have basic hardware support already working
> and only then continue with more complicated features, especially ones
> such as the FPU and 64-bit support which will require considerable updates
> to generic architecture code.
> 
>  NB if CP1.FCSR.FS indeed turns out hardwired to 1, then having this FPU
> hardware handled will be a more complex task, involving adding AT_FPUCW
> support to our MIPS port of the kernel and adjusting glibc appropriately
> before we are able to proceed.  So if this is indeed the case, then I
> think it'll be the most reasonable if we just ignore the issue of
> CP1.FCSR.FS for the time being, and have the emulated FP work with the bit
> flippable.
> 
>  Questions, comments?

This sounds like a good plan. I did have a few comments and questions on the
rest of the code in

https://www.linux-mips.org/archives/linux-mips/2017-08/msg00570.html

The first item in particular: The R5900 has 128 bit quadword registers which
isn't the native integer type and therefore maps poorly to pt_regs::regs[32]
in arch/mips/include/asm/ptrace.h and arch/mips/include/uapi/asm/ptrace.h.

The current patch does

struct pt_regs {
	...
	/* Saved main processor registers. */
#ifdef CONFIG_R5900_128BIT_SUPPORT
	/* Support for 128 bit. */
	r5900_reg_t regs[32];
#else
	unsigned long regs[32];
#endif

with r5900_reg_t as

typedef struct __attribute__((aligned(16))) {
	unsigned long long lo;
	unsigned long long hi;
} r5900_reg_t;

There are 300+ register reads/writes throughout arch/mips that need to be
adjusted with this change. The patch introduces a set of MIPS_READ_REG and
MIPS_WRITE_REG macros for this purpose:

/* Cast larger R5900 register to smaller 32 bit. */
#define MIPS_READ_REG_L(reg) ((unsigned long)((reg).lo))
#define MIPS_READ_REG(reg) ((reg).lo)
#define MIPS_READ_REG_HIGH(reg) ((reg).hi)
#define MIPS_READ_REG_S(reg) ((long long)(reg).lo)
#define MIPS_WRITE_REG(reg) ((reg).lo)
#define MIPS_REG_T unsigned long long

Typical use cases are

	orig31 = MIPS_READ_REG(regs->regs[31]);

and

	MIPS_WRITE_REG(regs->regs[insn.i_format.rt]) = value;

Can this be improved? CONFIG_R5900_128BIT_SUPPORT is configurable but the 32
bit programs I've tested become unstable unless it's set, so something isn't
quite working without it (which may or may not be related to the registers,
since CONFIG_R5900_128BIT_SUPPORT activates some other changes as well).

At what stage in the patch series would it be appropriate to introduce
support for quadword registers, and in what form?

The rest of the notes comment on the new SYNC.P instruction, MFC0/MTC0,
short loop crashes in the memcpy/strlen family of functions, etc. Several of
these changes and workarounds are required for a stable system and would
need to be introduced in some form.

Fredrik
