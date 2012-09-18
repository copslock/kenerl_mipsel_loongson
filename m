Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Sep 2012 14:09:29 +0200 (CEST)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:42609 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903421Ab2IRMJV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Sep 2012 14:09:21 +0200
Received: by bkcji2 with SMTP id ji2so3178708bkc.36
        for <multiple recipients>; Tue, 18 Sep 2012 05:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=EceTQEuvVbbTpm/sLkVxFQtHLPfI5GLD7CtbRzW/7Qw=;
        b=dFN1r0JV5GUZ2a+E/P6fIbZGmXu29kIPZ9GRrooV1ts6LQ3t4d73709RO0PL439DhT
         KiWq392fKuwNC3IJOVTkFKwnZk7fPJOW3uI55Z0FyLJW4bfcPnt3LASJ7JdcJAm50dzV
         ao5rGOORyOWb3fDu6YuIzw+MRB2sfH/nj/mwkAQqu194F9tb1j21iF7cXbSbYwK28mf3
         1/EpanIGUdYOPTiyjKI7TWLKnXlcUub/qLkD0ysuVcrX4YUOCBf/HQCTU6fwTqAPOPlo
         VYgmIGgvocwLC3jDSe8CFohAkEhvtSlPZIFaT0BA95UieIyRIRPlPlY9KovlP8sIqqzw
         +ITA==
Received: by 10.204.152.75 with SMTP id f11mr5791218bkw.83.1347970156505;
        Tue, 18 Sep 2012 05:09:16 -0700 (PDT)
Received: from ixxyvirt.lan (p50811FD1.dip.t-dialin.net. [80.129.31.209])
        by mx.google.com with ESMTPS id t23sm7663426bks.4.2012.09.18.05.09.14
        (version=SSLv3 cipher=OTHER);
        Tue, 18 Sep 2012 05:09:15 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Sergei Shtylyov <sshtylyov@mvista.com>
Subject: [PATCH V2] MIPS: BCM63XX: properly handle mac address octet overflow
Date:   Tue, 18 Sep 2012 14:09:08 +0200
Message-Id: <1347970148-17804-1-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1347960728-5884-1-git-send-email-jonas.gorski@gmail.com>
References: <1347960728-5884-1-git-send-email-jonas.gorski@gmail.com>
X-archive-position: 34528
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Status: A

While calculating the mac address the pointer for the current octet was
never reset back to the least significant one after being decremented
because of an octet overflow. This resulted in the code continuing to
increment at the current octet, potentially generating duplicate or
invalid mac addresses.

As a second issue the pointer was allowed to advance up to the most
significant octet, modifying the OUI, and potentially changing the type
of mac address.

Rewrite the code so it resets the pointer to the least significant
in each outer loop step, and bails out when the least significant octet
of the OUI is reached.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---

V1 -> V2: add a missing variable declaration breaking the compilation.

 arch/mips/bcm63xx/boards/board_bcm963xx.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
index ea4ea77..442ba96 100644
--- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -720,7 +720,7 @@ const char *board_get_name(void)
  */
 static int board_get_mac_address(u8 *mac)
 {
-	u8 *p;
+	u8 *oui;
 	int count;
 
 	if (mac_addr_used >= nvram.mac_addr_count) {
@@ -729,21 +729,23 @@ static int board_get_mac_address(u8 *mac)
 	}
 
 	memcpy(mac, nvram.mac_addr_base, ETH_ALEN);
-	p = mac + ETH_ALEN - 1;
+	oui = mac + ETH_ALEN/2 - 1;
 	count = mac_addr_used;
 
 	while (count--) {
+		u8 *p = mac + ETH_ALEN - 1;
+
 		do {
 			(*p)++;
 			if (*p != 0)
 				break;
 			p--;
-		} while (p != mac);
-	}
+		} while (p != oui);
 
-	if (p == mac) {
-		printk(KERN_ERR PFX "unable to fetch mac address\n");
-		return -ENODEV;
+		if (p == oui) {
+			printk(KERN_ERR PFX "unable to fetch mac address\n");
+			return -ENODEV;
+		}
 	}
 
 	mac_addr_used++;
-- 
1.7.10.4
