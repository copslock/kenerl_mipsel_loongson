Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jan 2006 19:55:08 +0000 (GMT)
Received: from smtp.gentoo.org ([134.68.220.30]:53444 "EHLO smtp.gentoo.org")
	by ftp.linux-mips.org with ESMTP id S8133543AbWAXTyv (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 24 Jan 2006 19:54:51 +0000
Received: from kumba by smtp.gentoo.org with local (Exim 4.54)
	id 1F1UJm-0004Lo-07
	for linux-mips@linux-mips.org; Tue, 24 Jan 2006 19:59:06 +0000
Date:	Tue, 24 Jan 2006 19:59:05 +0000
From:	Kumba <kumba@gentoo.org>
To:	linux-mips@linux-mips.org
Subject: Re: [PATCH]: IP22 HAL2 Kconfig tweaks/typo fix
Message-ID: <20060124195905.GC24568@toucan.gentoo.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="1ccMZA6j1vT5UqiK"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10111
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips


--1ccMZA6j1vT5UqiK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Indigo2 systems also have a Hal2 sound system, so change
sound/oss/Kconfig's help text to reflect this, and also fix a minor
grammatical typo in the description.

Signed-off-by: Joshua Kinard <kumba@gentoo.org>
---

 sound/oss/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


--1ccMZA6j1vT5UqiK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="hal2-kconfig-tweaks.patch"

diff -Naurp mipslinux/sound/oss/Kconfig mipslinux-hal2/sound/oss/Kconfig
--- mipslinux/sound/oss/Kconfig	2006-01-22 21:14:37.000000000 -0500
+++ mipslinux-hal2/sound/oss/Kconfig	2006-01-24 13:40:21.000000000 -0500
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

--1ccMZA6j1vT5UqiK--
