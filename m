Return-Path: <SRS0=HO0d=WG=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C3CC433FF
	for <linux-mips@archiver.kernel.org>; Sat, 10 Aug 2019 13:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3DCE2089E
	for <linux-mips@archiver.kernel.org>; Sat, 10 Aug 2019 13:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPsKK6pH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbfHJNWf (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sat, 10 Aug 2019 09:22:35 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38769 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbfHJNWf (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sat, 10 Aug 2019 09:22:35 -0400
Received: by mail-pf1-f194.google.com with SMTP id o70so2137191pfg.5;
        Sat, 10 Aug 2019 06:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LfW5UF0WPSwNFC1koZjG966JXkoCnsznfqFsgicfjg8=;
        b=OPsKK6pHC3yZdyenxTPa20jzJOU7f3JYhxC93PljEcQX9igFGL2qlfwdailJ/xdUfk
         fpgjyXzTOLG4g9OELLgIHNm0PW8FsVyN9t9KiHjgQAVX9CHmL83bT5slfsMJyWJIkZjX
         rfV838BJRlkFRoGb6lsjGvfsjORtC6n6p/gmL3o11kV91BwGuXvaC25iLwNLspDnej3M
         lDgWemBFnOt0+gBqBqmI4vejgSTwk/tFTXvxygP5OqmRK/K4qVeoNj6aC9ny23WKLzu6
         hPiaVwyIN6FbILIaa2lJgQ+kLSwRr1QXe1efVr9giSv8yG73k4AxUDMtkADX0Amd0+GR
         E4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LfW5UF0WPSwNFC1koZjG966JXkoCnsznfqFsgicfjg8=;
        b=KZDz0kEx5x+u+9oTsDZqWqe6YXDVujvv0qddLZXE0EutJcipm+ACkgSj0Wg/3wXEhq
         DPxmlxeNnLz7arggbuEQryRy/bc/5SzELLpztrfYyTHAXmTyiokZSZynjnxKQZZQL8ig
         9VrgNaBiCof0Ba6EpY19arNmzP2k+OIE4BQoID7mwZUswy/i4knCM2Y30LkBcCzoJcax
         db+aWqdwTTvQLZlqtbmVgpBsxOc1bgZvq7IwkUJDGYcln8i3B4t/rHicF4PgB2nGAwTs
         xpzL3A+vjEhs+eA10q/VFGzRLEBvpqfpcob1RXf1rEWFJEsf38gq7Uk7SmEbhGaYHmLe
         EDjw==
X-Gm-Message-State: APjAAAU7VZ9xGNkwT6W5JklwWxm/AQIRZd9Z+T+OhXe8XWCKMUmItfo3
        h2wauGrI0Pls+nghuFHI0tj8XGMrnJr9nRerO1k=
X-Google-Smtp-Source: APXvYqxQT51h8e21Sc17cPTK0edaN0yHI50B5ITFrzWoOtZPeT+kpbZrUJ0l2TgTjr9UCUJO4kWXj1vrRYD+GgjBBuU=
X-Received: by 2002:a17:90a:7788:: with SMTP id v8mr14874709pjk.132.1565443354292;
 Sat, 10 Aug 2019 06:22:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190809103235.16338-1-tbogendoerfer@suse.de> <20190809103235.16338-9-tbogendoerfer@suse.de>
In-Reply-To: <20190809103235.16338-9-tbogendoerfer@suse.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 10 Aug 2019 16:22:23 +0300
Message-ID: <CAHp75Vd_083R9sRsspVuJ3ZMTxpVR79PF5Lg-bpnMxRfN+b7wA@mail.gmail.com>
Subject: Re: [PATCH v4 8/9] MIPS: SGI-IP27: fix readb/writeb addressing
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Evgeniy Polyakov <zbr@ioremap.net>, linux-mips@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Fri, Aug 9, 2019 at 1:34 PM Thomas Bogendoerfer
<tbogendoerfer@suse.de> wrote:
>
> Our chosen byte swapping, which is what firmware already uses, is to
> do readl/writel by normal lw/sw intructions (data invariance). This
> also means we need to mangle addresses for u8 and u16 accesses. The
> mangling for 16bit has been done aready, but 8bit one was missing.
> Correcting this causes different addresses for accesses to the
> SuperIO and local bus of the IOC3 chip. This is fixed by changing
> byte order in ioc3 and m48rtc_rtc structs.

>  /* serial port register map */
>  struct ioc3_serialregs {
> -       uint32_t        sscr;
> -       uint32_t        stpir;
> -       uint32_t        stcir;
> -       uint32_t        srpir;
> -       uint32_t        srcir;
> -       uint32_t        srtr;
> -       uint32_t        shadow;
> +       u32     sscr;
> +       u32     stpir;
> +       u32     stcir;
> +       u32     srpir;
> +       u32     srcir;
> +       u32     srtr;
> +       u32     shadow;
>  };

Isn't it a churn? AFAIU kernel documentation the uint32_t is okay to
use, just be consistent inside one module / driver.
Am I mistaken?


-- 
With Best Regards,
Andy Shevchenko
