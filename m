Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6J2tHq24856
	for linux-mips-outgoing; Wed, 18 Jul 2001 19:55:17 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6J2tGV24853
	for <linux-mips@oss.sgi.com>; Wed, 18 Jul 2001 19:55:16 -0700
Received: from mvista.com (IDENT:ahennessy@penelope.mvista.com [10.0.0.122])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f6J1suW19457;
	Wed, 18 Jul 2001 18:54:56 -0700
Message-ID: <3B564CE7.2CF85A65@mvista.com>
Date: Wed, 18 Jul 2001 19:58:47 -0700
From: Alice Hennessy <ahennessy@mvista.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
CC: ahennessy@mvista.com
Subject: R3000 and kgdb
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Has anyone used kgdb with an R3000 cpu?   There was an obvious problem
in
gdb-low.S (patch below) but I still cannot get kgdb to work.

Alice



--- arch/mips/kernel/gdb-low.S.orig     Wed Jul 18 18:47:57 2001
+++ arch/mips/kernel/gdb-low.S  Wed Jul 18 17:52:21 2001
@@ -302,11 +302,18 @@
                lw      v1,GDB_FR_REG3(sp)
                lw      v0,GDB_FR_REG2(sp)
                lw      $1,GDB_FR_REG1(sp)
+#if defined(CONFIG_CPU_R3000)
+                lw      k0, GDB_FR_EPC(sp)
+                lw      sp,GDB_FR_REG29(sp)             /* Deallocate
stack */
+                jr      k0
+                rfe
+#else
                lw      sp,GDB_FR_REG29(sp)             /* Deallocate
stack */

                .set    mips3
                eret
                .set    mips0
+#endif
                .set    at
                .set    reorder
                END(trap_low)
