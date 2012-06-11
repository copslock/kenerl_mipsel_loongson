Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jun 2012 11:36:45 +0200 (CEST)
Received: from cpsmtpb-ews05.kpnxchange.com ([213.75.39.8]:1860 "EHLO
        cpsmtpb-ews05.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903647Ab2FKJgf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Jun 2012 11:36:35 +0200
Received: from cpsps-ews28.kpnxchange.com ([10.94.84.194]) by cpsmtpb-ews05.kpnxchange.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 11 Jun 2012 11:36:29 +0200
Received: from CPSMTPM-TLF103.kpnxchange.com ([195.121.3.6]) by cpsps-ews28.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Mon, 11 Jun 2012 11:36:29 +0200
Received: from [192.168.1.102] ([212.123.169.34]) by CPSMTPM-TLF103.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Mon, 11 Jun 2012 11:36:27 +0200
Message-ID: <1339407387.30984.87.camel@x61.thuisdomein>
Subject: [PATCH] MIPS: Remove unused smvp.h
From:   Paul Bolle <pebolle@tiscali.nl>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Date:   Mon, 11 Jun 2012 11:36:27 +0200
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3 (3.2.3-3.fc16) 
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
X-OriginalArrivalTime: 11 Jun 2012 09:36:27.0411 (UTC) FILETIME=[AC9B1630:01CD47B5]
X-RcptDomain: linux-mips.org
X-archive-position: 33605
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pebolle@tiscali.nl
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
Return-Path: <linux-mips-bounce@linux-mips.org>

This header was added in commit 39b8d5254246ac56342b72f812255c8f7a74dca9
("[MIPS] Add support for MIPS CMP platform."). None of the functions it
declared were ever included in the tree. The sole file that included it
got removed, because that file was itself unused, in commit
cb7f39d2bc5a20615d016dd86fca0fd233c13b5d ("[MIPS] Remove unused
maltasmp.h.").

This header is unused and unneeded. It can safely be removed.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Tested only by "git grepping" the (history of the) tree in various ways.

 arch/mips/include/asm/smvp.h |   19 -------------------
 1 files changed, 0 insertions(+), 19 deletions(-)
 delete mode 100644 arch/mips/include/asm/smvp.h

diff --git a/arch/mips/include/asm/smvp.h b/arch/mips/include/asm/smvp.h
deleted file mode 100644
index 0d0e80a..0000000
--- a/arch/mips/include/asm/smvp.h
+++ /dev/null
@@ -1,19 +0,0 @@
-#ifndef _ASM_SMVP_H
-#define _ASM_SMVP_H
-
-/*
- * Definitions for SMVP multitasking on MIPS MT cores
- */
-struct task_struct;
-
-extern void smvp_smp_setup(void);
-extern void smvp_smp_finish(void);
-extern void smvp_boot_secondary(int cpu, struct task_struct *t);
-extern void smvp_init_secondary(void);
-extern void smvp_smp_finish(void);
-extern void smvp_cpus_done(void);
-extern void smvp_prepare_cpus(unsigned int max_cpus);
-
-/* This is platform specific */
-extern void smvp_send_ipi(int cpu, unsigned int action);
-#endif /*  _ASM_SMVP_H */
-- 
1.7.7.6
