Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jul 2004 17:53:05 +0100 (BST)
Received: from web11906.mail.yahoo.com ([IPv6:::ffff:216.136.172.190]:11276
	"HELO web11906.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8224943AbUGVQxA>; Thu, 22 Jul 2004 17:53:00 +0100
Message-ID: <20040722165240.35417.qmail@web11906.mail.yahoo.com>
Received: from [65.204.143.11] by web11906.mail.yahoo.com via HTTP; Thu, 22 Jul 2004 09:52:40 PDT
Date: Thu, 22 Jul 2004 09:52:40 -0700 (PDT)
From: Wayne Gowcher <wgowcher@yahoo.com>
Subject: Re: Should pci driver probe behind a cardbus bridge at boot up ?
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
In-Reply-To: <20040721115743.C6813@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <wgowcher@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5541
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wgowcher@yahoo.com
Precedence: bulk
X-list: linux-mips

> > So as I wrote in my title, does anyone know if :
> > 
> > the pci driver should probe behind a cardbus
> bridge at
> > boot up or if it should be left to the yenta
> cardbus ?
> >
> 
> It should not - me think anyway.
> 
> Maybe you can tell us _why_, given the same code,
> i386 does
> not scan behind yenta.
> 
> Jun

I believe for x86 targets, the PC bios has already
scanned and programmed the memory / io  bar registers
of the PCI devices. So for an x86 target linux merely
reads the bar registers - it does not try to reprogram
them, and so does not go behind the cardbus bridge.

For mips and any other architecture which does not
have a bios to set up the pci bus like this, linux has
to scan and allocate io and memory, but as it is doing
so it is adding those resources to it's resource list.
- Effectively reserving those io / memory regions.
Then when yenta comes along, it also scans the cardbus
and tries to REALLOCATE the same resources, but finds
the pci probed resources, returns the "busy" and so
then tries to reallocate the already allocated
resources to a new memory region. 
Unfortunately in my case ( and I would like to know if
this true for other people's platforms ), when yenta
does this it seems to corrupt the proc/iomem and
proc/ioport list such that if I do "cat /proc/xx" on
either of these the kernel throws an oops. 

Can anyone else do a cat /proc/iomem or ioports with
yenta configured and a cardbus chip on board ?? 
If yes then I have a problem with my setup, if not
then I suspect the code.


		
__________________________________
Do you Yahoo!?
Yahoo! Mail Address AutoComplete - You start. We finish.
http://promotions.yahoo.com/new_mail 
