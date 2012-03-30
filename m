Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Mar 2012 16:01:40 +0200 (CEST)
Received: from smtp-vbr6.xs4all.nl ([194.109.24.26]:2855 "EHLO
        smtp-vbr6.xs4all.nl" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903611Ab2C3OBa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Mar 2012 16:01:30 +0200
Received: from starbug-2.trinair2002 (dhcp-089-098-069-120.chello.nl [89.98.69.120])
        (authenticated bits=0)
        by smtp-vbr6.xs4all.nl (8.13.8/8.13.8) with ESMTP id q2UE1N9W054753;
        Fri, 30 Mar 2012 16:01:24 +0200 (CEST)
        (envelope-from maarten@treewalker.org)
Received: from hyperion.localnet (hyperion.trinair2002 [192.168.0.43])
        by starbug-2.trinair2002 (Postfix) with ESMTP id 9673A3DF47;
        Fri, 30 Mar 2012 16:01:23 +0200 (CEST)
From:   Maarten ter Huurne <maarten@treewalker.org>
To:     Sergei Shtylyov <sshtylyov@mvista.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: JZ4740: reset: Initialize hibernate wakeup counters.
Date:   Fri, 30 Mar 2012 16:07:41 +0200
Message-ID: <27793108.UosBlGQXP9@hyperion>
User-Agent: KMail/4.8.0 (Linux/3.1.9-1.4-default; KDE/4.8.1; x86_64; ; )
In-Reply-To: <4F75A5C3.9000405@mvista.com>
References: <1333037998-18762-1-git-send-email-maarten@treewalker.org> <4F75A5C3.9000405@mvista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Virus-Scanned: by XS4ALL Virus Scanner
X-archive-position: 32827
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maarten@treewalker.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Friday 30 March 2012 16:23:31 Sergei Shtylyov wrote:

[...]

> > +static void jz4740_power_off(void)
> > +{
> > +	void __iomem *rtc_base = ioremap(JZ4740_RTC_BASE_ADDR, 0x38);
> > +	unsigned long long wakeup_filter_ticks;
> > +	unsigned long long reset_counter_ticks;
> > +
> > +	/* Set minimum wakeup pin assertion time: 100 ms.
> > +	   Range is 0 to 2 sec if RTC is clocked at 32 kHz. */
> > +	wakeup_filter_ticks = (100 * jz4740_clock_bdata.rtc_rate) / 1000;
> > +	if (wakeup_filter_ticks<  JZ_RTC_WAKEUP_FILTER_MASK)
> > +		wakeup_filter_ticks&= JZ_RTC_WAKEUP_FILTER_MASK;
> > +	else
> > +		wakeup_filter_ticks = JZ_RTC_WAKEUP_FILTER_MASK;
> > +	jz4740_rtc_wait_ready(rtc_base);
> > +	writel(wakeup_filter_ticks, rtc_base + JZ_REG_RTC_WAKEUP_FILTER);
> 
>     Writing 64-bit variable to a 32-bit register?

Actually the variable can be 32-bit: rtc_rate is in kHz, so the computation 
would wrap around for an RTC clock of over 40 GHz and I'm sure that is far 
more than the hardware supports.

I'll prepare a new patch fixing this and the other issues you mentioned. 
Thanks for reviewing.

Bye,
		Maarten
