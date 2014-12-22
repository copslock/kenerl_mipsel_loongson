Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Dec 2014 03:33:10 +0100 (CET)
Received: from mail-pd0-f178.google.com ([209.85.192.178]:46365 "EHLO
        mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009502AbaLVCcyResJF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Dec 2014 03:32:54 +0100
Received: by mail-pd0-f178.google.com with SMTP id r10so4900397pdi.37;
        Sun, 21 Dec 2014 18:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M3hksW3VAziDj/DxUcWrl2cX4N9yqxXEFlJ+FiY/vDA=;
        b=xmH6btpbpUuJP4SUrEnwFODIFJkfCSauxMSzWP4JlHZ18pExOmLalTnc+EnYffWwQk
         GgN3Xtc6vpl6OG7xuwIDxU2oXNT2rR1IsSGSxOl6Qg3PXXAt26bt/J4mOWX1LM2Bsi6c
         c4wAD6l4EAO/ildVMNQ5iD+u08ErkGK7JbY7ZudTj+Tz0CHpN9tkykUNm5RF5B5sxDEW
         KkZzMrHevEW+EteWth9JHNoJHwInuV/7PkuNXXrUhNEzjVbLDMQmkFRYYGX8Cf/ZqLtn
         5dOTPhYpmAPjHONkvM9syGx3ZRaWhuvQa9kpuulmo0vYK6TYk1FsGubMgKJvdaiDw6qc
         b6nA==
X-Received: by 10.70.129.48 with SMTP id nt16mr30596394pdb.113.1419215568324;
        Sun, 21 Dec 2014 18:32:48 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id sp6sm15735176pac.42.2014.12.21.18.32.46
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 21 Dec 2014 18:32:47 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH 2/2] MIPS: Hibernate: Restructure files and functions
Date:   Mon, 22 Dec 2014 10:30:39 +0800
Message-Id: <1419215439-27900-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1419215439-27900-1-git-send-email-chenhc@lemote.com>
References: <1419215439-27900-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44889
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

This patch has no functional changes, it just to keep the assembler
code to a minimum. Files and functions naming is borrowed from X86.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/power/Makefile                         |    2 +-
 arch/mips/power/hibernate.c                      |   10 ++++++++++
 arch/mips/power/{hibernate.S => hibernate_asm.S} |    6 ++----
 3 files changed, 13 insertions(+), 5 deletions(-)
 create mode 100644 arch/mips/power/hibernate.c
 rename arch/mips/power/{hibernate.S => hibernate_asm.S} (90%)

diff --git a/arch/mips/power/Makefile b/arch/mips/power/Makefile
index 73d56b8..70bd788 100644
--- a/arch/mips/power/Makefile
+++ b/arch/mips/power/Makefile
@@ -1 +1 @@
-obj-$(CONFIG_HIBERNATION) += cpu.o hibernate.o
+obj-$(CONFIG_HIBERNATION) += cpu.o hibernate.o hibernate_asm.o
diff --git a/arch/mips/power/hibernate.c b/arch/mips/power/hibernate.c
new file mode 100644
index 0000000..19a9af6
--- /dev/null
+++ b/arch/mips/power/hibernate.c
@@ -0,0 +1,10 @@
+#include <asm/tlbflush.h>
+
+extern int restore_image(void);
+
+int swsusp_arch_resume(void)
+{
+	/* Avoid TLB mismatch during and after kernel resume */
+	local_flush_tlb_all();
+	return restore_image();
+}
diff --git a/arch/mips/power/hibernate.S b/arch/mips/power/hibernate_asm.S
similarity index 90%
rename from arch/mips/power/hibernate.S
rename to arch/mips/power/hibernate_asm.S
index e7567c8..b1fab95 100644
--- a/arch/mips/power/hibernate.S
+++ b/arch/mips/power/hibernate_asm.S
@@ -29,9 +29,7 @@ LEAF(swsusp_arch_suspend)
 	j swsusp_save
 END(swsusp_arch_suspend)
 
-LEAF(swsusp_arch_resume)
-	/* Avoid TLB mismatch during and after kernel resume */
-	jal local_flush_tlb_all
+LEAF(restore_image)
 	PTR_L t0, restore_pblist
 0:
 	PTR_L t1, PBE_ADDRESS(t0)   /* source */
@@ -60,4 +58,4 @@ LEAF(swsusp_arch_resume)
 	PTR_L s7, PT_R23(t0)
 	PTR_LI v0, 0x0
 	jr ra
-END(swsusp_arch_resume)
+END(restore_image)
-- 
1.7.7.3
