Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jan 2005 14:46:37 +0000 (GMT)
Received: from [IPv6:::ffff:80.122.96.210] ([IPv6:::ffff:80.122.96.210]:12963
	"EHLO fwswe.inso.tuwien.ac.at") by linux-mips.org with ESMTP
	id <S8225243AbVAJOqb>; Mon, 10 Jan 2005 14:46:31 +0000
Received: from shswe.inso.tuwien.ac.at ([128.130.59.33] ident=hvr)
	by fwswe.inso.tuwien.ac.at with esmtp (Exim 3.36 #1 (Debian))
	id 1Co0oJ-0006mU-00; Mon, 10 Jan 2005 15:46:23 +0100
Subject: Re: [PATCH] I/O helpers rework
From: Herbert Valerio Riedel <hvr@inso.tuwien.ac.at>
To: "Maciej W. Rozycki" <macro@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	"Maciej W. Rozycki" <macro@linux-mips.org>
In-Reply-To: <Pine.LNX.4.61.0501101249280.18023@perivale.mips.com>
References: <Pine.LNX.4.61.0412151936460.14855@perivale.mips.com>
	 <1105029224.4361.21.camel@xterm.intra>
	 <Pine.LNX.4.61.0501101249280.18023@perivale.mips.com>
Content-Type: text/plain
Date: Mon, 10 Jan 2005 15:46:20 +0100
Message-Id: <1105368380.21670.4.camel@shswe.inso.tuwien.ac.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Return-Path: <hvr@inso.tuwien.ac.at>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6864
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hvr@inso.tuwien.ac.at
Precedence: bulk
X-list: linux-mips

On Mon, 2005-01-10 at 13:05 +0000, Maciej W. Rozycki wrote:
> On Thu, 6 Jan 2005, Herbert Valerio Riedel wrote:
> 
> > jfyi, this change broke mtd and au1xxx-usb on big endian au1xxx systems,
> > as the _raw calls do suddenly byteswapping :-(
> > 
> > was this intended?
> 
>  It was.  Generic code elsewhere expects it and the MIPS implementation 
> used to be broken because of that.  Note these functions are intended for 
> PCI/EISA/ISA accesses only and these buses are little-endian by 
> definition.  More specifically __raw_ calls are mainly for PIO copying 
> to/from memory over these buses when you want to keep byte ordering the 
> same as it would be for a DMA transfer.

>  If you have a driver that handles a non-PCI/EISA/ISA device you may and 
> probably should use bus_ calls to get a non-swapped access.

so this means, the mtd subsystem should use them and that the patch
below is the way to fix it? (hoping it won't brake on other systems?)

Index: map.h
===================================================================
RCS file: /home/cvs/linux/include/linux/mtd/map.h,v
retrieving revision 1.12
diff -u -r1.12 map.h
--- map.h	25 Oct 2004 20:44:46 -0000	1.12
+++ map.h	10 Jan 2005 14:45:00 -0000
@@ -343,14 +343,14 @@
 	map_word r;
 
 	if (map_bankwidth_is_1(map))
-		r.x[0] = __raw_readb(map->virt + ofs);
+		r.x[0] = readb(map->virt + ofs);
 	else if (map_bankwidth_is_2(map))
-		r.x[0] = __raw_readw(map->virt + ofs);
+		r.x[0] = readw(map->virt + ofs);
 	else if (map_bankwidth_is_4(map))
-		r.x[0] = __raw_readl(map->virt + ofs);
+		r.x[0] = readl(map->virt + ofs);
 #if BITS_PER_LONG >= 64
 	else if (map_bankwidth_is_8(map))
-		r.x[0] = __raw_readq(map->virt + ofs);
+		r.x[0] = readq(map->virt + ofs);
 #endif
 	else if (map_bankwidth_is_large(map))
 		memcpy_fromio(r.x, map->virt+ofs, map->bankwidth);
@@ -361,14 +361,14 @@
 static inline void inline_map_write(struct map_info *map, const map_word datum, unsigned long ofs)
 {
 	if (map_bankwidth_is_1(map))
-		__raw_writeb(datum.x[0], map->virt + ofs);
+		writeb(datum.x[0], map->virt + ofs);
 	else if (map_bankwidth_is_2(map))
-		__raw_writew(datum.x[0], map->virt + ofs);
+		writew(datum.x[0], map->virt + ofs);
 	else if (map_bankwidth_is_4(map))
-		__raw_writel(datum.x[0], map->virt + ofs);
+		writel(datum.x[0], map->virt + ofs);
 #if BITS_PER_LONG >= 64
 	else if (map_bankwidth_is_8(map))
-		__raw_writeq(datum.x[0], map->virt + ofs);
+		writeq(datum.x[0], map->virt + ofs);
 #endif
 	else if (map_bankwidth_is_large(map))
 		memcpy_toio(map->virt+ofs, datum.x, map->bankwidth);


-- 
Herbert Valerio Riedel <hvr@inso.tuwien.ac.at>
