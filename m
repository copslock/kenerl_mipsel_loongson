Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2014 15:47:25 +0200 (CEST)
Received: from mail-wg0-f41.google.com ([74.125.82.41]:52508 "EHLO
        mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6842533AbaGWNnunywqs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Jul 2014 15:43:50 +0200
Received: by mail-wg0-f41.google.com with SMTP id z12so1197678wgg.0
        for <linux-mips@linux-mips.org>; Wed, 23 Jul 2014 06:43:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AymMQJ5hyv8BuUeq7r6HU5mcV/8XF1bnbTziYBVqCBs=;
        b=QqiBWc6rs3RvTnSawtKOg+1XJ/SZ0gAciOa5RQ0g/JePqzL6d76mSmV4BrQqpZzERD
         mI+QupG7T2vKG4CHHLEuNNCWvSS1VF+pY/EE/V6Tu35B1Y+Jw9qaj2rV7Qm7S1bvxl/T
         TuzO1dIh2yuZLafZJOxP+BKKQPJNOUeWtwUX4hlqGEtXFU8WjSxFdynXNDiyfcVy2/wD
         LT6+MHBN5JvnEWgzoIJ/XEXrJ+hegz3AGaIokmn24CAvaIMiqqpgo8gBMzFo+lUIWBz4
         WmP+Zn+fVNDb5B0mo63dmAn/syXB4e0lMOio0WAdwblyCU8cTaW/qHPAzHaHEp33Orpi
         zmFA==
X-Gm-Message-State: ALoCoQnQTL3pD8iOXkV7Z2+KqJrM4XiKFhMjnxQOPyLEEdrDou9FMHkgKKcu/P5mPxDYRtXgRB83
X-Received: by 10.180.218.12 with SMTP id pc12mr25461974wic.15.1406123020865;
        Wed, 23 Jul 2014 06:43:40 -0700 (PDT)
Received: from localhost.localdomain (host31-50-226-70.range31-50.btcentralplus.com. [31.50.226.70])
        by mx.google.com with ESMTPSA id w10sm9359341wie.22.2014.07.23.06.43.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jul 2014 06:43:40 -0700 (PDT)
From:   Alex Smith <alex@alex-smith.me.uk>
To:     linux-mips@linux-mips.org
Cc:     Alex Smith <alex@alex-smith.me.uk>
Subject: [PATCH 11/11] MIPS: asm/reg.h: Move to uapi
Date:   Wed, 23 Jul 2014 14:40:16 +0100
Message-Id: <1406122816-2424-12-git-send-email-alex@alex-smith.me.uk>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1406122816-2424-1-git-send-email-alex@alex-smith.me.uk>
References: <1406122816-2424-1-git-send-email-alex@alex-smith.me.uk>
Return-Path: <alex@alex-smith.me.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41526
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@alex-smith.me.uk
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

This header defines an exported interface (the register layout used in
core dumps and the GP regset accessible with PTRACE_{GET,SET}REGSET),
therefore belongs in uapi.

Signed-off-by: Alex Smith <alex@alex-smith.me.uk>
---
 arch/mips/include/asm/reg.h      | 207 +--------------------------------------
 arch/mips/include/uapi/asm/reg.h | 206 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 207 insertions(+), 206 deletions(-)
 create mode 100644 arch/mips/include/uapi/asm/reg.h

diff --git a/arch/mips/include/asm/reg.h b/arch/mips/include/asm/reg.h
index b8343cc..84dc7e2 100644
--- a/arch/mips/include/asm/reg.h
+++ b/arch/mips/include/asm/reg.h
@@ -1,206 +1 @@
-/*
- * Various register offset definitions for debuggers, core file
- * examiners and whatnot.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 1995, 1999 Ralf Baechle
- * Copyright (C) 1995, 1999 Silicon Graphics
- */
-#ifndef __ASM_MIPS_REG_H
-#define __ASM_MIPS_REG_H
-
-#define MIPS32_EF_R0		6
-#define MIPS32_EF_R1		7
-#define MIPS32_EF_R2		8
-#define MIPS32_EF_R3		9
-#define MIPS32_EF_R4		10
-#define MIPS32_EF_R5		11
-#define MIPS32_EF_R6		12
-#define MIPS32_EF_R7		13
-#define MIPS32_EF_R8		14
-#define MIPS32_EF_R9		15
-#define MIPS32_EF_R10		16
-#define MIPS32_EF_R11		17
-#define MIPS32_EF_R12		18
-#define MIPS32_EF_R13		19
-#define MIPS32_EF_R14		20
-#define MIPS32_EF_R15		21
-#define MIPS32_EF_R16		22
-#define MIPS32_EF_R17		23
-#define MIPS32_EF_R18		24
-#define MIPS32_EF_R19		25
-#define MIPS32_EF_R20		26
-#define MIPS32_EF_R21		27
-#define MIPS32_EF_R22		28
-#define MIPS32_EF_R23		29
-#define MIPS32_EF_R24		30
-#define MIPS32_EF_R25		31
-
-/*
- * k0/k1 unsaved
- */
-#define MIPS32_EF_R26		32
-#define MIPS32_EF_R27		33
-
-#define MIPS32_EF_R28		34
-#define MIPS32_EF_R29		35
-#define MIPS32_EF_R30		36
-#define MIPS32_EF_R31		37
-
-/*
- * Saved special registers
- */
-#define MIPS32_EF_LO		38
-#define MIPS32_EF_HI		39
-
-#define MIPS32_EF_CP0_EPC	40
-#define MIPS32_EF_CP0_BADVADDR	41
-#define MIPS32_EF_CP0_STATUS	42
-#define MIPS32_EF_CP0_CAUSE	43
-#define MIPS32_EF_UNUSED0	44
-
-#define MIPS32_EF_SIZE		180
-
-#define MIPS64_EF_R0		0
-#define MIPS64_EF_R1		1
-#define MIPS64_EF_R2		2
-#define MIPS64_EF_R3		3
-#define MIPS64_EF_R4		4
-#define MIPS64_EF_R5		5
-#define MIPS64_EF_R6		6
-#define MIPS64_EF_R7		7
-#define MIPS64_EF_R8		8
-#define MIPS64_EF_R9		9
-#define MIPS64_EF_R10		10
-#define MIPS64_EF_R11		11
-#define MIPS64_EF_R12		12
-#define MIPS64_EF_R13		13
-#define MIPS64_EF_R14		14
-#define MIPS64_EF_R15		15
-#define MIPS64_EF_R16		16
-#define MIPS64_EF_R17		17
-#define MIPS64_EF_R18		18
-#define MIPS64_EF_R19		19
-#define MIPS64_EF_R20		20
-#define MIPS64_EF_R21		21
-#define MIPS64_EF_R22		22
-#define MIPS64_EF_R23		23
-#define MIPS64_EF_R24		24
-#define MIPS64_EF_R25		25
-
-/*
- * k0/k1 unsaved
- */
-#define MIPS64_EF_R26		26
-#define MIPS64_EF_R27		27
-
-
-#define MIPS64_EF_R28		28
-#define MIPS64_EF_R29		29
-#define MIPS64_EF_R30		30
-#define MIPS64_EF_R31		31
-
-/*
- * Saved special registers
- */
-#define MIPS64_EF_LO		32
-#define MIPS64_EF_HI		33
-
-#define MIPS64_EF_CP0_EPC	34
-#define MIPS64_EF_CP0_BADVADDR	35
-#define MIPS64_EF_CP0_STATUS	36
-#define MIPS64_EF_CP0_CAUSE	37
-
-#define MIPS64_EF_SIZE		304	/* size in bytes */
-
-#if defined(CONFIG_32BIT)
-
-#define EF_R0			MIPS32_EF_R0
-#define EF_R1			MIPS32_EF_R1
-#define EF_R2			MIPS32_EF_R2
-#define EF_R3			MIPS32_EF_R3
-#define EF_R4			MIPS32_EF_R4
-#define EF_R5			MIPS32_EF_R5
-#define EF_R6			MIPS32_EF_R6
-#define EF_R7			MIPS32_EF_R7
-#define EF_R8			MIPS32_EF_R8
-#define EF_R9			MIPS32_EF_R9
-#define EF_R10			MIPS32_EF_R10
-#define EF_R11			MIPS32_EF_R11
-#define EF_R12			MIPS32_EF_R12
-#define EF_R13			MIPS32_EF_R13
-#define EF_R14			MIPS32_EF_R14
-#define EF_R15			MIPS32_EF_R15
-#define EF_R16			MIPS32_EF_R16
-#define EF_R17			MIPS32_EF_R17
-#define EF_R18			MIPS32_EF_R18
-#define EF_R19			MIPS32_EF_R19
-#define EF_R20			MIPS32_EF_R20
-#define EF_R21			MIPS32_EF_R21
-#define EF_R22			MIPS32_EF_R22
-#define EF_R23			MIPS32_EF_R23
-#define EF_R24			MIPS32_EF_R24
-#define EF_R25			MIPS32_EF_R25
-#define EF_R26			MIPS32_EF_R26
-#define EF_R27			MIPS32_EF_R27
-#define EF_R28			MIPS32_EF_R28
-#define EF_R29			MIPS32_EF_R29
-#define EF_R30			MIPS32_EF_R30
-#define EF_R31			MIPS32_EF_R31
-#define EF_LO			MIPS32_EF_LO
-#define EF_HI			MIPS32_EF_HI
-#define EF_CP0_EPC		MIPS32_EF_CP0_EPC
-#define EF_CP0_BADVADDR		MIPS32_EF_CP0_BADVADDR
-#define EF_CP0_STATUS		MIPS32_EF_CP0_STATUS
-#define EF_CP0_CAUSE		MIPS32_EF_CP0_CAUSE
-#define EF_UNUSED0		MIPS32_EF_UNUSED0
-#define EF_SIZE			MIPS32_EF_SIZE
-
-#elif defined(CONFIG_64BIT)
-
-#define EF_R0			MIPS64_EF_R0
-#define EF_R1			MIPS64_EF_R1
-#define EF_R2			MIPS64_EF_R2
-#define EF_R3			MIPS64_EF_R3
-#define EF_R4			MIPS64_EF_R4
-#define EF_R5			MIPS64_EF_R5
-#define EF_R6			MIPS64_EF_R6
-#define EF_R7			MIPS64_EF_R7
-#define EF_R8			MIPS64_EF_R8
-#define EF_R9			MIPS64_EF_R9
-#define EF_R10			MIPS64_EF_R10
-#define EF_R11			MIPS64_EF_R11
-#define EF_R12			MIPS64_EF_R12
-#define EF_R13			MIPS64_EF_R13
-#define EF_R14			MIPS64_EF_R14
-#define EF_R15			MIPS64_EF_R15
-#define EF_R16			MIPS64_EF_R16
-#define EF_R17			MIPS64_EF_R17
-#define EF_R18			MIPS64_EF_R18
-#define EF_R19			MIPS64_EF_R19
-#define EF_R20			MIPS64_EF_R20
-#define EF_R21			MIPS64_EF_R21
-#define EF_R22			MIPS64_EF_R22
-#define EF_R23			MIPS64_EF_R23
-#define EF_R24			MIPS64_EF_R24
-#define EF_R25			MIPS64_EF_R25
-#define EF_R26			MIPS64_EF_R26
-#define EF_R27			MIPS64_EF_R27
-#define EF_R28			MIPS64_EF_R28
-#define EF_R29			MIPS64_EF_R29
-#define EF_R30			MIPS64_EF_R30
-#define EF_R31			MIPS64_EF_R31
-#define EF_LO			MIPS64_EF_LO
-#define EF_HI			MIPS64_EF_HI
-#define EF_CP0_EPC		MIPS64_EF_CP0_EPC
-#define EF_CP0_BADVADDR		MIPS64_EF_CP0_BADVADDR
-#define EF_CP0_STATUS		MIPS64_EF_CP0_STATUS
-#define EF_CP0_CAUSE		MIPS64_EF_CP0_CAUSE
-#define EF_SIZE			MIPS64_EF_SIZE
-
-#endif /* CONFIG_64BIT */
-
-#endif /* __ASM_MIPS_REG_H */
+#include <uapi/asm/reg.h>
diff --git a/arch/mips/include/uapi/asm/reg.h b/arch/mips/include/uapi/asm/reg.h
new file mode 100644
index 0000000..432037c
--- /dev/null
+++ b/arch/mips/include/uapi/asm/reg.h
@@ -0,0 +1,206 @@
+/*
+ * Various register offset definitions for debuggers, core file
+ * examiners and whatnot.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 1995, 1999 Ralf Baechle
+ * Copyright (C) 1995, 1999 Silicon Graphics
+ */
+#ifndef __UAPI_ASM_MIPS_REG_H
+#define __UAPI_ASM_MIPS_REG_H
+
+#define MIPS32_EF_R0		6
+#define MIPS32_EF_R1		7
+#define MIPS32_EF_R2		8
+#define MIPS32_EF_R3		9
+#define MIPS32_EF_R4		10
+#define MIPS32_EF_R5		11
+#define MIPS32_EF_R6		12
+#define MIPS32_EF_R7		13
+#define MIPS32_EF_R8		14
+#define MIPS32_EF_R9		15
+#define MIPS32_EF_R10		16
+#define MIPS32_EF_R11		17
+#define MIPS32_EF_R12		18
+#define MIPS32_EF_R13		19
+#define MIPS32_EF_R14		20
+#define MIPS32_EF_R15		21
+#define MIPS32_EF_R16		22
+#define MIPS32_EF_R17		23
+#define MIPS32_EF_R18		24
+#define MIPS32_EF_R19		25
+#define MIPS32_EF_R20		26
+#define MIPS32_EF_R21		27
+#define MIPS32_EF_R22		28
+#define MIPS32_EF_R23		29
+#define MIPS32_EF_R24		30
+#define MIPS32_EF_R25		31
+
+/*
+ * k0/k1 unsaved
+ */
+#define MIPS32_EF_R26		32
+#define MIPS32_EF_R27		33
+
+#define MIPS32_EF_R28		34
+#define MIPS32_EF_R29		35
+#define MIPS32_EF_R30		36
+#define MIPS32_EF_R31		37
+
+/*
+ * Saved special registers
+ */
+#define MIPS32_EF_LO		38
+#define MIPS32_EF_HI		39
+
+#define MIPS32_EF_CP0_EPC	40
+#define MIPS32_EF_CP0_BADVADDR	41
+#define MIPS32_EF_CP0_STATUS	42
+#define MIPS32_EF_CP0_CAUSE	43
+#define MIPS32_EF_UNUSED0	44
+
+#define MIPS32_EF_SIZE		180
+
+#define MIPS64_EF_R0		0
+#define MIPS64_EF_R1		1
+#define MIPS64_EF_R2		2
+#define MIPS64_EF_R3		3
+#define MIPS64_EF_R4		4
+#define MIPS64_EF_R5		5
+#define MIPS64_EF_R6		6
+#define MIPS64_EF_R7		7
+#define MIPS64_EF_R8		8
+#define MIPS64_EF_R9		9
+#define MIPS64_EF_R10		10
+#define MIPS64_EF_R11		11
+#define MIPS64_EF_R12		12
+#define MIPS64_EF_R13		13
+#define MIPS64_EF_R14		14
+#define MIPS64_EF_R15		15
+#define MIPS64_EF_R16		16
+#define MIPS64_EF_R17		17
+#define MIPS64_EF_R18		18
+#define MIPS64_EF_R19		19
+#define MIPS64_EF_R20		20
+#define MIPS64_EF_R21		21
+#define MIPS64_EF_R22		22
+#define MIPS64_EF_R23		23
+#define MIPS64_EF_R24		24
+#define MIPS64_EF_R25		25
+
+/*
+ * k0/k1 unsaved
+ */
+#define MIPS64_EF_R26		26
+#define MIPS64_EF_R27		27
+
+
+#define MIPS64_EF_R28		28
+#define MIPS64_EF_R29		29
+#define MIPS64_EF_R30		30
+#define MIPS64_EF_R31		31
+
+/*
+ * Saved special registers
+ */
+#define MIPS64_EF_LO		32
+#define MIPS64_EF_HI		33
+
+#define MIPS64_EF_CP0_EPC	34
+#define MIPS64_EF_CP0_BADVADDR	35
+#define MIPS64_EF_CP0_STATUS	36
+#define MIPS64_EF_CP0_CAUSE	37
+
+#define MIPS64_EF_SIZE		304	/* size in bytes */
+
+#if _MIPS_SIM == _MIPS_SIM_ABI32
+
+#define EF_R0			MIPS32_EF_R0
+#define EF_R1			MIPS32_EF_R1
+#define EF_R2			MIPS32_EF_R2
+#define EF_R3			MIPS32_EF_R3
+#define EF_R4			MIPS32_EF_R4
+#define EF_R5			MIPS32_EF_R5
+#define EF_R6			MIPS32_EF_R6
+#define EF_R7			MIPS32_EF_R7
+#define EF_R8			MIPS32_EF_R8
+#define EF_R9			MIPS32_EF_R9
+#define EF_R10			MIPS32_EF_R10
+#define EF_R11			MIPS32_EF_R11
+#define EF_R12			MIPS32_EF_R12
+#define EF_R13			MIPS32_EF_R13
+#define EF_R14			MIPS32_EF_R14
+#define EF_R15			MIPS32_EF_R15
+#define EF_R16			MIPS32_EF_R16
+#define EF_R17			MIPS32_EF_R17
+#define EF_R18			MIPS32_EF_R18
+#define EF_R19			MIPS32_EF_R19
+#define EF_R20			MIPS32_EF_R20
+#define EF_R21			MIPS32_EF_R21
+#define EF_R22			MIPS32_EF_R22
+#define EF_R23			MIPS32_EF_R23
+#define EF_R24			MIPS32_EF_R24
+#define EF_R25			MIPS32_EF_R25
+#define EF_R26			MIPS32_EF_R26
+#define EF_R27			MIPS32_EF_R27
+#define EF_R28			MIPS32_EF_R28
+#define EF_R29			MIPS32_EF_R29
+#define EF_R30			MIPS32_EF_R30
+#define EF_R31			MIPS32_EF_R31
+#define EF_LO			MIPS32_EF_LO
+#define EF_HI			MIPS32_EF_HI
+#define EF_CP0_EPC		MIPS32_EF_CP0_EPC
+#define EF_CP0_BADVADDR		MIPS32_EF_CP0_BADVADDR
+#define EF_CP0_STATUS		MIPS32_EF_CP0_STATUS
+#define EF_CP0_CAUSE		MIPS32_EF_CP0_CAUSE
+#define EF_UNUSED0		MIPS32_EF_UNUSED0
+#define EF_SIZE			MIPS32_EF_SIZE
+
+#elif _MIPS_SIM == _MIPS_SIM_ABI64 || _MIPS_SIM == _MIPS_SIM_NABI32
+
+#define EF_R0			MIPS64_EF_R0
+#define EF_R1			MIPS64_EF_R1
+#define EF_R2			MIPS64_EF_R2
+#define EF_R3			MIPS64_EF_R3
+#define EF_R4			MIPS64_EF_R4
+#define EF_R5			MIPS64_EF_R5
+#define EF_R6			MIPS64_EF_R6
+#define EF_R7			MIPS64_EF_R7
+#define EF_R8			MIPS64_EF_R8
+#define EF_R9			MIPS64_EF_R9
+#define EF_R10			MIPS64_EF_R10
+#define EF_R11			MIPS64_EF_R11
+#define EF_R12			MIPS64_EF_R12
+#define EF_R13			MIPS64_EF_R13
+#define EF_R14			MIPS64_EF_R14
+#define EF_R15			MIPS64_EF_R15
+#define EF_R16			MIPS64_EF_R16
+#define EF_R17			MIPS64_EF_R17
+#define EF_R18			MIPS64_EF_R18
+#define EF_R19			MIPS64_EF_R19
+#define EF_R20			MIPS64_EF_R20
+#define EF_R21			MIPS64_EF_R21
+#define EF_R22			MIPS64_EF_R22
+#define EF_R23			MIPS64_EF_R23
+#define EF_R24			MIPS64_EF_R24
+#define EF_R25			MIPS64_EF_R25
+#define EF_R26			MIPS64_EF_R26
+#define EF_R27			MIPS64_EF_R27
+#define EF_R28			MIPS64_EF_R28
+#define EF_R29			MIPS64_EF_R29
+#define EF_R30			MIPS64_EF_R30
+#define EF_R31			MIPS64_EF_R31
+#define EF_LO			MIPS64_EF_LO
+#define EF_HI			MIPS64_EF_HI
+#define EF_CP0_EPC		MIPS64_EF_CP0_EPC
+#define EF_CP0_BADVADDR		MIPS64_EF_CP0_BADVADDR
+#define EF_CP0_STATUS		MIPS64_EF_CP0_STATUS
+#define EF_CP0_CAUSE		MIPS64_EF_CP0_CAUSE
+#define EF_SIZE			MIPS64_EF_SIZE
+
+#endif /* _MIPS_SIM == _MIPS_SIM_ABI64 || _MIPS_SIM == _MIPS_SIM_NABI32 */
+
+#endif /* __UAPI_ASM_MIPS_REG_H */
-- 
1.9.1
