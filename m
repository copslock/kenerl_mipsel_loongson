Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3KHYcN32339
	for linux-mips-outgoing; Fri, 20 Apr 2001 10:34:38 -0700
Received: from cvsftp.cotw.com (cvsftp.cotw.com [208.242.241.39])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3KHYbM32336
	for <linux-mips@oss.sgi.com>; Fri, 20 Apr 2001 10:34:37 -0700
Received: from cotw.com (ptecdev3.inter.net [192.168.10.5])
	by cvsftp.cotw.com (8.9.3/8.9.3) with ESMTP id LAA09816
	for <linux-mips@oss.sgi.com>; Fri, 20 Apr 2001 11:34:34 -0500
Message-ID: <3AE081E3.434E9126@cotw.com>
Date: Fri, 20 Apr 2001 11:37:24 -0700
From: Scott A McConnell <samcconn@cotw.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: IRQ questions
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I am trying to hunt down what I believe is an IRQ problem associated
with my serial driver.

I guess I am using old style interrupts.

In 2.4.0-test 5 the file arch/mips/kernel/irq.c used to be built. Under
2.4.3 it no longer is. However, it appears it was renamed to old_irg.c
and a new irq.c was created. I also noticed that an i8259.c files was
added at some point. However, it does not seem to match the code that
was in irq.c.

Are there any notes available that explain how to convert from old style
IRQ's to new?
What are we suppose to do with the new irq.c which is not being used?


I have a 2.4.3 kernel booting. I copied the old  arch/mips/kernel/irq.c
to my target directory and changed
a few other things to get everything to compile. As long as I do not try
to use a serial port everything seems to be working.  I booted with a
frame buffer and started X.  The mouse and keyboard worked so some of my
IRQ's appear to be working.

When I start the serial port things seem to go fine untile it trys to
write the port at which point it starts running very slowly. Which is
what make me think the kernel is being overcome with interrupts.

Thanks for any thoughts or advice.

Scott
