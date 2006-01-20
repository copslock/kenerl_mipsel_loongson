Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jan 2006 17:23:05 +0000 (GMT)
Received: from sakura.staff.proxad.net ([213.228.1.107]:43396 "EHLO
	sakura.staff.proxad.net") by ftp.linux-mips.org with ESMTP
	id S3948868AbWATRWq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 20 Jan 2006 17:22:46 +0000
Received: from max by sakura.staff.proxad.net with local (Exim 3.36 #1 (Debian))
	id 1F0022-0001yY-00
	for <linux-mips@linux-mips.org>; Fri, 20 Jan 2006 18:26:38 +0100
Subject: Time slowing down while doing IDE PIO transfer
From:	Maxime Bizon <mbizon@freebox.fr>
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date:	Fri, 20 Jan 2006 18:26:37 +0100
Message-Id: <1137777997.16631.147.camel@sakura.staff.proxad.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Return-Path: <mbizon@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10022
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips


Hello all,

I have a R4Kec board with an IDE controller, and run linux-mips 2.6.14
on it. When running a transfer on a cdrom drive, with dma disabled and
at lowest pio mode, time is slowing down (about 10 times too slow).

HZ is 1000, I'm using generic mips timer code (arch/mips/kernel/time.c),
HPT and timer interrupts are R4K.

This is I guess related to the interrupts being disabled during pio
transfer (I can't use unmaskirq btw).

Looking at timer_interrupt() code, I see that do_timer() will be only
called once, whether we have lost timer interrupts or not, I guess this
is the reason of this time problem. Is it a wanted behaviour ?

If this is the case, I guess my only hope is running with lower HZ or
using an RTC ?

Thanks,

-- 
Maxime
