Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Sep 2017 08:46:35 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:14211 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993035AbdIVGqKvh0Sc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Sep 2017 08:46:10 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id ECEDF81C1754D;
        Fri, 22 Sep 2017 07:46:02 +0100 (IST)
Received: from localhost (10.20.79.126) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 22 Sep
 2017 07:46:04 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 3/4] MIPS: Allow bus error handlers to request quiet behaviour
Date:   Thu, 21 Sep 2017 23:44:46 -0700
Message-ID: <20170922064447.28728-4-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170922064447.28728-1-paul.burton@imgtec.com>
References: <20170922064447.28728-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.79.126]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60108
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Add a new MIPS_BE_FATAL_QUIET value which bus error handlers can return
to indicate that a bus error triggered by user code should be treated
the same way as MIPS_BE_FATAL, ie. we should deliver a SIGBUS, but the
kernel shouldn't print information about the bus error to the kernel
log.

This will be useful in a further commit which will silence kernel log
output from bus errors caused by user code performing smaller than 32
bit accesses to the GIC user page, which generates a bus error. Notably
this will silence a ton of output from crashme, which seems to be rather
eager to access the GIC user page in weird & wonderful ways.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/include/asm/traps.h | 1 +
 arch/mips/kernel/traps.c      | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/traps.h b/arch/mips/include/asm/traps.h
index f41cf3ee82a7..7594fb496001 100644
--- a/arch/mips/include/asm/traps.h
+++ b/arch/mips/include/asm/traps.h
@@ -17,6 +17,7 @@
 #define MIPS_BE_DISCARD 0		/* return with no action */
 #define MIPS_BE_FIXUP	1		/* return to the fixup code */
 #define MIPS_BE_FATAL	2		/* treat as an unrecoverable error */
+#define MIPS_BE_FATAL_QUIET	3	/* treat as an unrecoverable error */
 
 extern void (*board_be_init)(void);
 extern int (*board_be_handler)(struct pt_regs *regs, int is_fixup);
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 259e2d259204..2f4546e4abdb 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -465,6 +465,9 @@ asmlinkage void do_be(struct pt_regs *regs)
 			goto out;
 		}
 		break;
+	case MIPS_BE_FATAL_QUIET:
+		if (user_mode(regs))
+			goto out_sigbus;
 	default:
 		break;
 	}
@@ -480,8 +483,8 @@ asmlinkage void do_be(struct pt_regs *regs)
 		goto out;
 
 	die_if_kernel("Oops", regs);
+out_sigbus:
 	force_sig(SIGBUS, current);
-
 out:
 	exception_exit(prev_state);
 }
-- 
2.14.1
