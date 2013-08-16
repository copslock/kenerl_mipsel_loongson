Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Aug 2013 23:55:10 +0200 (CEST)
Received: from mail-pd0-f179.google.com ([209.85.192.179]:47956 "EHLO
        mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6865391Ab3HPVzIdklXV convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 16 Aug 2013 23:55:08 +0200
Received: by mail-pd0-f179.google.com with SMTP id v10so2778026pde.10
        for <linux-mips@linux-mips.org>; Fri, 16 Aug 2013 14:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=+arUZU9doYM95sT4MB7jPFtPV99h/Yo2kWAXy7dJgIo=;
        b=sxsdZButpL2UgH4XhA50unTECtE+M5jE6U+vui8UOLqRTcO0bwHrIRhjUIGTh1O6cb
         0MUdBi+HUr9pJt+6kkrUhcpnAlXSq2QhgQHMY0Tl1RKHAe57yM0h0MFpjrsMTDn9Oeza
         Mhg+1GPhjKIbYvY1UqKEuGzHkT0ruH83Xt6I1JZuG0O39IRjinRN59aGx67sM2Ez0TMV
         V9LUYxgxyjV0fpu8hSLd/ivf1+hQWGPngC4+jC/lxU6ZgoInaQi/7wcgyIku8Zd78TVM
         aip+9t5UFIT3W6RWK2DqavFlVXVaKr7NmdW2ruKaeJxFhNQnsV9ewmMSXS7s1ryKrvQe
         8wAA==
MIME-Version: 1.0
X-Received: by 10.67.23.227 with SMTP id id3mr771943pad.101.1376690102127;
 Fri, 16 Aug 2013 14:55:02 -0700 (PDT)
Received: by 10.70.18.229 with HTTP; Fri, 16 Aug 2013 14:55:02 -0700 (PDT)
In-Reply-To: <20130816202702.GD4568@roeck-us.net>
References: <520A1D56.2050507@roeck-us.net>
        <20130813175858.GC7336@kroah.com>
        <20130813201936.GA18358@roeck-us.net>
        <20130815063158.GB25754@kroah.com>
        <520C86BD.2020903@roeck-us.net>
        <CAMuHMdU+EOC_etihOzUC6N0cqc2qHaGm3_L+gyTRxESCGhOzEg@mail.gmail.com>
        <520DB045.7000309@roeck-us.net>
        <20130816051041.GA23784@kroah.com>
        <520DE21D.8000905@roeck-us.net>
        <20130816124140.GD24550@kroah.com>
        <20130816202702.GD4568@roeck-us.net>
Date:   Fri, 16 Aug 2013 23:55:02 +0200
X-Google-Sender-Auth: V5s-jvDrGM-Kyn7v61tHhUC-kHc
Message-ID: <CAMuHMdW6Ji7ibMeQj5FBQsJS3B-WWx=Lbhmjx4CCFEGg_uobHQ@mail.gmail.com>
Subject: Re: [ 00/17] 3.4.58-stable review
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37578
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

On Fri, Aug 16, 2013 at 10:27 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> Still failing:
>         sparc64:allmodconfig
> /opt/buildbot/slave/stable-queue-3_4/build/usr/include/linux/types.h:27:1: error: unknown type name ‘__u16’

According to my log collection, this same error message was fixed in v3.3-rc2,
but I couldn't easily find a matching commit.
But this is v3.4-stable, which is after v3.3-rc2, so it got reintroduced?

>         xtensa:defconfig
> dev.c:(.text.unlikely+0x3): dangerous relocation: l32r: literal placed after use: .literal.unlikely

Fixed in v3.7-rc1:

commit f6a03a12ecdbe0dd80a55f6df3b7206c5a403a49
Author: Max Filippov <jcmvbkbc@gmail.com>
Date:   Mon Sep 17 05:44:31 2012 +0400

    xtensa: fix linker script transformation for .text.unlikely

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
