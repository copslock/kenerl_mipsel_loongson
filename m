Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jun 2003 17:39:05 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:55290 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225211AbTFIQjD>;
	Mon, 9 Jun 2003 17:39:03 +0100
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id JAA03258;
	Mon, 9 Jun 2003 09:37:59 -0700
Subject: Re: pcmcia problem on pb1500
From: Pete Popov <ppopov@mvista.com>
To: Jan Pedersen <jp@q-networks.com>
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
In-Reply-To: <1055152798.17834.28.camel@jp>
References: <1054907964.14600.172.camel@jp>
	 <1054919329.18838.184.camel@zeus.mvista.com> <1055013539.10775.46.camel@jp>
	 <1055110501.11039.2.camel@adsl.pacbell.net>  <1055152798.17834.28.camel@jp>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1055176714.9969.4.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 09 Jun 2003 09:38:34 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2570
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Mon, 2003-06-09 at 02:59, Jan Pedersen wrote:
> found it!
> 
> the cardmgr has local cs_types.h & ss.h. Theese has to be patched as
> well...

Argh, I forgot about that.  One of more of the ioctls sent to the driver
are based on the actual data type. So after you apply the 64 bit pcmcia
patch (which you do need), you also need to patch the cardmgr. Thanks
for the reminder :)  I have to update the README.

Pete

> thanks for the help :-)

> On Mon, 2003-06-09 at 00:15, Pete Popov wrote:
> > 
> > > I am not using linux-mips. I am using 2.4.19 directly from kernel.org.
> > > Some files are patched from mips-linux (non-pcmcia stuff).
> > 
> > > Tried latest cvs version from linux-mips.org this weekend. By some
> > > reason I can't get any output on the serial port. If this kernel should
> > > work, maybe getting the serial-port to work on this is an easier task
> > > :-)
> > 
> > Take a look at the toplevel Makefile. I bet you got the head of
> > linux-mips which is 2.5 and, yes, it's quite borked right now :) I've
> > made some progress on the Pb1500 but until I get that board fully
> > functioning, I won't update the rest.  To get 2.4, do a "cvs update
> > -rlinux_2_4".
> > 
> > > On the other hand, everything else I need is currently working on 2.4.19
> > > (including pci)
> > > 
> > > Tried to do the 64bit_pcmcia.patch alone. Same result:
> > > 
> > > Linux Kernel Card Services 3.1.22
> > >   options:  [pci] [cardbus]
> > > Yenta IRQ list 0000, PCI irq4
> > > Socket status: 30000046
> > > Yenta IRQ list 0000, PCI irq4
> > > Socket status: 30000011
> > > cardmgr[148]: watching 2 sockets
> > > cardmgr[148]: could not adjust resource: IO ports 0xc00-0xcff: Invalid
> > > argument
> > > cardmgr[148]: could not adjust resource: IO ports 0x100-0x4ff: Invalid
> > > argument
> > > cardmgr[148]: could not adjust resource: memory 0x80000000-0x80ffffff:
> > > Invalid argument
> > > cardmgr[149]: starting, version is 3.2.4
> > > Done.
> > > cardmgr[cs: unable to map card memory!
> > > 14cs: unable to map card memory!
> > > 9]: initializing socket 1
> > > cardmgr[149]: socket 1: Anonymous Memory
> > > cardmgr[149]: module memory_cs.o not available
> > > cardmgr[149]: executing: 'modprobe memory_cs'
> > > cardmgr[149]: get dev info on socket 1 failed: Resource temporarily
> > > unavailable
> > > 
> > > Best result is with no patches, where it finds my cisco card.
> > > 
> > > > 
> > > > Take a look at the archives again and see how Jeff setup config.opts on
> > > > the target board. That was the key.  The cardmgr is recognizing your
> > > > card so it's reading the attribute memory successfully. You're almost
> > > > there ;)
> > > My configuration is based on his.
> > > yes, it seems like it can access the attribute memory, but not the io
> > > memory.
> > > 
> > > I was vondering about the io addresses shown with lspci -v. Are they
> > > valid?
> > 
> > I think so, yes.
> > 
> > Pete
> > 
> > > 00:0d.0 Class 0607: 104c:ac55 (rev 01)
> > >    I/O window 0: 00000000-00000fff
> > >    I/O window 1: 00000000-00000003
> > > 00:0d.1 Class 0607: 104c:ac55 (rev 01)
> > >    I/O window 0: 00000000-00000003
> > >    I/O window 1: 00001000-00001fff
> > > 
> > > anyway, thanks a lot for helping
> > > Jan
> > > 
> > > 
> > > 
> > > 
> > 
> 
> 
> 
