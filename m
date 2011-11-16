Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Nov 2011 16:42:51 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:33058 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903835Ab1KPPml (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Nov 2011 16:42:41 +0100
Received: by faar25 with SMTP id r25so2091183faa.36
        for <multiple recipients>; Wed, 16 Nov 2011 07:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=baT61w8eQ10fwiSd6qsAamv3/xpvu/x6eHEwywSzcI8=;
        b=FgNcNP+nkrTZrQLELZVEc8c6wXpQlsd3USFcS8Pj25CzzV4JFmP6Gtg0MErnG8KoIu
         4HRB75XkTdyteRWZHwMFW+zEXBp3VgdJ0GO7nDubbzPKXfqvgjgVeYi/LihbZ8mZVz70
         SODDVBvHqmsr7h4H7tdwgkgsBNa0CZltcVr44=
Received: by 10.152.134.77 with SMTP id pi13mr20880924lab.21.1321458156546;
        Wed, 16 Nov 2011 07:42:36 -0800 (PST)
Received: from flagship.roarinelk.net (188-22-3-28.adsl.highway.telekom.at. [188.22.3.28])
        by mx.google.com with ESMTPS id pi7sm17044221lab.5.2011.11.16.07.42.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Nov 2011 07:42:35 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 1/3] MIPS: Alchemy: db1200: improve PB1200 detection.
Date:   Wed, 16 Nov 2011 16:42:26 +0100
Message-Id: <1321458148-7894-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.8.rc1
X-archive-position: 31674
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13527

The PB1200 has the CPLD located at an address which on the DB1200 is
RAM;  reading the Board-ID sometimes results in a PB1200 being detected
instead (especially during reboots after long uptimes).
On the other hand, the address of the DB1200's CPLD is hosting Flash
chips on the PB1200.  Test for the DB1200 first and additionally do a
quick write-test to the hexleds register to make sure we're writing
to the CPLD.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
Applies on top of the other patches queued for 3.3

 arch/mips/alchemy/devboards/db1200.c |   30 ++++++++++++++++++++++--------
 1 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/arch/mips/alchemy/devboards/db1200.c b/arch/mips/alchemy/devboards/db1200.c
index 1181241..6721991 100644
--- a/arch/mips/alchemy/devboards/db1200.c
+++ b/arch/mips/alchemy/devboards/db1200.c
@@ -66,19 +66,33 @@ static int __init detect_board(void)
 {
 	int bid;
 
-	/* try the PB1200 first */
+	/* try the DB1200 first */
+	bcsr_init(DB1200_BCSR_PHYS_ADDR,
+		  DB1200_BCSR_PHYS_ADDR + DB1200_BCSR_HEXLED_OFS);
+	if (BCSR_WHOAMI_DB1200 == BCSR_WHOAMI_BOARD(bcsr_read(BCSR_WHOAMI))) {
+		unsigned short t = bcsr_read(BCSR_HEXLEDS);
+		bcsr_write(BCSR_HEXLEDS, ~t);
+		if (bcsr_read(BCSR_HEXLEDS) != t) {
+			bcsr_write(BCSR_HEXLEDS, t);
+			return 0;
+		}
+	}
+
+	/* okay, try the PB1200 then */
 	bcsr_init(PB1200_BCSR_PHYS_ADDR,
 		  PB1200_BCSR_PHYS_ADDR + PB1200_BCSR_HEXLED_OFS);
 	bid = BCSR_WHOAMI_BOARD(bcsr_read(BCSR_WHOAMI));
 	if ((bid == BCSR_WHOAMI_PB1200_DDR1) ||
-	    (bid == BCSR_WHOAMI_PB1200_DDR2))
-		return 0;
+	    (bid == BCSR_WHOAMI_PB1200_DDR2)) {
+		unsigned short t = bcsr_read(BCSR_HEXLEDS);
+		bcsr_write(BCSR_HEXLEDS, ~t);
+		if (bcsr_read(BCSR_HEXLEDS) != t) {
+			bcsr_write(BCSR_HEXLEDS, t);
+			return 0;
+		}
+	}
 
-	/* okay, try the DB1200 then */
-	bcsr_init(DB1200_BCSR_PHYS_ADDR,
-		  DB1200_BCSR_PHYS_ADDR + DB1200_BCSR_HEXLED_OFS);
-	bid = BCSR_WHOAMI_BOARD(bcsr_read(BCSR_WHOAMI));
-	return bid == BCSR_WHOAMI_DB1200 ? 0 : 1;
+	return 1;	/* it's neither */
 }
 
 void __init board_setup(void)
-- 
1.7.8.rc1
