Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Oct 2009 17:52:11 +0200 (CEST)
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:39986 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493475AbZJTPwE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 20 Oct 2009 17:52:04 +0200
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 57002B2966;
	Tue, 20 Oct 2009 11:52:00 -0400 (EDT)
Received: from web8.messagingengine.com ([10.202.2.217])
  by compute2.internal (MEProxy); Tue, 20 Oct 2009 11:52:00 -0400
Received: by web8.messagingengine.com (Postfix, from userid 99)
	id 96FAB372CC; Tue, 20 Oct 2009 11:52:00 -0400 (EDT)
Message-Id: <1256053920.24677.1341041247@webmail.messagingengine.com>
X-Sasl-Enc: xpJK0wLWsBrKVgkMCuKnHX+i85v3Xs2FNyU64AlP/hhs 1256053920
From:	myuboot@fastmail.fm
To:	"Florian Fainelli" <florian@openwrt.org>
Cc:	linux-kernel@vger.kernel.org,
	"linux-mips" <linux-mips@linux-mips.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: MessagingEngine.com Webmail Interface
References: <1255735395.30097.1340523469@webmail.messagingengine.com>
 <4AD906D8.3020404@caviumnetworks.com>
 <1255996564.10560.1340920621@webmail.messagingengine.com>
 <200910200817.24018.florian@openwrt.org>
Subject: Re: serial port 8250 messed up after coverting from little endian to
 big endian on kernel  2.6.31
In-Reply-To: <200910200817.24018.florian@openwrt.org>
Date:	Tue, 20 Oct 2009 10:52:00 -0500
Return-Path: <myuboot@fastmail.fm>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24391
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: myuboot@fastmail.fm
Precedence: bulk
X-list: linux-mips

I happen to use the same code from ar7. So this part
serial_int/serial_out should be fine?

#define PORT(offset) (KSEG1ADDR(MY_MIPSBOARD_REGS_UART0 + (offset * 4)))
static inline unsigned int serial_in(int offset)
{
        return readl((void *)PORT(offset));
}

static inline void serial_out(int offset, int value)
{
        writel(value, (void *)PORT(offset));
}

Thanks. 



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
