Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Jan 2006 20:39:38 +0000 (GMT)
Received: from deliver-1.mx.triera.net ([213.161.0.31]:39556 "HELO
	deliver-1.mx.triera.net") by ftp.linux-mips.org with SMTP
	id S8133788AbWACUjU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 3 Jan 2006 20:39:20 +0000
Received: from localhost (in-3.mx.triera.net [213.161.0.27])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id 4C95FC002;
	Tue,  3 Jan 2006 21:41:35 +0100 (CET)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-3.mx.triera.net (Postfix) with SMTP id BC9C71BC08C;
	Tue,  3 Jan 2006 21:41:37 +0100 (CET)
Received: from orionlinux.starfleet.com (cmb58-52.dial-up.arnes.si [153.5.49.52])
	by smtp.triera.net (Postfix) with ESMTP id 2EA541A18B9;
	Tue,  3 Jan 2006 21:41:36 +0100 (CET)
Subject: Re: ALCHEMY:  AU1200 USB Host Controller (OHCI/EHCI)
From:	Matej Kupljen <matej.kupljen@ultra.si>
To:	Jordan Crouse <jordan.crouse@amd.com>
Cc:	linux-mips@linux-mips.org, linux-usb-devel@lists.sourceforge.net,
	matthias.lenk@amd.com
In-Reply-To: <20060103155447.GI15770@cosmic.amd.com>
References: <20051208210042.GB17458@cosmic.amd.com>
	 <1136298329.6765.22.camel@localhost.localdomain>
	 <20060103155447.GI15770@cosmic.amd.com>
Content-Type: text/plain
Organization: Ultra d.o.o.
Date:	Tue, 03 Jan 2006 22:45:22 +0100
Message-Id: <1136324722.12175.20.camel@orionlinux.starfleet.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Triera AV Service
Return-Path: <matej.kupljen@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9766
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matej.kupljen@ultra.si
Precedence: bulk
X-list: linux-mips

Hi

> > I tried you patch, and this is what I get on 2.6.16-rc5:

I meant, 2.5.15-rc5 of course, and NOT 2.6.15-rc5. Sorry.

> Well, thats a fun one.  I'm assuming you tried to boot with a device
> plugged in.  I'm a bit confused by the __reqest_region coming from
> usb_create_hcd - I quickly glanced at the function, and I don't see anything
> that would have called request_region / request_mem_region.  However,
> there *is* a request_mem_region call immediately after the usb_create_hcd
> call in usb_ehci_au1xxx_probe, and I wonder that might be the guilty party.

I set up my BDI and tried to debug this. This is what I can tell you,
and maybe you can then be able to help me:

I get past the request_mem_region and ioremap in ehci-au1xxx.c.
I get to line 144:
if ((retval = driver->reset (hcd)) < 0) {

now, driver->reset points to the 
(gdb) p driver->reset
$6 = (int (*)(struct usb_hcd *)) 0x803505d4 <ehci_init>

I step into the call and I get to ehci_init in
drivers/usb/host/ehci-hcd.c. 

If I continue, i get to the  ehci_mem_init in the
drivers/usb/host/ehci-mem.c

On line:
228  memset (ehci->pshadow, 0, ehci->periodic_size * sizeof (void *));

If I do next in gdb, I end up in include/asm-mips/io.h, line
425 BUILDIO_MEM(l, u32) 
(Well, I am lost here now)

Now if I disassemble at $pc:
(gdb) x/20i $pc
0x80350760 <ehci_init+396>:     lw      v1,0(s0)
0x80350764 <ehci_init+400>:     lw      a2,8(v1)
0x80350768 <ehci_init+404>:     andi    v0,a2,0x80
0x8035076c <ehci_init+408>:     beqz    v0,0x80350888 <ehci_init+692>
0x80350770 <ehci_init+412>:     srl     v0,a2,0x4
0x80350774 <ehci_init+416>:     li      v0,8
0x80350778 <ehci_init+420>:     sw      v0,40(s0)
0x8035077c <ehci_init+424>:     lw      v0,24(s0)
0x80350780 <ehci_init+428>:     lw      a1,16(s0)
0x80350784 <ehci_init+432>:     li      v1,-2
0x80350788 <ehci_init+436>:     and     v0,v0,v1
0x8035078c <ehci_init+440>:     li      v1,-1
0x80350790 <ehci_init+444>:     sw      v1,48(s0)
0x80350794 <ehci_init+448>:     sw      v0,24(s0)
0x80350798 <ehci_init+452>:     sw      zero,20(s0)
0x8035079c <ehci_init+456>:     sw      zero,72(a1)
0x803507a0 <ehci_init+460>:     lw      a0,16(s0)
0x803507a4 <ehci_init+464>:     li      v1,-32
0x803507a8 <ehci_init+468>:     li      a1,1
0x803507ac <ehci_init+472>:     lw      v0,68(a0)
(gdb) p $s0
$9 = 0x8053c0d0
(gdb) x/x $s0
0x8053c0d0:     0x00000000

So I guess, that the instruction at 0x80350764 is loading from location
0 and offset 8, which can be seen also in the original post:

[4294668.602000] CPU 0 Unable to handle kernel paging request at virtual
address 00000008, epc == 80350764, ra == 80350760

What is going on here?
Is this some stack corruption, because of all this strange jumps
over the source code (I know optimisation is turned on, but still).

I hope this can help someone, I still have a lot of learning
to do to figure this out.

BR,
Matej

-- 
Matej Kupljen <matej.kupljen@ultra.si>
Ultra d.o.o.
