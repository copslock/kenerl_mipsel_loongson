Received:  by oss.sgi.com id <S553776AbRALDyn>;
	Thu, 11 Jan 2001 19:54:43 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:59380 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553760AbRALDya>;
	Thu, 11 Jan 2001 19:54:30 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f0C3prC03664;
	Thu, 11 Jan 2001 19:51:53 -0800
Message-ID: <3A5E7FFB.79925DF9@mvista.com>
Date:   Thu, 11 Jan 2001 19:54:35 -0800
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: broken RM7000 in CVS ...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


I saw mips_cpu structure is introduced to the CVS tree.  That is a really good
thing, although many places need to be improved.

An initial try found the following bug.  There are probably more down the
road. :-)

Jun

diff -Nru linux/arch/mips/mm/loadmmu.c.orig linux/arch/mips/mm/loadmmu.c
--- linux/arch/mips/mm/loadmmu.c.orig   Thu Jan 11 19:32:11 2001
+++ linux/arch/mips/mm/loadmmu.c        Thu Jan 11 19:48:06 2001
@@ -59,6 +59,11 @@
                printk("Loading MIPS32 MMU routines.\n");
                ld_mmu_mips32();
 #endif
+#if defined(CONFIG_CPU_RM7000)
+               printk("Loading RM7000 MMU routines.\n");
+               ld_mmu_rm7k();
+#endif
+
        } else switch(mips_cpu.cputype) {
 #ifdef CONFIG_CPU_R3000
        case CPU_R2000:
@@ -74,13 +79,6 @@
        case CPU_R5432:
                printk("Loading R5432 MMU routines.\n");
                ld_mmu_r5432();
-               break;
-#endif
-
-#if defined(CONFIG_CPU_RM7000)
-       case CPU_RM7000:
-               printk("Loading RM7000 MMU routines.\n");
-               ld_mmu_rm7k();
                break;
 #endif
