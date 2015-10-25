Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Oct 2015 22:17:19 +0100 (CET)
Received: from mail-lf0-f46.google.com ([209.85.215.46]:35645 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008799AbbJYVRSqq2SN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 25 Oct 2015 22:17:18 +0100
Received: by lfbn126 with SMTP id n126so93826400lfb.2;
        Sun, 25 Oct 2015 14:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=PsKahuPQa6cHkZy3AoyQd5AEY3fttqsIo7oPwvqwKWY=;
        b=BP7Wu1mXxXm3hfkDTu4CI7E0mlUlZa0hgs7eXfTeHTAHNzdT94F97CJVVSwbgFxFtN
         90p0aynP6LxSnGESDOOGDy1uJhghA5izWhLXvSjpMD/OxOHepFQN7LTtFw6aqbGpP6bS
         Hfa0DAlXUxZL5WixZ9rsuVSBTXrO06Sx4lx2LuRd2PoxP4xmB8PtTAJgwDyt1m+BpehF
         opyl3hwiM56/ObBXjM+65l3m7YU+ttVa0lh724OCiHsyKnxkQth0I9Upk1S1BN43Oj25
         +xYto1+PjGSIeJr0xPWITVdB2ymkmRedpK9zCAmZKuyz0i33/HFjGOKs8nbzojh/mkfh
         jO3g==
X-Received: by 10.112.144.225 with SMTP id sp1mr1882142lbb.97.1445807833383;
        Sun, 25 Oct 2015 14:17:13 -0700 (PDT)
Received: from linux-tdhb.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id 78sm5440312lfs.35.2015.10.25.14.17.12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Oct 2015 14:17:12 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH 1/2] MIPS: BCM47xx: Support on-SoC bus in SPROM reading function
Date:   Sun, 25 Oct 2015 22:16:47 +0100
Message-Id: <1445807808-23257-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49680
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

To support (extract) SPROM on Broadcom ARM devices we should separate
SPROM code and make it a separated module. We won't want to export
bcm47xx_fill_sprom symbol so we should support SoC SPROM in the standard
fallback function and then modify ssb to use it.

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
 arch/mips/bcm47xx/sprom.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/mips/bcm47xx/sprom.c b/arch/mips/bcm47xx/sprom.c
index 2d5c7a7..e19c1b9 100644
--- a/arch/mips/bcm47xx/sprom.c
+++ b/arch/mips/bcm47xx/sprom.c
@@ -610,14 +610,18 @@ static int bcm47xx_get_sprom_ssb(struct ssb_bus *bus, struct ssb_sprom *out)
 {
 	char prefix[10];
 
-	if (bus->bustype == SSB_BUSTYPE_PCI) {
+	switch (bus->bustype) {
+	case SSB_BUSTYPE_SSB:
+		bcm47xx_fill_sprom(out, NULL, false);
+		return 0;
+	case SSB_BUSTYPE_PCI:
 		memset(out, 0, sizeof(struct ssb_sprom));
 		snprintf(prefix, sizeof(prefix), "pci/%u/%u/",
 			 bus->host_pci->bus->number + 1,
 			 PCI_SLOT(bus->host_pci->devfn));
 		bcm47xx_fill_sprom(out, prefix, false);
 		return 0;
-	} else {
+	default:
 		pr_warn("Unable to fill SPROM for given bustype.\n");
 		return -EINVAL;
 	}
-- 
1.8.4.5
