Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jun 2015 13:32:43 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27006984AbbFBLckyJn34 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jun 2015 13:32:40 +0200
Date:   Tue, 2 Jun 2015 12:32:40 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Joshua Kinard <kumba@gentoo.org>
cc:     Linux MIPS List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: IP27: R14000: Unexpected General Exception in
 cpu_set_fpu_fcsr_mask()
In-Reply-To: <556D378C.8060503@gentoo.org>
Message-ID: <alpine.LFD.2.11.1506021208120.22908@eddie.linux-mips.org>
References: <556943D9.7020502@gentoo.org> <alpine.LFD.2.11.1506010025410.22908@eddie.linux-mips.org> <556BCA01.1070208@gentoo.org> <alpine.LFD.2.11.1506011218590.22908@eddie.linux-mips.org> <556D378C.8060503@gentoo.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47784
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

On Tue, 2 Jun 2015, Joshua Kinard wrote:

> I commented on it being odd because out of four CPUs, #2 was coming up with a
> sign-extended value, twice (I tested two reboot cycles, same both times).  I'm
> not fully knowledgable of IP27 hardware, and am probably one of the few on the
> planet in possession of R14K node boards, so this might be a quirk of these
> specific nodes.  Would need others to test to verify, I guess.

 That's how the CFC1 instruction works, it sign-extends the 32-bit value 
written to the destination register on 64-bit processors.  So if the chip 
has come out of reset with FCSR.FCC[7] set, then the bit will be repeated 
across bits 63:32 when the bit pattern from FCSR has been transferred to a 
general-purpose register.

> As for a typo, nope:
> 
> 	__enable_fpu(FPU_AS_IS);
> 
> 	fcsr = read_32bit_cp1_register(CP1_STATUS);
> ->	pr_info("CPU%d: FCSR is: %08lx\n", smp_processor_id(), fcsr);
> 	fcsr &= ~mask;

 OK, thanks for confirming.  So it looks like the cause of the exception 
vanished at the same time.  There's no harm in reinitialising FCSR here 
though, any vendor-specific bits possibly set will be cleared on process 
creation anyway.

  Maciej
