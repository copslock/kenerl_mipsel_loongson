Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Oct 2007 15:34:36 +0100 (BST)
Received: from host238-171-dynamic.0-79-r.retail.telecomitalia.it ([79.0.171.238]:20379
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S20029309AbXJQOe0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 17 Oct 2007 15:34:26 +0100
Received: from eppesuig3 ([192.168.2.50])
	by eppesuigoccas.homedns.org with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1Ii9vQ-0004Xr-Nb
	for linux-mips@linux-mips.org; Wed, 17 Oct 2007 16:31:10 +0200
Subject: Re: Problems writing to USB devices
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To:	linux-mips@linux-mips.org
In-Reply-To: <Pine.LNX.4.64.0710170853090.22402@pixie.tetracon-eng.net>
References: <20071017100803.7794bb87.giuseppe@eppesuigoccas.homedns.org>
	 <Pine.LNX.4.64.0710170853090.22402@pixie.tetracon-eng.net>
Content-Type: text/plain
Date:	Wed, 17 Oct 2007 16:31:09 +0200
Message-Id: <1192631469.7948.16.camel@scarafaggio>
Mime-Version: 1.0
X-Mailer: Evolution 2.10.3 
Content-Transfer-Encoding: 7bit
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17091
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

Il giorno mer, 17/10/2007 alle 09.14 -0400, J. Scott Kasten ha scritto:
> On Wed, 17 Oct 2007, Giuseppe Sacco wrote:
> 
> > Hi all, I am still testing new kernels on the ip32 platform (and 
> > learning kernel structure :-)). Currently I found problems in writing to 
> > USB block devices. I may read from a pendrive without problem, but when 
> > I try to write the process stop. This is the last part of a transcript 
> > of strace output for "pvcreate /dev/sdc" command:
> >
> 
> A few questions...
> 
> * Which USB card, or more precisely, which chipset is on the USB card you 
> picked?
> 
> I've had great luck with NEC and ALI chips thus far.

giuseppe@sgi:~$ (lspci;lspci -n)| sort | grep ^01.08.02
01:08.2 0c03: 1033:00e0 (rev 04)
01:08.2 USB Controller: NEC Corporation USB 2.0 (rev 04)

> * Which driver was loaded for the USB controller, OHCI, UHCI, EHCI?

giuseppe@sgi:~$ lsusb
Bus 003 Device 001: ID 0000:0000  
Bus 002 Device 001: ID 0000:0000  
Bus 001 Device 003: ID 067b:2517 Prolific Technology, Inc. Flash Disk Mass Storage Device
Bus 001 Device 002: ID 067b:2515 Prolific Technology, Inc. Flash Disk Embedded Hub
Bus 001 Device 001: ID 0000:0000

giuseppe@sgi:~$ dmesg | grep 0000:01:08
PCI: Enabling device 0000:01:08.2 (0000 -> 0002)
ehci_hcd 0000:01:08.2: EHCI Host Controller
ehci_hcd 0000:01:08.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:01:08.2: irq 15, io mem 0x280003000
ehci_hcd 0000:01:08.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004

So, I think that PCI device 0000:01:08.2 is managed by ehci and its
assigned USB bus #001.

Bye,
Giuseppe
