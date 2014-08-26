Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Aug 2014 08:42:00 +0200 (CEST)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:55270 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006629AbaHZGl6AH8KA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Aug 2014 08:41:58 +0200
Received: by mail-pa0-f49.google.com with SMTP id hz1so22426577pad.8
        for <multiple recipients>; Mon, 25 Aug 2014 23:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=smMiAX+i+cS6THQzQbQzVzY9+iGGdUIfrVt3cXr1D4w=;
        b=vvO+mzGzjVPKr2fbt7dFqnuen98eRJPmVZJCaju9ZvJs++HoF8Gb9cL68GxqmcQHSl
         4/chaET5gNYSXQuxnk0p/L8cjIhsxECmvb3N15UAfFrRLsO3AySxhgvIMxjHaHLzBbjq
         yEEh3BJS2G0x06QpjGBGFuDNrTcb9BdFPU7g5kp0G0xTbxI9os6tprL5UrjBVSvXoK6B
         dn6intjga8WoBzkFTp4vDPBmI6rqQqON7BjO9FEk36JrKK3P51iPidnFJS/mTRPqGTGp
         4jhY2jn0WT9+tUt/puZ6YwGcfcbt2rGcBl2HzNwKJOJo54V07jKtunyzc7gf+MD4qE53
         tRbA==
X-Received: by 10.66.237.206 with SMTP id ve14mr14417128pac.40.1409035311295;
        Mon, 25 Aug 2014 23:41:51 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id u8sm3040705pdp.10.2014.08.25.23.41.43
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 25 Aug 2014 23:41:50 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        "Jayachandran C." <jchandra@broadcom.com>
Subject: [PATCH V2] MIPS: Move CPU topology macros to topology.h
Date:   Tue, 26 Aug 2014 14:41:31 +0800
Message-Id: <1409035291-11040-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42244
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

The correct position is topology.h, and this fix macros redefinition
problems for Netlogic.

V2: remove unnecessary #ifndefs.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Cc: Jayachandran C. <jchandra@broadcom.com>
---
 arch/mips/include/asm/smp.h      |    5 -----
 arch/mips/include/asm/topology.h |    5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/smp.h b/arch/mips/include/asm/smp.h
index 1e0f20a..eacf865 100644
--- a/arch/mips/include/asm/smp.h
+++ b/arch/mips/include/asm/smp.h
@@ -37,11 +37,6 @@ extern int __cpu_logical_map[NR_CPUS];
 
 #define NO_PROC_ID	(-1)
 
-#define topology_physical_package_id(cpu)	(cpu_data[cpu].package)
-#define topology_core_id(cpu)			(cpu_data[cpu].core)
-#define topology_core_cpumask(cpu)		(&cpu_core_map[cpu])
-#define topology_thread_cpumask(cpu)		(&cpu_sibling_map[cpu])
-
 #define SMP_RESCHEDULE_YOURSELF 0x1	/* XXX braindead */
 #define SMP_CALL_FUNCTION	0x2
 /* Octeon - Tell another core to flush its icache */
diff --git a/arch/mips/include/asm/topology.h b/arch/mips/include/asm/topology.h
index 20ea485..e012429 100644
--- a/arch/mips/include/asm/topology.h
+++ b/arch/mips/include/asm/topology.h
@@ -10,4 +10,9 @@
 
 #include <topology.h>
 
+#define topology_physical_package_id(cpu)	(cpu_data[cpu].package)
+#define topology_core_id(cpu)			(cpu_data[cpu].core)
+#define topology_core_cpumask(cpu)		(&cpu_core_map[cpu])
+#define topology_thread_cpumask(cpu)		(&cpu_sibling_map[cpu])
+
 #endif /* __ASM_TOPOLOGY_H */
-- 
1.7.7.3
