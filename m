Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g766ljRw002020
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 5 Aug 2002 23:47:45 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g766ljXF002019
	for linux-mips-outgoing; Mon, 5 Aug 2002 23:47:45 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g766lXRw002010;
	Mon, 5 Aug 2002 23:47:33 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g766ktXb010116;
	Mon, 5 Aug 2002 23:46:55 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id XAA14711;
	Mon, 5 Aug 2002 23:46:57 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g766kvb25641;
	Tue, 6 Aug 2002 08:46:57 +0200 (MEST)
Message-ID: <3D4F70E0.5DCC7AD4@mips.com>
Date: Tue, 06 Aug 2002 08:46:56 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@oss.sgi.com
Subject: Re: [patch] 2.4: Revert interface removal
References: <Pine.GSO.3.96.1020805105624.18894C-100000@delta.ds2.pg.gda.pl> <20020805124154.B6365@dea.linux-mips.net> <3D4E5BFE.595DA175@mips.com> <3D4E6743.58776F67@mips.com> <3D4E77CD.A4E7B78B@mips.com> <20020805164729.A11853@dea.linux-mips.net>
Content-Type: multipart/mixed;
 boundary="------------90A4148FC0DD876EEAD2CD73"
X-Spam-Status: No, hits=-5.0 required=5.0 tests=UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------90A4148FC0DD876EEAD2CD73
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

Ralf Baechle wrote:

> On Mon, Aug 05, 2002 at 03:04:13PM +0200, Carsten Langgaard wrote:
>
> > Ok, I finally figured out what the problem is.
> > The attached patch fix the problems, please apply.
>
> Applied, along with the 64-bit and 2.5 bits your patch was missing.
>

I was waiting for you to fix the bus_to_baddr in the 64-bit, I can see
you have have done something about it now, but I'm afraid you didn't get
it quite right.
Here is a patch to fix the typos.

/Carsten





--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com



--------------90A4148FC0DD876EEAD2CD73
Content-Type: text/plain; charset=iso-8859-15;
 name="pci.h.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pci.h.patch"

Index: include/asm-mips64/pci.h
===================================================================
RCS file: /cvs/linux/include/asm-mips64/pci.h,v
retrieving revision 1.16.2.9
diff -u -r1.16.2.9 pci.h
--- include/asm-mips64/pci.h	2002/08/06 02:21:50	1.16.2.9
+++ include/asm-mips64/pci.h	2002/08/06 06:36:35
@@ -213,8 +213,8 @@
 			out_of_line_bug();
 
 		dma_cache_wback_inv((unsigned long)sg->address, sg->length);
-		sg->address = bus_to_baddr(hwdev->bus->number) |
-		              virt_to_bus(sg->address);
+		sg->address = bus_to_baddr(hwdev->bus->number,
+					   virt_to_bus(sg->address));
 	}
 
 	return nents;
@@ -251,7 +251,7 @@
 	if (direction == PCI_DMA_NONE)
 		out_of_line_bug();
 
-	dma_cache_wback_inv((unsigned long)__va(dma_handle - bus_to_baddr(hwdev->bus->number)), size);
+	dma_cache_wback_inv((unsigned long)__va(bus_to_baddr(hwdev->bus->number, dma_handle)), size);
 }
 
 /*

--------------90A4148FC0DD876EEAD2CD73--
