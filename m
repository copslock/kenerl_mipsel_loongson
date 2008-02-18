Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Feb 2008 10:03:14 +0000 (GMT)
Received: from hall.aurel32.net ([88.191.38.19]:12422 "EHLO hall.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S20027096AbYBRKDL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 18 Feb 2008 10:03:11 +0000
Received: from aurel32 by hall.aurel32.net with local (Exim 4.63)
	(envelope-from <aurelien@aurel32.net>)
	id 1JR2pt-0006BJ-El; Mon, 18 Feb 2008 11:02:57 +0100
Date:	Mon, 18 Feb 2008 11:02:57 +0100
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	Michael Buesch <mb@bu3sch.de>
Cc:	Adrian Bunk <bunk@kernel.org>,
	Larry Finger <Larry.Finger@lwfinger.net>,
	"John W. Linville" <linville@tuxdriver.com>, ralf@linux-mips.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [SSB] PCI core driver: use new SPROM data structure
Message-ID: <20080218100257.GB22519@hall.aurel32.net>
Mail-Followup-To: Aurelien Jarno <aurelien@aurel32.net>,
	Michael Buesch <mb@bu3sch.de>, Adrian Bunk <bunk@kernel.org>,
	Larry Finger <Larry.Finger@lwfinger.net>,
	"John W. Linville" <linville@tuxdriver.com>, ralf@linux-mips.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
References: <20080217200947.GH1403@cs181133002.pp.htv.fi> <20080218074944.GA9317@hall.aurel32.net> <20080218100126.GA22519@hall.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20080218100126.GA22519@hall.aurel32.net>
X-Mailer: Mutt 1.5.13 (2006-08-11)
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18246
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

Switch the SSB PCI core driver to the new SPROM data structure now that
the old one has been removed.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 drivers/ssb/driver_pcicore.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ssb/driver_pcicore.c b/drivers/ssb/driver_pcicore.c
index 2faaa90..191db7a 100644
--- a/drivers/ssb/driver_pcicore.c
+++ b/drivers/ssb/driver_pcicore.c
@@ -362,7 +362,7 @@ static int pcicore_is_in_hostmode(struct ssb_pcicore *pc)
 	    chipid_top != 0x5300)
 		return 0;
 
-	if (bus->sprom.r1.boardflags_lo & SSB_PCICORE_BFL_NOPCI)
+	if (bus->sprom.boardflags_lo & SSB_PCICORE_BFL_NOPCI)
 		return 0;
 
 	/* The 200-pin BCM4712 package does not bond out PCI. Even when
-- 
1.5.4.1

-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
