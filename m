Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Jan 2018 04:13:50 +0100 (CET)
Received: from mail-pl0-x241.google.com ([IPv6:2607:f8b0:400e:c01::241]:41076
        "EHLO mail-pl0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990401AbeA0DNgfCehB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 27 Jan 2018 04:13:36 +0100
Received: by mail-pl0-x241.google.com with SMTP id q3so157424plr.8;
        Fri, 26 Jan 2018 19:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iH2Gs23CrB1QOGbdp+WdneY54fx5P4Oi3432Yr6oGDQ=;
        b=Qd6HXUinPMaTMFA4QqneBsKF4mbjsaEv+G/EafiVZtp1kQ4mBkTKGEhwLqh7edYjzW
         8dnCVd8nKYlLW3TUczfHHsLqibHFlHAZJLp6pyLpeywk/lMZHiZN6hplU5zYgNBx97lm
         /zvvnhQKLarGDEmTqxNitEjUVJBLFaXMWmok8hAcrBwoOdy7Tt1H4SqI731U6tprRU/B
         cgT7avn+t42alI/iT2R1FZKMzU5bOXxKmqKnSW7jBImva13rXSvWhxTGo/8opaOf2dBP
         XCW0QuUp3DT8hJSbxGEKjy9GgqhAzt7ak3aQWWVt/VN48z8eYxb7FSkRMwTtbpp8YYtD
         rYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=iH2Gs23CrB1QOGbdp+WdneY54fx5P4Oi3432Yr6oGDQ=;
        b=KLzqXgSsJEmGo3CpU8vQEAvlMW6ErMFDu9U6iS/IsuMo4mlyRr4EbLltSRllD6o7AG
         Z7/FnlEwbvS/V5NDCmMUv7nzEMjYG103fzk1v0LbYBUjpgU2a5PWvTq9MdfDTryDPl6B
         4ZLMiebwDfIHSo/VfDm6QTnok3Wb633fL0PReve9czjNZNq5UBFl9/JNhhMfmrAl9hG4
         j++1gxFVAwuWo1GrCsquSzXXlSlh5Vaz5NK01ZmwaS2uZWQsZU1GeSHJlh9Kh++V4iKD
         6RIYEYvi4g9a6UCkH+b0FlqmLOluaBFJAHCGFr/wTf9Y4zIMGnVcldD6t1wHYGhZXov3
         ZMEw==
X-Gm-Message-State: AKwxytcvPRGokAOv4XeJvgo+hdfG500T0IbD29YUrN0u/XVFbiqWCqTv
        pqiKxc/X90Xxu4Rza8vCHGLFzA==
X-Google-Smtp-Source: AH8x226Xjs+aZIEwBj04MOBS64dHozzyQiCIW7khQ/VAfixVPYN7On3ruGbyzccyK1AnPcOVZgc+uA==
X-Received: by 2002:a17:902:ab93:: with SMTP id f19-v6mr16188804plr.10.1517022808053;
        Fri, 26 Jan 2018 19:13:28 -0800 (PST)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id w16sm4775884pfk.18.2018.01.26.19.13.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jan 2018 19:13:27 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@mips.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V2 02/12] MIPS: Loongson64: Define and use some CP0 registers
Date:   Sat, 27 Jan 2018 11:12:22 +0800
Message-Id: <1517022752-3053-3-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1517022752-3053-1-git-send-email-chenhc@lemote.com>
References: <1517022752-3053-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62345
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

This patche defines CP0_CONFIG3, CP0_CONFIG6, CP0_PAGEGRAIN and uses
them in kernel-entry-init.h for Loongson64.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 .../asm/mach-loongson64/kernel-entry-init.h        | 24 +++++++++++-----------
 arch/mips/include/asm/mipsregs.h                   |  2 ++
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h b/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h
index 8393bc54..3127391 100644
--- a/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h
+++ b/arch/mips/include/asm/mach-loongson64/kernel-entry-init.h
@@ -19,18 +19,18 @@
 	.set	push
 	.set	mips64
 	/* Set LPA on LOONGSON3 config3 */
-	mfc0	t0, $16, 3
+	mfc0	t0, CP0_CONFIG3
 	or	t0, (0x1 << 7)
-	mtc0	t0, $16, 3
+	mtc0	t0, CP0_CONFIG3
 	/* Set ELPA on LOONGSON3 pagegrain */
-	mfc0	t0, $5, 1
+	mfc0	t0, CP0_PAGEGRAIN
 	or	t0, (0x1 << 29)
-	mtc0	t0, $5, 1
+	mtc0	t0, CP0_PAGEGRAIN
 #ifdef CONFIG_LOONGSON3_ENHANCEMENT
 	/* Enable STFill Buffer */
-	mfc0	t0, $16, 6
+	mfc0	t0, CP0_CONFIG6
 	or	t0, 0x100
-	mtc0	t0, $16, 6
+	mtc0	t0, CP0_CONFIG6
 #endif
 	_ehb
 	.set	pop
@@ -45,18 +45,18 @@
 	.set	push
 	.set	mips64
 	/* Set LPA on LOONGSON3 config3 */
-	mfc0	t0, $16, 3
+	mfc0	t0, CP0_CONFIG3
 	or	t0, (0x1 << 7)
-	mtc0	t0, $16, 3
+	mtc0	t0, CP0_CONFIG3
 	/* Set ELPA on LOONGSON3 pagegrain */
-	mfc0	t0, $5, 1
+	mfc0	t0, CP0_PAGEGRAIN
 	or	t0, (0x1 << 29)
-	mtc0	t0, $5, 1
+	mtc0	t0, CP0_PAGEGRAIN
 #ifdef CONFIG_LOONGSON3_ENHANCEMENT
 	/* Enable STFill Buffer */
-	mfc0	t0, $16, 6
+	mfc0	t0, CP0_CONFIG6
 	or	t0, 0x100
-	mtc0	t0, $16, 6
+	mtc0	t0, CP0_CONFIG6
 #endif
 	_ehb
 	.set	pop
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 0b58864..69307b3 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -51,6 +51,7 @@
 #define CP0_GLOBALNUMBER $3, 1
 #define CP0_CONTEXT $4
 #define CP0_PAGEMASK $5
+#define CP0_PAGEGRAIN $5, 1
 #define CP0_SEGCTL0 $5, 2
 #define CP0_SEGCTL1 $5, 3
 #define CP0_SEGCTL2 $5, 4
@@ -77,6 +78,7 @@
 #define CP0_CONFIG $16
 #define CP0_CONFIG3 $16, 3
 #define CP0_CONFIG5 $16, 5
+#define CP0_CONFIG6 $16, 6
 #define CP0_LLADDR $17
 #define CP0_WATCHLO $18
 #define CP0_WATCHHI $19
-- 
2.7.0
