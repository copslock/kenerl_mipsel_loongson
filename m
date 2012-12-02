Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Dec 2012 02:51:33 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:10381 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823082Ab2LBBvbh61U4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Dec 2012 02:51:31 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B50bab4930000>; Sat, 01 Dec 2012 17:53:23 -0800
Received: from casmarthost.caveonetworks.com ([192.168.16.225]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Sat, 1 Dec 2012 17:51:28 -0800
Received: from localhost (vs-lnx.caveonetworks.com [10.18.104.167])
        by casmarthost.caveonetworks.com (8.13.8/8.13.8) with ESMTP id qB21pRBH017839;
        Sat, 1 Dec 2012 17:51:28 -0800
From:   vsubbiah@caviumnetworks.com
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        ddaney@caviumnetworks.com
Subject: [PATCH] MIPS: Octeon: Adding driver to measure interrupt latency on Octeon.
Date:   Sat,  1 Dec 2012 17:51:26 -0800
Message-Id: <1354413086-25162-1-git-send-email-vsubbiah@caviumnetworks.com>
X-Mailer: git-send-email 1.7.9.5
X-OriginalArrivalTime: 02 Dec 2012 01:51:28.0298 (UTC) FILETIME=[8B50C8A0:01CDD02F]
X-archive-position: 35165
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vsubbiah@caviumnetworks.com
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

From: Venkat Subbiah <venkat.subbiah@cavium.com>

Signed-off-by: Venkat Subbiah <venkat.subbiah@cavium.com>
[Rewrote timeing calculations]
Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/Kconfig   |    9 ++
 arch/mips/cavium-octeon/Makefile  |    1 +
 arch/mips/cavium-octeon/oct_ilm.c |  206 +++++++++++++++++++++++++++++++++++++
 3 files changed, 216 insertions(+)
 create mode 100644 arch/mips/cavium-octeon/oct_ilm.c

diff --git a/arch/mips/cavium-octeon/Kconfig b/arch/mips/cavium-octeon/Kconfig
index 2f4f6d5..75a6df7 100644
--- a/arch/mips/cavium-octeon/Kconfig
+++ b/arch/mips/cavium-octeon/Kconfig
@@ -94,4 +94,13 @@ config SWIOTLB
 	select NEED_SG_DMA_LENGTH
 
 
+config OCTEON_ILM
+	tristate "Module to measure interrupt latency using Octeon CIU Timer"
+	help
+	  This driver is a module to measure interrupt latency using the
+	  the CIU Timers on Octeon.
+
+	  To compile this driver as a module, choose M here.  The module
+	  will be called octeon-ilm
+
 endif # CPU_CAVIUM_OCTEON
diff --git a/arch/mips/cavium-octeon/Makefile b/arch/mips/cavium-octeon/Makefile
index bc96e29..614db10 100644
--- a/arch/mips/cavium-octeon/Makefile
+++ b/arch/mips/cavium-octeon/Makefile
@@ -18,6 +18,7 @@ obj-y += octeon-memcpy.o
 obj-y += executive/
 
 obj-$(CONFIG_SMP)                     += smp.o
+obj-$(CONFIG_OCTEON_ILM)              += oct_ilm.o
 
 DTS_FILES = octeon_3xxx.dts octeon_68xx.dts
 DTB_FILES = $(patsubst %.dts, %.dtb, $(DTS_FILES))
diff --git a/arch/mips/cavium-octeon/oct_ilm.c b/arch/mips/cavium-octeon/oct_ilm.c
new file mode 100644
index 0000000..71b213d
--- /dev/null
+++ b/arch/mips/cavium-octeon/oct_ilm.c
@@ -0,0 +1,206 @@
+#include <linux/fs.h>
+#include <linux/interrupt.h>
+#include <asm/octeon/octeon.h>
+#include <asm/octeon/cvmx-ciu-defs.h>
+#include <asm/octeon/cvmx.h>
+#include <linux/debugfs.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/seq_file.h>
+
+#define TIMER_NUM 3
+
+static bool reset_stats;
+
+struct latency_info {
+	u64 io_interval;
+	u64 cpu_interval;
+	u64 timer_start1;
+	u64 timer_start2;
+	u64 max_latency;
+	u64 min_latency;
+	u64 latency_sum;
+	u64 average_latency;
+	u64 interrupt_cnt;
+};
+
+static struct latency_info li;
+static struct dentry *dir;
+
+static int show_latency(struct seq_file *m, void *v)
+{
+	u64 cpuclk, avg, max, min;
+	struct latency_info curr_li = li;
+
+	cpuclk = octeon_get_clock_rate();
+
+	max = (curr_li.max_latency * 1000000000) / cpuclk;
+	min = (curr_li.min_latency * 1000000000) / cpuclk;
+	avg = (curr_li.latency_sum * 1000000000) / (cpuclk * curr_li.interrupt_cnt);
+
+	seq_printf(m, "cnt: %10lld, avg: %7lld ns, max: %7lld ns, min: %7lld ns\n",
+		   curr_li.interrupt_cnt, avg, max, min);
+	return 0;
+}
+
+static int oct_ilm_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, show_latency, NULL);
+}
+
+static const struct file_operations oct_ilm_ops = {
+	.open = oct_ilm_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+static int reset_statistics(void *data, u64 value)
+{
+	reset_stats = true;
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(reset_statistics_ops, NULL, reset_statistics, "%llu\n");
+
+static int init_debufs(void)
+{
+	struct dentry *show_dentry;
+	dir = debugfs_create_dir("oct_ilm", 0);
+	if (!dir) {
+		pr_err("oct_ilm: failed to create debugfs entry oct_ilm\n");
+		return -1;
+	}
+
+	show_dentry = debugfs_create_file("statistics", 0222, dir, NULL,
+					  &oct_ilm_ops);
+	if (!show_dentry) {
+		pr_err("oct_ilm: failed to create debugfs entry oct_ilm/statistics\n");
+		return -1;
+	}
+
+	show_dentry = debugfs_create_file("reset", 0222, dir, NULL,
+					  &reset_statistics_ops);
+	if (!show_dentry) {
+		pr_err("oct_ilm: failed to create debugfs entry oct_ilm/reset\n");
+		return -1;
+	}
+
+	return 0;
+
+}
+
+static void init_latency_info(struct latency_info *li, int startup)
+{
+	/* interval in milli seconds after which the interrupt will
+	 * be triggered
+	 */
+	int interval = 1;
+
+	if (startup) {
+		/* Calculating by the amounts io clock and cpu clock would
+		 *  increment in interval amount of ms
+		 */
+		li->io_interval = (octeon_get_io_clock_rate() * interval) / 1000;
+		li->cpu_interval = (octeon_get_clock_rate() * interval) / 1000;
+	}
+	li->timer_start1 = 0;
+	li->timer_start2 = 0;
+	li->max_latency = 0;
+	li->min_latency = (u64)-1;
+	li->latency_sum = 0;
+	li->interrupt_cnt = 0;
+}
+
+
+static void start_timer(int timer, u64 interval)
+{
+	union cvmx_ciu_timx timx;
+	unsigned long flags;
+
+	timx.u64 = 0;
+	timx.s.one_shot = 1;
+	timx.s.len = interval;
+	raw_local_irq_save(flags);
+	li.timer_start1 = read_c0_cvmcount();
+	cvmx_write_csr(CVMX_CIU_TIMX(timer), timx.u64);
+	/* Read it back to force wait until register is written. */
+	timx.u64 = cvmx_read_csr(CVMX_CIU_TIMX(timer));
+	li.timer_start2 = read_c0_cvmcount();
+	raw_local_irq_restore(flags);
+}
+
+
+static irqreturn_t cvm_oct_ciu_timer_interrupt(int cpl, void *dev_id)
+{
+	u64 last_latency;
+	u64 last_int_cnt;
+
+	if (reset_stats) {
+		init_latency_info(&li, 0);
+		reset_stats = false;
+	} else {
+		last_int_cnt = read_c0_cvmcount();
+		last_latency = last_int_cnt - (li.timer_start1 + li.cpu_interval);
+		li.interrupt_cnt++;
+		li.latency_sum += last_latency;
+		if (last_latency > li.max_latency)
+			li.max_latency = last_latency;
+		if (last_latency < li.min_latency)
+			li.min_latency = last_latency;
+	}
+	start_timer(TIMER_NUM, li.io_interval);
+	return IRQ_HANDLED;
+}
+
+static void disable_timer(int timer)
+{
+	union cvmx_ciu_timx timx;
+
+	timx.s.one_shot = 0;
+	timx.s.len = 0;
+	cvmx_write_csr(CVMX_CIU_TIMX(timer), timx.u64);
+	/* Read it back to force immediate write of timer register*/
+	timx.u64 = cvmx_read_csr(CVMX_CIU_TIMX(timer));
+}
+
+static __init int oct_ilm_module_init(void)
+{
+	int rc;
+	int irq = OCTEON_IRQ_TIMER0 + TIMER_NUM;
+
+	rc = init_debufs();
+	if (rc) {
+		WARN(1, "Could not create debugfs entries");
+		return rc;
+	}
+
+	rc = request_irq(irq, cvm_oct_ciu_timer_interrupt, IRQF_NO_THREAD,
+			 "oct_ilm", 0);
+	if (rc) {
+		WARN(1, "Could not acquire IRQ %d", irq);
+		goto err_irq;
+	}
+
+	init_latency_info(&li, 1);
+	start_timer(TIMER_NUM, li.io_interval);
+
+	return 0;
+err_irq:
+	debugfs_remove_recursive(dir);
+	return rc;
+}
+
+static __exit void oct_ilm_module_exit(void)
+{
+	disable_timer(TIMER_NUM);
+	if (dir)
+		debugfs_remove_recursive(dir);
+	free_irq(OCTEON_IRQ_TIMER0 + TIMER_NUM, 0);
+}
+
+module_exit(oct_ilm_module_exit);
+module_init(oct_ilm_module_init);
+MODULE_AUTHOR("Venkat Subbiah, Cavium");
+MODULE_DESCRIPTION("Measures interrupt latency on Octeon chips.");
+MODULE_LICENSE("GPL");
-- 
1.7.9.5
