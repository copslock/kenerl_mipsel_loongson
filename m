Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Apr 2003 16:38:29 +0100 (BST)
Received: from UX3.SP.CS.CMU.EDU ([IPv6:::ffff:128.2.198.103]:466 "HELO
	ux3.sp.cs.cmu.edu") by linux-mips.org with SMTP id <S8225072AbTDHPi2>;
	Tue, 8 Apr 2003 16:38:28 +0100
Received: from GS256.SP.CS.CMU.EDU ([128.2.199.27]) by ux3.sp.cs.cmu.edu
          id aa04659; 8 Apr 2003 11:37 EDT
Subject: Re: printk problems
From: Justin Carlson <justinca@cs.cmu.edu>
To: "Avinash S." <avinash.s@inspiretech.com>
Cc: linux <linux-mips@linux-mips.org>
In-Reply-To: <200304081211.h38CBgf6024962@smtp.inspirtek.com>
References: <200304081211.h38CBgf6024962@smtp.inspirtek.com>
Content-Type: text/plain
Organization: 
Message-Id: <1049816267.17005.25.camel@gs256.sp.cs.cmu.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 08 Apr 2003 11:37:48 -0400
Content-Transfer-Encoding: 7bit
Return-Path: <justinca@cs.cmu.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1941
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: justinca@cs.cmu.edu
Precedence: bulk
X-list: linux-mips

On Tue, 2003-04-08 at 07:57, Avinash S. wrote:
> Hello,
> I am trying to port linux to a custom built IDT MIPS board. I have 
> managed to get the UART working. My bootup code loads and prints some 
> debugging messages initially and then actual kernel bootup occurs. 
> However it hangs when it reaches the first printk function. i have tried 
> to debug this with some difficulty but with no effect. Could some one 
> tell me or atleast point me to where i can get some info on how printk 
> works or atleast how to debug my printk to see where the actual problem 
> lies?
> 

Couple quick questions:

1)  I assume you want to do console over serial port.  You have
SERIAL_CONSOLE enabled in your .config, right?

2) Is the UART standard, for which a driver is extant?  If not, you'll
need to write one.  

3) Are you sure it's hanging, or is it just not reporting anything
else?  Do you have other status indicators (i.e. LED's of some sort?)


Here's the 30 second summary of what happens at bootup on a serial
console.  This is mostly from memory a year old or so, so don't take
this as gospel:

Pretty early in the boot sequence (in init/main.c) console_init() is
called (in drivers/char/tty_io.c).  If your serial driver is compiled in
with console support, the serial port is initialized here, and added to
a list of available consoles.  The first(?) extant console is chosen for
console output, where your printk()s will end up.

Until this point, printk() calls are buffered in memory.  If you have
printk()s not showing up, odds are pretty good you're failing to
initialize the serial console in some way.

Hope that helps...

-Justin
