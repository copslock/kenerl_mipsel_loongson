Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 May 2015 11:31:40 +0200 (CEST)
Received: from mail-wi0-f181.google.com ([209.85.212.181]:34377 "EHLO
        mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012957AbbELJbi1wlRC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 May 2015 11:31:38 +0200
Received: by wicmc15 with SMTP id mc15so48963552wic.1;
        Tue, 12 May 2015 02:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=aGqcAUa9CMMT/gBi5Dy9ho5l5+c5uwib3SJ+h6prz+o=;
        b=LqvL7oTZTHvSnj7G0IXTQHuXxebJ36pEYRFFrPIh0LRQv0MmWgWECE6CwnAkIY4m60
         4oH7XDDyPtB85HF9rrbSV1UqekjQ3OpCqAmR9oF2tCGvao7/uByfPrNwQTh4fofl1712
         MKkk8dN2EaonLkVSgqdYlKEUxpsqPQCOkSbYsDUfGNIRzCjp4qWEOTOMn9O9MbB3kSfU
         PRjhFT8aK641wp1JKy+/5/1E8x/uGHpPrm5gzr7B5cV8sIewg8hJpCPQVyZXCBiBgHzR
         OOZTgUt1YeMCTAfTIhUXqFrDSAH6Zt3yoR5cL7WGOprhAI682ZlUR3jfjWILWGO/X7N7
         tAYw==
X-Received: by 10.180.8.34 with SMTP id o2mr5366180wia.18.1431423095483;
        Tue, 12 May 2015 02:31:35 -0700 (PDT)
Received: from linux-tdhb.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id v20sm26784876wjr.49.2015.05.12.02.31.33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2015 02:31:34 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH] MIPS: BCM47XX: Extract all boardflags to new u32 fields
Date:   Tue, 12 May 2015 11:31:02 +0200
Message-Id: <1431423062-704-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47339
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

For years we planned to get rid of old u16 fields, let's start doing it
with MIPS code. This process will take some time, it requires doing the
same in ssb/bcma and then switching all drivers to new fields. This will
be handled in separated patches submitted to appropriate trees.

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
 arch/mips/bcm47xx/sprom.c | 3 +++
 include/linux/ssb/ssb.h   | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/mips/bcm47xx/sprom.c b/arch/mips/bcm47xx/sprom.c
index 68ebf23..4048083 100644
--- a/arch/mips/bcm47xx/sprom.c
+++ b/arch/mips/bcm47xx/sprom.c
@@ -201,6 +201,9 @@ static void bcm47xx_sprom_fill_auto(struct ssb_sprom *sprom,
 	bool fb = fallback;
 
 	ENTRY(0xfffffffe, u16, pre, "boardrev", board_rev, 0, true);
+	ENTRY(0xfffffffe, u32, pre, "boardflags", boardflags, 0, fb);
+	ENTRY(0xfffffff0, u32, pre, "boardflags2", boardflags2, 0, fb);
+	ENTRY(0xfffff800, u32, pre, "boardflags3", boardflags3, 0, fb);
 	ENTRY(0x00000002, u16, pre, "boardflags", boardflags_lo, 0, fb);
 	ENTRY(0xfffffffc, u16, pre, "boardtype", board_type, 0, true);
 	ENTRY(0xfffffffe, u16, pre, "boardnum", board_num, 0, fb);
diff --git a/include/linux/ssb/ssb.h b/include/linux/ssb/ssb.h
index 4568a5c..ee90e32 100644
--- a/include/linux/ssb/ssb.h
+++ b/include/linux/ssb/ssb.h
@@ -88,11 +88,14 @@ struct ssb_sprom {
 	u32 ofdm5glpo;		/* 5.2GHz OFDM power offset */
 	u32 ofdm5gpo;		/* 5.3GHz OFDM power offset */
 	u32 ofdm5ghpo;		/* 5.8GHz OFDM power offset */
+	u32 boardflags;
+	u32 boardflags2;
+	u32 boardflags3;
+	/* TODO: Switch all drivers to new u32 fields and drop below ones */
 	u16 boardflags_lo;	/* Board flags (bits 0-15) */
 	u16 boardflags_hi;	/* Board flags (bits 16-31) */
 	u16 boardflags2_lo;	/* Board flags (bits 32-47) */
 	u16 boardflags2_hi;	/* Board flags (bits 48-63) */
-	/* TODO store board flags in a single u64 */
 
 	struct ssb_sprom_core_pwr_info core_pwr_info[4];
 
-- 
1.8.4.5
