Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2017 15:16:51 +0100 (CET)
Received: from mail-it0-x229.google.com ([IPv6:2607:f8b0:4001:c0b::229]:35840
        "EHLO mail-it0-x229.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993892AbdAaOQoBShue (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Jan 2017 15:16:44 +0100
Received: by mail-it0-x229.google.com with SMTP id c7so216725606itd.1
        for <linux-mips@linux-mips.org>; Tue, 31 Jan 2017 06:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4j3Qt1vr+kDpX0TMSnUUuAXlpCEZr9GiWYIU3ZE4jaY=;
        b=g18zyPm+E04hKTY22eW78i4OJAqSQKLIj90EjImNZ+J5uDqMLgj6LX40Di/NXdIl89
         4RYzLYfqFAghWiTF0RjBDc2trGJdHbjxyQwkmt1nN/jFdMBx/SpYXD0KvdgYuYv5vJ15
         YrXMJSnUsBS9xXIYnfhracqegA34uam3g6PKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4j3Qt1vr+kDpX0TMSnUUuAXlpCEZr9GiWYIU3ZE4jaY=;
        b=Guv77AjI19Dr7pVHMn775vkRPw2Agr5jIYmJEVspnAdvf6KJCQ0YKLixyNxpx9m1nk
         FY8CM/y21ac/O1/AYVJ3vpN7Pthc0AC7mRlKDKcZDSVg5ip7aPs8smCmahPe0UJsQeLA
         DNPzuiNemM4E/CVRgvVGuVwM8iJ7ZsoA1Jf/O7MoZnAcO9wtINgBoIYc7zg2nYSQ8zs1
         ZcXDWDC6h8qpAq2nNynGcQ7l0pmp5sluKO2MToUiVnF3Q9/BfFiz1Gd0QPQWpYKQI4+2
         nk4e29BBj3ApR/KJv88/X91ZzOXAV6WsFTWA8nZ9hpaOHyjV3MChKrzScHEo/u0WEPGF
         aAtw==
X-Gm-Message-State: AIkVDXJho+0VFjhhUyeO5FpUu3EHPEDTeFfN1u4t80umRV02Zrmu9jvCJg0CnnWDTKZNE8z9IvTqVRI5I+9ow2DS
X-Received: by 10.36.123.136 with SMTP id q130mr20059442itc.25.1485872198386;
 Tue, 31 Jan 2017 06:16:38 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.169.75 with HTTP; Tue, 31 Jan 2017 06:16:37 -0800 (PST)
In-Reply-To: <20170125185207.23902-7-paul@crapouillou.net>
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
 <20170125185207.23902-1-paul@crapouillou.net> <20170125185207.23902-7-paul@crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 31 Jan 2017 15:16:37 +0100
Message-ID: <CACRpkdbzzF7jSHZZD2dCixeVZDLVa3R7-1avXwyKc1-RQDK9jw@mail.gmail.com>
Subject: Re: [PATCH v3 06/14] MIPS: jz4740: DTS: Add nodes for ingenic pinctrl
 and gpio drivers
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Burton <paul.burton@imgtec.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56548
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

On Wed, Jan 25, 2017 at 7:51 PM, Paul Cercueil <paul@crapouillou.net> wrote:

> For a description of the pinctrl devicetree node, please read
> Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.txt
>
> For a description of the gpio devicetree nodes, please read
> Documentation/devicetree/bindings/gpio/ingenic,gpio.txt
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  arch/mips/boot/dts/ingenic/jz4740.dtsi | 194 +++++++++++++++++++++++++++++++++
>  1 file changed, 194 insertions(+)
>
> v2: Changed the devicetree bindings to match the new driver
> v3: No changes

This looks good to me, except the use of ingenic,pins instead
of just pins and the GPIO base property
which needs to be removed from the DT bindings and
the driver alike.

But now we're discussing where to put these GPIO controllers
in the device tree in another thread. Maybe as subnodes of the
pin controller...

Yours,
Linus Walleij
