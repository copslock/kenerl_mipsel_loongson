Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Jan 2011 12:26:16 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:58188 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492592Ab1AML0N (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 Jan 2011 12:26:13 +0100
Message-ID: <4D2EDE92.40203@openwrt.org>
Date:   Thu, 13 Jan 2011 12:14:26 +0100
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.12) Gecko/20100913 Icedove/3.0.7
MIME-Version: 1.0
To:     Daniel Schwierzeck <daniel.schwierzeck@googlemail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 01/10] MIPS: lantiq: add initial support for Lantiq SoCs
References: <1294257379-417-1-git-send-email-blogic@openwrt.org>        <1294257379-417-2-git-send-email-blogic@openwrt.org> <AANLkTinBovWsPak3cCNRMigC8mxUwEik2oB3kSsw-YQL@mail.gmail.com>
In-Reply-To: <AANLkTinBovWsPak3cCNRMigC8mxUwEik2oB3kSsw-YQL@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28903
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi Daniel,

>> +static struct clk *cpu_clk;
>> +static int cpu_clk_cnt;
>> +
>> +static unsigned int r4k_offset;
>> +static unsigned int r4k_cur;
>>     
> What is the sense of these variables? They are never really used.
>   

left overs from old kernel patches, i'll remove them
>> +void __init
>> +plat_time_init(void)
>> +{
>> +       struct clk *clk = clk_get(0, "cpu");
>> +       mips_hpt_frequency = clk_get_rate(clk) / ltq_get_counter_resolution();
>> +       r4k_cur = (read_c0_count() + r4k_offset);
>> +       write_c0_compare(r4k_cur);
>>     
> Like stated above the r4k_cur and r4k_offset are only initailied with
> 0. So the last two lines
> could be written as write_c0_compare(read_c0_count()) and are actually
> ineffective.
>
>   

ok
>> +void
>> +early_printf(const char *fmt, ...)
>> +{
>> +       char buf[ASC_BUF];
>> +       va_list args;
>> +       int l;
>> +       char *p, *buf_end;
>> +       va_start(args, fmt);
>> +       l = vsnprintf(buf, ASC_BUF, fmt, args);
>> +       va_end(args);
>> +       buf_end = buf + l;
>> +       for (p = buf; p < buf_end; p++)
>> +               prom_putchar(*p);
>> +}
>>     
> With CONFIG_EARLY_PRINTK enabled and prom_putchar() implemented you
> can use printk() everywhere.
> So an own early_printf() is not needed.
>
>   

not quite, this is used by the prom code where printk is followed by an
unreachable() rendering the printk to not work. i asked in #mipslinux
about this already and was tolf that this is the only work around as the
early_printk api does not expose its internal simple_printf() function.

>> +
>> +static void
>> +ltq_hw_irqdispatch(int module)
>> +{
>> +       u32 irq;
>> +
>> +       irq = ltq_r32(LTQ_ICU_IM0_IOSR + (module * LTQ_ICU_OFFSET));
>> +       if (irq == 0)
>> +               return;
>> +
>> +       /* silicon bug causes only the msb set to 1 to be valid. all
>> +          other bits might be bogus */
>> +       irq = __fls(irq);
>> +       do_IRQ((int)irq + INT_NUM_IM0_IRL0 + (INT_NUM_IM_OFFSET * module));
>> +}
>> +
>> +#define DEFINE_HWx_IRQDISPATCH(x) \
>> +static void ltq_hw ## x ## _irqdispatch(void)\
>> +{\
>> +       ltq_hw_irqdispatch(x); \
>> +}
>> +DEFINE_HWx_IRQDISPATCH(0)
>> +DEFINE_HWx_IRQDISPATCH(1)
>> +DEFINE_HWx_IRQDISPATCH(2)
>> +DEFINE_HWx_IRQDISPATCH(3)
>> +DEFINE_HWx_IRQDISPATCH(4)
>>     
> The interrupt line IM0-IRL22 is shared by PCI (INT A) and EBU. Thus
> ltq_hw0_irqdispatch()
> should clear the PCI bit (5th bit) in EBU_PCC_ISTAT register (EBU_BASE
> + 0xA0) if you enable
> this interrupt in pcibios_plat_dev_init().
> This is undocumented in the hardware manuals but can be found in all
> Lantiq BSP's.
>
>   
i'll look into it


> +void __init
>> +arch_init_irq(void)
>> +{
>> +       int i;
>> +
>> +       for (i = 0; i < 5; i++)
>> +               ltq_w32(0, LTQ_ICU_IM0_IER + (i * LTQ_ICU_OFFSET));
>>     
> Perhaps pending interrupts should be cleared too with
> ltq_w32(~0, LTQ_ICU_IM0_ISR + (i * LTQ_ICU_OFFSET));
>
>   

will look into this too


>> +
>> +/* all access to the ebu must be locked */
>> +DEFINE_SPINLOCK(ebu_lock);
>> +EXPORT_SYMBOL_GPL(ebu_lock);
>>     
> This lock is only needed if you want to use software arbitration.
> Normally the EBU does hardware arbitration and can be accessed safely
> without lock.
>
>   
openwrt borks up on mini_fo init when this lock is not in-place. we saw
a lot of issues in the past which lead to this lock being added. i will
retry it with out the lock to verify

thx i will fold all suggestions into the next version of the series.

John
