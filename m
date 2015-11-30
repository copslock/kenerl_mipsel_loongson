Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2015 13:21:41 +0100 (CET)
Received: from mail-oi0-f47.google.com ([209.85.218.47]:33655 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007949AbbK3MVjfKPXP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Nov 2015 13:21:39 +0100
Received: by oixx65 with SMTP id x65so93582372oix.0
        for <linux-mips@linux-mips.org>; Mon, 30 Nov 2015 04:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=p2MwtY7xTQCuZxnM/gziElGbMnqG4NBE186kivjoNKE=;
        b=KUpnbA+bl1gDIPyfVWsXdqKD/kK5pK1WY/dSAHttva+C2dRT8aaP+t8Wr2rxKbs4+v
         iVpd+4vhibJSVjSHrX/p5mr/nocVdbRpF4zdCnvJntFS3tHGdFxpFIMeABLpr++ERt78
         NEGobFNMwObojp5jbRP1zoFUvAnVlvzdE5JyJTIzKEf0OeBp4eOnoRo65wxKw2emwO/a
         yqEO3CSr3iY0P1xhEVM+zvy+duzld58nB02/WL0GjD2ixHWtRQgnWyubl7t6DOKyNd37
         oVgO7hXE436yY3vZvCQCbJEVbW/cMs3bGRwavVxseI0eXjiuxWhwqV/t88jKKJ0wWTMA
         dt7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=p2MwtY7xTQCuZxnM/gziElGbMnqG4NBE186kivjoNKE=;
        b=NhXZ9iBPsXZvWVAYNWSIrCKDVIvPm6wVX56XoLDKDig3R1OoYAfKgSIDtgRG8Jf9Tc
         S90AgQD+R4vPUqkQSDLSflpQKeaKMA4WSQnZzmF1Dtlm5jWgs6cFVZ477ea8qV06ThWg
         rsqal4H6uBs6fpauWgWolItOgNRYc/XU6J833faopzF32tyj5vnWRbEo8vbl2sJD9tCM
         J2uEMDAGOEYgCe/GEmf4h2vjlOk3VmgydEtye1Osl4BNKSGWw08Mu4n11I8cc+i+bstE
         GxS21BAsTDCOCIjKyL1XrIxgcfxUPw9C9GrpLzKALORehVygtHS4OAh9a22eZEsbtJQ9
         Eplw==
X-Gm-Message-State: ALoCoQkCJzrSKoc/1TfeoknAYqIiEu25Dnd8H/hoIGeoFvVdjWFzkHwuae9yqm/M7Av2mRm69azO
MIME-Version: 1.0
X-Received: by 10.202.98.86 with SMTP id w83mr41259054oib.135.1448886093640;
 Mon, 30 Nov 2015 04:21:33 -0800 (PST)
Received: by 10.182.32.70 with HTTP; Mon, 30 Nov 2015 04:21:33 -0800 (PST)
In-Reply-To: <1448532010-30930-5-git-send-email-mschiller@tdt.de>
References: <1448532010-30930-1-git-send-email-mschiller@tdt.de>
        <1448532010-30930-5-git-send-email-mschiller@tdt.de>
Date:   Mon, 30 Nov 2015 13:21:33 +0100
Message-ID: <CACRpkdaeCR+h+3qLkJXuhwfSCffgbn-nzdKasVxQAKETbk6s5A@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] pinctrl/lantiq: Implement gpio_chip.to_irq
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Martin Schiller <mschiller@tdt.de>
Cc:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Pawe=C5=82_Moll?= <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Jonas Gorski <jogo@openwrt.org>, daniel.schwierzeck@gmail.com
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50172
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.walleij@linaro.org
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

On Thu, Nov 26, 2015 at 11:00 AM, Martin Schiller <mschiller@tdt.de> wrote:

Please write a commit message.

> From: John Crispin <blogic@openwrt.org>
>
> Signed-off-by: John Crispin <blogic@openwrt.org>
> Signed-off-by: Martin Schiller <mschiller@tdt.de>
> ---
> Changes in v3:
> - Moved this change into a separate patch

(...)
> +static int xway_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
> +{
> +       struct ltq_pinmux_info *info = dev_get_drvdata(chip->dev);
> +       int i;
> +
> +       for (i = 0; i < info->num_exin; i++)
> +               if (info->exin[i] == offset)
> +                       return ltq_eiu_get_irq(i);
> +
> +       return -1;
> +}
> +
(...)
> +       .to_irq = xway_gpio_to_irq,

Can you explain this a bit, and add a comment in the code as to
what is going on?

I take it that the Lantiq has a dedicated IRQ line for some of the
GPIO lines, referred to as external interrupts, and then you just
go in and grab that frm the external interrupt unit like this?

Looks OK, just send an updated patch with some more
explanations.

Yours,
Linus Walleij
