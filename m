Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jun 2015 21:32:14 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:46659 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27026886AbbFATcMbBg54 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 1 Jun 2015 21:32:12 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t51JW8NT003259;
        Mon, 1 Jun 2015 21:32:08 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t51JW8sd003258;
        Mon, 1 Jun 2015 21:32:08 +0200
Date:   Mon, 1 Jun 2015 21:32:08 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: IP30: SMP, Almost there?
Message-ID: <20150601193208.GA29986@linux-mips.org>
References: <55597B21.4010704@gentoo.org>
 <556142C5.7090206@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <556142C5.7090206@gentoo.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47766
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

On Sat, May 23, 2015 at 11:17:25PM -0400, Joshua Kinard wrote:

> I even got the IRQs to be fanned out across both CPUs.  Well, primarily the
> qla1280 drivers.  They randomly hop between both CPUs, but no ill effects so far.
> 
> But if I boot that *same* working kernel on an R14000 dual module, I get handed
> an IBE as soon as the userland mounts.  The only documented differences that I
> can find on the R14000 is that it supports DDR memory, being able to do memory
> operations on the rising edge and falling edge of each clock.  Not sure if that
> matters to the kernel at all, but I know of nothing else that describes the
> R14K's internals, such as if there's some new bit in CP0 config,
> branch-diagnostic, status, etc, that might explain why these IBE's are happening.
> 
> Guess I need to hunt down my old dual R10K module next and verify that works
> fine...
> 
> Also, is there a way to hardcode the cca=5 setting for IP30?  Maybe it needs to
> be a hidden Kconfig item?.  I tried setting cpu->writecombine in cpu-probe.c,
> but no dice there.  If I boot an SMP kernel on dual R12K's w/o cca=5, I'll get
> one or two pretty-specific oopses.  The one I did grab complains about bad
> spinlock magic in the core tty driver somewhere.  I can transcribe that oops
> later on if interested.

Can you insert something like:

  printk("c0_config: %08x\n", read_c0_config());

into a kernel and boot it without cca=5?  I'm really curious what the
startup CCA is.

  Ralf
