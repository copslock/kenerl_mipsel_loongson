Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2006 16:13:02 +0000 (GMT)
Received: from mms2.broadcom.com ([216.31.210.18]:41486 "EHLO
	mms2.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S8133603AbWCNQMw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 14 Mar 2006 16:12:52 +0000
Received: from 10.10.64.154 by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.0)); Tue, 14 Mar 2006 08:22:14 -0800
X-Server-Uuid: D9EB6F12-1469-4C1C-87A2-5E4C0D6F9D06
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 060752AF; Tue, 14 Mar 2006 08:21:37 -0800 (PST)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id CCE702AE; Tue, 14 Mar
 2006 08:21:36 -0800 (PST)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.3a-GA) with ESMTP
 id DCE14643; Tue, 14 Mar 2006 08:21:35 -0800 (PST)
Received: from NT-SJCA-0750.brcm.ad.broadcom.com (nt-sjca-0750
 [10.16.192.220]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 C647F20501; Tue, 14 Mar 2006 08:21:35 -0800 (PST)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: BCM91x80A/B PCI DMA problems
Date:	Tue, 14 Mar 2006 08:21:19 -0800
Message-ID: <7E000E7F06B05C49BDBB769ADAF44D0786817B@NT-SJCA-0750.brcm.ad.broadcom.com>
Thread-Topic: BCM91x80A/B PCI DMA problems
Thread-Index: AcZHGEfBUPgLV56pRn26zZYm9SsU3wAaaGjA
From:	"Mark E Mason" <mark.e.mason@broadcom.com>
To:	"Martin Michlmayr" <tbm@cyrius.com>
cc:	linux-mips@linux-mips.org
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006031405; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413039303230392E34343136454433462E303042372D412D;
 ENG=IBF; TS=20060314162219; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006031405_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 6808323C4KO3816937-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-Path: <mark.e.mason@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10810
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mark.e.mason@broadcom.com
Precedence: bulk
X-list: linux-mips

Hello, 

[snip]
> Finding 1: while it fails with > 1 GB RAM, using 512 MB or 1 GB works.
> 
> Finding 2: with > 1 GB RAM, we're getting addresses over 4 GB in
> sg->dma_address.  We put some printks into arch/mips/mm/dma-coherent.c
> and while everything looks okay with 1 GB of RAM, with 2 GB I get e.g.
>     map page a8000000063f36c0 to addr 000000017fc68000
> 
> That's an address > 4G.  Lennert thinks that it's "most 
> likely going to stuff it into a 32bit address register 
> somewhere" and: "I can't see how it can work at all if it 
> passes the >32bit pci address to the device.  it should 
> detect, hey, this is above 4G, so then allocate a buffer 
> below 4G, copy it into there, and pass _that_ buffer to the 
> device.  that's called dma bounce buffering."

Well, PCI supports both 64 and 32-bit addresses.  There's a lot of PCI
HW out there that's 32-bit only, but there's also a fair bit that isn't.
A 32-bit device in a 64-bit system is going to require bounce buffering
by the driver/OS.  But, a 64-bit device won't (given a reasonable PCI
controller implementation, which we have here).

> Finding 3: the memory layout is weird.
> memory: 000000000fe91e00 @ 0000000000000000 (usable)
> memory: 000000001ffffe00 @ 0000000080000000 (usable)
> memory: 000000000ffffe00 @ 00000000c0000000 (usable)
> memory: 000000003ffffe00 @ 0000000140000000 (usable)
> 
> Lennert, "if the pci controller doesn't compensate for such a 
> weird layout, you're bound to see pci issues."

The PCI controller is built into the 1250/1480, and compensates for
this.


> Finding 4: the host bridge has some "unassigned" memory.  Why?
> 
> 0001:00:04.0 Host bridge: Broadcom Corporation: Unknown 
> device 0014 (rev 01)
>          Flags: bus master, fast devsel, latency 0, IRQ 255
>          Memory at 60000000 (32-bit, prefetchable) [size=16M]
>          Memory at <unassigned> (32-bit, prefetchable)
>          Memory at 70000000 (32-bit, prefetchable) [size=4K]
>          Memory at <unassigned> (64-bit, prefetchable)

Chuckle, I have *no* idea what this corresponds to.

> 
> Does this information help?  Also, we were wondering how to 
> find out whether a driver is okay with 64-bit dma addresses.

This last part is the part I don't know about.  While I've spent the
last 12 years doing this sort of OS/driver programming, it wasn't under
Linux and I'm still coming up to speed on the way things are handled
there.

IIRC most of the testing of the PCI code on the 1480 was done with a
Broadcom PCI-X GigE ethernet card which does support 64-bit addresses,
so the bounce buffering simply wouldn't have been an issue.  I wouldn't
be surprised if there are a number of 32-bit drivers out there that
simply assume that they're always going to be in a 32-bit system.

Unfortunately, the engineer who developed and tested this has since
left, so I don't have a lot of details about what exactly was tested and
what wasn't.

HTH,
Mark
