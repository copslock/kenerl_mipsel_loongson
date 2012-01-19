Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jan 2012 21:40:26 +0100 (CET)
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:62725 "EHLO
        mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903680Ab2ASUkW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Jan 2012 21:40:22 +0100
Received: from 117.235.221.87.dynamic.jazztel.es ([87.221.235.117] helo=mail.viric.name)
        by mho-02-ewr.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.72)
        (envelope-from <viric@viric.name>)
        id 1RnymO-000FoO-22
        for linux-mips@linux-mips.org; Thu, 19 Jan 2012 20:40:16 +0000
Received: by mail.viric.name (Postfix, from userid 1000)
        id F02EE501572; Thu, 19 Jan 2012 21:40:10 +0100 (CET)
X-Mail-Handler: MailHop Outbound by DynDNS
X-Originating-IP: 87.221.235.117
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/mailhop/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1+qPrO3l8/LjBQxUb3410Kh
Date:   Thu, 19 Jan 2012 21:40:10 +0100
From:   =?iso-8859-1?Q?Llu=EDs?= Batlle i Rossell <viric@viric.name>
To:     linux-mips@linux-mips.org
Subject: Remove a Kconfig warning on 3.2.1 for fuloong2f
Message-ID: <20120119204010.GR21947@vicerveza.homeunix.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="HSQ3hISbU3Um6hch"
Content-Disposition: inline
X-Accept-Language: ca, es, eo, ru, en, jbo, tokipona
User-Agent: Mutt/1.5.20 (2009-06-14)
Content-Transfer-Encoding: 7bit
X-archive-position: 32291
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: viric@viric.name
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>


--HSQ3hISbU3Um6hch
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

building the kernel 3.2.1 for the fuloong2f I hit a warning at every 'mak=
e
nconfig'.

Here is a patch that takes out the warning, but someone that understands =
better
than me should check I did not break anything.

Regards,
Llu=EDs.

--HSQ3hISbU3Um6hch
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-Remove-a-warning-I-saw-on-make-nconfig-for-the-Fuloo.patch"

>From 4dd3da2b4290b5e790e07d24d2e6daa7cb989ee3 Mon Sep 17 00:00:00 2001
From: Lluis Batlle <viric@vicerveza.homeunix.net>
Date: Thu, 19 Jan 2012 21:35:44 +0100
Subject: [PATCH] Remove a warning I saw on 'make nconfig' for the Fuloong2F.

The warning was:
warning: (LEMOTE_FULOONG2E && LEMOTE_MACH2F && DEXXON_GDIUM) selects
ARCH_SPARSEMEM_ENABLE which has unmet direct dependencies
(CPU_CAVIUM_OCTEON)

I followed advices from daney on irc.

I don't know how to test it, but now I don't see the warning at least.
---
 arch/mips/Kconfig               |    1 +
 arch/mips/cavium-octeon/Kconfig |    4 ----
 2 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index d46f1da..330800d 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1404,6 +1404,7 @@ config CPU_CAVIUM_OCTEON
 	select WEAK_ORDERING
 	select CPU_SUPPORTS_HIGHMEM
 	select CPU_SUPPORTS_HUGEPAGES
+	select ARCH_SPARSEMEM_ENABLE
 	help
 	  The Cavium Octeon processor is a highly integrated chip containing
 	  many ethernet hardware widgets for networking tasks. The processor
diff --git a/arch/mips/cavium-octeon/Kconfig b/arch/mips/cavium-octeon/Kconfig
index cad555e..15ba565 100644
--- a/arch/mips/cavium-octeon/Kconfig
+++ b/arch/mips/cavium-octeon/Kconfig
@@ -82,10 +82,6 @@ config CAVIUM_OCTEON_LOCK_L2_MEMCPY
 	help
 	  Lock the kernel's implementation of memcpy() into L2.
 
-config ARCH_SPARSEMEM_ENABLE
-	def_bool y
-	select SPARSEMEM_STATIC
-
 config CAVIUM_OCTEON_HELPER
 	def_bool y
 	depends on OCTEON_ETHERNET || PCI
-- 
1.7.8


--HSQ3hISbU3Um6hch--
