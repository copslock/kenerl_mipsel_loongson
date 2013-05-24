Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 May 2013 23:55:23 +0200 (CEST)
Received: from mail-pa0-f44.google.com ([209.85.220.44]:51285 "EHLO
        mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835045Ab3EXVyXbbNxO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 May 2013 23:54:23 +0200
Received: by mail-pa0-f44.google.com with SMTP id wp1so2183092pac.17
        for <multiple recipients>; Fri, 24 May 2013 14:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=mddbPFGJeCnmstOI6k3iAwmS7tUTi3E5AWcsZpKG54I=;
        b=Ea+mXqRO8goxN9xR6pOhLZ0PPxA/86SF4ydRb3NuGDpmKAyqlyfnWMoimfIXOrjENm
         w5cyD84TVA/3qq2WbdbieLCU5qYHONGsJOlmU6eDUBd6/tvPOaNBJH7KDejbd+vAbmpP
         WDESgD2e5v/+ukYaunDw03GA8dcAb3Fy7hkJvHMIyvN553rwhJvhlMHs1XUCNPqr/wqk
         a1xYsUGLPgfbhWVrL4WjVwR6eEE3zNiGCkBQqZv6wIDYz3haZMoIOD+BvzrBHnpPHA1h
         iY/JDxJB5r1+kS28uyDmRt31lLVM3vZg6DXpfpz+vQjZIW+/XYMn1KtBEv9MwQblcdEu
         fwag==
X-Received: by 10.66.159.234 with SMTP id xf10mr20137582pab.203.1369432456988;
        Fri, 24 May 2013 14:54:16 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id ea15sm19002020pad.16.2013.05.24.14.54.15
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 14:54:16 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r4OLsElo013632;
        Fri, 24 May 2013 14:54:14 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r4OLsEeh013631;
        Fri, 24 May 2013 14:54:14 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>,
        Jonas Gorski <jogo@openwrt.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>
Subject: [PATCH 3/3] MIPS: Only set cpu_has_mmips if SYS_SUPPORTS_MICROMIPS
Date:   Fri, 24 May 2013 14:54:10 -0700
Message-Id: <1369432450-13583-4-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1369432450-13583-1-git-send-email-ddaney.cavm@gmail.com>
References: <1369432450-13583-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36594
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

As Jonas Gorske said in his patch:

   Disable cpu_has_mmips for everything but SEAD3 and MALTA. Most of
   these platforms are from before the micromips introduction, so they
   are very unlikely to implement it.

   Reduces an -Os compiled, uncompressed kernel image by 8KiB for
   BCM63XX.

This patch taks a different approach than his, we gate the runtime
test for microMIPS by the config symbol SYS_SUPPORTS_MICROMIPS.

Signed-off-by: David Daney <david.daney@cavium.com>
Cc: Jonas Gorski <jogo@openwrt.org>
Cc: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/include/asm/cpu-features.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index e5ec8fc..2cdfd24 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -99,7 +99,11 @@
 #define cpu_has_rixi		(cpu_data[0].options & MIPS_CPU_RIXI)
 #endif
 #ifndef cpu_has_mmips
-#define cpu_has_mmips		(cpu_data[0].options & MIPS_CPU_MICROMIPS)
+# ifdef CONFIG_SYS_SUPPORTS_MICROMIPS
+#  define cpu_has_mmips		(cpu_data[0].options & MIPS_CPU_MICROMIPS)
+# else
+#  define cpu_has_mmips		0
+# endif
 #endif
 #ifndef cpu_has_vtag_icache
 #define cpu_has_vtag_icache	(cpu_data[0].icache.flags & MIPS_CACHE_VTAG)
-- 
1.7.11.7
