Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 20:51:58 +0200 (CEST)
Received: from mail-yk0-f169.google.com ([209.85.160.169]:37658 "EHLO
        mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010743AbaJGSv5Q6wye (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2014 20:51:57 +0200
Received: by mail-yk0-f169.google.com with SMTP id 10so3157920ykt.28
        for <multiple recipients>; Tue, 07 Oct 2014 11:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Db12MzLhRY/9eu13o0cdw1kt8ntCkihA/jPvASHn0h4=;
        b=o3zG2i64zaDVchu33IsxkhVJfssygAoT70BnBNECEY5UCjoSqmy1xraAv1H0hjj499
         vFq8rfq29Jf6m99ShXilufh9KbAC0CXKy3bcqqc07t+8fN2V/2KqQKG2gNf6XP08FINF
         QZpiNOHgkGfXOiSOBjySv2ApniKAeTDPcw0pb7tCQga/mpjnTUFOhLniDqyzKztA5nSB
         nhVKIg92OliJCHUfS0NggC1o+ox7byMrkjIA5dWitUpAOXjjfbg7J2wBbgWdiiPG+tEX
         518W25m16snH6uI6Ey8CHqVQDArkbBN9oYeK6MnBMBFdwkVkgB6EKOmn1Ni4eZHp/1UW
         mdzQ==
X-Received: by 10.236.61.6 with SMTP id v6mr8107022yhc.32.1412707911198;
        Tue, 07 Oct 2014 11:51:51 -0700 (PDT)
Received: from t430.minyard.home (pool-173-57-152-84.dllstx.fios.verizon.net. [173.57.152.84])
        by mx.google.com with ESMTPSA id 26sm6037477yhw.51.2014.10.07.11.51.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Oct 2014 11:51:50 -0700 (PDT)
Received: from t430.minyard.home (t430.minyard.home [127.0.0.1])
        by t430.minyard.home (8.14.7/8.14.7) with ESMTP id s97IpdX3016113;
        Tue, 7 Oct 2014 13:51:49 -0500
Received: (from cminyard@localhost)
        by t430.minyard.home (8.14.7/8.14.7/Submit) id s97IpSUY016102;
        Tue, 7 Oct 2014 13:51:28 -0500
From:   minyard@acm.org
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Corey Minyard <cminyard@mvista.com>
Subject: [PATCH 2/3] Move generic dwarf2 operations from x86 to asm-generic
Date:   Tue,  7 Oct 2014 13:50:53 -0500
Message-Id: <1412707854-15555-3-git-send-email-minyard@acm.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1412707854-15555-1-git-send-email-minyard@acm.org>
References: <1412707854-15555-1-git-send-email-minyard@acm.org>
Return-Path: <tcminyard@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43079
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

A lot of arch/x86/include/asm/dwarf2.h was generic, move it to
asm-generic so other arches can get to it.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 arch/x86/include/asm/dwarf2.h | 74 +----------------------------------------
 include/asm-generic/dwarf2.h  | 77 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+), 73 deletions(-)
 create mode 100644 include/asm-generic/dwarf2.h

diff --git a/arch/x86/include/asm/dwarf2.h b/arch/x86/include/asm/dwarf2.h
index f6f1598..3360e2a 100644
--- a/arch/x86/include/asm/dwarf2.h
+++ b/arch/x86/include/asm/dwarf2.h
@@ -1,79 +1,7 @@
 #ifndef _ASM_X86_DWARF2_H
 #define _ASM_X86_DWARF2_H
 
-#ifndef __ASSEMBLY__
-#warning "asm/dwarf2.h should be only included in pure assembly files"
-#endif
-
-/*
- * Macros for dwarf2 CFI unwind table entries.
- * See "as.info" for details on these pseudo ops. Unfortunately
- * they are only supported in very new binutils, so define them
- * away for older version.
- */
-
-#ifdef CONFIG_AS_CFI
-
-#define CFI_STARTPROC		.cfi_startproc
-#define CFI_ENDPROC		.cfi_endproc
-#define CFI_DEF_CFA		.cfi_def_cfa
-#define CFI_DEF_CFA_REGISTER	.cfi_def_cfa_register
-#define CFI_DEF_CFA_OFFSET	.cfi_def_cfa_offset
-#define CFI_ADJUST_CFA_OFFSET	.cfi_adjust_cfa_offset
-#define CFI_OFFSET		.cfi_offset
-#define CFI_REL_OFFSET		.cfi_rel_offset
-#define CFI_REGISTER		.cfi_register
-#define CFI_RESTORE		.cfi_restore
-#define CFI_REMEMBER_STATE	.cfi_remember_state
-#define CFI_RESTORE_STATE	.cfi_restore_state
-#define CFI_UNDEFINED		.cfi_undefined
-#define CFI_ESCAPE		.cfi_escape
-
-#ifdef CONFIG_AS_CFI_SIGNAL_FRAME
-#define CFI_SIGNAL_FRAME	.cfi_signal_frame
-#else
-#define CFI_SIGNAL_FRAME
-#endif
-
-#if defined(CONFIG_AS_CFI_SECTIONS) && defined(__ASSEMBLY__)
-	/*
-	 * Emit CFI data in .debug_frame sections, not .eh_frame sections.
-	 * The latter we currently just discard since we don't do DWARF
-	 * unwinding at runtime.  So only the offline DWARF information is
-	 * useful to anyone.  Note we should not use this directive if this
-	 * file is used in the vDSO assembly, or if vmlinux.lds.S gets
-	 * changed so it doesn't discard .eh_frame.
-	 */
-	.cfi_sections .debug_frame
-#endif
-
-#else
-
-/*
- * Due to the structure of pre-exisiting code, don't use assembler line
- * comment character # to ignore the arguments. Instead, use a dummy macro.
- */
-.macro cfi_ignore a=0, b=0, c=0, d=0
-.endm
-
-#define CFI_STARTPROC		cfi_ignore
-#define CFI_ENDPROC		cfi_ignore
-#define CFI_DEF_CFA		cfi_ignore
-#define CFI_DEF_CFA_REGISTER	cfi_ignore
-#define CFI_DEF_CFA_OFFSET	cfi_ignore
-#define CFI_ADJUST_CFA_OFFSET	cfi_ignore
-#define CFI_OFFSET		cfi_ignore
-#define CFI_REL_OFFSET		cfi_ignore
-#define CFI_REGISTER		cfi_ignore
-#define CFI_RESTORE		cfi_ignore
-#define CFI_REMEMBER_STATE	cfi_ignore
-#define CFI_RESTORE_STATE	cfi_ignore
-#define CFI_UNDEFINED		cfi_ignore
-#define CFI_ESCAPE		cfi_ignore
-#define CFI_SIGNAL_FRAME	cfi_ignore
-
-#endif
-
+#include <asm-generic/dwarf2.h>
 /*
  * An attempt to make CFI annotations more or less
  * correct and shorter. It is implied that you know
diff --git a/include/asm-generic/dwarf2.h b/include/asm-generic/dwarf2.h
new file mode 100644
index 0000000..19a677f
--- /dev/null
+++ b/include/asm-generic/dwarf2.h
@@ -0,0 +1,77 @@
+#ifndef _ASM_GENERIC_DWARF2_H
+#define _ASM_GENERIC_DWARF2_H
+
+#ifndef __ASSEMBLY__
+#warning "asm/dwarf2.h should be only included in pure assembly files"
+#endif
+
+/*
+ * Macros for dwarf2 CFI unwind table entries.
+ * See "as.info" for details on these pseudo ops. Unfortunately
+ * they are only supported in very new binutils, so define them
+ * away for older version.
+ */
+
+#ifdef CONFIG_AS_CFI
+
+#define CFI_STARTPROC		.cfi_startproc
+#define CFI_ENDPROC		.cfi_endproc
+#define CFI_DEF_CFA		.cfi_def_cfa
+#define CFI_DEF_CFA_REGISTER	.cfi_def_cfa_register
+#define CFI_DEF_CFA_OFFSET	.cfi_def_cfa_offset
+#define CFI_ADJUST_CFA_OFFSET	.cfi_adjust_cfa_offset
+#define CFI_OFFSET		.cfi_offset
+#define CFI_REL_OFFSET		.cfi_rel_offset
+#define CFI_REGISTER		.cfi_register
+#define CFI_RESTORE		.cfi_restore
+#define CFI_REMEMBER_STATE	.cfi_remember_state
+#define CFI_RESTORE_STATE	.cfi_restore_state
+#define CFI_UNDEFINED		.cfi_undefined
+#define CFI_ESCAPE		.cfi_escape
+
+#ifdef CONFIG_AS_CFI_SIGNAL_FRAME
+#define CFI_SIGNAL_FRAME	.cfi_signal_frame
+#else
+#define CFI_SIGNAL_FRAME
+#endif
+
+#if defined(CONFIG_AS_CFI_SECTIONS) && defined(__ASSEMBLY__)
+	/*
+	 * Emit CFI data in .debug_frame sections, not .eh_frame sections.
+	 * The latter we currently just discard since we don't do DWARF
+	 * unwinding at runtime.  So only the offline DWARF information is
+	 * useful to anyone.  Note we should not use this directive if this
+	 * file is used in the vDSO assembly, or if vmlinux.lds.S gets
+	 * changed so it doesn't discard .eh_frame.
+	 */
+	.cfi_sections .debug_frame
+#endif
+
+#else
+
+/*
+ * Due to the structure of pre-exisiting code, don't use assembler line
+ * comment character # to ignore the arguments. Instead, use a dummy macro.
+ */
+.macro cfi_ignore a=0, b=0, c=0, d=0
+.endm
+
+#define CFI_STARTPROC		cfi_ignore
+#define CFI_ENDPROC		cfi_ignore
+#define CFI_DEF_CFA		cfi_ignore
+#define CFI_DEF_CFA_REGISTER	cfi_ignore
+#define CFI_DEF_CFA_OFFSET	cfi_ignore
+#define CFI_ADJUST_CFA_OFFSET	cfi_ignore
+#define CFI_OFFSET		cfi_ignore
+#define CFI_REL_OFFSET		cfi_ignore
+#define CFI_REGISTER		cfi_ignore
+#define CFI_RESTORE		cfi_ignore
+#define CFI_REMEMBER_STATE	cfi_ignore
+#define CFI_RESTORE_STATE	cfi_ignore
+#define CFI_UNDEFINED		cfi_ignore
+#define CFI_ESCAPE		cfi_ignore
+#define CFI_SIGNAL_FRAME	cfi_ignore
+
+#endif
+
+#endif /* _ASM_GENERIC_DWARF2_H */
-- 
1.8.3.1
