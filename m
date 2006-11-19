Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Nov 2006 15:01:03 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:28171 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S20038619AbWKSPAd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 19 Nov 2006 15:00:33 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 9516564D3F; Sun, 19 Nov 2006 15:00:21 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 5781F54E76; Sun, 19 Nov 2006 14:58:43 +0000 (GMT)
Date:	Sun, 19 Nov 2006 14:58:43 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Cc:	ths@networkno.de
Subject: Add -mfix7000 to CONFIG_SGI_IP22
Message-ID: <20061119145843.GA5387@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13219
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

What was the rationale to add that to CONFIG_SGI_IP22?  Shouldn't it
be added to CONFIG_SGI_IP32, i.e. O2?

From: Thiemo Seufer <ths@networkno.de>

Add -mfix7000 to CONFIG_SGI_IP22

Signed-off-by: Thiemo Seufer <ths@networkno.de>
Signed-off-by: Martin Michlmayr <tbm@cyrius.com>

--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -478,7 +478,7 @@ load-$(CONFIG_PNX8550_JBS)	+= 0xffffffff
 # address by 8kb.
 #
 core-$(CONFIG_SGI_IP22)		+= arch/mips/sgi-ip22/
-cflags-$(CONFIG_SGI_IP22)	+= -Iinclude/asm-mips/mach-ip22
+cflags-$(CONFIG_SGI_IP22)	+= -Iinclude/asm-mips/mach-ip22 -Wa,-mfix7000
 ifdef CONFIG_32BIT
 load-$(CONFIG_SGI_IP22)		+= 0xffffffff88002000
 endif

-- 
Martin Michlmayr
http://www.cyrius.com/
