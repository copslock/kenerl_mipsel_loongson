Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Jun 2006 07:18:41 +0100 (BST)
Received: from sccrmhc11.comcast.net ([63.240.77.81]:37004 "EHLO
	sccrmhc11.comcast.net") by ftp.linux-mips.org with ESMTP
	id S8134175AbWFRGRI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 18 Jun 2006 07:17:08 +0100
Received: from [127.0.0.1] (unknown[69.140.185.142])
          by comcast.net (sccrmhc11) with ESMTP
          id <2006061806170701100ep67le>; Sun, 18 Jun 2006 06:17:07 +0000
Message-ID: <4494EFE4.70708@gentoo.org>
Date:	Sun, 18 Jun 2006 02:17:08 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To:	Linux MIPS List <linux-mips@linux-mips.org>
CC:	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH]: Correct HAL2 Kconfig description
Content-Type: multipart/mixed;
 boundary="------------070300050205050406080502"
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11759
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------070300050205050406080502
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


The current HAL2 Kconfig description indicates it is only used on SGI Indy 
systems, however all members of the Indigo2 Family have this sound card as well. 
  Plus a minor grammatical fix is included.

--Kumba


Signed-off-by: Joshua Kinard <kumba@gentoo.org>

  Kconfig |    4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)


--------------070300050205050406080502
Content-Type: text/plain;
 name="indigo2-has-hal2-too.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="indigo2-has-hal2-too.patch"

diff -Naurp linux-2.6.17.mips.orig/sound/oss/Kconfig linux-2.6.17.mips.p3/sound/oss/Kconfig
--- linux-2.6.17.mips.orig/sound/oss/Kconfig	2006-06-17 00:45:21.000000000 -0400
+++ linux-2.6.17.mips.p3/sound/oss/Kconfig	2006-06-17 00:54:50.000000000 -0400
@@ -98,8 +98,8 @@ config SOUND_HAL2
 	tristate "SGI HAL2 sound (EXPERIMENTAL)"
 	depends on SOUND_PRIME && SGI_IP22 && EXPERIMENTAL
 	help
-	  Say Y or M if you have an SGI Indy system and want to be able to
-	  use it's on-board A2 audio system.
+	  Say Y or M if you have an SGI Indy or Indigo2 system and want to be able to
+	  use its on-board A2 audio system.
 
 config SOUND_IT8172
 	tristate "IT8172G Sound"

--------------070300050205050406080502--
