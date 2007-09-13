Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Sep 2007 19:24:17 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:10940 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20022544AbXIMSYI (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 13 Sep 2007 19:24:08 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1IVtMF-00005V-00; Thu, 13 Sep 2007 20:24:07 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 04ABAC3367; Thu, 13 Sep 2007 20:23:49 +0200 (CEST)
Date:	Thu, 13 Sep 2007 20:23:48 +0200
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Kumba <kumba@gentoo.org>, linux-mips@linux-mips.org
Subject: Re: IP22 64bit kernel
Message-ID: <20070913182348.GA11473@alpha.franken.de>
References: <20070911213048.GA20579@alpha.franken.de> <46E8E134.8000004@gentoo.org> <20070913155059.GA8790@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070913155059.GA8790@linux-mips.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16509
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Thu, Sep 13, 2007 at 04:50:59PM +0100, Ralf Baechle wrote:
> The problem isn't limited to ARC firmware; basically any non-R8000 64-bit
> system can be affected.  A kernel may be using either addresses in XKPHYS
> or in CKSEG0 and the segment for which the kernel is linked is not
> necessarily the same that the firmware will load it to.

here is a patch:

Always jump to the place where the kernel is linked to. This helps
where the bootloaders/proms ignores the start address inside the ELF
header.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
index e46782b..80d0ab9 100644
--- a/arch/mips/kernel/head.S
+++ b/arch/mips/kernel/head.S
@@ -27,16 +27,6 @@
 
 #include <kernel-entry-init.h>
 
-	.macro	ARC64_TWIDDLE_PC
-#if defined(CONFIG_ARC64) || defined(CONFIG_MAPPED_KERNEL)
-	/* We get launched at a XKPHYS address but the kernel is linked to
-	   run at a KSEG0 address, so jump there.  */
-	PTR_LA	t0, \@f
-	jr	t0
-\@:
-#endif
-	.endm
-
 	/*
 	 * inputs are the text nasid in t1, data nasid in t2.
 	 */
@@ -155,7 +145,11 @@ NESTED(kernel_entry, 16, sp)			# kernel entry point
 
 	setup_c0_status_pri
 
-	ARC64_TWIDDLE_PC
+	/* We might not get launched at the address the kernel is linked to,
+	   so we jump there.  */
+	PTR_LA	t0, 0f
+	jr	t0
+0:
 
 #ifdef CONFIG_MIPS_MT_SMTC
 	/*

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
