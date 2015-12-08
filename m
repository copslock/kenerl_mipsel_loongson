Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Dec 2015 19:30:59 +0100 (CET)
Received: from mail-ig0-f172.google.com ([209.85.213.172]:34730 "EHLO
        mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007036AbbLHSa5CnTYe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Dec 2015 19:30:57 +0100
Received: by igvg19 with SMTP id g19so107368319igv.1
        for <linux-mips@linux-mips.org>; Tue, 08 Dec 2015 10:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=btnFFwfnWp8f6tt80iZcpA9DqMNV8kAEPZ7dOm5yKyQ=;
        b=CqD4e4K8s2sOvJYFPdSEuBQXavdeBi9wKOXSvO2JaH8XsHzrKYNrVn1Kdcxq/C57GW
         hBbni3ZvdbFI2y7FXueOXsiJaDxfb+TCAyYeC5S9nbloekgvzzg5KGYOlp1iwTnd/YFL
         wh1xkXP/dE9eAw6EQ9dC4FnsF4VzdvZLaW8Xtyf8MJgPw5fkg5b4PrE5YD/2IJOdvqhX
         mepR8VJVd9P67iPUa79+im93KvKEeDS4VaZ4pmbCuVqdpH2cWO+0jkz/ceTDTIOkSDHt
         D4BgE9tuzRKLkBQnmyrw8aZNPNx5IIlLR9+JmG4XCUNVVkuBpqOoYFrgeTvT6VgLCTbW
         SMHg==
X-Received: by 10.50.43.131 with SMTP id w3mr5126060igl.33.1449599451330;
        Tue, 08 Dec 2015 10:30:51 -0800 (PST)
Received: from kolya-laptop.shuttercorp.net (dhcp-108-170-142-183.cable.user.start.ca. [108.170.142.183])
        by smtp.gmail.com with ESMTPSA id 75sm1811398ios.35.2015.12.08.10.30.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Dec 2015 10:30:50 -0800 (PST)
From:   Nikolay Martynov <mar.kolya@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Nikolay Martynov <mar.kolya@gmail.com>
Subject: [PATCH] mips: make mips_cps_{core_init,boot_vpes} work on mips32r2
Date:   Tue,  8 Dec 2015 13:30:37 -0500
Message-Id: <1449599437-9593-1-git-send-email-mar.kolya@gmail.com>
X-Mailer: git-send-email 2.6.3
Return-Path: <mar.kolya@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50448
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mar.kolya@gmail.com
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

mips_cps_{core_init,boot_vpes} had 'mips64r2' hardcoded which
prevented them from being run on mips32. Fix that by choosing
cpu type based on CONFIG_64BIT.

Tested on mt7621.

Signed-off-by: Nikolay Martynov <mar.kolya@gmail.com>
---
 arch/mips/kernel/cps-vec.S | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
index 8fd5a27..1254a51 100644
--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -257,7 +257,11 @@ LEAF(mips_cps_core_init)
 	has_mt	t0, 3f
 
 	.set	push
+#ifdef CONFIG_64BIT
 	.set	mips64r2
+#else
+	.set	mips32r2
+#endif
 	.set	mt
 
 	/* Only allow 1 TC per VPE to execute... */
@@ -376,7 +380,11 @@ LEAF(mips_cps_boot_vpes)
 	 nop
 
 	.set	push
+#ifdef CONFIG_64BIT
 	.set	mips64r2
+#else
+	.set	mips32r2
+#endif
 	.set	mt
 
 1:	/* Enter VPE configuration state */
-- 
2.6.3
