Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jun 2017 13:49:11 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:25738 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992036AbdFTLtFI90cV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Jun 2017 13:49:05 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id A37C95FEEAF93;
        Tue, 20 Jun 2017 12:48:55 +0100 (IST)
Received: from [192.168.154.107] (192.168.154.107) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 20 Jun
 2017 12:48:58 +0100
Subject: Re: [PATCH 02/10] MIPS: ranchu: Add Goldfish RTC driver
To:     Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
        <linux-mips@linux-mips.org>, <James.Hogan@imgtec.com>,
        <Paul.Burton@imgtec.com>
CC:     <Raghu.Gandham@imgtec.com>, <Leonid.Yegoshin@imgtec.com>,
        <Douglas.Leung@imgtec.com>, <Petar.Jovanovic@imgtec.com>,
        <Miodrag.Dinic@imgtec.com>, <Goran.Ferenc@imgtec.com>
References: <1497887380-13718-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1497887380-13718-3-git-send-email-aleksandar.markovic@rt-rk.com>
From:   Harvey Hunt <Harvey.Hunt@imgtec.com>
Message-ID: <916a045a-d0dc-3ad9-560d-c4d1d931600d@imgtec.com>
Date:   Tue, 20 Jun 2017 12:48:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <1497887380-13718-3-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.107]
Return-Path: <Harvey.Hunt@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58682
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Harvey.Hunt@imgtec.com
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

Hi Aleksandar,

You've not CC'ed any of the maintainers or mailing lists other than 
linux-mips, so it's likely that reviewers will be unaware of your patchset.

scripts/get_maintainer.pl will show you which email addresses to send to.

On 19/06/17 16:49, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
> 
> Add device driver for a virtual Goldfish RTC clock.
> 
> The driver can be build only if CONFIG_MIPS and CONFIG_GOLDFISH

s/build/built

> are set. The device tree key used by OS for binding the driver is
> defined as "google,goldfish-rtc".

This is usually referred to as the compatible string

[...]

> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/rtc.h>
> +
> +enum {
> +	TIMER_TIME_LOW          = 0x00,	/* get low bits of current time  */
> +					/*   and update TIMER_TIME_HIGH  */
> +	TIMER_TIME_HIGH         = 0x04,	/* get high bits of time at last */
> +					/*   TIMER_TIME_LOW read         */
> +	TIMER_ALARM_LOW         = 0x08, /* set low bits of alarm and     */
> +					/*   activate it                 */
> +	TIMER_ALARM_HIGH        = 0x0c, /* set high bits of next alarm   */
> +	TIMER_CLEAR_INTERRUPT   = 0x10,
> +	TIMER_CLEAR_ALARM       = 0x14
> +};

Why an enum rather than defines?

> +
> +struct goldfish_rtc {
> +	void __iomem *base;
> +	uint32_t irq;

s/uint32_t/u32

> +	struct rtc_device *rtc;
> +};
> +
> +static irqreturn_t
> +goldfish_rtc_interrupt(int irq, void *dev_id)

You could make this into one line

> +{
> +	struct goldfish_rtc	*qrtc = dev_id;
> +	unsigned long		events = 0;
> +	void __iomem *base = qrtc->base;
> +
> +	writel(1, base + TIMER_CLEAR_INTERRUPT);
> +	events = RTC_IRQF | RTC_AF;
> +
> +	rtc_update_irq(qrtc->rtc, 1, events);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int goldfish_rtc_read_time(struct device *dev, struct rtc_time *tm)
> +{
> +	uint64_t time;
> +	uint64_t time_low;
> +	uint64_t time_high;
> +	uint64_t time_high_prev;

s/uint64_t/u64

> +	struct goldfish_rtc *qrtc =
> +			platform_get_drvdata(to_platform_device(dev));
> +	void __iomem *base = qrtc->base;
> +
> +	time_high = readl(base + TIMER_TIME_HIGH);
> +	do {
> +		time_high_prev = time_high;
> +		time_low = readl(base + TIMER_TIME_LOW);
> +		time_high = readl(base + TIMER_TIME_HIGH);
> +	} while (time_high != time_high_prev);
> +	time = ((int64_t)time_high << 32) | time_low;

Why a signed type?

> +
> +	do_div(time, NSEC_PER_SEC);
> +
> +	rtc_time_to_tm(time, tm);
> +	return 0;
> +}
> +
> +static const struct rtc_class_ops goldfish_rtc_ops = {
> +	.read_time	= goldfish_rtc_read_time,
> +};
> +
> +static int goldfish_rtc_probe(struct platform_device *pdev)
> +{
> +	int ret;

You can remove this variable (see later for justification)

> +	struct resource *r;
> +	struct goldfish_rtc *qrtc;
> +	unsigned long rtc_dev_len;
> +	unsigned long rtc_dev_addr;
> +
> +	qrtc = devm_kzalloc(&pdev->dev, sizeof(*qrtc), GFP_KERNEL);
> +	if (qrtc == NULL) {

if (!qrtc) {

> +		ret = -ENOMEM;
> +		goto error;

There's no need to goto error, so this can become:

return -ENOMEM;

> +	}
> +	platform_set_drvdata(pdev, qrtc);
> +
> +	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (r == NULL) {

if (!r) {

> +		ret = -ENODEV;
> +		goto error;

There's no need to goto error, so this can become:

return -ENODEV;

> +	}
> +
> +	rtc_dev_addr = r->start;
> +	rtc_dev_len = resource_size(r);
> +	qrtc->base = devm_ioremap(&pdev->dev, rtc_dev_addr, rtc_dev_len);
> +	if (IS_ERR(qrtc->base)) {
> +		ret = -ENODEV;
> +		goto error;

Ditto

> +	}
> +
> +	qrtc->irq = platform_get_irq(pdev, 0);
> +	if (qrtc->irq < 0) {
> +		ret = -ENODEV;
> +		goto error;

Ditto

> +	}
> +
> +	qrtc->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
> +					&goldfish_rtc_ops, THIS_MODULE);
> +	if (IS_ERR(qrtc->rtc)) {
> +		ret = PTR_ERR(qrtc->rtc);
> +		goto error;

Ditto

> +	}
> +
> +	ret = devm_request_irq(&pdev->dev, qrtc->irq, goldfish_rtc_interrupt,
> +		0, pdev->name, qrtc);
> +	if (ret)
> +		goto error;

Ditto

> +
> +	return 0;
> +
> +error:
> +	return ret;

This label can be removed

> +}
> +
> +static const struct of_device_id goldfish_rtc_of_match[] = {
> +	{ .compatible = "google,goldfish-rtc", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, goldfish_rtc_of_match);
> +
> +static struct platform_driver goldfish_rtc = {
> +	.probe = goldfish_rtc_probe,
> +	.driver = {
> +		.name = "goldfish_rtc",
> +		.of_match_table = goldfish_rtc_of_match,
> +	}
> +};
> +
> +module_platform_driver(goldfish_rtc);
> 

Thanks,

Harvey
