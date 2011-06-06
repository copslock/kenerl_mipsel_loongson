Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jun 2011 13:23:51 +0200 (CEST)
Received: from mail-qw0-f49.google.com ([209.85.216.49]:39433 "EHLO
        mail-qw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490978Ab1FFLXs convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 6 Jun 2011 13:23:48 +0200
Received: by qwi2 with SMTP id 2so2080893qwi.36
        for <linux-mips@linux-mips.org>; Mon, 06 Jun 2011 04:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1Y/1Xz+veULU1juedg8a1ZBlbh0LXI9Ab5GEegPR8+Y=;
        b=P1LXs+oOmWbomaA7A2OwvO1x752O7Kuv4wU0zTj+h+nw/7C0y2ZC9SzR+wWOD0ViSm
         wv/kCuim5xpTdCd3Wnpr/9qU23XSJPqYd5waR2prB9Q9CMXtOAFwjtNG+CW8DpOMcvCm
         7VxBMPl7uExjyvxyjsEii9wgCdHVljgmr4iw8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KNWgiDZLD+V5FOWBO9zXyAncnw42HbiGQZf3NTbOmukODke4bNoRvu/Kt7v2ic/41C
         qbg9QkIhQWO+NE/CMTWKq11kPfOE6lARp2jDEyQFK0+HEX+1qC15d4cle2e+7jxdTa9V
         Ti1ByEtWxMWTjgf5ZEDtctTNnQujay/zRpCwM=
MIME-Version: 1.0
Received: by 10.229.118.69 with SMTP id u5mr3407780qcq.122.1307359422318; Mon,
 06 Jun 2011 04:23:42 -0700 (PDT)
Received: by 10.229.96.21 with HTTP; Mon, 6 Jun 2011 04:23:42 -0700 (PDT)
In-Reply-To: <1307311658-15853-5-git-send-email-hauke@hauke-m.de>
References: <1307311658-15853-1-git-send-email-hauke@hauke-m.de>
        <1307311658-15853-5-git-send-email-hauke@hauke-m.de>
Date:   Mon, 6 Jun 2011 13:23:42 +0200
Message-ID: <BANLkTim_TtNVmmyH5J3G0pK-vrWNL1+24A@mail.gmail.com>
Subject: Re: [RFC][PATCH 04/10] bcma: add mips driver
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     linux-wireless@vger.kernel.org, linux-mips@linux-mips.org,
        mb@bu3sch.de, george@znau.edu.ua, arend@broadcom.com,
        b43-dev@lists.infradead.org, bernhardloos@googlemail.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 30252
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 4136

2011/6/6 Hauke Mehrtens <hauke@hauke-m.de>:
> +/* driver_mips.c */
> +extern unsigned int bcma_core_mips_irq(struct bcma_device *dev);

Does it compile without CONFIG_BCMA_DRIVER_MIPS?


> +/* Get the MIPS IRQ assignment for a specified device.
> + * If unassigned, 0 is returned.
> + * If disabled, 5 is returned.
> + * If not supported, 6 is returned.
> + */

Does it ever return 6?


> +unsigned int bcma_core_mips_irq(struct bcma_device *dev)
> +{
> +       struct bcma_device *mdev = dev->bus->drv_mips.core;
> +       u32 irqflag;
> +       unsigned int irq;
> +
> +       irqflag = bcma_core_mips_irqflag(dev);
> +
> +       for (irq = 1; irq <= 4; irq++)
> +               if (bcma_read32(mdev, BCMA_MIPS_MIPS74K_INTMASK(irq)) & (1 << irqflag))
> +                       break;

Use scripts/checkpatch*. Braces around "for" and split line to match
80 chars width.

Why don't you just use "return irq;" instead of break?


> +
> +       if (irq == 5)
> +               irq = 0;
> +
> +       return irq;

You can just make it "return 0;" after changing break to return.


> +                       for (i = 0; i < bus->nr_cores; i++)
> +                               if ((1 << bcma_core_mips_irqflag(&bus->cores[i])) == oldirqflag) {
> +                                       bcma_core_mips_set_irq(&bus->cores[i], 0);
> +                                       break;
> +                               }

Braces for "for".


> +       pr_info("after irq reconfiguration\n");

Make first letter uppercase. I'm not English expert, but doesn't
something like "IRQ reconfiguration done" sound better?

-- 
Rafał
