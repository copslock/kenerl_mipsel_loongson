Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Mar 2013 23:49:47 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:4098 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823116Ab3C2Wtp1Orl- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Mar 2013 23:49:45 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B51561afd0000>; Fri, 29 Mar 2013 15:51:41 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 29 Mar 2013 15:49:41 -0700
Received: from [10.18.104.167] ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 29 Mar 2013 15:49:41 -0700
Message-ID: <51561A75.4040601@caviumnetworks.com>
Date:   Fri, 29 Mar 2013 15:49:25 -0700
From:   Venkat Subbiah <vsubbiah@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
MIME-Version: 1.0
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        ddaney@caviumnetworks.com
Subject: Re: [PATCH] MIPS: Octeon: Adding driver to measure interrupt latency
 on Octeon.
References: <1354413086-25162-1-git-send-email-vsubbiah@caviumnetworks.com>
In-Reply-To: <1354413086-25162-1-git-send-email-vsubbiah@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Mar 2013 22:49:41.0771 (UTC) FILETIME=[B34355B0:01CE2CCF]
X-archive-position: 35995
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

I was wondering whether this patch got accepted upstream. How do you 
usually got about checking whether a patch made it upstream?
Thanks,
Venkat



On 12/01/2012 05:51 PM, vsubbiah@caviumnetworks.com wrote:
> From: Venkat Subbiah <venkat.subbiah@cavium.com>
>
> Signed-off-by: Venkat Subbiah <venkat.subbiah@cavium.com>
> [Rewrote timeing calculations]
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>   arch/mips/cavium-octeon/Kconfig   |    9 ++
>   arch/mips/cavium-octeon/Makefile  |    1 +
>   arch/mips/cavium-octeon/oct_ilm.c |  206 +++++++++++++++++++++++++++++++++++++
>   3 files changed, 216 insertions(+)
>   create mode 100644 arch/mips/cavium-octeon/oct_ilm.c
>
> diff --git a/arch/mips/cavium-octeon/Kconfig b/arch/mips/cavium-octeon/Kconfig
> index 2f4f6d5..75a6df7 100644
> --- a/arch/mips/cavium-octeon/Kconfig
> +++ b/arch/mips/cavium-octeon/Kconfig
> @@ -94,4 +94,13 @@ config SWIOTLB
>   	select NEED_SG_DMA_LENGTH
>   
>   
> +config OCTEON_ILM
> +	tristate "Module to measure interrupt latency using Octeon CIU Timer"
> +	help
> +	  This driver is a module to measure interrupt latency using the
> +	  the CIU Timers on Octeon.
> +
> +	  To compile this driver as a module, choose M here.  The module
> +	  will be called octeon-ilm
> +
>   endif # CPU_CAVIUM_OCTEON
> diff --git a/arch/mips/cavium-octeon/Makefile b/arch/mips/cavium-octeon/Makefile
> index bc96e29..614db10 100644
> --- a/arch/mips/cavium-octeon/Makefile
> +++ b/arch/mips/cavium-octeon/Makefile
> @@ -18,6 +18,7 @@ obj-y += octeon-memcpy.o
>   obj-y += executive/
>   
>   obj-$(CONFIG_SMP)                     += smp.o
> +obj-$(CONFIG_OCTEON_ILM)              += oct_ilm.o
>   
>   DTS_FILES = octeon_3xxx.dts octeon_68xx.dts
>   DTB_FILES = $(patsubst %.dts, %.dtb, $(DTS_FILES))
> diff --git a/arch/mips/cavium-octeon/oct_ilm.c b/arch/mips/cavium-octeon/oct_ilm.c
> new file mode 100644
> index 0000000..71b213d
> --- /dev/null
> +++ b/arch/mips/cavium-octeon/oct_ilm.c
> @@ -0,0 +1,206 @@
> +#include <linux/fs.h>
> +#include <linux/interrupt.h>
> +#include <asm/octeon/octeon.h>
> +#include <asm/octeon/cvmx-ciu-defs.h>
> +#include <asm/octeon/cvmx.h>
> +#include <linux/debugfs.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/seq_file.h>
> +
> +#define TIMER_NUM 3
> +
> +static bool reset_stats;
> +
> +struct latency_info {
> +	u64 io_interval;
> +	u64 cpu_interval;
> +	u64 timer_start1;
> +	u64 timer_start2;
> +	u64 max_latency;
> +	u64 min_latency;
> +	u64 latency_sum;
> +	u64 average_latency;
> +	u64 interrupt_cnt;
> +};
> +
> +static struct latency_info li;
> +static struct dentry *dir;
> +
> +static int show_latency(struct seq_file *m, void *v)
> +{
> +	u64 cpuclk, avg, max, min;
> +	struct latency_info curr_li = li;
> +
> +	cpuclk = octeon_get_clock_rate();
> +
> +	max = (curr_li.max_latency * 1000000000) / cpuclk;
> +	min = (curr_li.min_latency * 1000000000) / cpuclk;
> +	avg = (curr_li.latency_sum * 1000000000) / (cpuclk * curr_li.interrupt_cnt);
> +
> +	seq_printf(m, "cnt: %10lld, avg: %7lld ns, max: %7lld ns, min: %7lld ns\n",
> +		   curr_li.interrupt_cnt, avg, max, min);
> +	return 0;
> +}
> +
> +static int oct_ilm_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, show_latency, NULL);
> +}
> +
> +static const struct file_operations oct_ilm_ops = {
> +	.open = oct_ilm_open,
> +	.read = seq_read,
> +	.llseek = seq_lseek,
> +	.release = single_release,
> +};
> +
> +static int reset_statistics(void *data, u64 value)
> +{
> +	reset_stats = true;
> +	return 0;
> +}
> +
> +DEFINE_SIMPLE_ATTRIBUTE(reset_statistics_ops, NULL, reset_statistics, "%llu\n");
> +
> +static int init_debufs(void)
> +{
> +	struct dentry *show_dentry;
> +	dir = debugfs_create_dir("oct_ilm", 0);
> +	if (!dir) {
> +		pr_err("oct_ilm: failed to create debugfs entry oct_ilm\n");
> +		return -1;
> +	}
> +
> +	show_dentry = debugfs_create_file("statistics", 0222, dir, NULL,
> +					  &oct_ilm_ops);
> +	if (!show_dentry) {
> +		pr_err("oct_ilm: failed to create debugfs entry oct_ilm/statistics\n");
> +		return -1;
> +	}
> +
> +	show_dentry = debugfs_create_file("reset", 0222, dir, NULL,
> +					  &reset_statistics_ops);
> +	if (!show_dentry) {
> +		pr_err("oct_ilm: failed to create debugfs entry oct_ilm/reset\n");
> +		return -1;
> +	}
> +
> +	return 0;
> +
> +}
> +
> +static void init_latency_info(struct latency_info *li, int startup)
> +{
> +	/* interval in milli seconds after which the interrupt will
> +	 * be triggered
> +	 */
> +	int interval = 1;
> +
> +	if (startup) {
> +		/* Calculating by the amounts io clock and cpu clock would
> +		 *  increment in interval amount of ms
> +		 */
> +		li->io_interval = (octeon_get_io_clock_rate() * interval) / 1000;
> +		li->cpu_interval = (octeon_get_clock_rate() * interval) / 1000;
> +	}
> +	li->timer_start1 = 0;
> +	li->timer_start2 = 0;
> +	li->max_latency = 0;
> +	li->min_latency = (u64)-1;
> +	li->latency_sum = 0;
> +	li->interrupt_cnt = 0;
> +}
> +
> +
> +static void start_timer(int timer, u64 interval)
> +{
> +	union cvmx_ciu_timx timx;
> +	unsigned long flags;
> +
> +	timx.u64 = 0;
> +	timx.s.one_shot = 1;
> +	timx.s.len = interval;
> +	raw_local_irq_save(flags);
> +	li.timer_start1 = read_c0_cvmcount();
> +	cvmx_write_csr(CVMX_CIU_TIMX(timer), timx.u64);
> +	/* Read it back to force wait until register is written. */
> +	timx.u64 = cvmx_read_csr(CVMX_CIU_TIMX(timer));
> +	li.timer_start2 = read_c0_cvmcount();
> +	raw_local_irq_restore(flags);
> +}
> +
> +
> +static irqreturn_t cvm_oct_ciu_timer_interrupt(int cpl, void *dev_id)
> +{
> +	u64 last_latency;
> +	u64 last_int_cnt;
> +
> +	if (reset_stats) {
> +		init_latency_info(&li, 0);
> +		reset_stats = false;
> +	} else {
> +		last_int_cnt = read_c0_cvmcount();
> +		last_latency = last_int_cnt - (li.timer_start1 + li.cpu_interval);
> +		li.interrupt_cnt++;
> +		li.latency_sum += last_latency;
> +		if (last_latency > li.max_latency)
> +			li.max_latency = last_latency;
> +		if (last_latency < li.min_latency)
> +			li.min_latency = last_latency;
> +	}
> +	start_timer(TIMER_NUM, li.io_interval);
> +	return IRQ_HANDLED;
> +}
> +
> +static void disable_timer(int timer)
> +{
> +	union cvmx_ciu_timx timx;
> +
> +	timx.s.one_shot = 0;
> +	timx.s.len = 0;
> +	cvmx_write_csr(CVMX_CIU_TIMX(timer), timx.u64);
> +	/* Read it back to force immediate write of timer register*/
> +	timx.u64 = cvmx_read_csr(CVMX_CIU_TIMX(timer));
> +}
> +
> +static __init int oct_ilm_module_init(void)
> +{
> +	int rc;
> +	int irq = OCTEON_IRQ_TIMER0 + TIMER_NUM;
> +
> +	rc = init_debufs();
> +	if (rc) {
> +		WARN(1, "Could not create debugfs entries");
> +		return rc;
> +	}
> +
> +	rc = request_irq(irq, cvm_oct_ciu_timer_interrupt, IRQF_NO_THREAD,
> +			 "oct_ilm", 0);
> +	if (rc) {
> +		WARN(1, "Could not acquire IRQ %d", irq);
> +		goto err_irq;
> +	}
> +
> +	init_latency_info(&li, 1);
> +	start_timer(TIMER_NUM, li.io_interval);
> +
> +	return 0;
> +err_irq:
> +	debugfs_remove_recursive(dir);
> +	return rc;
> +}
> +
> +static __exit void oct_ilm_module_exit(void)
> +{
> +	disable_timer(TIMER_NUM);
> +	if (dir)
> +		debugfs_remove_recursive(dir);
> +	free_irq(OCTEON_IRQ_TIMER0 + TIMER_NUM, 0);
> +}
> +
> +module_exit(oct_ilm_module_exit);
> +module_init(oct_ilm_module_init);
> +MODULE_AUTHOR("Venkat Subbiah, Cavium");
> +MODULE_DESCRIPTION("Measures interrupt latency on Octeon chips.");
> +MODULE_LICENSE("GPL");
