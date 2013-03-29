Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Mar 2013 23:55:27 +0100 (CET)
Received: from co1ehsobe006.messaging.microsoft.com ([216.32.180.189]:20636
        "EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823116Ab3C2WzZtMnU- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Mar 2013 23:55:25 +0100
Received: from mail132-co1-R.bigfish.com (10.243.78.237) by
 CO1EHSOBE027.bigfish.com (10.243.66.90) with Microsoft SMTP Server id
 14.1.225.23; Fri, 29 Mar 2013 22:55:17 +0000
Received: from mail132-co1 (localhost [127.0.0.1])      by
 mail132-co1-R.bigfish.com (Postfix) with ESMTP id 543F4120290; Fri, 29 Mar
 2013 22:55:17 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:157.56.242.245;KIP:(null);UIP:(null);IPV:NLI;H:BL2PRD0712HT003.namprd07.prod.outlook.com;RD:none;EFVD:NLI
X-SpamScore: -5
X-BigFish: PS-5(zzbb2dI98dI9371I1432I4015Izz1f42h1fc6h1ee6h1de0h1202h1e76h1d1ah1d2ahzz8275bh8275dhz2dh2a8h668h839h947hd25he5bhf0ah1288h12a5h12a9h12bdh137ah13b6h1441h14ddh1504h1537h153bh162dh1631h1758h1765h18e1h190ch1946h19b4h19c3h19ceh1ad9h1b0ah1155h)
Received: from mail132-co1 (localhost.localdomain [127.0.0.1]) by mail132-co1
 (MessageSwitch) id 1364597715433015_25541; Fri, 29 Mar 2013 22:55:15 +0000
 (UTC)
Received: from CO1EHSMHS012.bigfish.com (unknown [10.243.78.247])       by
 mail132-co1.bigfish.com (Postfix) with ESMTP id 5DBBBAC004E;   Fri, 29 Mar 2013
 22:55:15 +0000 (UTC)
Received: from BL2PRD0712HT003.namprd07.prod.outlook.com (157.56.242.245) by
 CO1EHSMHS012.bigfish.com (10.243.66.22) with Microsoft SMTP Server (TLS) id
 14.1.225.23; Fri, 29 Mar 2013 22:55:15 +0000
Received: from dl.caveonetworks.com (64.2.3.195) by pod51018.outlook.com
 (10.255.236.36) with Microsoft SMTP Server (TLS) id 14.16.275.6; Fri, 29 Mar
 2013 22:55:14 +0000
Message-ID: <51561BCF.5010706@caviumnetworks.com>
Date:   Fri, 29 Mar 2013 15:55:11 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
MIME-Version: 1.0
To:     Venkat Subbiah <vsubbiah@caviumnetworks.com>
CC:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: Octeon: Adding driver to measure interrupt latency
 on Octeon.
References: <1354413086-25162-1-git-send-email-vsubbiah@caviumnetworks.com> <51561A75.4040601@caviumnetworks.com>
In-Reply-To: <51561A75.4040601@caviumnetworks.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.195]
X-OriginatorOrg: caviumnetworks.com
X-archive-position: 35996
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
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

On 03/29/2013 03:49 PM, Venkat Subbiah wrote:
> I was wondering whether this patch got accepted upstream. How do you
> usually got about checking whether a patch made it upstream?
> Thanks,
> Venkat
>

It did.

You can always look here:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/

>
>
> On 12/01/2012 05:51 PM, vsubbiah@caviumnetworks.com wrote:
>> From: Venkat Subbiah <venkat.subbiah@cavium.com>
>>
>> Signed-off-by: Venkat Subbiah <venkat.subbiah@cavium.com>
>> [Rewrote timeing calculations]
>> Signed-off-by: David Daney <david.daney@cavium.com>
>> ---
>>   arch/mips/cavium-octeon/Kconfig   |    9 ++
>>   arch/mips/cavium-octeon/Makefile  |    1 +
>>   arch/mips/cavium-octeon/oct_ilm.c |  206
>> +++++++++++++++++++++++++++++++++++++
>>   3 files changed, 216 insertions(+)
>>   create mode 100644 arch/mips/cavium-octeon/oct_ilm.c
>>
>> diff --git a/arch/mips/cavium-octeon/Kconfig
>> b/arch/mips/cavium-octeon/Kconfig
>> index 2f4f6d5..75a6df7 100644
>> --- a/arch/mips/cavium-octeon/Kconfig
>> +++ b/arch/mips/cavium-octeon/Kconfig
>> @@ -94,4 +94,13 @@ config SWIOTLB
>>       select NEED_SG_DMA_LENGTH
>> +config OCTEON_ILM
>> +    tristate "Module to measure interrupt latency using Octeon CIU
>> Timer"
>> +    help
>> +      This driver is a module to measure interrupt latency using the
>> +      the CIU Timers on Octeon.
>> +
>> +      To compile this driver as a module, choose M here.  The module
>> +      will be called octeon-ilm
>> +
>>   endif # CPU_CAVIUM_OCTEON
>> diff --git a/arch/mips/cavium-octeon/Makefile
>> b/arch/mips/cavium-octeon/Makefile
>> index bc96e29..614db10 100644
>> --- a/arch/mips/cavium-octeon/Makefile
>> +++ b/arch/mips/cavium-octeon/Makefile
>> @@ -18,6 +18,7 @@ obj-y += octeon-memcpy.o
>>   obj-y += executive/
>>   obj-$(CONFIG_SMP)                     += smp.o
>> +obj-$(CONFIG_OCTEON_ILM)              += oct_ilm.o
>>   DTS_FILES = octeon_3xxx.dts octeon_68xx.dts
>>   DTB_FILES = $(patsubst %.dts, %.dtb, $(DTS_FILES))
>> diff --git a/arch/mips/cavium-octeon/oct_ilm.c
>> b/arch/mips/cavium-octeon/oct_ilm.c
>> new file mode 100644
>> index 0000000..71b213d
>> --- /dev/null
>> +++ b/arch/mips/cavium-octeon/oct_ilm.c
>> @@ -0,0 +1,206 @@
>> +#include <linux/fs.h>
>> +#include <linux/interrupt.h>
>> +#include <asm/octeon/octeon.h>
>> +#include <asm/octeon/cvmx-ciu-defs.h>
>> +#include <asm/octeon/cvmx.h>
>> +#include <linux/debugfs.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/seq_file.h>
>> +
>> +#define TIMER_NUM 3
>> +
>> +static bool reset_stats;
>> +
>> +struct latency_info {
>> +    u64 io_interval;
>> +    u64 cpu_interval;
>> +    u64 timer_start1;
>> +    u64 timer_start2;
>> +    u64 max_latency;
>> +    u64 min_latency;
>> +    u64 latency_sum;
>> +    u64 average_latency;
>> +    u64 interrupt_cnt;
>> +};
>> +
>> +static struct latency_info li;
>> +static struct dentry *dir;
>> +
>> +static int show_latency(struct seq_file *m, void *v)
>> +{
>> +    u64 cpuclk, avg, max, min;
>> +    struct latency_info curr_li = li;
>> +
>> +    cpuclk = octeon_get_clock_rate();
>> +
>> +    max = (curr_li.max_latency * 1000000000) / cpuclk;
>> +    min = (curr_li.min_latency * 1000000000) / cpuclk;
>> +    avg = (curr_li.latency_sum * 1000000000) / (cpuclk *
>> curr_li.interrupt_cnt);
>> +
>> +    seq_printf(m, "cnt: %10lld, avg: %7lld ns, max: %7lld ns, min:
>> %7lld ns\n",
>> +           curr_li.interrupt_cnt, avg, max, min);
>> +    return 0;
>> +}
>> +
>> +static int oct_ilm_open(struct inode *inode, struct file *file)
>> +{
>> +    return single_open(file, show_latency, NULL);
>> +}
>> +
>> +static const struct file_operations oct_ilm_ops = {
>> +    .open = oct_ilm_open,
>> +    .read = seq_read,
>> +    .llseek = seq_lseek,
>> +    .release = single_release,
>> +};
>> +
>> +static int reset_statistics(void *data, u64 value)
>> +{
>> +    reset_stats = true;
>> +    return 0;
>> +}
>> +
>> +DEFINE_SIMPLE_ATTRIBUTE(reset_statistics_ops, NULL, reset_statistics,
>> "%llu\n");
>> +
>> +static int init_debufs(void)
>> +{
>> +    struct dentry *show_dentry;
>> +    dir = debugfs_create_dir("oct_ilm", 0);
>> +    if (!dir) {
>> +        pr_err("oct_ilm: failed to create debugfs entry oct_ilm\n");
>> +        return -1;
>> +    }
>> +
>> +    show_dentry = debugfs_create_file("statistics", 0222, dir, NULL,
>> +                      &oct_ilm_ops);
>> +    if (!show_dentry) {
>> +        pr_err("oct_ilm: failed to create debugfs entry
>> oct_ilm/statistics\n");
>> +        return -1;
>> +    }
>> +
>> +    show_dentry = debugfs_create_file("reset", 0222, dir, NULL,
>> +                      &reset_statistics_ops);
>> +    if (!show_dentry) {
>> +        pr_err("oct_ilm: failed to create debugfs entry
>> oct_ilm/reset\n");
>> +        return -1;
>> +    }
>> +
>> +    return 0;
>> +
>> +}
>> +
>> +static void init_latency_info(struct latency_info *li, int startup)
>> +{
>> +    /* interval in milli seconds after which the interrupt will
>> +     * be triggered
>> +     */
>> +    int interval = 1;
>> +
>> +    if (startup) {
>> +        /* Calculating by the amounts io clock and cpu clock would
>> +         *  increment in interval amount of ms
>> +         */
>> +        li->io_interval = (octeon_get_io_clock_rate() * interval) /
>> 1000;
>> +        li->cpu_interval = (octeon_get_clock_rate() * interval) / 1000;
>> +    }
>> +    li->timer_start1 = 0;
>> +    li->timer_start2 = 0;
>> +    li->max_latency = 0;
>> +    li->min_latency = (u64)-1;
>> +    li->latency_sum = 0;
>> +    li->interrupt_cnt = 0;
>> +}
>> +
>> +
>> +static void start_timer(int timer, u64 interval)
>> +{
>> +    union cvmx_ciu_timx timx;
>> +    unsigned long flags;
>> +
>> +    timx.u64 = 0;
>> +    timx.s.one_shot = 1;
>> +    timx.s.len = interval;
>> +    raw_local_irq_save(flags);
>> +    li.timer_start1 = read_c0_cvmcount();
>> +    cvmx_write_csr(CVMX_CIU_TIMX(timer), timx.u64);
>> +    /* Read it back to force wait until register is written. */
>> +    timx.u64 = cvmx_read_csr(CVMX_CIU_TIMX(timer));
>> +    li.timer_start2 = read_c0_cvmcount();
>> +    raw_local_irq_restore(flags);
>> +}
>> +
>> +
>> +static irqreturn_t cvm_oct_ciu_timer_interrupt(int cpl, void *dev_id)
>> +{
>> +    u64 last_latency;
>> +    u64 last_int_cnt;
>> +
>> +    if (reset_stats) {
>> +        init_latency_info(&li, 0);
>> +        reset_stats = false;
>> +    } else {
>> +        last_int_cnt = read_c0_cvmcount();
>> +        last_latency = last_int_cnt - (li.timer_start1 +
>> li.cpu_interval);
>> +        li.interrupt_cnt++;
>> +        li.latency_sum += last_latency;
>> +        if (last_latency > li.max_latency)
>> +            li.max_latency = last_latency;
>> +        if (last_latency < li.min_latency)
>> +            li.min_latency = last_latency;
>> +    }
>> +    start_timer(TIMER_NUM, li.io_interval);
>> +    return IRQ_HANDLED;
>> +}
>> +
>> +static void disable_timer(int timer)
>> +{
>> +    union cvmx_ciu_timx timx;
>> +
>> +    timx.s.one_shot = 0;
>> +    timx.s.len = 0;
>> +    cvmx_write_csr(CVMX_CIU_TIMX(timer), timx.u64);
>> +    /* Read it back to force immediate write of timer register*/
>> +    timx.u64 = cvmx_read_csr(CVMX_CIU_TIMX(timer));
>> +}
>> +
>> +static __init int oct_ilm_module_init(void)
>> +{
>> +    int rc;
>> +    int irq = OCTEON_IRQ_TIMER0 + TIMER_NUM;
>> +
>> +    rc = init_debufs();
>> +    if (rc) {
>> +        WARN(1, "Could not create debugfs entries");
>> +        return rc;
>> +    }
>> +
>> +    rc = request_irq(irq, cvm_oct_ciu_timer_interrupt, IRQF_NO_THREAD,
>> +             "oct_ilm", 0);
>> +    if (rc) {
>> +        WARN(1, "Could not acquire IRQ %d", irq);
>> +        goto err_irq;
>> +    }
>> +
>> +    init_latency_info(&li, 1);
>> +    start_timer(TIMER_NUM, li.io_interval);
>> +
>> +    return 0;
>> +err_irq:
>> +    debugfs_remove_recursive(dir);
>> +    return rc;
>> +}
>> +
>> +static __exit void oct_ilm_module_exit(void)
>> +{
>> +    disable_timer(TIMER_NUM);
>> +    if (dir)
>> +        debugfs_remove_recursive(dir);
>> +    free_irq(OCTEON_IRQ_TIMER0 + TIMER_NUM, 0);
>> +}
>> +
>> +module_exit(oct_ilm_module_exit);
>> +module_init(oct_ilm_module_init);
>> +MODULE_AUTHOR("Venkat Subbiah, Cavium");
>> +MODULE_DESCRIPTION("Measures interrupt latency on Octeon chips.");
>> +MODULE_LICENSE("GPL");
>
>
