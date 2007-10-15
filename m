Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Oct 2007 16:06:01 +0100 (BST)
Received: from relay01.mx.bawue.net ([193.7.176.67]:38817 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S20036832AbXJOPFx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 15 Oct 2007 16:05:53 +0100
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	by relay01.mx.bawue.net (Postfix) with ESMTP id DCC5348C0D;
	Mon, 15 Oct 2007 17:04:50 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.67)
	(envelope-from <ths@networkno.de>)
	id 1IhRVK-0007Q3-3o; Mon, 15 Oct 2007 16:05:14 +0100
Date:	Mon, 15 Oct 2007 16:05:14 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Aurelien Jarno <aurelien@aurel32.net>
Cc:	linux-mips@linux-mips.org, qemu-devel@nongnu.org
Subject: Re: [Qemu-devel] QEMU/MIPS & dyntick kernel
Message-ID: <20071015150514.GV3379@networkno.de>
References: <20071002200644.GA19140@hall.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071002200644.GA19140@hall.aurel32.net>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17040
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Aurelien Jarno wrote:
> Hi,
> 
> As announced by Ralf Baechle, dyntick is now available on MIPS. I gave a
> try on QEMU/MIPS, and unfortunately it doesn't work correctly.
> 
> In some cases the kernel schedules an event very near in the future, 
> which means the timer is scheduled a few cycles only from its current
> value. Unfortunately under QEMU, the timer runs too fast compared to the
> speed at which instructions are execution. This causes a lockup of the
> kernel. This can be triggered by running hwclock --hctosys in the guest
> (which is run at boot time by most distributions). Until now, I haven't 
> found any other way to trigger the bug.

I found Qemu/MIPS locks up in the emulated kernel's calibrate_delay
function. Switching the kernel option off works around the problem.

> The problematic code in the kernel from arch/mips/kernel/time.c is the
> following:
> 
>         cnt = read_c0_count();
>         cnt += delta;
>         write_c0_compare(cnt);
>         res = ((long)(read_c0_count() - cnt ) > 0) ? -ETIME : 0;
> 
> Note that there is a minimum value for delta (currently set to 48) to 
> avoid lockup.
> 
> In QEMU, the emulated kernel runs at 100 MHz, ie very fast, which means
> that more than 48 timer cycles happen between the two calls of
> read_c0_count(). The code returns -ETIME, and the routine is called
> again with 48 and so on.
> 
> I have tried to reduce the speed of the timer, the problem disappears
> when running at 1MHz (on my machine).
> 
> Here are a few proposed ways to fix the problem (they are not exclusive):
> 
> 1) Improve the emulation speed for timer instructions. This is what I
> did with the attached patch. I see no obvious reason of stopping the
> translation after a write to CP0_Compare, so I removed that part.

The write could trigger an exception.


Thiemo
