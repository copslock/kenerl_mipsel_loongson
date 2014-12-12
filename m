Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Dec 2014 23:13:42 +0100 (CET)
Received: from mail-pd0-f178.google.com ([209.85.192.178]:40512 "EHLO
        mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008610AbaLLWIuJEigJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Dec 2014 23:08:50 +0100
Received: by mail-pd0-f178.google.com with SMTP id r10so7984441pdi.9
        for <multiple recipients>; Fri, 12 Dec 2014 14:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qtZgFXamabCUYeps+RiV+ikhsJuRiwWoyKYOk8/eovM=;
        b=g+kk/fxnxbtbWJGzg/Sg1N8Hp0U4D9zelrS/i5HMHPvU2IKmgQp5QIpzNXYDikW2fE
         GjoYEMR8L6lPzVBEAyRjRMkRkiPti3LsOZ0r6UdZefkiRYTOwOHvqDVy5yS9ESHOlAlp
         ABfrHEJscOB/yrMh3nA2+A3V4zt+Q1foopr7M0LlSbxqnE/Zml3dVnrCMUCjHYIh/s0k
         onNbJqorFgS/VYXtithx5oUJr+kcw/fJrFX3dAcMjDGHWQWRuu6CIYloiRFZov3Y8WnI
         EhslRGZAnm4+YNj/DIMnZ/rBVn7F9vwcGMGK8S7XI85/+Rm9POD3pfr1Libtub56sOux
         fX0g==
X-Received: by 10.66.166.39 with SMTP id zd7mr30841335pab.11.1418422124490;
        Fri, 12 Dec 2014 14:08:44 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id tm3sm2425841pac.12.2014.12.12.14.08.43
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 12 Dec 2014 14:08:43 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, tglx@linutronix.de, jason@lakedaemon.net,
        jogo@openwrt.org, arnd@arndb.de, computersforpeace@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V5 19/23] MIPS: BMIPS: Use a non-default FIXADDR_TOP setting
Date:   Fri, 12 Dec 2014 14:07:10 -0800
Message-Id: <1418422034-17099-20-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1418422034-17099-1-git-send-email-cernekee@gmail.com>
References: <1418422034-17099-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44657
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

This will be required to support BMIPS3300 platforms.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/include/asm/mach-bmips/spaces.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 arch/mips/include/asm/mach-bmips/spaces.h

diff --git a/arch/mips/include/asm/mach-bmips/spaces.h b/arch/mips/include/asm/mach-bmips/spaces.h
new file mode 100644
index 0000000..1b05bdd
--- /dev/null
+++ b/arch/mips/include/asm/mach-bmips/spaces.h
@@ -0,0 +1,18 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 1994 - 1999, 2000, 03, 04 Ralf Baechle
+ * Copyright (C) 2000, 2002  Maciej W. Rozycki
+ * Copyright (C) 1990, 1999, 2000 Silicon Graphics, Inc.
+ */
+#ifndef _ASM_BMIPS_SPACES_H
+#define _ASM_BMIPS_SPACES_H
+
+/* Avoid collisions with system base register (SBR) region on BMIPS3300 */
+#define FIXADDR_TOP		((unsigned long)(long)(int)0xff000000)
+
+#include <asm/mach-generic/spaces.h>
+
+#endif /* __ASM_BMIPS_SPACES_H */
-- 
2.1.1
