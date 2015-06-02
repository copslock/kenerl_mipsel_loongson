Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jun 2015 08:51:31 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:50824 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27006736AbbFBGv26Q5K4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 2 Jun 2015 08:51:28 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t526pNCX014402;
        Tue, 2 Jun 2015 08:51:24 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t526pNkG014401;
        Tue, 2 Jun 2015 08:51:23 +0200
Date:   Tue, 2 Jun 2015 08:51:23 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: IP27: R14000: Unexpected General Exception in
 cpu_set_fpu_fcsr_mask()
Message-ID: <20150602065122.GE26432@linux-mips.org>
References: <556943D9.7020502@gentoo.org>
 <alpine.LFD.2.11.1506010025410.22908@eddie.linux-mips.org>
 <556BCA01.1070208@gentoo.org>
 <alpine.LFD.2.11.1506011218590.22908@eddie.linux-mips.org>
 <556D378C.8060503@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <556D378C.8060503@gentoo.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47772
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Tue, Jun 02, 2015 at 12:56:44AM -0400, Joshua Kinard wrote:

> >>>  I'll submit the final fix, properly annotated, if your testing confirms 
> >>> my diagnosis.
> >>
> >> That got it to boot again.  I added CPU ID to the printk as well, and got some
> >> odd output from one of the CPUs:
> >>
> >> # dmesg | grep FCSR
> >> [    0.000000] CPU0: FCSR is: 00000000
> >> [    0.319158] CPU1: FCSR is: 00000000
> >> [    0.364971] CPU2: FCSR is: ffffffffa8000000
> >> [    0.404854] CPU3: FCSR is: 00000000
> > 
> >  The value reported for CPU2 merely shows FCC[7,5,3] bits set, nothing 
> > really odd about that, the CPU may well have come out of reset like this.  
> > Neither of the values reported though actually corresponds to the symptom 
> > you saw, can you double-check you didn't make a typo in your modification 
> > to `printk'?
> 
> I commented on it being odd because out of four CPUs, #2 was coming up with a
> sign-extended value, twice (I tested two reboot cycles, same both times).  I'm
> not fully knowledgable of IP27 hardware, and am probably one of the few on the
> planet in possession of R14K node boards, so this might be a quirk of these
> specific nodes.  Would need others to test to verify, I guess.
> 
> Could always turn on heavy diags and poke through the verbose MSC reporting if
> needed.
> 
> As for a typo, nope:
> 
> 	__enable_fpu(FPU_AS_IS);
> 
> 	fcsr = read_32bit_cp1_register(CP1_STATUS);
> ->	pr_info("CPU%d: FCSR is: %08lx\n", smp_processor_id(), fcsr);
> 	fcsr &= ~mask;

Maciej, I think the variables sr, mask, fcsr, fcsr0 and fcsr1 should
become unsigned ints; they all represent 32 bit CPU registers.  Also
read_32bit_cp1_register() return a signed int.  A signed int probably
would make more sense here.

  Ralf
