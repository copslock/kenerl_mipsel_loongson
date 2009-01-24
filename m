Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Jan 2009 08:57:40 +0000 (GMT)
Received: from mail.bugwerft.de ([212.112.241.193]:29134 "EHLO
	mail.bugwerft.de") by ftp.linux-mips.org with ESMTP
	id S21366144AbZAXI5i (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 24 Jan 2009 08:57:38 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.bugwerft.de (Postfix) with ESMTP id A6D068F849D;
	Sat, 24 Jan 2009 09:57:32 +0100 (CET)
Received: from mail.bugwerft.de ([127.0.0.1])
	by localhost (mail.bugwerft.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3Xe2-7LZt6En; Sat, 24 Jan 2009 09:57:31 +0100 (CET)
Received: from [10.1.1.26] (unknown [192.168.22.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bugwerft.de (Postfix) with ESMTP id 68CD68F849C;
	Sat, 24 Jan 2009 09:57:30 +0100 (CET)
Subject: Re: Au1550 with kernel linux-2.6.28.1
From:	Frank Neuber <linux-mips@kernelport.de>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20090124085734.5b6b5c66@scarran.roarinelk.net>
References: <1232739600.28527.289.camel@t60p>
	 <20090124085734.5b6b5c66@scarran.roarinelk.net>
Content-Type: text/plain
Date:	Sat, 24 Jan 2009 09:57:28 +0100
Message-Id: <1232787448.28527.302.camel@t60p>
Mime-Version: 1.0
X-Mailer: Evolution 2.12.1 
Content-Transfer-Encoding: 7bit
Return-Path: <linux-mips@kernelport.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21805
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux-mips@kernelport.de
Precedence: bulk
X-list: linux-mips

Hi Manuel,
thank you for your quick response.

Am Samstag, den 24.01.2009, 08:57 +0100 schrieb Manuel Lauss:
> > I just want to ask who is working with the au1550 on a more recent
> > kernel than 2.6.16.11. 
> > I'll start now with some early printk to solve booting problems and than
> > we will see .....
> 
> I know of at least one person running 2.6.26 or .27 on a Au1550.
> You should start by throwing away the defconfig ;-).  Create a new
> config with only au1x00 serial and serial console enabled and then add
> new devices one at a time and see where it breaks.
Yestoday I tested the earlyprintk stuff witout luck :-(
I simply added this CMDLINE earlycon=uart,mmio,0x11100000,115200n8
console=ttyS0,115200n8 panic=1
The drivers/serial/8250_early.o is build in the kernel but without
adding CONFIG_EARLY_PRINTK or CONFIG_SYS_HAS_EARLY_PRINTK. Maybe this is
the problem.
On the running kernel I see this.
Serial: 8250/16550 driver $Revision: 1.90 $ 5 ports, IRQ sharing enabled
serial8250.7: ttyS0 at MMIO 0x11100000 (irq = 0) is a 16550A
serial8250.7: ttyS1 at MMIO 0x11200000 (irq = 8) is a 16550A
serial8250.7: ttyS2 at MMIO 0x11400000 (irq = 9) is a 16550A
The console is console=ttyS0,115200n8 ....

Now I'll go more deep into the kernel. 
> 
> (Btw, which board?  I'd love to get my hands on other alchemy boards to
> test on).
It is a customer board not available on the market.

It is possible for you to connect me to this person. Maybe we can share
some know how. At the moment I work on USB Analog/DVB stuff more deep on
MIPS.

Kind Regards,
 Frank
