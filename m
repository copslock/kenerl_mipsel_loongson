Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7KFvnEC031557
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 20 Aug 2002 08:57:49 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7KFvnJk031556
	for linux-mips-outgoing; Tue, 20 Aug 2002 08:57:49 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mta5.snfc21.pbi.net (mta5.snfc21.pbi.net [206.13.28.241])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7KFvfEC031547
	for <linux-mips@oss.sgi.com>; Tue, 20 Aug 2002 08:57:41 -0700
Received: from [10.2.2.62] ([63.194.214.47])
 by mta5.snfc21.pbi.net (iPlanet Messaging Server 5.1 (built May  7 2001))
 with ESMTP id <0H1500LKGGH2WW@mta5.snfc21.pbi.net> for linux-mips@oss.sgi.com;
 Tue, 20 Aug 2002 09:00:39 -0700 (PDT)
Date: Tue, 20 Aug 2002 08:51:42 -0700
From: Pete Popov <ppopov@mvista.com>
Subject: Re: CONFIG_MIPS_IVR change for arch/mips/config.in
In-reply-to: <869DF7E0-B454-11D6-8E42-000393B3D1D0@tomlogic.com>
To: Tom Collins <tom@tomlogic.com>
Cc: linux-mips <linux-mips@oss.sgi.com>
Message-id: <1029858703.13478.18.camel@localhost.localdomain>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.0.8
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <869DF7E0-B454-11D6-8E42-000393B3D1D0@tomlogic.com>
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Without PCI_AUTO none of the pci devices will be configured properly,
unless the boot code sets them up.  The pmon version you have does that,
I believe, but I'm not sure everyone can count on using the same boot
code.  I think we fixed the problem you describe by skipping the system
controller (IT8172) config and leaving its default map.  The small patch
which affects it8172_pci.c is in the source forge tree but I don't know
if it made it to oss, probably not since the interest in that board is
small in the community itself.  In general, I think the IVR board
support in the sourceforge kernel is more up to date than oss.

Pete

On Tue, 2002-08-20 at 08:50, Tom Collins wrote:
> I'm not a subscriber to the list, so if anyone has questions or 
> responses, please email me directly.
> 
> I have a machine based on the Globespan IVR board, and just got done 
> fighting through an upgrade from 2.4.2 to 2.4.19.  In the process, I 
> determined that (at least for my configuration), CONFIG_PCI_AUTO should 
> not be set.  When set, the I/O mappings for my devices (USB) were out of 
> whack, and I was unable to use one of the on-board USB chips.
> 
> Here's the configuration as it stands on my machine now:
> 
> if [ "$CONFIG_MIPS_IVR" = "y" ]; then
>      define_bool CONFIG_PCI y
>      define_bool CONFIG_PC_KEYB y
>      define_bool CONFIG_NEW_PCI y
>      define_bool CONFIG_NONCOHERENT_IO y
>      define_bool CONFIG_PCI_AUTO n
>      define_bool CONFIG_IT8172_CIR y
>      define_bool CONFIG_NEW_IRQ y
>      define_bool CONFIG_NEW_TIME_C y
> fi
> 
> I am still working on a problem with a PCI card on the unit though.  
> It's a USB 2.0 interface which appears to the kernel as two OHCI (1.0) 
> interfaces and one EHCI (2.0) interface.  Right now, the kernel doesn't 
> find the EHCI interface.  If I find that changing other settings (like 
> CONFIG_NEW_PCI) results in that interface showing up (without blowing up 
> the others), I'll be sure to tell the list.
> 
> Can someone here please make sure this change gets into the 2.4.20 
> kernel?  I haven't been using the 2.5 kernels because the last one I 
> tried (2.5.25) wouldn't compile on my platform.
> 
> --
> Tom Collins
> tom@tomlogic.com
