Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Feb 2008 13:17:58 +0000 (GMT)
Received: from hall.aurel32.net ([88.191.38.19]:24968 "EHLO hall.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S28582197AbYBXNRp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 24 Feb 2008 13:17:45 +0000
Received: from ctse16.ulb.ac.be ([164.15.3.4] helo=volta.aurel32.net)
	by hall.aurel32.net with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <aurelien@aurel32.net>)
	id 1JTGjb-0001sg-MJ; Sun, 24 Feb 2008 14:17:40 +0100
Received: from aurel32 by volta.aurel32.net with local (Exim 4.69)
	(envelope-from <aurelien@aurel32.net>)
	id 1JTCa1-0001Ht-65; Sun, 24 Feb 2008 09:51:29 +0100
Date:	Sun, 24 Feb 2008 09:51:29 +0100
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: [PATCH] [MIPS] WGT634U: Add machine detection message
Message-ID: <20080224085129.GA4842@volta.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
X-Mailer: Mutt 1.5.17+20080114 (2008-01-14)
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18292
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

This adds a printk message when a WGT634U machine is detected.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 arch/mips/bcm47xx/wgt634u.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/mips/bcm47xx/wgt634u.c b/arch/mips/bcm47xx/wgt634u.c
index d1d90c9..f9e309a 100644
--- a/arch/mips/bcm47xx/wgt634u.c
+++ b/arch/mips/bcm47xx/wgt634u.c
@@ -112,6 +112,9 @@ static int __init wgt634u_init(void)
 	    ((et0mac[1] == 0x09 && et0mac[2] == 0x5b) ||
 	     (et0mac[1] == 0x0f && et0mac[2] == 0xb5))) {
 		struct ssb_mipscore *mcore = &ssb_bcm47xx.mipscore;
+
+		printk(KERN_INFO "WGT634U machine detected.\n");
+
 		wgt634u_flash_data.width = mcore->flash_buswidth;
 		wgt634u_flash_resource.start = mcore->flash_window;
 		wgt634u_flash_resource.end = mcore->flash_window
-- 
1.5.4.2

-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
