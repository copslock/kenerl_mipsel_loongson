Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Feb 2006 13:22:03 +0000 (GMT)
Received: from mail-out.m-online.net ([212.18.0.9]:61121 "EHLO
	mail-out.m-online.net") by ftp.linux-mips.org with ESMTP
	id S8133646AbWBTNVs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Feb 2006 13:21:48 +0000
Received: from mail01.m-online.net (svr21.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id CD40272F35
	for <linux-mips@linux-mips.org>; Mon, 20 Feb 2006 14:28:32 +0100 (CET)
Received: from schenk.isar.de (host-82-135-47-202.customer.m-online.net [82.135.47.202])
	by mail.m-online.net (Postfix) with ESMTP id BCA8892833
	for <linux-mips@linux-mips.org>; Mon, 20 Feb 2006 14:28:32 +0100 (CET)
Received: from gwhaus.rt.schenk (gwhaus.rt.schenk [172.22.0.4])
	by schenk.isar.de (8.11.6/8.11.6/SuSE Linux 0.5) with ESMTP id k1KDSWa30911
	for <linux-mips@linux-mips.org>; Mon, 20 Feb 2006 14:28:32 +0100
Received: from [172.22.10.24] (pcimr4.rt.schenk [172.22.10.24])
	by gwhaus.rt.schenk (Postfix) with ESMTP id 6368A988C5
	for <linux-mips@linux-mips.org>; Mon, 20 Feb 2006 14:28:32 +0100 (CET)
Message-ID: <43F9C400.5080200@rtschenk.de>
Date:	Mon, 20 Feb 2006 14:28:32 +0100
From:	Rojhalat Ibrahim <imr@rtschenk.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050919
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: [PATCH] Add topology_init
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <imr@rtschenk.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10554
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: imr@rtschenk.de
Precedence: bulk
X-list: linux-mips

A recent patch introduced cpu topology in sysfs.
When you run a kernel with SMP and sysfs enabled,
you now get an Oops on boot. The following patch
fixes that by adding topology_init to
arch/mips/kernel/smp.c. The code is copied from
arch/s390/kernel/smp.c.

Signed-off-by: Rojhalat Ibrahim <imr@rtschenk.de>

--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -29,6 +29,7 @@
 #include <linux/timex.h>
 #include <linux/sched.h>
 #include <linux/cpumask.h>
+#include <linux/cpu.h>

 #include <asm/atomic.h>
 #include <asm/cpu.h>
@@ -424,6 +425,24 @@ void flush_tlb_one(unsigned long vaddr)
        local_flush_tlb_one(vaddr);
 }

+static DEFINE_PER_CPU(struct cpu, cpu_devices);
+
+static int __init topology_init(void)
+{
+       int cpu;
+       int ret;
+
+       for_each_cpu(cpu) {
+               ret = register_cpu(&per_cpu(cpu_devices, cpu), cpu, NULL);
+               if (ret)
+                       printk(KERN_WARNING "topology_init: register_cpu %d "
+                              "failed (%d)\n", cpu, ret);
+       }
+       return 0;
+}
+
+subsys_initcall(topology_init);
+
 EXPORT_SYMBOL(flush_tlb_page);
 EXPORT_SYMBOL(flush_tlb_one);
 EXPORT_SYMBOL(cpu_data);
