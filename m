Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Jul 2014 16:06:11 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:36196 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6861527AbaGUNgUf5aiP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Jul 2014 15:36:20 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 9B21FAEC4C3D9
        for <linux-mips@linux-mips.org>; Mon, 21 Jul 2014 14:36:09 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Mon, 21 Jul
 2014 14:36:12 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 21 Jul 2014 14:36:12 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.145) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 21 Jul 2014 14:36:11 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 1/3] MIPS: EVA: Add new EVA header
Date:   Mon, 21 Jul 2014 14:35:54 +0100
Message-ID: <1405949756-10427-2-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1405949756-10427-1-git-send-email-markos.chandras@imgtec.com>
References: <1405949756-10427-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.145]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41358
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

Generic code may need to perform certain operations when EVA is
enabled, for example, configure the segmentation registers during
boot. In order to avoid using more CONFIG_EVA ifdefs in the arch code,
such functions will be added in this header instead.
Initially this header contains a macro which will be used by generic
code later on during VPEs configuration on secondary cores.
All it does is to call the platform specific EVA init code in case
EVA is enabled.

Reviewed-by: Paul Burton <paul.burton@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/eva.h | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 arch/mips/include/asm/eva.h

diff --git a/arch/mips/include/asm/eva.h b/arch/mips/include/asm/eva.h
new file mode 100644
index 000000000000..a3d1807f227c
--- /dev/null
+++ b/arch/mips/include/asm/eva.h
@@ -0,0 +1,43 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2014, Imagination Technologies Ltd.
+ *
+ * EVA functions for generic code
+ */
+
+#ifndef _ASM_EVA_H
+#define _ASM_EVA_H
+
+#include <kernel-entry-init.h>
+
+#ifdef __ASSEMBLY__
+
+#ifdef CONFIG_EVA
+
+/*
+ * EVA early init code
+ *
+ * Platforms must define their own 'platform_eva_init' macro in
+ * their kernel-entry-init.h header. This macro usually does the
+ * platform specific configuration of the segmentation registers,
+ * and it is normally called from assembly code.
+ *
+ */
+
+.macro eva_init
+platform_eva_init
+.endm
+
+#else
+
+.macro eva_init
+.endm
+
+#endif /* CONFIG_EVA */
+
+#endif /* __ASSEMBLY__ */
+
+#endif
-- 
2.0.0
