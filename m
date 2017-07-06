Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Jul 2017 15:25:27 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:36298 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993894AbdGFNZVAvsR0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Jul 2017 15:25:21 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 3CAE8E69593E;
        Thu,  6 Jul 2017 14:25:10 +0100 (IST)
Received: from HHMAIL-X.hh.imgtec.org (10.100.10.113) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 6 Jul 2017 14:25:13 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by HHMAIL-X.hh.imgtec.org
 (10.100.10.113) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 6 Jul
 2017 14:25:13 +0100
Received: from BADAG02.ba.imgtec.org ([fe80::612d:e977:c603:32d6]) by
 bamail02.ba.imgtec.org ([fe80::5efe:10.20.40.28%12]) with mapi id
 14.03.0266.001; Thu, 6 Jul 2017 06:25:10 -0700
From:   Miodrag Dinic <Miodrag.Dinic@imgtec.com>
To:     Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        "Aleksandar Markovic" <aleksandar.markovic@rt-rk.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "Aleksandar Markovic" <Aleksandar.Markovic@imgtec.com>,
        Goran Ferenc <Goran.Ferenc@imgtec.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        "David S. Miller" <davem@davemloft.net>,
        Douglas Leung <Douglas.Leung@imgtec.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Hogan <James.Hogan@imgtec.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paul Burton <Paul.Burton@imgtec.com>,
        Petar Jovanovic <Petar.Jovanovic@imgtec.com>,
        Raghu Gandham <Raghu.Gandham@imgtec.com>,
        "jinqian@google.com" <jinqian@google.com>, Bo Hu <bohu@google.com>,
        "lfy@google.com" <lfy@google.com>
Subject: RE: [PATCH v2 02/10] MIPS: ranchu: Add Goldfish RTC driver
Thread-Topic: [PATCH v2 02/10] MIPS: ranchu: Add Goldfish RTC driver
Thread-Index: AQHS8CZqqLh/yoIrEkOda53qS4lugqJGSAgAgAB3juc=
Date:   Thu, 6 Jul 2017 13:25:09 +0000
Message-ID: <232DDC0A2B605E4F9E85F6904417885F015D929D3D@BADAG02.ba.imgtec.org>
References: <1498664922-28493-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1498664922-28493-3-git-send-email-aleksandar.markovic@rt-rk.com>,<20170705215602.vihwoio2dagxy2fc@piout.net>
In-Reply-To: <20170705215602.vihwoio2dagxy2fc@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [82.117.201.26]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Miodrag.Dinic@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59032
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Miodrag.Dinic@imgtec.com
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

cc-ing Jin Quian, Bo Hu & Lingfeng Yang from Google

Hi Alexandre,

thank you for your comments, answers are inline:

> 
> On 28/06/2017 at 17:46:55 +0200, Aleksandar Markovic wrote:
> > From: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
> > 
> > Add device driver for a virtual Goldfish RTC clock.
> > 
> > The driver can be built only if CONFIG_MIPS and CONFIG_GOLDFISH are
> > set. The compatible string used by OS for binding the driver is
> > defined as "google,goldfish-rtc".
> > 
> 
> Is it really MIPS specific? I would expect the same driver to work on
> the ARM based emulator too.

This driver can be made to work for ARM/Intel emulator but it is currently
used only by MIPS emulator, so I would prefer to keep it guarded with "MIPS".
If ARM or Intel decide to use this driver for their emulators it can be easily
enabled.

> > +config RTC_DRV_GOLDFISH
> > +     tristate "Goldfish Real Time Clock"
> > +     depends on MIPS
> > +     depends on GOLDFISH
> 
> This should be made buildable with COMPILE_TEST to extend coverage.

It will be included in the next version.

> > +     help
> > +       Say yes here to build support for the Goldfish RTC.
> 
> Please, don't expect anybody to actually know what is goldfish can you
> add a sentence or two?

It will be better documented in the next version. Thank you.

> > +static irqreturn_t goldfish_rtc_interrupt(int irq, void *dev_id)
> > +{
> > +     struct goldfish_rtc     *qrtc = dev_id;
> > +     unsigned long           events = 0;
> > +     void __iomem *base = qrtc->base;
> > +
> > +     writel(1, base + TIMER_CLEAR_INTERRUPT);
> > +     events = RTC_IRQF | RTC_AF;
> > +
> > +     rtc_update_irq(qrtc->rtc, 1, events);
> 
> I'd say that events is not needed you can pass the flags directly to
> rtc_update_irq

It will be corrected in the next version.

> > +static int goldfish_rtc_read_time(struct device *dev, struct rtc_time *tm)
> > +{
> > +     u64 time;
> > +     u64 time_low;
> > +     u64 time_high;
> > +     u64 time_high_prev;
> > +
> > +     struct goldfish_rtc *qrtc =
> > +                     platform_get_drvdata(to_platform_device(dev));
> > +     void __iomem *base = qrtc->base;
> > +
> > +     time_high = readl(base + TIMER_TIME_HIGH);
> > +     do {
> > +             time_high_prev = time_high;
> > +             time_low = readl(base + TIMER_TIME_LOW);
> > +             time_high = readl(base + TIMER_TIME_HIGH);
> > +     } while (time_high != time_high_prev);
> 
> I'm not sure why you need that loop as the comments for TIMER_TIME_LOW
> and TIMER_TIME_HIGH indicate that TIMER_TIME_HIGH is latched when
> TIMER_TIME_LOW is read. Note that the original driver from google
> doesn't do that.

This is the way how other HW drivers are doing it, so we used this
approach to make it more in-line with other HW, and it also does not
make any assumptions regarding TIMER_TIME_HIGH is latched or not.
This is the relevant part of code on the RTC device side which emulates these reads:

static uint64_t goldfish_timer_read(void *opaque, hwaddr offset, unsigned size)
{
    struct timer_state *s = (struct timer_state *)opaque;
    switch(offset) {
        case TIMER_TIME_LOW:
            s->now_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
            return s->now_ns;
        case TIMER_TIME_HIGH:
            return s->now_ns >> 32;
        default:
            cpu_abort(current_cpu,
                      "goldfish_timer_read: Bad offset %" HWADDR_PRIx "\n",
                      offset);
            return 0;
    }
}

So theoretically speaking, we could imagine the situation that the kernel pre-empts after the
first TIMER_TIME_LOW read and another request for reading the time gets processed, so
the previous call would end-up having stale TIMER_TIME_LOW value.
This is however very unlikely to happen, but one extra read in the loop doesn't hurt and
actually makes the code less prone to error.

> > +     time = (time_high << 32) | time_low;
> > +
> > +     do_div(time, NSEC_PER_SEC);
> > +
> > +     rtc_time_to_tm(time, tm);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct rtc_class_ops goldfish_rtc_ops = {
> > +     .read_time      = goldfish_rtc_read_time,
> > +};
> > +
> > +static int goldfish_rtc_probe(struct platform_device *pdev)
> > +{
> > +     struct resource *r;
> > +     struct goldfish_rtc *qrtc;
> > +     unsigned long rtc_dev_len;
> > +     unsigned long rtc_dev_addr;
> > +     int err;
> > +
> > +     qrtc = devm_kzalloc(&pdev->dev, sizeof(*qrtc), GFP_KERNEL);
> > +     if (qrtc == NULL)
> > +             return -ENOMEM;
> > +
> > +     platform_set_drvdata(pdev, qrtc);
> > +
> > +     r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +     if (r == NULL)
> > +             return -ENODEV;
> > +
> > +     rtc_dev_addr = r->start;
> > +     rtc_dev_len = resource_size(r);
> > +     qrtc->base = devm_ioremap(&pdev->dev, rtc_dev_addr, rtc_dev_len);
> 
> devm_ioremap_resource ?

Thanks, it will be fixed in next version to use devm_ioremap_resource().

> > +     if (IS_ERR(qrtc->base))
> > +             return -ENODEV;
> > +
> > +     qrtc->irq = platform_get_irq(pdev, 0);
> > +     if (qrtc->irq < 0)
> > +             return -ENODEV;
> > +
> 
> Is the irq so important that you have to fail here even if the driver
> doesn't support any alarm?

Well currently it does not support alarm features, but we are considering
to implement it in some other iteration. Maybe we will introduce it in the next version
if not we will remove the IRQ handling. Thanks.

> > +     qrtc->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
> > +                                     &goldfish_rtc_ops, THIS_MODULE);
> > +     if (IS_ERR(qrtc->rtc))
> > +             return PTR_ERR(qrtc->rtc);
> > +
> > +     err = devm_request_irq(&pdev->dev, qrtc->irq, goldfish_rtc_interrupt,
> > +             0, pdev->name, qrtc);
> > +     if (err)
> > +             return err;
> 
> Ditto.

Kind regards,
Miodrag

________________________________________
From: Alexandre Belloni [alexandre.belloni@free-electrons.com]
Sent: Wednesday, July 05, 2017 11:56 PM
To: Aleksandar Markovic
Cc: linux-mips@linux-mips.org; Aleksandar Markovic; Miodrag Dinic; Goran Ferenc; Alessandro Zummo; David S. Miller; Douglas Leung; Greg Kroah-Hartman; James Hogan; linux-kernel@vger.kernel.org; linux-rtc@vger.kernel.org; Martin K. Petersen; Mauro Carvalho Chehab; Paul Burton; Petar Jovanovic; Raghu Gandham
Subject: Re: [PATCH v2 02/10] MIPS: ranchu: Add Goldfish RTC driver

Hi,

The subject doesn't fit the subsystem style, this needs to be changed.

On 28/06/2017 at 17:46:55 +0200, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
>
> Add device driver for a virtual Goldfish RTC clock.
>
> The driver can be built only if CONFIG_MIPS and CONFIG_GOLDFISH are
> set. The compatible string used by OS for binding the driver is
> defined as "google,goldfish-rtc".
>

Is it really MIPS specific? I would expect the same driver to work on
the ARM based emulator too.

> +config RTC_DRV_GOLDFISH
> +     tristate "Goldfish Real Time Clock"
> +     depends on MIPS
> +     depends on GOLDFISH

This should be made buildable with COMPILE_TEST to extend coverage.

> +     help
> +       Say yes here to build support for the Goldfish RTC.

Please, don't expect anybody to actually know what is goldfish can you
add a sentence or two?

> +static irqreturn_t goldfish_rtc_interrupt(int irq, void *dev_id)
> +{
> +     struct goldfish_rtc     *qrtc = dev_id;
> +     unsigned long           events = 0;
> +     void __iomem *base = qrtc->base;
> +
> +     writel(1, base + TIMER_CLEAR_INTERRUPT);
> +     events = RTC_IRQF | RTC_AF;
> +
> +     rtc_update_irq(qrtc->rtc, 1, events);

I'd say that events is not needed you can pass the flags directly to
rtc_update_irq

> +static int goldfish_rtc_read_time(struct device *dev, struct rtc_time *tm)
> +{
> +     u64 time;
> +     u64 time_low;
> +     u64 time_high;
> +     u64 time_high_prev;
> +
> +     struct goldfish_rtc *qrtc =
> +                     platform_get_drvdata(to_platform_device(dev));
> +     void __iomem *base = qrtc->base;
> +
> +     time_high = readl(base + TIMER_TIME_HIGH);
> +     do {
> +             time_high_prev = time_high;
> +             time_low = readl(base + TIMER_TIME_LOW);
> +             time_high = readl(base + TIMER_TIME_HIGH);
> +     } while (time_high != time_high_prev);

I'm not sure why you need that loop as the comments for TIMER_TIME_LOW
and TIMER_TIME_HIGH indicate that TIMER_TIME_HIGH is latched when
TIMER_TIME_LOW is read. Note that the original driver from google
doesn't do that.

> +     time = (time_high << 32) | time_low;
> +
> +     do_div(time, NSEC_PER_SEC);
> +
> +     rtc_time_to_tm(time, tm);
> +
> +     return 0;
> +}
> +
> +static const struct rtc_class_ops goldfish_rtc_ops = {
> +     .read_time      = goldfish_rtc_read_time,
> +};
> +
> +static int goldfish_rtc_probe(struct platform_device *pdev)
> +{
> +     struct resource *r;
> +     struct goldfish_rtc *qrtc;
> +     unsigned long rtc_dev_len;
> +     unsigned long rtc_dev_addr;
> +     int err;
> +
> +     qrtc = devm_kzalloc(&pdev->dev, sizeof(*qrtc), GFP_KERNEL);
> +     if (qrtc == NULL)
> +             return -ENOMEM;
> +
> +     platform_set_drvdata(pdev, qrtc);
> +
> +     r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +     if (r == NULL)
> +             return -ENODEV;
> +
> +     rtc_dev_addr = r->start;
> +     rtc_dev_len = resource_size(r);
> +     qrtc->base = devm_ioremap(&pdev->dev, rtc_dev_addr, rtc_dev_len);

devm_ioremap_resource ?

> +     if (IS_ERR(qrtc->base))
> +             return -ENODEV;
> +
> +     qrtc->irq = platform_get_irq(pdev, 0);
> +     if (qrtc->irq < 0)
> +             return -ENODEV;
> +

Is the irq so important that you have to fail here even if the driver
doesn't support any alarm?

> +     qrtc->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
> +                                     &goldfish_rtc_ops, THIS_MODULE);
> +     if (IS_ERR(qrtc->rtc))
> +             return PTR_ERR(qrtc->rtc);
> +
> +     err = devm_request_irq(&pdev->dev, qrtc->irq, goldfish_rtc_interrupt,
> +             0, pdev->name, qrtc);
> +     if (err)
> +             return err;

Ditto.


--
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
