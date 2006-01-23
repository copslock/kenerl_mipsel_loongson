Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jan 2006 20:33:51 +0000 (GMT)
Received: from smtp.gentoo.org ([134.68.220.30]:26545 "EHLO smtp.gentoo.org")
	by ftp.linux-mips.org with ESMTP id S3457351AbWAWUde (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 23 Jan 2006 20:33:34 +0000
Received: from kumba by smtp.gentoo.org with local (Exim 4.54)
	id 1F18Rb-00033t-GN
	for linux-mips@linux-mips.org; Mon, 23 Jan 2006 20:37:43 +0000
Date:	Mon, 23 Jan 2006 20:37:43 +0000
From:	Kumba <kumba@gentoo.org>
To:	linux-mips@linux-mips.org
Subject: [PATCH]: IP22 HAL2 Kconfig tweaks/typo fix
Message-ID: <20060123203743.GD499@toucan.gentoo.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8nsIa27JVQLqB7/C"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10078
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips


--8nsIa27JVQLqB7/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In sound/oss/Kconfig, the description for the HAL2 sound driver lacks a reference to Indigo2 systems, which also have 
this sound board, and there's a minor anomaly in grammar.  Attached patch fixes both cases.


--Kumba


--
Gentoo/MIPS Team Lead
Gentoo Foundation Board of Trustees

"Such is oft the course of deeds that move the wheels of the world: small hands do them because they must, while the
eyes of the great are elsewhere." --Elrond


--8nsIa27JVQLqB7/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="misc-2.6.15-ip22-hal2-kconfig-tweaks.patch"

--- sound/oss/Kconfig.orig	2006-01-23 15:01:08.000000000 -0500
+++ sound/oss/Kconfig	2006-01-23 15:01:36.000000000 -0500
@@ -216,8 +216,8 @@ config SOUND_HAL2
 	tristate "SGI HAL2 sound (EXPERIMENTAL)"
 	depends on SOUND_PRIME && SGI_IP22 && EXPERIMENTAL
 	help
-	  Say Y or M if you have an SGI Indy system and want to be able to
-	  use it's on-board A2 audio system.
+	  Say Y or M if you have an SGI Indy or Indigo2 system and want to be able to
+	  use its on-board A2 audio system.
 
 config SOUND_IT8172
 	tristate "IT8172G Sound"

--8nsIa27JVQLqB7/C--
