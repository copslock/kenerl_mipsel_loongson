Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Jul 2013 00:07:58 +0200 (CEST)
Received: from mail-pa0-f46.google.com ([209.85.220.46]:50853 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6831317Ab3G2WHQw7PlG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Jul 2013 00:07:16 +0200
Received: by mail-pa0-f46.google.com with SMTP id fa1so6411193pad.33
        for <multiple recipients>; Mon, 29 Jul 2013 15:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=IZx8rMnvZD3x/CuABzDsC0xWYMKboiAD/gxfQFlXa+U=;
        b=ulIKOb3ZmgUblJF4eqY9PYPUrlPjD6rAGFt86n4CxSKwqo9PfnRKTUpj6qEMnagShT
         BTSqqvZprNdw/6ECADeCkG4sf7nNfg0guhWFb1JsCO7+GhwTxRlgM5Wly3UJVD0Eiinj
         3qH6OWk3G0t9HYndlIjHcywPGx/vwIDqZend8jPiqwx45e96odISiedalzdsWLcpqrtf
         NNBadJiGujJOHbf+XGh0N6uSb5YNbnjJz450vjyWA3V1Nq6HE5MvJxJf4OPxfuJfN+5F
         lG7Eqm91c26Gy7jEnj2ek1GVF/5ICkMeWMJfo1PNk4XkW03WsZ8s7q/FIQPVQRM5K17G
         31EA==
X-Received: by 10.66.171.77 with SMTP id as13mr30900911pac.170.1375135630432;
        Mon, 29 Jul 2013 15:07:10 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id wr9sm79053499pbc.7.2013.07.29.15.07.08
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 29 Jul 2013 15:07:09 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r6TM774S030993;
        Mon, 29 Jul 2013 15:07:07 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r6TM77AJ030992;
        Mon, 29 Jul 2013 15:07:07 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH 1/5] MIPS: Add CPU identifiers for more OCTEON family members.
Date:   Mon, 29 Jul 2013 15:07:00 -0700
Message-Id: <1375135624-30950-2-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1375135624-30950-1-git-send-email-ddaney.cavm@gmail.com>
References: <1375135624-30950-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37395
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

Needed to support new SOCs.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/cpu.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index 632bbe5..c198615 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -141,6 +141,9 @@
 #define PRID_IMP_CAVIUM_CN68XX 0x9100
 #define PRID_IMP_CAVIUM_CN66XX 0x9200
 #define PRID_IMP_CAVIUM_CN61XX 0x9300
+#define PRID_IMP_CAVIUM_CNF71XX 0x9400
+#define PRID_IMP_CAVIUM_CN78XX 0x9500
+#define PRID_IMP_CAVIUM_CN70XX 0x9600
 
 /*
  * These are the PRID's for when 23:16 == PRID_COMP_INGENIC
@@ -272,7 +275,7 @@ enum cpu_type_enum {
 	 */
 	CPU_5KC, CPU_5KE, CPU_20KC, CPU_25KF, CPU_SB1, CPU_SB1A, CPU_LOONGSON2,
 	CPU_CAVIUM_OCTEON, CPU_CAVIUM_OCTEON_PLUS, CPU_CAVIUM_OCTEON2,
-	CPU_XLR, CPU_XLP,
+	CPU_CAVIUM_OCTEON3, CPU_XLR, CPU_XLP,
 
 	CPU_LAST
 };
-- 
1.7.11.7
