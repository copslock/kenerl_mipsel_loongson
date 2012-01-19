Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jan 2012 22:08:42 +0100 (CET)
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49310 "EHLO
        mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903682Ab2ASVIj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Jan 2012 22:08:39 +0100
Received: from 117.235.221.87.dynamic.jazztel.es ([87.221.235.117] helo=mail.viric.name)
        by mho-02-ewr.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.72)
        (envelope-from <viric@viric.name>)
        id 1RnzDl-0004ns-Gm
        for linux-mips@linux-mips.org; Thu, 19 Jan 2012 21:08:33 +0000
Received: by mail.viric.name (Postfix, from userid 1000)
        id 402F0501577; Thu, 19 Jan 2012 22:08:29 +0100 (CET)
X-Mail-Handler: MailHop Outbound by DynDNS
X-Originating-IP: 87.221.235.117
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/mailhop/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX19fVaDWXVA3AANlm1Plne6X
Date:   Thu, 19 Jan 2012 22:08:29 +0100
From:   =?iso-8859-1?Q?Llu=EDs?= Batlle i Rossell <viric@viric.name>
To:     linux-mips@linux-mips.org
Subject: MIPS: [PATCH] Fix on Kconfig warning, building for Fuloong2f
Message-ID: <20120119210829.GS21947@vicerveza.homeunix.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3MHXEHrrXKLGx71o"
Content-Disposition: inline
X-Accept-Language: ca, es, eo, ru, en, jbo, tokipona
User-Agent: Mutt/1.5.20 (2009-06-14)
Content-Transfer-Encoding: 7bit
X-archive-position: 32292
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: viric@viric.name
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>


--3MHXEHrrXKLGx71o
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I resubmit the patch I sent some minutes ago, now following better
Documentation/SubmittingPatches.

Regards,
Llu=EDs.

--3MHXEHrrXKLGx71o
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="0001-Remove-a-warning-I-saw-on-make-nconfig-for-the-Fuloo.patch"
Content-Transfer-Encoding: quoted-printable

>From 533a82b8ffec030d316e22d01a16211c0a3c645d Mon Sep 17 00:00:00 2001
From: =3D?UTF-8?q?Llu=3DC3=3DADs=3D20Batlle=3D20i=3D20Rossell?=3D <viric@=
viric.name>
Date: Thu, 19 Jan 2012 21:35:44 +0100
Subject: [PATCH] Remove a warning I saw on 'make nconfig' for the Fuloong=
2F.
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

The warning was:
warning: (LEMOTE_FULOONG2E && LEMOTE_MACH2F && DEXXON_GDIUM) selects
ARCH_SPARSEMEM_ENABLE which has unmet direct dependencies
(CPU_CAVIUM_OCTEON)

I followed advices from daney on irc.

I don't know how to test it, but now I don't see the warning at least.

Signed-off-by: Llu=EDs Batlle i Rossell <viric@viric.name>
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
diff --git a/arch/mips/cavium-octeon/Kconfig b/arch/mips/cavium-octeon/Kc=
onfig
index cad555e..15ba565 100644
--- a/arch/mips/cavium-octeon/Kconfig
+++ b/arch/mips/cavium-octeon/Kconfig
@@ -82,10 +82,6 @@ config CAVIUM_OCTEON_LOCK_L2_MEMCPY
 	help
 	  Lock the kernel's implementation of memcpy() into L2.
=20
-config ARCH_SPARSEMEM_ENABLE
-	def_bool y
-	select SPARSEMEM_STATIC
-
 config CAVIUM_OCTEON_HELPER
 	def_bool y
 	depends on OCTEON_ETHERNET || PCI
--=20
1.7.8


--3MHXEHrrXKLGx71o--
