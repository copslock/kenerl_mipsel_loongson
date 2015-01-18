Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Jan 2015 23:42:21 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:10441 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011779AbbARWltb8XQi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Jan 2015 23:41:49 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 6229D71E1A06D;
        Sun, 18 Jan 2015 22:41:39 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Sun, 18 Jan 2015 22:41:43 +0000
Received: from localhost (192.168.159.114) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Sun, 18 Jan
 2015 22:41:38 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 27/36] MIPS: allow mach-provided serial.h
Date:   Sun, 18 Jan 2015 14:41:35 -0800
Message-ID: <1421620895-25211-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.2.1
In-Reply-To: <1421620067-23933-1-git-send-email-paul.burton@imgtec.com>
References: <1421620067-23933-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.114]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45276
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Allow platforms to set BAUD_BASE, which is used by earlycon to calculate
the baud clock.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/mips/include/asm/Kbuild                |  1 -
 arch/mips/include/asm/mach-generic/serial.h | 25 +++++++++++++++++++++++++
 arch/mips/include/asm/serial.h              | 25 +++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/include/asm/mach-generic/serial.h
 create mode 100644 arch/mips/include/asm/serial.h

diff --git a/arch/mips/include/asm/Kbuild b/arch/mips/include/asm/Kbuild
index 200efea..3cd9114 100644
--- a/arch/mips/include/asm/Kbuild
+++ b/arch/mips/include/asm/Kbuild
@@ -13,7 +13,6 @@ generic-y += preempt.h
 generic-y += scatterlist.h
 generic-y += sections.h
 generic-y += segment.h
-generic-y += serial.h
 generic-y += trace_clock.h
 generic-y += ucontext.h
 generic-y += user.h
diff --git a/arch/mips/include/asm/mach-generic/serial.h b/arch/mips/include/asm/mach-generic/serial.h
new file mode 100644
index 0000000..ed82ec8
--- /dev/null
+++ b/arch/mips/include/asm/mach-generic/serial.h
@@ -0,0 +1,25 @@
+/*
+ * Copyright (c) 2015 Imagination Technologies
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+ * MA 02111-1307 USA
+ */
+
+#ifndef __MACH_GENERIC_SERIAL_H__
+#define __MACH_GENERIC_SERIAL_H__
+
+#include <asm-generic/serial.h>
+
+#endif /* __MACH_GENERIC_SERIAL_H__ */
diff --git a/arch/mips/include/asm/serial.h b/arch/mips/include/asm/serial.h
new file mode 100644
index 0000000..5b83f9b
--- /dev/null
+++ b/arch/mips/include/asm/serial.h
@@ -0,0 +1,25 @@
+/*
+ * Copyright (c) 2015 Imagination Technologies
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+ * MA 02111-1307 USA
+ */
+
+#ifndef __ASM_SERIAL_H__
+#define __ASM_SERIAL_H__
+
+#include_next <serial.h>
+
+#endif /* __ASM_SERIAL_H__ */
-- 
2.2.1
