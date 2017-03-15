Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Mar 2017 10:33:54 +0100 (CET)
Received: from mail-io0-x234.google.com ([IPv6:2607:f8b0:4001:c06::234]:34433
        "EHLO mail-io0-x234.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991932AbdCOJdqD8CvG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Mar 2017 10:33:46 +0100
Received: by mail-io0-x234.google.com with SMTP id b140so16307911iof.1
        for <linux-mips@linux-mips.org>; Wed, 15 Mar 2017 02:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9XteiJQvqeJu5SZ/dDrM03UOL9JAY1aRxrlM7kn9v9c=;
        b=LuPo4lLFWjvvqhpj8KemJslZxD6QfHYzS7Ziv3EJzN1vyzxYPt/v+QyI5Ee50F/c8e
         ay66TbqUrMVT49ZiFyD5ym+mZJ0ew2boW7vEriP2Huq7f2HymzwZepNYnKZO6aJ/INTv
         jni334JnftC760mF9IKdWk38ORr5ghX8GQHkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9XteiJQvqeJu5SZ/dDrM03UOL9JAY1aRxrlM7kn9v9c=;
        b=o9kBo7MWDJK7I3+Xeae6a7AD4k+GZ2RKjOhSF/EK/kwWhx2BNWuMZTRDxjxTOlEBgt
         n/4MzM5k0PgHB/ITaOTrRhjiO45gQLAlRsk5u10Sq18/ZAdPJda2Qp/4dsfjECyBaDas
         GtHW2+65/V39Z7B88Gd6IuJr+5ikwfZv2dSzhzyZi9CXhxJPp8OLelyTjFZha5H/qB4D
         ffWC9ec27qqE+n1xdRJJxhkYsTHgsJpSf4e/voWKyKxvmloE6XZvYu6iFxe9LP9u3TCI
         PX5xhL88du/sPwapEbQVrxmPs9fkT3qneSdIyojbjRHIUAZUlvoSmB2pL9IqbCS95FS3
         p62Q==
X-Gm-Message-State: AFeK/H3yUyeLrdSTHU09TBpfqeiQVv4mJLR7vTkRcAVIgJsgxUSUo9uFOP3RxdYT5lzPMPFqI5xAkxRjOFM56Af1
X-Received: by 10.107.20.193 with SMTP id 184mr3895256iou.61.1489570420267;
 Wed, 15 Mar 2017 02:33:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.134.193 with HTTP; Wed, 15 Mar 2017 02:33:39 -0700 (PDT)
In-Reply-To: <1488830761-681-2-git-send-email-nathan.sullivan@ni.com>
References: <1488830761-681-1-git-send-email-nathan.sullivan@ni.com> <1488830761-681-2-git-send-email-nathan.sullivan@ni.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 15 Mar 2017 10:33:39 +0100
Message-ID: <CACRpkdZm1B=ohBp4eOh8j++SWUwa9dU0-PErdj3P0u-+kvrYzg@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: mmio: add support for NI 169445 NAND GPIO
To:     Nathan Sullivan <nathan.sullivan@ni.com>
Cc:     Alexandre Courbot <gnurou@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57284
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

On Mon, Mar 6, 2017 at 9:06 PM, Nathan Sullivan <nathan.sullivan@ni.com> wrote:

> The GPIO-based NAND controller on National Instruments 169445 hardware
> exposes a set of simple lines for the control signals.
>
> Signed-off-by: Nathan Sullivan <nathan.sullivan@ni.com>

Totally standard ans simple patch, applied.

Hint: it's probably nice to use the gpio-line-names attribute
on these boards to name the lines.

Yours,
Linus Walleij
