Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Apr 2009 18:10:11 +0100 (BST)
Received: from main.gmane.org ([80.91.229.2]:56215 "EHLO ciao.gmane.org")
	by ftp.linux-mips.org with ESMTP id S20025723AbZDHRKE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 8 Apr 2009 18:10:04 +0100
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LrbHm-0001XV-9T
	for linux-mips@linux-mips.org; Wed, 08 Apr 2009 17:10:02 +0000
Received: from gate-ca119.motorola.com ([144.189.100.25])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Wed, 08 Apr 2009 17:10:02 +0000
Received: from dave+gmane by gate-ca119.motorola.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Wed, 08 Apr 2009 17:10:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
To:	linux-mips@linux-mips.org
From:	David Wuertele <dave+gmane@wuertele.com>
Subject:  What is the right way to setup MIPS timer irq in 2.6.29?
Date:	Wed, 8 Apr 2009 16:57:33 +0000 (UTC)
Message-ID:  <loom.20090408T165537-312@post.gmane.org>
Mime-Version:  1.0
Content-Type:  text/plain; charset=us-ascii
Content-Transfer-Encoding:  7bit
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 144.189.100.25 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.8) Gecko/2009032608 Firefox/3.0.8)
Return-Path: <sgi-linux-mips@m.gmane.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22276
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dave+gmane@wuertele.com
Precedence: bulk
X-list: linux-mips

Has the system timer paradigm changed between 2.6.18 and 2.6.29?
I'm trying to update my Broadcom-based embedded system to 2.6.29,
and I'm running into problems getting the system timer to run.
I'm looking for a clue about how to port forward my arch/mips/brcmstb/*
files, specifically I want to write a plat_time_init() function
that does for 2.6.29 what plat_timer_setup(struct irqaction *irq)
did for 2.6.18.

In 2.6.18, arch/mips/kernel/time.c defines a high-level ISR called
timer_interrupt (which does things like lock xtime_lock, call
mips_hpt_read() and do_timer(regs), and return IRQ_HANDLED). time.c
then defines a struct irqaction timer_irqaction and sets
timer_interrupt to be the .handler field.  Finally, time.c calls
plat_timer_setup(timer_irqaction), which is defined by the Broadcom
patches to call setup_irq(timer_irqaction).

In 2.6.29, arch/mips/kernel/time.c has a comment saying that the new
plat_time_init hook does not receive the irqaction pointer argument
anymore, because each "clock_event_device" should use its own struct
irqrequest.

I tried having the broadcom arch's plat_time_init() function create an
irqaction and call setup_irq(), but the timer_interrupt() function
that used to be in arch/mips/kernel/time.c doesn't exist anymore, and
I can't seem to find the replacement.

Is there a replacement for timer_interrupt()?  I thought that maybe
the hrtimer_interrupt() might be the one, but it requires something
called a struct clock_event_device.  When I looked at clock_event_device
it was very complex, and I get the feeling I'm barking up the wrong tree.

Can anyone offer pointers on how to call setup_irq() from plat_time_init()?

Thanks,
Dave
