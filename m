Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 May 2008 18:00:09 +0100 (BST)
Received: from smtp4.pp.htv.fi ([213.243.153.38]:470 "EHLO smtp4.pp.htv.fi")
	by ftp.linux-mips.org with ESMTP id S20046280AbYEDRAG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 4 May 2008 18:00:06 +0100
Received: from cs181133002.pp.htv.fi (cs181133002.pp.htv.fi [82.181.133.2])
	by smtp4.pp.htv.fi (Postfix) with ESMTP id 1B7865BC034;
	Sun,  4 May 2008 19:59:59 +0300 (EEST)
Date:	Sun, 4 May 2008 19:58:54 +0300
From:	Adrian Bunk <bunk@kernel.org>
To:	Roman Zippel <zippel@linux-m68k.org>, ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: [2.6 patch] mips/emma2rh/markeins/setup.c build fix
Message-ID: <20080504165850.GM5838@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Return-Path: <bunk@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19096
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bunk@kernel.org
Precedence: bulk
X-list: linux-mips

This patch fixes the following build errror caused by
commit 7dffa3c673fbcf835cd7be80bb4aec8ad3f51168
(ntp: handle leap second via timer):

<--  snip  -->

...
  CC      arch/mips/emma2rh/markeins/setup.o
/home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/emma2rh/markeins/setup.c:79: error: conflicting types for 'clock'
/home/bunk/linux/kernel-2.6/git/linux-2.6/include/linux/clocksource.h:96: error: previous declaration of 'clock' was here
make[2]: *** [arch/mips/emma2rh/markeins/setup.o] Error 1

<--  snip  -->

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

 arch/mips/emma2rh/markeins/setup.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

139244b9f3cd31793da682da14c67e38836bec36 diff --git a/arch/mips/emma2rh/markeins/setup.c b/arch/mips/emma2rh/markeins/setup.c
index 82f9e90..487cac5 100644
--- a/arch/mips/emma2rh/markeins/setup.c
+++ b/arch/mips/emma2rh/markeins/setup.c
@@ -76,7 +76,7 @@ static void markeins_machine_power_off(void)
 	while (1) ;
 }
 
-static unsigned long clock[4] = { 166500000, 187312500, 199800000, 210600000 };
+static unsigned long emma2rh_clock[4] = { 166500000, 187312500, 199800000, 210600000 };
 
 static unsigned int __init detect_bus_frequency(unsigned long rtc_base)
 {
@@ -85,7 +85,7 @@ static unsigned int __init detect_bus_frequency(unsigned long rtc_base)
 	/* detect from boot strap */
 	reg = emma2rh_in32(EMMA2RH_BHIF_STRAP_0);
 	reg = (reg >> 4) & 0x3;
-	return clock[reg];
+	return emma2rh_clock[reg];
 }
 
 void __init plat_time_init(void)
