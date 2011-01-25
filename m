Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Jan 2011 09:07:17 +0100 (CET)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:53828 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491148Ab1AYIHO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Jan 2011 09:07:14 +0100
Received: by gyg4 with SMTP id 4so1622752gyg.36
        for <multiple recipients>; Tue, 25 Jan 2011 00:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=PY0NgWqnopckUl3friSHBiz8CO7MDa48SB3YIg/i3i4=;
        b=elO/2othGuEEU/Akc6VeLCxjI9eYTTcpoq/0JOCShiwHhA+0KCNayPud0QgS/6cP6K
         C4JVCCACl2MjQr0+vsefjT9gplvavu1JNusB1jeRe41vYj699hJvWdUsNW7ZesB62pkM
         ngLBC4b/+v9RX3el02D4Q+vWctLKgzKgiUzCM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=tD7MUjn/umaj6PfGqK/KW3YxEKwzdYGUp+rCAVt4HdMmUv9gp/77PkzvSNXc8uegXp
         CaTaKKwHPStw8UmefRUgK772frtjeMAixNRmdkeW9QUCwRR8KcSpWSE2ORBTC1BEnkem
         iypnwysTOYKwvYKJ2AMiNiMvfgedOPTo49aMw=
Received: by 10.91.81.12 with SMTP id i12mr6538846agl.21.1295942827390;
        Tue, 25 Jan 2011 00:07:07 -0800 (PST)
Received: from localhost.localdomain ([59.160.135.215])
        by mx.google.com with ESMTPS id 35sm17407663ano.11.2011.01.25.00.07.04
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 25 Jan 2011 00:07:06 -0800 (PST)
From:   "Anoop P.A" <anoop.pa@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     Anoop P A <anoop.pa@gmail.com>
Subject: [PATCH 6/6] Cpu features overrides for msp platforms.
Date:   Tue, 25 Jan 2011 13:53:17 +0530
Message-Id: <1295943797-20467-1-git-send-email-anoop.pa@gmail.com>
X-Mailer: git-send-email 1.7.0.4
Return-Path: <anoop.pa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29075
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anoop.pa@gmail.com
Precedence: bulk
X-list: linux-mips

From: Anoop P A <anoop.pa@gmail.com>


Signed-off-by: Anoop P A <anoop.pa@gmail.com>
---
 .../asm/pmc-sierra/msp71xx/cpu-feature-overrides.h |   21 ++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/pmc-sierra/msp71xx/cpu-feature-overrides.h

diff --git a/arch/mips/include/asm/pmc-sierra/msp71xx/cpu-feature-overrides.h b/arch/mips/include/asm/pmc-sierra/msp71xx/cpu-feature-overrides.h
new file mode 100644
index 0000000..a80801b
--- /dev/null
+++ b/arch/mips/include/asm/pmc-sierra/msp71xx/cpu-feature-overrides.h
@@ -0,0 +1,21 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2003, 04, 07 Ralf Baechle (ralf@linux-mips.org)
+ */
+#ifndef __ASM_MACH_MSP71XX_CPU_FEATURE_OVERRIDES_H
+#define __ASM_MACH_MSP71XX_CPU_FEATURE_OVERRIDES_H
+
+#define cpu_has_mips16		1
+#define cpu_has_dsp		1
+#define cpu_has_mipsmt		1
+#define cpu_has_fpu		0
+
+#define cpu_has_mips32r1	0
+#define cpu_has_mips32r2	1
+#define cpu_has_mips64r1	0
+#define cpu_has_mips64r2	0
+
+#endif /* __ASM_MACH_MSP71XX_CPU_FEATURE_OVERRIDES_H */
-- 
1.7.0.4
