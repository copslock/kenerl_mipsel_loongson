Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jan 2016 20:47:28 +0100 (CET)
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33853 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011864AbcA1Tr0puRZy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Jan 2016 20:47:26 +0100
Received: by mail-oi0-f65.google.com with SMTP id s2so2470584oie.1;
        Thu, 28 Jan 2016 11:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=bR5HpmSxQKW/MGmEa/Dsw/u+wjaxg+oW4MgvB29cgF8=;
        b=ZjprvsI2P7DkEFUZj9+HEQWAVAxxa3zBbm0M51Ejap1LVOBEQZw7gvWlMYOMDX59w0
         v059Ww2p7zO9lUf94vHp5nEzjD84Gu+SUF1j4TQhZ6ODbv0rXz4tFPSvJVLHBQxf9uDG
         V0SL23tqMFy1DN1U55cRyLF6HzSGB4peRUYNTiZcpmGq2nLblFD5viJsZzXWVQKZFZN3
         Ai2KzkRggS1epOSQjUJwcnqxiBW/6/qtC2+vG0jDp7GJR/BZso1RMNWG4wdwetOjusGm
         f9KjXmUoU9VJA1BIo+tEKnqZZ4mD0SXQhvz3gVsU4NbBHTHOaF8MzWTf3655YMSNlbJp
         dFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bR5HpmSxQKW/MGmEa/Dsw/u+wjaxg+oW4MgvB29cgF8=;
        b=HawSw8+GFWIhTdVeBnlvlrNKg/OIBi44ZogieCUxyKkHq82bG8nZ7j+m88AgI7tQ7J
         rTzlzeqeqOwxu9Q3JE8XgObU9SB4ngMGyBsb1gXYovM8oW2QU5czlQpeU5Kob9YwMqhk
         c5WUxeuL2XlLdC5N0xOGwcohAMgChIGb7Gc9hsHUC4XLLkovfMabc7UKRP3I1FXlSJGG
         hnr0yiNkwTg0V0K1ltqQj/KHfMFrNlq0V/fxTeswXx8MAX5XZHzn4S5+Q2RBYvHzFcmt
         IaFXNbIX88xnTWPCYmRc2jQUNH/pr00lcaeI2k29nszE71X9fNd20cnc59BfA7xKT2Ic
         hpNg==
X-Gm-Message-State: AG10YOSPLYabFEB0BbUFrNGNGlqKz7/g0bSuK1+tF4yTUzpM2JIKeLArb/1xrCD1e9WRLw==
X-Received: by 10.202.173.210 with SMTP id w201mr3476179oie.1.1454010440837;
        Thu, 28 Jan 2016 11:47:20 -0800 (PST)
Received: from localhost.Home (97-126-249-174.slkc.qwest.net. [97.126.249.174])
        by smtp.googlemail.com with ESMTPSA id t74sm6238311oie.21.2016.01.28.11.47.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jan 2016 11:47:19 -0800 (PST)
From:   Jeffrey Merkey <jeffmerkey@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ralf@linux-mips.org, james.hogan@imgtec.com, linux.mdb@gmail.com,
        linux-mips@linux-mips.org
Subject: [PATCH 21/31] Add debugger entry points for MIPS
Date:   Thu, 28 Jan 2016 12:47:17 -0700
Message-Id: <1454010437-29265-1-git-send-email-jeffmerkey@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Return-Path: <jeffmerkey@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51512
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jeffmerkey@gmail.com
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

This patch series adds an export which can be set by system debuggers to
direct the hard lockup and soft lockup detector to trigger a breakpoint
exception and enter a debugger if one is active.  It is assumed that if
someone sets this variable, then an breakpoint handler of some sort will
be actively loaded or registered via the notify die handler chain.

This addition is extremely useful for debugging hard and soft lockups
real time and quickly from a console debugger.

Signed-off-by: Jeffrey Merkey <jeffmerkey@gmail.com>
---
 arch/mips/include/asm/kdebug.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/mips/include/asm/kdebug.h b/arch/mips/include/asm/kdebug.h
index 8e3d08e..af5999e 100644
--- a/arch/mips/include/asm/kdebug.h
+++ b/arch/mips/include/asm/kdebug.h
@@ -16,4 +16,16 @@ enum die_val {
 	DIE_UPROBE_XOL,
 };
 
+
+void arch_breakpoint(void)
+{
+	__asm__ __volatile__(
+		".globl breakinst\n\t"
+		".set\tnoreorder\n\t"
+		"nop\n"
+		"breakinst:\tbreak\n\t"
+		"nop\n\t"
+		".set\treorder");
+}
+
 #endif /* _ASM_MIPS_KDEBUG_H */
-- 
1.8.3.1
