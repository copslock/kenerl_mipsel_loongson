Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Nov 2006 16:04:52 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:29379 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20040307AbWK2QEu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 29 Nov 2006 16:04:50 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id kATG4iLJ015289;
	Wed, 29 Nov 2006 16:04:44 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id kATG4ZEW015283;
	Wed, 29 Nov 2006 16:04:35 GMT
Date:	Wed, 29 Nov 2006 16:04:35 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Philip J. Mucci" <mucci@cs.utk.edu>
Cc:	eranian@hpl.hp.com, perfmon@napali.hpl.hp.com,
	linux-mips@linux-mips.org
Subject: Re: [Perfctr-devel] 2.6.19-rc6-git10 new perfmon code base + libpfm + pfmon
Message-ID: <20061129160434.GA15230@linux-mips.org>
References: <20061127143705.GC24980@frankl.hpl.hp.com> <1164725427.2316.109.camel@localhost.localdomain> <20061128182049.GA19304@linux-mips.org> <1164740702.2316.151.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1164740702.2316.151.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13270
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 28, 2006 at 08:05:02PM +0100, Philip J. Mucci wrote:

> Forgive me, I thought Stefane had posted the announcement of the new
> perfmon kernel substrate on Linux/MIPS list. I see now that he did not,
> so it's likely that the below patch has little meaning to you folks. I
> do know however, that there are some broadcom folks tracking this work.
> 
> This is not meant to be a patch for the Linux/MIPS tree, but rather the
> perfmon2 patch when applied to Linus' latest GIT tree. This hack (marked
> as such) gets around a NULL pointer dereference upon boot. I make no
> claims other than that it lets the MIPS folks play with the perfmon2
> implementation.

So following our private mail exchange I've checked in below fix.

  Ralf

commit 83eee867cf914c968933e8bc3acf7a3fe58ceaed
Author: Ralf Baechle <ralf@linux-mips.org>
Date:   Wed Nov 29 15:04:08 2006 +0000

[MIPS] Do topology_init even on uniprocessor kernels.

Otherwise CPU 0 doesn't show up in sysfs which breaks some software.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index cd9cec9..6bfbbed 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -6,7 +6,7 @@ extra-y		:= head.o init_task.o vmlinux.l
 
 obj-y		+= cpu-probe.o branch.o entry.o genex.o irq.o process.o \
 		   ptrace.o reset.o semaphore.o setup.o signal.o syscall.o \
-		   time.o traps.o unaligned.o
+		   time.o topology.o traps.o unaligned.o
 
 binfmt_irix-objs	:= irixelf.o irixinv.o irixioctl.o irixsig.o	\
 			   irix5sys.o sysirix.o
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index db80957..49db516 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -463,28 +463,5 @@ void flush_tlb_one(unsigned long vaddr)
 	smp_on_each_tlb(flush_tlb_one_ipi, (void *) vaddr);
 }
 
-static DEFINE_PER_CPU(struct cpu, cpu_devices);
-
-static int __init topology_init(void)
-{
-	int i, ret;
-
-#ifdef CONFIG_NUMA
-	for_each_online_node(i)
-		register_one_node(i);
-#endif /* CONFIG_NUMA */
-
-	for_each_present_cpu(i) {
-		ret = register_cpu(&per_cpu(cpu_devices, i), i);
-		if (ret)
-			printk(KERN_WARNING "topology_init: register_cpu %d "
-			       "failed (%d)\n", i, ret);
-	}
-
-	return 0;
-}
-
-subsys_initcall(topology_init);
-
 EXPORT_SYMBOL(flush_tlb_page);
 EXPORT_SYMBOL(flush_tlb_one);
diff --git a/arch/mips/kernel/topology.c b/arch/mips/kernel/topology.c
new file mode 100644
index 0000000..660e44e
--- /dev/null
+++ b/arch/mips/kernel/topology.c
@@ -0,0 +1,29 @@
+#include <linux/cpu.h>
+#include <linux/cpumask.h>
+#include <linux/init.h>
+#include <linux/node.h>
+#include <linux/nodemask.h>
+#include <linux/percpu.h>
+
+static DEFINE_PER_CPU(struct cpu, cpu_devices);
+
+static int __init topology_init(void)
+{
+	int i, ret;
+
+#ifdef CONFIG_NUMA
+	for_each_online_node(i)
+		register_one_node(i);
+#endif /* CONFIG_NUMA */
+
+	for_each_present_cpu(i) {
+		ret = register_cpu(&per_cpu(cpu_devices, i), i);
+		if (ret)
+			printk(KERN_WARNING "topology_init: register_cpu %d "
+			       "failed (%d)\n", i, ret);
+	}
+
+	return 0;
+}
+
+subsys_initcall(topology_init);
