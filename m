Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 May 2015 11:55:43 +0200 (CEST)
Received: from mail-wi0-f172.google.com ([209.85.212.172]:35458 "EHLO
        mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012350AbbELJzkT1bDb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 May 2015 11:55:40 +0200
Received: by widdi4 with SMTP id di4so144841138wid.0;
        Tue, 12 May 2015 02:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=Ww85vHCXwlPyQIUxqR5x941nsQYzt6AVIHqrI3z6v54=;
        b=ZNnjes9cUnAvuTb+K2CayL+3HqyKIq4TWppxYCsZudlg3gImEkBYbrnS1UajzxxVsS
         csZ6m1isA75fTf1DZcd59l/2JNPLPEHu0sVijCyCZyz+YRXLyG55rCUpZyzWy0Qrjr3K
         8VXSIouiZDi5bvzs9jXlAsuB045PqFhgTv659p5nCeF1UcetlUDtCQK4O+QLXaatpX7k
         n052yjR0hmjU6PeQET+7nvA6weEVs/f+WpUhYvTAKT0UffhM1gaPWBeDaT+ibzJx41zp
         1eJmbIp9McM4EIEnBPmp1TF9XwFMpEk48ExGjVJ7LJOXagku6nDEWAfbqLYjP3QX1yJy
         Grpw==
X-Received: by 10.180.99.166 with SMTP id er6mr2988057wib.58.1431424537346;
        Tue, 12 May 2015 02:55:37 -0700 (PDT)
Received: from linux-tdhb.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id 14sm26910970wjv.0.2015.05.12.02.55.35
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2015 02:55:36 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        Hante Meuleman <meuleman@broadcom.com>,
        Ian Kent <raven@themaw.net>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH] MIPS: BCM47XX: Extract info about et2 interface
Date:   Tue, 12 May 2015 11:54:48 +0200
Message-Id: <1431424488-11394-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47340
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

New devices may have more than 1 Ethernet core (device). We should
extract info about them to make it available to Ethernet drivers.

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
 arch/mips/bcm47xx/sprom.c | 6 ++++++
 include/linux/ssb/ssb.h   | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/arch/mips/bcm47xx/sprom.c b/arch/mips/bcm47xx/sprom.c
index 4048083..92a6c9d 100644
--- a/arch/mips/bcm47xx/sprom.c
+++ b/arch/mips/bcm47xx/sprom.c
@@ -531,6 +531,8 @@ static int mac_addr_used = 2;
 static void bcm47xx_fill_sprom_ethernet(struct ssb_sprom *sprom,
 					const char *prefix, bool fallback)
 {
+	bool fb = fallback;
+
 	nvram_read_macaddr(prefix, "et0macaddr", sprom->et0mac, fallback);
 	nvram_read_u8(prefix, NULL, "et0mdcport", &sprom->et0mdcport, 0,
 		      fallback);
@@ -543,6 +545,10 @@ static void bcm47xx_fill_sprom_ethernet(struct ssb_sprom *sprom,
 	nvram_read_u8(prefix, NULL, "et1phyaddr", &sprom->et1phyaddr, 0,
 		      fallback);
 
+	nvram_read_macaddr(prefix, "et2macaddr", sprom->et2mac, fb);
+	nvram_read_u8(prefix, NULL, "et2mdcport", &sprom->et2mdcport, 0, fb);
+	nvram_read_u8(prefix, NULL, "et2phyaddr", &sprom->et2phyaddr, 0, fb);
+
 	nvram_read_macaddr(prefix, "macaddr", sprom->il0mac, fallback);
 	nvram_read_macaddr(prefix, "il0macaddr", sprom->il0mac, fallback);
 
diff --git a/include/linux/ssb/ssb.h b/include/linux/ssb/ssb.h
index ee90e32..c3d1a52 100644
--- a/include/linux/ssb/ssb.h
+++ b/include/linux/ssb/ssb.h
@@ -29,10 +29,13 @@ struct ssb_sprom {
 	u8 il0mac[6] __aligned(sizeof(u16));	/* MAC address for 802.11b/g */
 	u8 et0mac[6] __aligned(sizeof(u16));	/* MAC address for Ethernet */
 	u8 et1mac[6] __aligned(sizeof(u16));	/* MAC address for 802.11a */
+	u8 et2mac[6] __aligned(sizeof(u16));	/* MAC address for extra Ethernet */
 	u8 et0phyaddr;		/* MII address for enet0 */
 	u8 et1phyaddr;		/* MII address for enet1 */
+	u8 et2phyaddr;		/* MII address for enet2 */
 	u8 et0mdcport;		/* MDIO for enet0 */
 	u8 et1mdcport;		/* MDIO for enet1 */
+	u8 et2mdcport;		/* MDIO for enet2 */
 	u16 dev_id;		/* Device ID overriding e.g. PCI ID */
 	u16 board_rev;		/* Board revision number from SPROM. */
 	u16 board_num;		/* Board number from SPROM. */
-- 
1.8.4.5
