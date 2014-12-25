Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Dec 2014 19:03:22 +0100 (CET)
Received: from mail-pa0-f45.google.com ([209.85.220.45]:60569 "EHLO
        mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009916AbaLYR5inolno (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Dec 2014 18:57:38 +0100
Received: by mail-pa0-f45.google.com with SMTP id lf10so12052205pab.4;
        Thu, 25 Dec 2014 09:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qtZgFXamabCUYeps+RiV+ikhsJuRiwWoyKYOk8/eovM=;
        b=ZeooPMWhFLq/oRNZs2HVz+86UrKZHEbKuXA5FEXLcxR/9OGIqvbMyIuJhlH4Fl+ZUh
         43Pv8AxARtZQJHgULdnPZnG2BJ5qR3ptDdc4sQ18rzw65pXK14ELwv1bsPHUwdTWv6up
         ByNSEs9YKRioiVCbTO+aGGJFkbAK989SA5TRSfzfcnLJJwwo6msC7SxDmfneIsB0Lhnp
         s03FYMueEKmUqOtn0JbxssxUvgFLOfEzyzOAXuNAhu56UiEKsgbqdTFOWn9oxkP7yNI6
         sP/GTxIG+7gMMrFltuEVc0unQH8Hqd3xtlgKWvsXK6za86+LTkJxiatT1OOeJW60UOUV
         vQYQ==
X-Received: by 10.66.121.132 with SMTP id lk4mr3604663pab.33.1419530252923;
        Thu, 25 Dec 2014 09:57:32 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id e9sm25964046pdp.59.2014.12.25.09.57.31
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 25 Dec 2014 09:57:32 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, jaedon.shin@gmail.com, abrestic@chromium.org,
        tglx@linutronix.de, jason@lakedaemon.net, jogo@openwrt.org,
        arnd@arndb.de, computersforpeace@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V6 21/25] MIPS: BMIPS: Use a non-default FIXADDR_TOP setting
Date:   Thu, 25 Dec 2014 09:49:16 -0800
Message-Id: <1419529760-9520-22-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1419529760-9520-1-git-send-email-cernekee@gmail.com>
References: <1419529760-9520-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44931
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
