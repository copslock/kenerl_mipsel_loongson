Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Feb 2017 13:04:56 +0100 (CET)
Received: from mail-wr0-x241.google.com ([IPv6:2a00:1450:400c:c0c::241]:36451
        "EHLO mail-wr0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993866AbdBNMDlKQtTR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Feb 2017 13:03:41 +0100
Received: by mail-wr0-x241.google.com with SMTP id k90so27248960wrc.3;
        Tue, 14 Feb 2017 04:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gRTVtfGRDuDU2irYMP0u5am11lqM7ORDyHSOhCW+WlM=;
        b=WmPI+6z7WhISk6t2i3hnnt2BH6SpoF9RIp2raEodJieleRUI6u543MmkpCAW+LPDEE
         8cJmlk1mrm+TunSMWrqAouucKBOVpNdISBIi3Gi6eh/m4jsY8+O9iNJCC3owuwq4ztIp
         ae570e/YTTEDRe09x2W5rE3zT9HlDhwmegfN6tILeTXAe/Bnc6Cx2A154u2gKCEbORkh
         5HLWTeMgu7VfXEDM2wH4o9Axywa05Wgq+P3K8jPXCDfUvUhdZ1/6b/mirTBaA8XLyhe2
         uD2ejvtkkHGmeYhlE1rWS/d+Eg64ilBhR0LkpSGyPv9u7fPuI2yH/93rFHa8819y8PcK
         Wf5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gRTVtfGRDuDU2irYMP0u5am11lqM7ORDyHSOhCW+WlM=;
        b=KM4HOVIyfwVHFLTshNRZHXUpr7bdMVBKKBU4qkQXGHs5u9/xVQm16+rlDHVq81TQOf
         GOXG0YMrnwTIaxI3O5XxIbDVUx8EH5/Xdkm6m55ROpXnkm1TVvKzM+8L+Yx9K1zamtaQ
         fFYvh32Loy+Ifrd087gt3TFKisoWQHpiPqXh1sFRiIk0/p23xsEG5r/MwA+2w/RSZ02w
         Uk/w/EAN1kwNInWhGOQrX+eFW1nUt4fZsxLRKN6uwctAJeH4z5sXl4xe3hb2FVNOM6s9
         zR3UUiKbv+a4Rrj2j6YdhKLAY1DjIRQGhrDBwjT5NKBTXnJaWgOR9W89fomCKvOXbeaO
         tTwQ==
X-Gm-Message-State: AMke39nN+cXVZJ23gElgJjQWbJiV9Orev+5xfmBFsuw8iAiPmWHXh9khU/aj3dwR5f6mTA==
X-Received: by 10.223.138.188 with SMTP id y57mr24083170wry.191.1487073815788;
        Tue, 14 Feb 2017 04:03:35 -0800 (PST)
Received: from dargo.Speedport_W_724V_Typ_A_05011603_05_020 (p200300C023CC14391746B39401FFCB78.dip0.t-ipconnect.de. [2003:c0:23cc:1439:1746:b394:1ff:cb78])
        by smtp.gmail.com with ESMTPSA id e71sm1030339wma.8.2017.02.14.04.03.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Feb 2017 04:03:35 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 3/3] MIPS: Alchemy: Threaded carddetect irqs for devboards
Date:   Tue, 14 Feb 2017 13:03:28 +0100
Message-Id: <20170214120328.240326-4-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.11.1
In-Reply-To: <20170214120328.240326-1-manuel.lauss@gmail.com>
References: <20170214120328.240326-1-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56809
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

This introduces threaded carddetect irqs for the db1200/db1300 boards.
Main benefit is that the broken insertion/ejection interrupt pairs
can now be better supported and debounced in software.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/alchemy/devboards/db1200.c | 64 ++++++++++++++++++++----------------
 arch/mips/alchemy/devboards/db1300.c | 31 +++++++++--------
 drivers/pcmcia/db1xxx_ss.c           | 33 +++++++++++--------
 3 files changed, 72 insertions(+), 56 deletions(-)

diff --git a/arch/mips/alchemy/devboards/db1200.c b/arch/mips/alchemy/devboards/db1200.c
index 992442a03d8b..c1bdd6e8191e 100644
--- a/arch/mips/alchemy/devboards/db1200.c
+++ b/arch/mips/alchemy/devboards/db1200.c
@@ -344,28 +344,32 @@ static struct platform_device db1200_ide_dev = {
 
 /* SD carddetects:  they're supposed to be edge-triggered, but ack
  * doesn't seem to work (CPLD Rev 2).  Instead, the screaming one
- * is disabled and its counterpart enabled.  The 500ms timeout is
- * because the carddetect isn't debounced in hardware.
+ * is disabled and its counterpart enabled.  The 200ms timeout is
+ * because the carddetect usually triggers twice, after debounce.
  */
 static irqreturn_t db1200_mmc_cd(int irq, void *ptr)
 {
-	void(*mmc_cd)(struct mmc_host *, unsigned long);
+	disable_irq_nosync(irq);
+	return IRQ_WAKE_THREAD;
+}
 
-	if (irq == DB1200_SD0_INSERT_INT) {
-		disable_irq_nosync(DB1200_SD0_INSERT_INT);
-		enable_irq(DB1200_SD0_EJECT_INT);
-	} else {
-		disable_irq_nosync(DB1200_SD0_EJECT_INT);
-		enable_irq(DB1200_SD0_INSERT_INT);
-	}
+static irqreturn_t db1200_mmc_cdfn(int irq, void *ptr)
+{
+	void (*mmc_cd)(struct mmc_host *, unsigned long);
 
 	/* link against CONFIG_MMC=m */
 	mmc_cd = symbol_get(mmc_detect_change);
 	if (mmc_cd) {
-		mmc_cd(ptr, msecs_to_jiffies(500));
+		mmc_cd(ptr, msecs_to_jiffies(200));
 		symbol_put(mmc_detect_change);
 	}
 
+	msleep(100);	/* debounce */
+	if (irq == DB1200_SD0_INSERT_INT)
+		enable_irq(DB1200_SD0_EJECT_INT);
+	else
+		enable_irq(DB1200_SD0_INSERT_INT);
+
 	return IRQ_HANDLED;
 }
 
@@ -374,13 +378,13 @@ static int db1200_mmc_cd_setup(void *mmc_host, int en)
 	int ret;
 
 	if (en) {
-		ret = request_irq(DB1200_SD0_INSERT_INT, db1200_mmc_cd,
-				  0, "sd_insert", mmc_host);
+		ret = request_threaded_irq(DB1200_SD0_INSERT_INT, db1200_mmc_cd,
+				db1200_mmc_cdfn, 0, "sd_insert", mmc_host);
 		if (ret)
 			goto out;
 
-		ret = request_irq(DB1200_SD0_EJECT_INT, db1200_mmc_cd,
-				  0, "sd_eject", mmc_host);
+		ret = request_threaded_irq(DB1200_SD0_EJECT_INT, db1200_mmc_cd,
+				db1200_mmc_cdfn, 0, "sd_eject", mmc_host);
 		if (ret) {
 			free_irq(DB1200_SD0_INSERT_INT, mmc_host);
 			goto out;
@@ -436,23 +440,27 @@ static struct led_classdev db1200_mmc_led = {
 
 static irqreturn_t pb1200_mmc1_cd(int irq, void *ptr)
 {
-	void(*mmc_cd)(struct mmc_host *, unsigned long);
+	disable_irq_nosync(irq);
+	return IRQ_WAKE_THREAD;
+}
 
-	if (irq == PB1200_SD1_INSERT_INT) {
-		disable_irq_nosync(PB1200_SD1_INSERT_INT);
-		enable_irq(PB1200_SD1_EJECT_INT);
-	} else {
-		disable_irq_nosync(PB1200_SD1_EJECT_INT);
-		enable_irq(PB1200_SD1_INSERT_INT);
-	}
+static irqreturn_t pb1200_mmc1_cdfn(int irq, void *ptr)
+{
+	void (*mmc_cd)(struct mmc_host *, unsigned long);
 
 	/* link against CONFIG_MMC=m */
 	mmc_cd = symbol_get(mmc_detect_change);
 	if (mmc_cd) {
-		mmc_cd(ptr, msecs_to_jiffies(500));
+		mmc_cd(ptr, msecs_to_jiffies(200));
 		symbol_put(mmc_detect_change);
 	}
 
+	msleep(100);	/* debounce */
+	if (irq == PB1200_SD1_INSERT_INT)
+		enable_irq(PB1200_SD1_EJECT_INT);
+	else
+		enable_irq(PB1200_SD1_INSERT_INT);
+
 	return IRQ_HANDLED;
 }
 
@@ -461,13 +469,13 @@ static int pb1200_mmc1_cd_setup(void *mmc_host, int en)
 	int ret;
 
 	if (en) {
-		ret = request_irq(PB1200_SD1_INSERT_INT, pb1200_mmc1_cd, 0,
-				  "sd1_insert", mmc_host);
+		ret = request_threaded_irq(PB1200_SD1_INSERT_INT, pb1200_mmc1_cd,
+				pb1200_mmc1_cdfn, 0, "sd1_insert", mmc_host);
 		if (ret)
 			goto out;
 
-		ret = request_irq(PB1200_SD1_EJECT_INT, pb1200_mmc1_cd, 0,
-				  "sd1_eject", mmc_host);
+		ret = request_threaded_irq(PB1200_SD1_EJECT_INT, pb1200_mmc1_cd,
+				pb1200_mmc1_cdfn, 0, "sd1_eject", mmc_host);
 		if (ret) {
 			free_irq(PB1200_SD1_INSERT_INT, mmc_host);
 			goto out;
diff --git a/arch/mips/alchemy/devboards/db1300.c b/arch/mips/alchemy/devboards/db1300.c
index d3c087f59f1a..418d657bdd4a 100644
--- a/arch/mips/alchemy/devboards/db1300.c
+++ b/arch/mips/alchemy/devboards/db1300.c
@@ -449,24 +449,27 @@ static struct platform_device db1300_ide_dev = {
 
 static irqreturn_t db1300_mmc_cd(int irq, void *ptr)
 {
-	void(*mmc_cd)(struct mmc_host *, unsigned long);
+	disable_irq_nosync(irq);
+	return IRQ_WAKE_THREAD;
+}
 
-	/* disable the one currently screaming. No other way to shut it up */
-	if (irq == DB1300_SD1_INSERT_INT) {
-		disable_irq_nosync(DB1300_SD1_INSERT_INT);
-		enable_irq(DB1300_SD1_EJECT_INT);
-	} else {
-		disable_irq_nosync(DB1300_SD1_EJECT_INT);
-		enable_irq(DB1300_SD1_INSERT_INT);
-	}
+static irqreturn_t db1300_mmc_cdfn(int irq, void *ptr)
+{
+	void (*mmc_cd)(struct mmc_host *, unsigned long);
 
 	/* link against CONFIG_MMC=m.  We can only be called once MMC core has
 	 * initialized the controller, so symbol_get() should always succeed.
 	 */
 	mmc_cd = symbol_get(mmc_detect_change);
-	mmc_cd(ptr, msecs_to_jiffies(500));
+	mmc_cd(ptr, msecs_to_jiffies(200));
 	symbol_put(mmc_detect_change);
 
+	msleep(100);	/* debounce */
+	if (irq == DB1300_SD1_INSERT_INT)
+		enable_irq(DB1300_SD1_EJECT_INT);
+	else
+		enable_irq(DB1300_SD1_INSERT_INT);
+
 	return IRQ_HANDLED;
 }
 
@@ -486,13 +489,13 @@ static int db1300_mmc_cd_setup(void *mmc_host, int en)
 	int ret;
 
 	if (en) {
-		ret = request_irq(DB1300_SD1_INSERT_INT, db1300_mmc_cd, 0,
-				  "sd_insert", mmc_host);
+		ret = request_threaded_irq(DB1300_SD1_INSERT_INT, db1300_mmc_cd,
+				db1300_mmc_cdfn, 0, "sd_insert", mmc_host);
 		if (ret)
 			goto out;
 
-		ret = request_irq(DB1300_SD1_EJECT_INT, db1300_mmc_cd, 0,
-				  "sd_eject", mmc_host);
+		ret = request_threaded_irq(DB1300_SD1_EJECT_INT, db1300_mmc_cd,
+				db1300_mmc_cdfn, 0, "sd_eject", mmc_host);
 		if (ret) {
 			free_irq(DB1300_SD1_INSERT_INT, mmc_host);
 			goto out;
diff --git a/drivers/pcmcia/db1xxx_ss.c b/drivers/pcmcia/db1xxx_ss.c
index 944674ee3464..19e17829f515 100644
--- a/drivers/pcmcia/db1xxx_ss.c
+++ b/drivers/pcmcia/db1xxx_ss.c
@@ -131,22 +131,27 @@ static irqreturn_t db1000_pcmcia_stschgirq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+/* Db/Pb1200 have separate per-socket insertion and ejection
+ * interrupts which stay asserted as long as the card is
+ * inserted/missing.  The one which caused us to be called
+ * needs to be disabled and the other one enabled.
+ */
 static irqreturn_t db1200_pcmcia_cdirq(int irq, void *data)
 {
+	disable_irq_nosync(irq);
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t db1200_pcmcia_cdirq_fn(int irq, void *data)
+{
 	struct db1x_pcmcia_sock *sock = data;
 
-	/* Db/Pb1200 have separate per-socket insertion and ejection
-	 * interrupts which stay asserted as long as the card is
-	 * inserted/missing.  The one which caused us to be called
-	 * needs to be disabled and the other one enabled.
-	 */
-	if (irq == sock->insert_irq) {
-		disable_irq_nosync(sock->insert_irq);
+	/* Wait a bit for the signals to stop bouncing. */
+	msleep(100);
+	if (irq == sock->insert_irq)
 		enable_irq(sock->eject_irq);
-	} else {
-		disable_irq_nosync(sock->eject_irq);
+	else
 		enable_irq(sock->insert_irq);
-	}
 
 	pcmcia_parse_events(&sock->socket, SS_DETECT);
 
@@ -172,13 +177,13 @@ static int db1x_pcmcia_setup_irqs(struct db1x_pcmcia_sock *sock)
 	 */
 	if ((sock->board_type == BOARD_TYPE_DB1200) ||
 	    (sock->board_type == BOARD_TYPE_DB1300)) {
-		ret = request_irq(sock->insert_irq, db1200_pcmcia_cdirq,
-				  0, "pcmcia_insert", sock);
+		ret = request_threaded_irq(sock->insert_irq, db1200_pcmcia_cdirq,
+			db1200_pcmcia_cdirq_fn, 0, "pcmcia_insert", sock);
 		if (ret)
 			goto out1;
 
-		ret = request_irq(sock->eject_irq, db1200_pcmcia_cdirq,
-				  0, "pcmcia_eject", sock);
+		ret = request_threaded_irq(sock->eject_irq, db1200_pcmcia_cdirq,
+			db1200_pcmcia_cdirq_fn, 0, "pcmcia_eject", sock);
 		if (ret) {
 			free_irq(sock->insert_irq, sock);
 			goto out1;
-- 
2.11.1
