Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Nov 2018 15:52:14 +0100 (CET)
Received: from mail-pf1-x444.google.com ([IPv6:2607:f8b0:4864:20::444]:37160
        "EHLO mail-pf1-x444.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992482AbeKEOu4Kws0c (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Nov 2018 15:50:56 +0100
Received: by mail-pf1-x444.google.com with SMTP id u13-v6so4546772pfm.4;
        Mon, 05 Nov 2018 06:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2B7uMq8TqOBuAo7vU8+IMU1kjMIN9Kqw1L+asdWIuHQ=;
        b=jhHXnwi5N3/L7zBLT3i/y/rO8BSQ6O8PFmse5gtSTVsbMoUbT4PVUDiVzQ4ckcnEkB
         dcrpGyA3hilxNjRqYsReykOqJf+GFpgA3t9AzPOO+1GJDMVbu3UB0+S+WC95LaRFBvqK
         v5GCgaLm1L18Jk2KudnVwnmg9p52Sj6MypiRKh/Gy8saCceAeHGgn1kuzqB0HPm7JbEK
         jZZiXF55f/NUZGokNiiVPt3TrBUCUz6N5F86FObO04OTDqYGIjTti16LiXEheTzj+V1+
         LO9zgsYTeaFpGoJMOpv0IvRsvwkJud2L79UnzoH/+rxrMriGiX0pehDXxSXyFQSCIB8r
         iVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2B7uMq8TqOBuAo7vU8+IMU1kjMIN9Kqw1L+asdWIuHQ=;
        b=BGO2Ps1dzzKSatfk9G2whgSngrkT582kunfojT2PGjwRHG3KEpgA+LJn+2YpizUoGb
         wsI/Dbs1vGEuWEGKRxD2pXsSTe0q11qrfkDwz1kGIRduzS0aAU2HgqlYuFkCW03+smcu
         EcMFax1tdrgr3wUyslkFpx+xa4cEljSzhn9WqbSt6MJCm2ZpCig5H8sbaU4+qnJLsi3W
         10DxCJf97LZvMif5AYFzDzfS0E+cb9q/Q2ZnvGNp9R7K+58zktjKbhc7jTL8MTMVean6
         Ccd+QjmB3rMOWm9+/OJq6la9YQ4+077GojSTG+mC8igA/qfEXNmS71JqT/ybarPTjo1k
         PkEA==
X-Gm-Message-State: AGRZ1gIjht8fogRQb676I9AhVIHZR2dRZcnLTlOXKLGs8t8GJRYqim7h
        cKsMP/xKmVdvdEyGod2+F1/Er0A/Zvo=
X-Google-Smtp-Source: AJdET5c+p64hChEXHWkpMFitn4qV3I8r3BonAN+kHb2NbL0DiRovQvbY//NAb++dn+M8vyVvfMCjKA==
X-Received: by 2002:a62:1693:: with SMTP id 141-v6mr22992293pfw.183.1541429454756;
        Mon, 05 Nov 2018 06:50:54 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id e204-v6sm8594336pfh.68.2018.11.05.06.50.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 06:50:54 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] MIPS: math-emu: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date:   Mon,  5 Nov 2018 09:50:49 -0500
Message-Id: <20181105145049.6336-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Return-Path: <tiny.windzz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67085
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiny.windzz@gmail.com
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

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 arch/mips/math-emu/me-debugfs.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/mips/math-emu/me-debugfs.c b/arch/mips/math-emu/me-debugfs.c
index 62566385ce0e..58798f527356 100644
--- a/arch/mips/math-emu/me-debugfs.c
+++ b/arch/mips/math-emu/me-debugfs.c
@@ -183,17 +183,7 @@ static int fpuemustats_clear_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static int fpuemustats_clear_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, fpuemustats_clear_show, inode->i_private);
-}
-
-static const struct file_operations fpuemustats_clear_fops = {
-	.open                   = fpuemustats_clear_open,
-	.read			= seq_read,
-	.llseek			= seq_lseek,
-	.release		= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(fpuemustats_clear);
 
 static int __init debugfs_fpuemu(void)
 {
-- 
2.17.0
