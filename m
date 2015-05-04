Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 May 2015 21:10:41 +0200 (CEST)
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33224 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011137AbbEDTKYw7d5S (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 May 2015 21:10:24 +0200
Received: by pacwv17 with SMTP id wv17so168804819pac.0;
        Mon, 04 May 2015 12:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uXMNFC5PLGMrrkRq0njxbw1BTUQ53b6EjfAPp/xy0FY=;
        b=aGE1IRkccZ454JFhox9hPk9kRaHIW7MIxCoPDESYkFXsiYhd2Bk7ZefzINVFXwMp69
         3Z8pyzQ0ExG4rzbjHY5JScahwdoci++2PEfIvRJaR3dOn0hL1iC6wiJTz3i8ml88u9Ra
         L7IxaPj36IFVauZBXtR/reRhBgC1N/mMpghkTakMXyOJl2dzsihGczYHCm92zhAOJ85i
         SFNSYpUiLLEP/ANFyOq3aEwvjKGPFYjDUwk5R6ubzP42By2nG61QN1zkRoBvi+LhFtGn
         yOtmeZQ651X3skJT66KCjaDgymZn5nLfk8n28pql4Rn7gYpjxqftXti8i2xEDVoaiSR8
         keBw==
X-Received: by 10.66.162.74 with SMTP id xy10mr24812832pab.55.1430766620868;
        Mon, 04 May 2015 12:10:20 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id vi5sm13503820pbc.89.2015.05.04.12.10.19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 May 2015 12:10:20 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, blogic@openwrt.org, cernekee@chromium.org,
        jogo@openwrt.org, Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 1/2] MIPS: BMIPS: Define BMIPS_FIXADDR_TOP in asm/bmips-spaces.h
Date:   Mon,  4 May 2015 12:09:43 -0700
Message-Id: <1430766584-8429-2-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1430766584-8429-1-git-send-email-f.fainelli@gmail.com>
References: <1430766584-8429-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47231
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

The FIXADDR_TOP value used by mach-bmips is in fact required whenever we
run on BMIPS3300 BMIPS CPUs, and is not machine, but CPU-specific, move
this constant to asm/bmips-spaces.h and use it in mach-bmips/spaces.h.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/include/asm/bmips-spaces.h      | 7 +++++++
 arch/mips/include/asm/mach-bmips/spaces.h | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/include/asm/bmips-spaces.h

diff --git a/arch/mips/include/asm/bmips-spaces.h b/arch/mips/include/asm/bmips-spaces.h
new file mode 100644
index 000000000000..eb96541ae67e
--- /dev/null
+++ b/arch/mips/include/asm/bmips-spaces.h
@@ -0,0 +1,7 @@
+#ifndef __ASM_BMIPS_SPACES_H
+#define __ASM_BMIPS_SPACES_H
+
+/* Avoid collisions with system base register (SBR) region on BMIPS3300 */
+#define FIXADDR_TOP		((unsigned long)(long)(int)0xff000000)
+
+#endif /* __ASM_BMIPS_SPACES_H */
diff --git a/arch/mips/include/asm/mach-bmips/spaces.h b/arch/mips/include/asm/mach-bmips/spaces.h
index 1b05bddc8ec5..c59b28fd9e1d 100644
--- a/arch/mips/include/asm/mach-bmips/spaces.h
+++ b/arch/mips/include/asm/mach-bmips/spaces.h
@@ -11,7 +11,7 @@
 #define _ASM_BMIPS_SPACES_H
 
 /* Avoid collisions with system base register (SBR) region on BMIPS3300 */
-#define FIXADDR_TOP		((unsigned long)(long)(int)0xff000000)
+#include <asm/bmips-spaces.h>
 
 #include <asm/mach-generic/spaces.h>
 
-- 
2.1.0
