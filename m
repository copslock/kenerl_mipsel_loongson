Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Feb 2005 00:40:43 +0000 (GMT)
Received: from p3EE07C05.dip.t-dialin.net ([IPv6:::ffff:62.224.124.5]:52346
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224987AbVBDAk3>; Fri, 4 Feb 2005 00:40:29 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j140eSEP024065;
	Fri, 4 Feb 2005 01:40:28 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id j140eSA6024064;
	Fri, 4 Feb 2005 01:40:28 +0100
Date:	Fri, 4 Feb 2005 01:40:28 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Rojhalat Ibrahim <ibrahim@schenk.isar.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: More than 512MB of memory
Message-ID: <20050204004028.GC22311@linux-mips.org>
References: <41ED20E3.60309@schenk.isar.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41ED20E3.60309@schenk.isar.de>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7143
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 18, 2005 at 03:44:51PM +0100, Rojhalat Ibrahim wrote:

> is there anything special I have to do
> when I want to use more than 512MB of memory?
> My Yosemite board works fine with 512MB
> but when I try 1GB it crashes in 32bit mode
> with highmem and also in 64bit mode.
> The boot monitor (PMON) maps the 1024MB
> to physical addresses 0x0000.0000 - 0x4000.0000.

Can you try below patch?

  Ralf

--- linux/arch/mips/mm/c-r4k.c	2004-12-07 02:30:50.000000000 +0000
+++ linux/arch/mips/mm/c-r4k.c	2005-02-04 00:31:34.623814760 +0000
@@ -566,7 +566,10 @@
 
 	if (!cpu_has_ic_fills_f_dc) {
 		unsigned long addr = (unsigned long) page_address(page);
-		r4k_blast_dcache_page(addr);
+		if (addr)
+			r4k_blast_dcache_page(addr);
+		else
+			r4k_blast_dcache();
 		if (!cpu_icache_snoops_remote_store)
 			r4k_blast_scache_page(addr);
 		ClearPageDcacheDirty(page);
