Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Oct 2015 09:41:23 +0200 (CEST)
Received: from mail-ob0-f176.google.com ([209.85.214.176]:34871 "EHLO
        mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008855AbbJEHlWRDCyy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Oct 2015 09:41:22 +0200
Received: by obbzf10 with SMTP id zf10so122347964obb.2
        for <linux-mips@linux-mips.org>; Mon, 05 Oct 2015 00:41:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=TbFaei5fFV/SJ6K3kTN5Et6SvGoxEhxu0GDvoK2YtMw=;
        b=Plo4eNnRIKGzDS2ITyMt2Oft8WS1dKpIwMz3twvXuOP7Fj/Znb0IOnvVim2IngFCgc
         O3/5ToBQO5/B6iWB5rzem7z3aghY/3SDJrIfstekU6gAiuCErTvE0jg2QGcJrzkr1Twi
         kFKyVneadFUNKHwZiUwazEdB0Ro995VxPpVm4jmmGjL6YqlBDBUaBfM132JP2WaVOSV7
         0qxU8W5nQeNjKXcSkSRdtWuImBp0T2os5zB9nL/WZTLxNmcjLjZ+f6mtq+hdHscfFntN
         F6o9wU/3UF0CDeO6AYKgdP5HBI+vOr9Q61EGgWP+f126ZpFJ0n5g4dvPYo4pm4MW1eti
         GgnA==
X-Gm-Message-State: ALoCoQnseBa5qVN1DPuadDI5tU8I8yvEwNHe6HdXUFZ+Vf6M+jevoZPnK4GRFQ6PcYaLYo18iEXd
MIME-Version: 1.0
X-Received: by 10.60.123.2 with SMTP id lw2mr17163831oeb.2.1444030874762; Mon,
 05 Oct 2015 00:41:14 -0700 (PDT)
Received: by 10.182.44.135 with HTTP; Mon, 5 Oct 2015 00:41:14 -0700 (PDT)
In-Reply-To: <20151002085254.6a929c58@tock>
References: <1441100282-13584-1-git-send-email-albeu@free.fr>
        <CACRpkdbX+cMmS-j85zqhPSa8XRQHtus6HXqZrLo9b++KAHDc5g@mail.gmail.com>
        <20151002085254.6a929c58@tock>
Date:   Mon, 5 Oct 2015 09:41:14 +0200
Message-ID: <CACRpkdbyWyvLQyv8abZju4zA62JP2ARgXcsrXhX5gdWBRS+L2w@mail.gmail.com>
Subject: Re: [PATCH] gpio: ath79: Convert to the state container design pattern
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Alban <albeu@free.fr>
Cc:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Gabor Juhos <juhosg@openwrt.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49420
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

On Fri, Oct 2, 2015 at 8:52 AM, Alban <albeu@free.fr> wrote:

>> Would you consider sending a patch adding yourself as maintainer
>> for this file in MAINTAINERS?
>
> Yes, I'll send that soon.

Thanks!

> However while looking at adding IRQ support I stumbled upon the bgpio
> API from the generic gpio driver. I think it might make more sense
> to simply move to this API instead of doing the above cleanup. I'll
> send a patch for this in the next days.

Yeah maybe that is better. For IRQ support please use GPIOLIB_IRQCHIP
if you can. I think I saw that OpenWRT has implemented IRQ support for
ath79 with some outoftree patch right?

Yours,
Linus Walleij
