Return-Path: <SRS0=ZXKW=V5=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F75AC19759
	for <linux-mips@archiver.kernel.org>; Thu,  1 Aug 2019 17:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB904206A2
	for <linux-mips@archiver.kernel.org>; Thu,  1 Aug 2019 17:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="jwpEXn91"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732090AbfHARmy (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 1 Aug 2019 13:42:54 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41329 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731372AbfHARmy (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 1 Aug 2019 13:42:54 -0400
Received: by mail-ot1-f66.google.com with SMTP id o101so75170964ota.8;
        Thu, 01 Aug 2019 10:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ECZri73s+Gv0ZwKEFSe2mRTlsjOHPWNXKWGJDthydaM=;
        b=jwpEXn91t6z0IZ1NW08QzkBAryA/5qHOB9K/aGzewYyQndjQ2zmV6S7+j12t/iD7xj
         2grzLSf3qY97IUhyE3doJfyp7YRKupolSIK7osWLVOIh6Y1y7/e6EetmZvoDVax7JYQu
         ELK0KubsZHfeA5VYCQK8wOnC/HDLnPQ4Hzt0SVIgVjIhQ5jSSDkPUPaR1opC5+AnkGXR
         tF1lW+5i3aktJ5U6U+wS/Wph8D+YQ4bmbVDWA7BsUagjgeY401qrr5usDQdkGxP0mz4T
         BI5brUdIaCP9unNkzNF+cHnd9FjJeTHk3aUMJcT+658u5ZeFcYcukNjJehR7CJErpLBu
         5J0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ECZri73s+Gv0ZwKEFSe2mRTlsjOHPWNXKWGJDthydaM=;
        b=bi5udLlO2kq8O447nonq7atabsClnBAwPNMa9Yeroic9c0mBcqUiOBzamPjMogp/hS
         hBkD7GUWqWdxUKvkwIH0SzegumoydoAvY//0VUzsnM6JT+NKgvmjwwlgtGqwNPEdhDHI
         i41q39/J8GskSS+3lwMKASl/qNv4O0pdcMifkHJYzGCpfz7H7QzI9uL5oELtgJTI97Ba
         v0HtOvZ5pQqb51mtql6qaONrMVhdZBTGGBiCwXbeFlkJbahXsvjw162zHrzLnE5QzwC4
         IL+w1q5kD24WHev9yGfWSMDLFg9zFuhAXa7PsrmRNXy8myrRwkEIrS/ciytvf7Pj4wEP
         6+sg==
X-Gm-Message-State: APjAAAWFlDN6kXtgIsKDq3sjfN6ej15FER2RL8P8c1JaPlFtbYatn50c
        v/Jnux0B+CiPRnt9EWPuInhC6+eubxo6CzW6FyY=
X-Google-Smtp-Source: APXvYqwvge2l3cxV/sbmIAl8AdtrZzovSRPfcuZrQO+L4sPr4JGNHOYiIeI6u67E3Qs4v5KPGOwhzDbsNRjd0F7xgEA=
X-Received: by 2002:a9d:39a6:: with SMTP id y35mr33656345otb.81.1564681373244;
 Thu, 01 Aug 2019 10:42:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190727175315.28834-1-martin.blumenstingl@googlemail.com>
 <20190727175315.28834-4-martin.blumenstingl@googlemail.com> <86y30imq9p.wl-marc.zyngier@arm.com>
In-Reply-To: <86y30imq9p.wl-marc.zyngier@arm.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 1 Aug 2019 19:42:42 +0200
Message-ID: <CAFBinCCb4aTfuxaSrUp8xbUjjefi_qHOUJLjzH+acUTLY+6Geg@mail.gmail.com>
Subject: Re: [PATCH 3/5] MIPS: lantiq: add an irq_domain and irq_chip for EBU
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     tglx@linutronix.de, jason@lakedaemon.net, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        john@phrozen.org, Hauke Mehrtens <hauke@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi Marc,

thank you for taking time to review this patch!

On Sun, Jul 28, 2019 at 12:01 PM Marc Zyngier <marc.zyngier@arm.com> wrote:
[...]
> > @@ -15,6 +19,19 @@
> >
> >  #define LTQ_EBU_BUSCON0                              0x0060
> >  #define LTQ_EBU_BUSCON_WRDIS                 BIT(31)
> > +#define LTQ_EBU_PCC_CON                              0x0090
> > +#define LTQ_EBU_PCC_CON_PCCARD_ON            BIT(0)
> > +#define LTQ_EBU_PCC_CON_IREQ_RISING_EDGE        0x2
> > +#define LTQ_EBU_PCC_CON_IREQ_FALLING_EDGE       0x4
> > +#define LTQ_EBU_PCC_CON_IREQ_BOTH_EDGE          0x6
>
> So BOTH_EDGE is actually (RISING_EDGE | FALLING_EDGE). It'd be nice to
> express it this way.
I only notice this now - thank you for the hint
v2 will have this cleaned up

> > +#define LTQ_EBU_PCC_CON_IREQ_DIS                0x8
>
> What does "DIS" mean?
after reading all of your comments it may be "disable edge detection"
I don't have access to the datasheet but I'll ask someone at Intel (Lantiq)

> > +#define LTQ_EBU_PCC_CON_IREQ_HIGH_LEVEL_DETECT  0xa
> > +#define LTQ_EBU_PCC_CON_IREQ_LOW_LEVEL_DETECT        0xc
>
> Again, these two are (DIS | RISING) and (DIS | FALLING).
understood, v2 will use a better name for DIS (assuming there's a
better name) and I'll convert the macros based on your suggestion

[...]
> > +     switch (flow_type & IRQ_TYPE_SENSE_MASK) {
> > +     case IRQ_TYPE_NONE:
> > +             val |= LTQ_EBU_PCC_CON_IREQ_DIS;
> > +             break;
>
> I'm not sure IRQ_TYPE_NONE makes much sense here. What's the expected
> semantic?
if it's "disable edge detection" then this "case" will be removed

[...]
> > +     default:
> > +             pr_err("Invalid trigger mode %x for IRQ %d\n", flow_type,
> > +                    d->irq);
>
> irq_set_type will already complain in the kernel log, no need to add
> an extra message.
I'll drop this in v2, thank you for pointing this out

[...]
> > +static void ltq_ebu_irq_handler(struct irq_desc *desc)
> > +{
> > +     struct irq_domain *domain = irq_desc_get_handler_data(desc);
> > +     struct irq_chip *irqchip = irq_desc_get_chip(desc);
> > +
> > +     chained_irq_enter(irqchip, desc);
> > +
> > +     generic_handle_irq(irq_find_mapping(domain, 0));
>
> Having an irqdomain for a single interrupt is a bit over the top... Is
> that for the convenience of the DT infrastructure?
yes, I did it to get DT support
please let me know if there's a "better" way (preferably with another
driver as example)

[...]
> > +     irq_create_mapping(domain, 0);
>
> Why do you need to perform this eagerly? I'd expect this interrupt to
> be mapped when it is actually claimed by a driver.
I don't remember why I added it, it may be left-over from copying from
another driver
in v2 I'll try to drop it

> > +
> > +     irq_set_chained_handler_and_data(irq, ltq_ebu_irq_handler, domain);
>
> And there is no HW initialisation whatsoever? I'd expect, at the very
> least, the sole interrupt to be configured as disabled/masked.
I can add that. is there any "best practice" on what I should
initialize (just disable it or also set a "default" mode like
LEVEL_LOW)?


Martin
