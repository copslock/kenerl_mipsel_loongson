Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Jan 2004 12:20:38 +0000 (GMT)
Received: from p508B6259.dip.t-dialin.net ([IPv6:::ffff:80.139.98.89]:47685
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225217AbUAQMUf>; Sat, 17 Jan 2004 12:20:35 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i0HCKN4P023609;
	Sat, 17 Jan 2004 13:20:23 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i0HCKMWt023607;
	Sat, 17 Jan 2004 13:20:22 +0100
Date: Sat, 17 Jan 2004 13:20:22 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Suresh. R" <suresh@mistralsoftware.com>
Cc: linux-mips@linux-mips.org
Subject: Re: VR4131 - MQ1132 - UPD63335
Message-ID: <20040117122022.GD5288@linux-mips.org>
References: <40079391.7080301@mistralsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40079391.7080301@mistralsoftware.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4002
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jan 16, 2004 at 01:02:33PM +0530, Suresh. R wrote:

>   This might be a very basic question, but I am very new to this field. 
> So please help me.
> 
> I am writing a linux device driver for UPD63335 audio codec. Its 
> controlled through the MQ1132 co-processor. The VR4131 is the processor. 
> The memory of MQ1132 is mapped to the processor memory in Kseg1 (0xA000 
> 0000 onwards) which the manual says is TLB Unmapped region. Now my 
> question is is it necessary to map this region before using it in Linux. 
> Actually I have WinCE code for my reference. In that code the programmer 
> is mapping the region using Virtual Cpoy and Virtual Alloc. Is it 
> necessary to do that or Can I directly address the memory locatoin.

Generally a driver under Linux maps a device in it's initialization
routine with a bit of code like

#define FOO_BASE	0x12340000UL		/* physical address */
#define FOO_SIZE	0x00001000UL

...
	struct foo_regs *base;

	base = ioremap(0x1234, FOO_SIZE);
	if (!base) {
		/* Failed, game over  */
		harakiri();
		...
	}

	/* Success, make it blink ... */
	foo->blinkenlight = 42;
...
	/* Done, unmap before exiting.
	unmap(base);
...

This removes all knowledge about how a particular architecture handles
mappings from the driver and therefore is generally the prefered way in
Linux.

Linux/MIPS optimize the case where an unmapped area can be used, so no
runtime overhead at all.

  Ralf
