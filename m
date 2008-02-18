Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Feb 2008 10:04:48 +0000 (GMT)
Received: from hall.aurel32.net ([88.191.38.19]:40917 "EHLO hall.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S20027052AbYBRKEp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 18 Feb 2008 10:04:45 +0000
Received: from aurel32 by hall.aurel32.net with local (Exim 4.63)
	(envelope-from <aurelien@aurel32.net>)
	id 1JR2rP-0006Bw-6v; Mon, 18 Feb 2008 11:04:31 +0100
Date:	Mon, 18 Feb 2008 11:04:31 +0100
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Adrian Bunk <bunk@kernel.org>,
	Larry Finger <Larry.Finger@lwfinger.net>,
	"John W. Linville" <linville@tuxdriver.com>,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [MIPS] BCM47XX: use new SSB SPROM data structure
Message-ID: <20080218100431.GC22519@hall.aurel32.net>
Mail-Followup-To: Aurelien Jarno <aurelien@aurel32.net>,
	Ralf Baechle <ralf@linux-mips.org>, Adrian Bunk <bunk@kernel.org>,
	Larry Finger <Larry.Finger@lwfinger.net>,
	"John W. Linville" <linville@tuxdriver.com>,
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
X-archive-position: 18247
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

Switch the BCM47XX code to the new SPROM data structure now that
the old one has been removed.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 arch/mips/bcm47xx/setup.c   |   12 ++++++------
 arch/mips/bcm47xx/wgt634u.c |    2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
index 1b6b0fa..8d36f18 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -92,17 +92,17 @@ static int bcm47xx_get_invariants(struct ssb_bus *bus,
 	iv->sprom.revision = 3;
 
 	if (cfe_getenv("et0macaddr", buf, sizeof(buf)) >= 0)
-		str2eaddr(buf, iv->sprom.r1.et0mac);
+		str2eaddr(buf, iv->sprom.et0mac);
 	if (cfe_getenv("et1macaddr", buf, sizeof(buf)) >= 0)
-		str2eaddr(buf, iv->sprom.r1.et1mac);
+		str2eaddr(buf, iv->sprom.et1mac);
 	if (cfe_getenv("et0phyaddr", buf, sizeof(buf)) >= 0)
-		iv->sprom.r1.et0phyaddr = simple_strtoul(buf, NULL, 10);
+		iv->sprom.et0phyaddr = simple_strtoul(buf, NULL, 10);
 	if (cfe_getenv("et1phyaddr", buf, sizeof(buf)) >= 0)
-		iv->sprom.r1.et1phyaddr = simple_strtoul(buf, NULL, 10);
+		iv->sprom.et1phyaddr = simple_strtoul(buf, NULL, 10);
 	if (cfe_getenv("et0mdcport", buf, sizeof(buf)) >= 0)
-		iv->sprom.r1.et0mdcport = simple_strtoul(buf, NULL, 10);
+		iv->sprom.et0mdcport = simple_strtoul(buf, NULL, 10);
 	if (cfe_getenv("et1mdcport", buf, sizeof(buf)) >= 0)
-		iv->sprom.r1.et1mdcport = simple_strtoul(buf, NULL, 10);
+		iv->sprom.et1mdcport = simple_strtoul(buf, NULL, 10);
 
 	return 0;
 }
diff --git a/arch/mips/bcm47xx/wgt634u.c b/arch/mips/bcm47xx/wgt634u.c
index 5a017ea..f21a206 100644
--- a/arch/mips/bcm47xx/wgt634u.c
+++ b/arch/mips/bcm47xx/wgt634u.c
@@ -50,7 +50,7 @@ static int __init wgt634u_init(void)
 	 * been allocated ranges 00:09:5b:xx:xx:xx and 00:0f:b5:xx:xx:xx.
 	 */
 
-	u8 *et0mac = ssb_bcm47xx.sprom.r1.et0mac;
+	u8 *et0mac = ssb_bcm47xx.sprom.et0mac;
 
 	if (et0mac[0] == 0x00 &&
 	    ((et0mac[1] == 0x09 && et0mac[2] == 0x5b) ||
-- 
1.5.4.1


-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
