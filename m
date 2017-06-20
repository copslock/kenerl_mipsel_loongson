Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jun 2017 22:39:57 +0200 (CEST)
Received: from mail-pf0-x242.google.com ([IPv6:2607:f8b0:400e:c00::242]:32830
        "EHLO mail-pf0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992143AbdFTUjujs36k (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Jun 2017 22:39:50 +0200
Received: by mail-pf0-x242.google.com with SMTP id w12so25779040pfk.0;
        Tue, 20 Jun 2017 13:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=sp8LLuwnRdZ3MjD4hpL+/jjWxlWc0+/QexAaLmZpAUA=;
        b=YzSubVa6qfGapAh3styIbPypdwA0lKv+iVwnsKd9zDhv+pp/RXehhsYUoQimTftz2f
         V2+V76DzM4WeSgpiy9pE9FuWZgwY4AmHHovCobfAOEsPhOXZUM2EUSECqIkg/62ByaHe
         1jx+jPfXorAe+V5pMYw4yVWBruCIJwGKh5/umMxIr0PDOXRn4JFcCQfh1RLsDHTQ5jz/
         c6pVqN0dpeKjJct9vk26f0Q9XBqA2Dg+rWJH5XDjSVxUCs4r2K/NEf8Zs7+RKF1jrl13
         JCoMmAw+2ZtrPR/1WNuvdgv6LLs1M/WvC8+KXzSqphcMRs+9kg0z8IPOPa2J8XcdXa/w
         pIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=sp8LLuwnRdZ3MjD4hpL+/jjWxlWc0+/QexAaLmZpAUA=;
        b=srD+5QCxPGKKbo0rJRSGy5OjypqHvnesb4e346kCIze3GW7Sn1vanqQ33Q6e+QnMhe
         Lyxpni94ebCbYsU7w3bV55JNYSuA5cIiZh+WUStGAaCIUptbQBKuZmC/qzhPWzi4BDzw
         WYbcMde3LLJUOVsdv17o0R0n8hLxwbhP7XhN920XatJoik5ICbvA2XgtAT8VRqvl1PoO
         hv84tFbuD2PYsTN7UfUIsptz0qFUaSXXtp2wSfqjijqbJstXGAAXj3vQMpZubQPAtOul
         A1zCAOYBScCe/DyfEKypJF3KTVvpl8UByLKO1UmSY6g19uxSlFY2rCztdI5YdtbxGkMW
         yQVg==
X-Gm-Message-State: AKS2vOw/efqWLXil4C7koaX1ASVEe16wcE6/Qtqtfiy8QU+BPysp3S+p
        1XzHWco6QTxWzA==
X-Received: by 10.99.123.18 with SMTP id w18mr22114711pgc.122.1497991184440;
        Tue, 20 Jun 2017 13:39:44 -0700 (PDT)
Received: from serve.minyard.net ([47.184.154.34])
        by smtp.gmail.com with ESMTPSA id z69sm31446940pff.0.2017.06.20.13.39.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jun 2017 13:39:42 -0700 (PDT)
Received: from t430.minyard.net (t430m.minyard.net [192.168.27.3])
        by serve.minyard.net (Postfix) with ESMTPA id E9F7F6CA;
        Tue, 20 Jun 2017 15:39:40 -0500 (CDT)
Received: by t430.minyard.net (Postfix, from userid 1000)
        id 55397300038; Tue, 20 Jun 2017 15:39:40 -0500 (CDT)
From:   minyard@acm.org
To:     Ralf Baechle <ralf@linux-mips.org>,
        Alex Smith <alex@alex-smith.me.uk>
Cc:     linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>,
        Corey Minyard <cminyard@mvista.com>
Subject: [PATCH] Partially revert "MIPS: Remove old core dump functions"
Date:   Tue, 20 Jun 2017 15:39:25 -0500
Message-Id: <1497991165-31361-1-git-send-email-minyard@acm.org>
X-Mailer: git-send-email 2.7.4
Return-Path: <tcminyard@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58709
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: minyard@acm.org
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

From: Corey Minyard <cminyard@mvista.com>

This reverts part of commit 30852ad0039b4a54b5062efd66877125e519dc30,
which removed some ELF coredump functions from MIPS.  They are no
longer needed for normal coredumps, but they are still needed for
kdump.  The kernel crashes when doing a kdump shutdown because
elf_core_copy_kernel_regs() needs a MIPS-specific version and the
reverted commit removes it.

This change adds back in ELF_CORE_COPY_REGS() and the required
support for it.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 arch/mips/include/asm/elf.h |  7 +++++++
 arch/mips/kernel/process.c  | 22 ++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/mips/include/asm/elf.h b/arch/mips/include/asm/elf.h
index 2b3dc29..600db7b 100644
--- a/arch/mips/include/asm/elf.h
+++ b/arch/mips/include/asm/elf.h
@@ -414,6 +414,13 @@ do {									\
 
 #endif /* CONFIG_64BIT */
 
+struct pt_regs;
+
+extern void elf_dump_regs(elf_greg_t *, struct pt_regs *regs);
+
+#define ELF_CORE_COPY_REGS(elf_regs, regs)                     \
+       elf_dump_regs((elf_greg_t *)&(elf_regs), regs);
+
 #define CORE_DUMP_USE_REGSET
 #define ELF_EXEC_PAGESIZE	PAGE_SIZE
 
diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index fbbf5fc..0d63aa1 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -180,6 +180,28 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	return 0;
 }
 
+void elf_dump_regs(elf_greg_t *gp, struct pt_regs *regs)
+{
+	int i;
+
+	for (i = 0; i < EF_R0; i++)
+		gp[i] = 0;
+	gp[EF_R0] = 0;
+	for (i = 1; i <= 31; i++)
+		gp[EF_R0 + i] = regs->regs[i];
+	gp[EF_R26] = 0;
+	gp[EF_R27] = 0;
+	gp[EF_LO] = regs->lo;
+	gp[EF_HI] = regs->hi;
+	gp[EF_CP0_EPC] = regs->cp0_epc;
+	gp[EF_CP0_BADVADDR] = regs->cp0_badvaddr;
+	gp[EF_CP0_STATUS] = regs->cp0_status;
+	gp[EF_CP0_CAUSE] = regs->cp0_cause;
+#ifdef EF_UNUSED0
+	gp[EF_UNUSED0] = 0;
+#endif
+}
+
 #ifdef CONFIG_CC_STACKPROTECTOR
 #include <linux/stackprotector.h>
 unsigned long __stack_chk_guard __read_mostly;
-- 
2.7.4
