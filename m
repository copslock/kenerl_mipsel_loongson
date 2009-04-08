Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Apr 2009 23:47:27 +0100 (BST)
Received: from mms1.broadcom.com ([216.31.210.17]:4358 "EHLO mms1.broadcom.com")
	by ftp.linux-mips.org with ESMTP id S20024384AbZDHWrU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 8 Apr 2009 23:47:20 +0100
Received: from [10.11.16.99] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.2)); Wed, 08 Apr 2009 15:46:57 -0700
X-Server-Uuid: 02CED230-5797-4B57-9875-D5D2FEE4708A
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 181CD2C1; Wed, 8 Apr 2009 15:46:57 -0700 (PDT)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.11.18.52]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id 03E692B0; Wed, 8 Apr
 2009 15:46:57 -0700 (PDT)
Received: from mail-irva-13.broadcom.com (mail-irva-13.broadcom.com
 [10.11.16.103]) by mail-irva-8.broadcom.com (MOS 3.7.5a-GA) with ESMTP
 id HPG03619; Wed, 8 Apr 2009 15:46:55 -0700 (PDT)
Received: from [10.28.6.13] (lab-mhtb-013.ne.broadcom.com [10.28.6.13])
 by mail-irva-13.broadcom.com (Postfix) with ESMTP id B132374D04; Wed, 8
 Apr 2009 15:46:54 -0700 (PDT)
Subject: Re: What is the right way to setup MIPS timer irq in 2.6.29?
From:	"Jon Fraser" <jfraser@broadcom.com>
Reply-to: jfraser@broadcom.com
To:	"David Wuertele" <dave+gmane@wuertele.com>
cc:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
In-Reply-To: <loom.20090408T165537-312@post.gmane.org>
References: <loom.20090408T165537-312@post.gmane.org>
Organization: Broadcom
Date:	Wed, 08 Apr 2009 18:46:54 -0400
Message-ID: <1239230814.14558.42.camel@chaos.ne.broadcom.com>
MIME-Version: 1.0
X-Mailer: Evolution 2.12.3 (2.12.3-5.fc8)
X-WSS-ID: 65C3F6EB3843947664-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jfraser@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22278
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jfraser@broadcom.com
Precedence: bulk
X-list: linux-mips

Which platform?

On Wed, 2009-04-08 at 09:57 -0700, David Wuertele wrote:
> Has the system timer paradigm changed between 2.6.18 and 2.6.29?
> I'm trying to update my Broadcom-based embedded system to 2.6.29,
> and I'm running into problems getting the system timer to run.
> I'm looking for a clue about how to port forward my arch/mips/brcmstb/*
> files, specifically I want to write a plat_time_init() function
> that does for 2.6.29 what plat_timer_setup(struct irqaction *irq)
> did for 2.6.18.
> 
> In 2.6.18, arch/mips/kernel/time.c defines a high-level ISR called
> timer_interrupt (which does things like lock xtime_lock, call
> mips_hpt_read() and do_timer(regs), and return IRQ_HANDLED). time.c
> then defines a struct irqaction timer_irqaction and sets
> timer_interrupt to be the .handler field.  Finally, time.c calls
> plat_timer_setup(timer_irqaction), which is defined by the Broadcom
> patches to call setup_irq(timer_irqaction).
> 
> In 2.6.29, arch/mips/kernel/time.c has a comment saying that the new
> plat_time_init hook does not receive the irqaction pointer argument
> anymore, because each "clock_event_device" should use its own struct
> irqrequest.
> 
> I tried having the broadcom arch's plat_time_init() function create an
> irqaction and call setup_irq(), but the timer_interrupt() function
> that used to be in arch/mips/kernel/time.c doesn't exist anymore, and
> I can't seem to find the replacement.
> 
> Is there a replacement for timer_interrupt()?  I thought that maybe
> the hrtimer_interrupt() might be the one, but it requires something
> called a struct clock_event_device.  When I looked at clock_event_device
> it was very complex, and I get the feeling I'm barking up the wrong tree.
> 
> Can anyone offer pointers on how to call setup_irq() from plat_time_init()?
> 
> Thanks,
> Dave
> 
> 
> 
