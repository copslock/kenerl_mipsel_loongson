Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Sep 2008 20:20:44 +0100 (BST)
Received: from hall.aurel32.net ([91.121.138.14]:37818 "EHLO hall.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S28658635AbYIXTUi (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 24 Sep 2008 20:20:38 +0100
Received: from volta.aurel32.net ([2002:52e8:2fb:1:21e:8cff:feb0:693b])
	by hall.aurel32.net with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <aurelien@aurel32.net>)
	id 1KiZuf-0003nk-Ob; Wed, 24 Sep 2008 21:20:37 +0200
Received: from aurel32 by volta.aurel32.net with local (Exim 4.69)
	(envelope-from <aurelien@aurel32.net>)
	id 1KiZue-000587-IZ; Wed, 24 Sep 2008 21:20:36 +0200
Date:	Wed, 24 Sep 2008 21:20:36 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: [PATCH 2/6] [MIPS] WGT634U: Add machine detection message
Message-ID: <20080924192036.GC18700@volta.aurel32.net>
References: <20080924191840.GA18700@volta.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20080924191840.GA18700@volta.aurel32.net>
X-Mailer: Mutt 1.5.18 (2008-05-17)
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20617
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
1.5.6.5

-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
