Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Apr 2018 05:20:34 +0200 (CEST)
Received: from mail-pf0-x244.google.com ([IPv6:2607:f8b0:400e:c00::244]:46842
        "EHLO mail-pf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990411AbeD1DU1mo3aZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 Apr 2018 05:20:27 +0200
Received: by mail-pf0-x244.google.com with SMTP id p12so2796371pff.13;
        Fri, 27 Apr 2018 20:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IHUQibHEDZXuLf7M6P2enF7dkE+2qbCBKcottF1rRiw=;
        b=HCTY/WhIarq/Zsg4IxZkt8jocdY5j0a/ui5B45BKOkY1V+BENA2TIxIMqsi34qv6Ew
         MbmyNRxzSmFALN7b1fZd7nYo2aXbz9ZlEr5ud6t0NvHDYramGt1oKzCn5YcWr6SJt7xz
         L4JDqGtVin1/HPUzc8iV6ZIfHdkiJpNtc2VEoqCQ/qGP8di795LPh+XIixRI3Gd9j6fv
         vC6u6XTU+gflwvDUDRUK6DTywZSsqwvBRJyrA3qDL5ljf5/IgwsDiacTXywWPX+DLGYW
         E4KkP5+zirWhcOQ597YuGMgOz6SqB/Ns+bFFdMTrIqLxz4hUfiDGkF39/l0ZsaykAKPU
         E+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=IHUQibHEDZXuLf7M6P2enF7dkE+2qbCBKcottF1rRiw=;
        b=qA3qwG00w4cfLXxc0FIE7a8htvVasaYTgVb+RL5FRqkzdPt7CZ6qKYEGo8siKLxZ/2
         RmYBGxkUPuK0cEZG6fB0TBlJWjihrBBIYUUNQFRB/A36RjmKhJVGfoBIhNacWavnSZv4
         QjzIMtujXNDXv70+eBIKpIjPDYRwUMZRRg3PGauKIe+4VsQD6wRXGCMJK/Ojn/ioteMz
         F/oH0PvA2f/4cKqBW8ub57zaWQymFmeYa60Vr4PEq5jOOrPkYi9PA11VRKBHkzwlRkDL
         ORi8XpurwULuInIX79MTOmzR5vMMIgcZay7THr4k4olSLDGvqT3+V8hVhazO0uMc6TZQ
         doxw==
X-Gm-Message-State: ALQs6tD4Lq7ZKgQmlGZ0+jlQW2Wa26R+m5mzIL5YseKI/vj8SGk4Ozxe
        yaaHwmzmBIuL3eyex/dysMvlGQ==
X-Google-Smtp-Source: AB8JxZrW4gXLw3ZOjqMG2VPxhVckBuIc8kDyxAGOfCdIAvBks5nlkhC9qL2HfHOXhUPNZAjIUzsstQ==
X-Received: by 2002:a63:6196:: with SMTP id v144-v6mr4132907pgb.264.1524885621146;
        Fri, 27 Apr 2018 20:20:21 -0700 (PDT)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id g72sm7148114pfg.60.2018.04.27.20.20.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Apr 2018 20:20:20 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@mips.com>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V3 02/10] MIPS: Loongson64: Define and use some CP0 registers
Date:   Sat, 28 Apr 2018 11:21:26 +0800
Message-Id: <1524885694-18132-3-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1524885694-18132-1-git-send-email-chenhc@lemote.com>
References: <1524885694-18132-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63820
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

Defines CP0_CONFIG3, CP0_CONFIG6, CP0_PAGEGRAIN and use them in
kernel-entry-init.h for Loongson64.

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
index f658597..38779b8 100644
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
