Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Oct 2009 21:40:25 +0100 (CET)
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:42664 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493147AbZJ0UkR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Oct 2009 21:40:17 +0100
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id B4D99BD9C1;
	Tue, 27 Oct 2009 16:40:13 -0400 (EDT)
Received: from web8.messagingengine.com ([10.202.2.217])
  by compute1.internal (MEProxy); Tue, 27 Oct 2009 16:40:14 -0400
Received: by web8.messagingengine.com (Postfix, from userid 99)
	id 85F131165D2; Tue, 27 Oct 2009 16:40:13 -0400 (EDT)
Message-Id: <1256676013.24305.1342273367@webmail.messagingengine.com>
X-Sasl-Enc: O5GRR4xDMrWRKUIPjIVxN3wYn9czEaaR89TCZMt3OAjj 1256676013
From:	myuboot@fastmail.fm
To:	"Florian Fainelli" <florian@openwrt.org>
Cc:	linux-kernel@vger.kernel.org,
	"linux-mips" <linux-mips@linux-mips.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: MessagingEngine.com Webmail Interface
In-Reply-To: <200910200817.24018.florian@openwrt.org>
References: <1255735395.30097.1340523469@webmail.messagingengine.com>
 <4AD906D8.3020404@caviumnetworks.com>
 <1255996564.10560.1340920621@webmail.messagingengine.com>
 <200910200817.24018.florian@openwrt.org>
Subject: Re: serial port 8250 messed up after coverting from little endian to
 big endian on kernel  2.6.31
Date:	Tue, 27 Oct 2009 15:40:13 -0500
Return-Path: <myuboot@fastmail.fm>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24544
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: myuboot@fastmail.fm
Precedence: bulk
X-list: linux-mips

Thanks, Florian. I found the cause of the problem. My board is 32 bit
based, so each serial port register is 32bit even only 8 bit is used. So
when the board is switched endianess, I need to change the address
offset to access the same registers.
For example, original RHR register address is 0x8001000 with little
endian mode. With big endian, I need to access it as 0x8001003.

On Tue, 20 Oct 2009 08:17 +0200, "Florian Fainelli"
<florian@openwrt.org> wrote:
> Hi,
> 
> Le mardi 20 octobre 2009 01:56:04, myuboot@fastmail.fm a écrit :
> > I am trying to bringup a MIPS32 board using 2.6.31. It is working in
> > little endian mode. After changing the board's hardware from little
> > endian to bit endian, the serial port print messed up. It prints now
> > something like - "àààààààààààààààà" on the screen. When I trace the
> > execution, I can see the string the kernel is trying print is correct -
> > "Linux version 2.6.31 ..." and etc.
> > 
> > I guess it means the initialization of the serial port is not properly
> > done. But I am not sure where I should check for the problem. The serial
> > port device I am using is 8250. Please give me some advise.
> 
> If the same initialization routine used to work in little-endian, check
> how 
> you actually write and read characters from the UART FIFO and especially
> if 
> your hardware requires you to do word or byte access to these registers.
> 
> You can have a look at AR7, which has the same code working for Little
> and Big 
> Endian modes in arch/mips/ar7/prom.c lines 272 to the end of the file. It
> also 
> uses a 8250-compatible UART.
