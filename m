Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Sep 2002 23:40:15 +0200 (CEST)
Received: from gateway-1237.mvista.com ([12.44.186.158]:5630 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S1122987AbSIPVkP>;
	Mon, 16 Sep 2002 23:40:15 +0200
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id g8GLRjM17778;
	Mon, 16 Sep 2002 14:27:45 -0700
Date: Mon, 16 Sep 2002 14:27:45 -0700
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: [PATCH] fpu enabling/disabling in ptrace.c
Message-ID: <20020916142745.A17321@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 195
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


I think the original intention is to enable FPU, read the
FPU id register and restore original FPU state.  Unfortnately
restore_flags() does not achieve it.

Following patch fixes that.  Applies to both 2.4 and 2.5 branch.

Jun

P.S., I am still waiting for comments or check-in of the following
patches:

020417.kgdb-compile-warning.patch
020722.malta-kgdb
020826.swarm-rtc-m41t81.patch

--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="020916.ptrace.c-restore-fpu-state.patch"

diff -Nru link/arch/mips/kernel/ptrace.c.orig link/arch/mips/kernel/ptrace.c
--- link/arch/mips/kernel/ptrace.c.orig	Fri Aug  9 09:38:10 2002
+++ link/arch/mips/kernel/ptrace.c	Mon Sep 16 14:22:27 2002
@@ -168,10 +168,10 @@
 				break;
 			}
 
-			__save_flags(flags);
+			flags = read_32bit_cp0_register(CP0_STATUS);
 			__enable_fpu();
 			__asm__ __volatile__("cfc1\t%0,$0": "=r" (tmp));
-			__restore_flags(flags);
+			write_32bit_cp0_register(CP0_STATUS, flags);
 			break;
 		}
 		default:
diff -Nru link/arch/mips64/kernel/ptrace.c.orig link/arch/mips64/kernel/ptrace.c
--- link/arch/mips64/kernel/ptrace.c.orig	Fri Aug  9 09:38:19 2002
+++ link/arch/mips64/kernel/ptrace.c	Mon Sep 16 14:24:02 2002
@@ -165,10 +165,10 @@
 			break;
 		case FPC_EIR: { /* implementation / version register */
 			unsigned int flags;
-			__save_flags(flags);
+			flags = read_32bit_cp0_register(CP0_STATUS);
 			__enable_fpu();
 			__asm__ __volatile__("cfc1\t%0,$0": "=r" (tmp));
-			__restore_flags(flags);
+			write_32bit_cp0_register(CP0_STATUS, flags);
 			break;
 		}
 		default:

--NzB8fVQJ5HfG6fxh--
