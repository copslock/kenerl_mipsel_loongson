Received:  by oss.sgi.com id <S553815AbQJ0CIH>;
	Thu, 26 Oct 2000 19:08:07 -0700
Received: from gateway-490.mvista.com ([63.192.220.206]:46844 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553796AbQJ0CHq>;
	Thu, 26 Oct 2000 19:07:46 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id e9R269326679;
	Thu, 26 Oct 2000 19:06:09 -0700
Message-ID: <39F8E3C7.57C6D1DE@mvista.com>
Date:   Thu, 26 Oct 2000 19:09:11 -0700
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: gdb bus error for unaligned access
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Ralf,

This is the long-overdue patch for kgdb.  It gets rid of "BUS signal"
for unaligned accesses in kgdb mode.

Jun


diff -Nru linux/arch/mips/kernel/gdb-stub.c.orig
linux/arch/mips/kernel/gdb-stub.c
--- linux/arch/mips/kernel/gdb-stub.c.orig      Wed Oct 25 11:08:20 2000
+++ linux/arch/mips/kernel/gdb-stub.c   Thu Oct 26 19:05:07 2000
@@ -320,8 +320,9 @@
        unsigned char tt;               /* Trap type code for MIPS R3xxx
and R4xxx */
        unsigned char signo;            /* Signal that we map this trap
into */
 } hard_trap_info[] = {
-       { 4, SIGBUS },                  /* address error (load) */
-       { 5, SIGBUS },                  /* address error (store) */
+/* [jsun] kernel emulates unaligned access */
+/*     { 4, SIGBUS },          */      /* address error (load) */
+/*     { 5, SIGBUS },          */      /* address error (store) */
        { 6, SIGBUS },                  /* instruction bus error */
        { 7, SIGBUS },                  /* data bus error */
        { 9, SIGTRAP },                 /* break */
