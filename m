Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Apr 2003 14:13:23 +0100 (BST)
Received: from mail.stellartec.com ([IPv6:::ffff:65.107.16.99]:14856 "EHLO
	nt_server.stellartec.com") by linux-mips.org with ESMTP
	id <S8225204AbTDWNNS>; Wed, 23 Apr 2003 14:13:18 +0100
Received: from wssseeger ([192.168.1.53]) by nt_server.stellartec.com
          (Post.Office MTA v3.1.2 release (PO205-101c)
          ID# 568-43562U100L2S100) with SMTP id AAA470;
          Wed, 23 Apr 2003 06:13:05 -0700
Reply-To: <sseeger@stellartec.com>
From: sseeger@stellartec.com (Steven Seeger)
To: <linux-mips@linux-mips.org>
Cc: <stevep@metrowerks.com>
Subject: rtai kernel patch
Date: Wed, 23 Apr 2003 06:19:00 -0700
Message-ID: <06fc01c3099a$e7c81950$3501a8c0@wssseeger>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Law11-F23vBGtWva7DY00002848@hotmail.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Return-Path: <sseeger@stellartec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2152
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sseeger@stellartec.com
Precedence: bulk
X-list: linux-mips

Hey guys. I have patched (successfully so far) RTAI into the latest
linux_2_4 tree on cvs. The patch is for mips32, which I guess is what falls
under arch/mips.

There are a couple of rules you must follow and these may require mods in
your board specific setup. The patch will include the proper patches for the
VR4181, since that is my only mips board.

1) Must use the cycle counter. (CP0_COUNT/CPO_COMPARE on IRQ 7(int 5))
2) Must have an interrupt handler that correctly passes irq numbers at the
low level.
3) Your int handler must not clobber v0 after calls to do_IRQ because
ret_from_irq and restore_all need to know what's up.
4) The linux timer interrupt handler must be set with setup_irq
5) In order to not crash, you may need to stick a litle magic in the
tlb-xk.c file for your CPU. I did this for the 4k already. 	Look at that
file in my patch. (when I submit it)
6) This will only work with the latest rtai cvs currently, at least once I
clean it up and check it in to their CVS later today. :)
7) Must set up mips_counter_frequency with correct cycle count for RTAI to
use.
8) If you use a wrapper for the timer interrupt, be sure it returns a 1.
(for rtai's sake) If it returns nothing or a zero, you will incur wrath so
great you'll be hoping for plagues or floods. You should not need a wrapper
if using the cycle counter, however.

The patching is done in:

include/asm/system.h
arch/mips/mm/tlb-r4k.c
arch/mips/kernel/irq.c
arch/mips/kernel/time.c
arch/mips/kernel/scall_o32.S
arch/mips/kernel/mips_ksyms.c
arch/mips/kernel/entry.S
arch/mips/vr4181/whatever to make it use the counter for the system timer,
plus taking a real command line on a0 for my board.

This kernel I am using here also currently has the VR41XX sound driver in
it, as well as the old /dev/rom driver. If I should include those let me
know. The drivers and the RTAI patch can be turned on and off from make
menuconfig of course. :)

Anyhow, I am wondering if anyone has a 5k board they'd like to try this on.
I can help with patching for that board, but I have no way to test it. Would
anyone else like to try rtai on a 4k board or anything else that falls under
arch/mips?

Let me know!

For those who don't know what RTAI is, check out
http://www.aero.polimi.it/~rtai/

On my wussy crappy sissy POS VR4181 my worst case interrupt latency on a
GPIO interrupt was 46 uS on 2.4.18 at 400 hz. Also running was an rtai
thread at 1000 khz. The stress test was repeated cat /dev/rom > /dev/null
and running a userland program that continues to allocate memory until it's
OOM'd.

For those who do know what RTAI is, there is currently no LXRT support and I
forget if there is SHM support or not. I only use interrupt handlers, timed
tasks (periodic and one-shot) and fifos.

If anyone has any requests or instructions on how I should submit the patch
other than my current plan (attached to a list message once I make the
patch) let me know.

Thanks guys.

Steve
