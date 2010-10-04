Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Oct 2010 20:57:11 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:19552 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491102Ab0JDS5H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Oct 2010 20:57:07 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4caa23a20002>; Mon, 04 Oct 2010 11:57:38 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 4 Oct 2010 11:57:10 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 4 Oct 2010 11:57:10 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o94Iv1vH024050;
        Mon, 4 Oct 2010 11:57:01 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o94Iv1Zn024049;
        Mon, 4 Oct 2010 11:57:01 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        jbaron@redhat.com
Cc:     David Daney <ddaney@caviumnetworks.com>,
        David Miller <davem@davemloft.net>
Subject: [PATCH v2 1/2] jump label: Make arch_jump_label_text_poke_early() optional
Date:   Mon,  4 Oct 2010 11:56:54 -0700
Message-Id: <1286218615-24011-2-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.2
In-Reply-To: <1286218615-24011-1-git-send-email-ddaney@caviumnetworks.com>
References: <1286218615-24011-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 04 Oct 2010 18:57:10.0123 (UTC) FILETIME=[F2C38BB0:01CB63F5]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27934
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

For the forthcoming MIPS jump label support,
arch_jump_label_text_poke_early() is unneeded as the MIPS NOP
instruction is already optimal.

Supply a default implementation that does nothing.  Flag x86 and SPARC
as having arch_jump_label_text_poke_early().

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Jason Baron <jbaron@redhat.com>
Cc: David Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/jump_label.h |    1 +
 arch/x86/include/asm/jump_label.h   |    1 +
 include/linux/jump_label.h          |    6 ++++++
 3 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/include/asm/jump_label.h b/arch/sparc/include/asm/jump_label.h
index 62e66d7..9aa82d7 100644
--- a/arch/sparc/include/asm/jump_label.h
+++ b/arch/sparc/include/asm/jump_label.h
@@ -6,6 +6,7 @@
 #include <linux/types.h>
 #include <asm/system.h>
 
+#define HAVE_ARCH_JUMP_LABEL_TEXT_POKE_EARLY
 #define JUMP_LABEL_NOP_SIZE 4
 
 #define JUMP_LABEL(key, label)					\
diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
index f52d42e..169cfd8 100644
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -6,6 +6,7 @@
 #include <linux/types.h>
 #include <asm/nops.h>
 
+#define HAVE_ARCH_JUMP_LABEL_TEXT_POKE_EARLY
 #define JUMP_LABEL_NOP_SIZE 5
 
 # define JUMP_LABEL_INITIAL_NOP ".byte 0xe9 \n\t .long 0\n\t"
diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index b72cd9f..e98ad3a 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -20,7 +20,13 @@ extern struct jump_entry __stop___jump_table[];
 
 extern void arch_jump_label_transform(struct jump_entry *entry,
 				 enum jump_label_type type);
+
+#ifdef HAVE_ARCH_JUMP_LABEL_TEXT_POKE_EARLY
 extern void arch_jump_label_text_poke_early(jump_label_t addr);
+#else
+static inline void arch_jump_label_text_poke_early(jump_label_t addr) {}
+#endif
+
 extern void jump_label_update(unsigned long key, enum jump_label_type type);
 extern void jump_label_apply_nops(struct module *mod);
 extern int jump_label_text_reserved(void *start, void *end);
-- 
1.7.2.2
