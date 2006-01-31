Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2006 19:37:34 +0000 (GMT)
Received: from deliver-1.mx.triera.net ([213.161.0.31]:6081 "HELO
	deliver-1.mx.triera.net") by ftp.linux-mips.org with SMTP
	id S8133545AbWAaThR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 31 Jan 2006 19:37:17 +0000
Received: from localhost (in-3.mx.triera.net [213.161.0.27])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id D8BD7C039;
	Tue, 31 Jan 2006 20:42:08 +0100 (CET)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-3.mx.triera.net (Postfix) with SMTP id 0CA5D1BC08D;
	Tue, 31 Jan 2006 20:42:13 +0100 (CET)
Received: from [192.168.80.29] (cmb58-52.dial-up.arnes.si [153.5.49.52])
	by smtp.triera.net (Postfix) with ESMTP id D09101A18B0;
	Tue, 31 Jan 2006 20:42:00 +0100 (CET)
Subject: Re: PCMCIA on AU1200
From:	Matej Kupljen <matej.kupljen@ultra.si>
To:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <200601311503.52130.eckhardt@satorlaser.com>
References: <1138703953.7932.36.camel@localhost.localdomain>
	 <200601311503.52130.eckhardt@satorlaser.com>
Content-Type: text/plain
Date:	Tue, 31 Jan 2006 20:41:53 +0100
Message-Id: <1138736513.7884.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Triera AV Service
Return-Path: <matej.kupljen@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10261
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matej.kupljen@ultra.si
Precedence: bulk
X-list: linux-mips

Hi

> I'm not exactly sure what your problems are, but maybe this helps you achieve 
> what you want.
> 
> Firstly, 0xf 0000 0000 is the 36 bit physical address. This address is mapped 
> by the driver via ioremap() into a 32 bit virtual address. 

Yes, in the drivers/pcmcia/au1000_generic.c.
Also, the skt->phys_attr and the skt->phys_mem are set to
0xF4000000 and 0xF8000000 respectively and I wonder, where they got
those values? 

> Now, I think there 
> are three macros for the PCMCIA memory regions (at least there were for the 
> Au1100), which you can ioremap() separately.
> 
> Now, what gave me most trouble where two other things that needed to be done 
> for my board (they might be different for you):
> 1. configure the static bus controller
> This mainly means selecting the right timing parameters and switching the 
> right bits on and off. You definitely need to read the programmer's handbook 
> from AMD/Alchemy.

I am reading the specs for the CPU. 
That is my problem, I do not to what value should I set CE[3], namely
mem_stadd3 register. which select the physical address that asserts 
the CE[3]. I think this should be set up by bootloader. I am using
U-Boot, but I have checked also the Yamon and it does not work, also.

> 2. turn on power
> In my case, power on and card detect were wired to some GPIO pins, so I had to 
> switch them to the right level. This might require additional configuration 
> in advance, too, but you can check the results using a simple voltmeter.

The power is detected and the power is turned ON (I can set the LED on
the PCMCIA card blinking).

> However: The DB boards are generally supported by Linux, so I wonder why you 
> need to do anything at all.

Yes. I am using kernel 2.6.15 and when I insert card into the slot,
Linux detects it and turns on the power.
I do not have the board here right now, so I'll post the messages from
the cardmngr tomorrow.

Thanks for the answers.

BR,
Matej
