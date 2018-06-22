Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jun 2018 15:10:25 +0200 (CEST)
Received: from mail-vk0-f67.google.com ([209.85.213.67]:39128 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993104AbeFVNKRXM7EB convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 22 Jun 2018 15:10:17 +0200
Received: by mail-vk0-f67.google.com with SMTP id r83-v6so3865490vkf.6
        for <linux-mips@linux-mips.org>; Fri, 22 Jun 2018 06:10:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ut/4QJGsufGW+Nm0DUNoMHHNGmiTCJyMQmIVxxy7OL8=;
        b=GbXB+KElAWHWocB2kQiS8cAVaatz9ccNs3yhEEQtKQSp+KfPh2ZF8qaXw2TFj2nKG0
         rTbRNFmK+VEMaLFnO6F4rp6WekFmGZ11es0rRoqIu1+XDq4CPe/3JpZGMxAOq8o0A/aZ
         JsIGpQsIEsg0g75lnr3tSBkezIqwP2vfJXySiWZPDhdt3quwWkz+Bqb2cqBr4B9dkQFO
         FpQyICXJU92ckR94AkUfFjDKu63d/tlNLRHlJq9WrhPCgaplQVvwKmIM/siESgbi1kh3
         5JSpHSGRHQHQFDzcDOllvlKCm9A0kUiguHoVIIb82sMQiw38IO2rpmQeEBX9tUj7u5js
         NLqg==
X-Gm-Message-State: APt69E1sW6joUwf8s3pVS2HtDdTJHTakQ26iws9IuBXWsFZEvaM205/s
        DT9zKXICT2zYBiuFIBmPdiYbIMSLmxYbE5/JnXE=
X-Google-Smtp-Source: ADUXVKJ09BT6RLW5d2rMDWcp+dS5U3FSuZPqgNVIAgO75ZoTt2zWoPSgOE2s+BMqsytMworPNm05p31fAS5u4GGDY1o=
X-Received: by 2002:a1f:8307:: with SMTP id f7-v6mr900763vkd.3.1529673011210;
 Fri, 22 Jun 2018 06:10:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180622075421.16001-1-geert@linux-m68k.org> <alpine.DEB.2.21.1806221446230.2402@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1806221446230.2402@nanos.tec.linutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 22 Jun 2018 15:09:59 +0200
Message-ID: <CAMuHMdW9FUMQ568GTJG_p9J8jFbVLOR6hPhsxsaMTttQjp=Wzw@mail.gmail.com>
Subject: Re: [PATCH v2] time: Make sure jiffies_to_msecs() preserves non-zero
 time periods
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64410
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

Hi Thomas,

On Fri, Jun 22, 2018 at 2:49 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> On Fri, 22 Jun 2018, Geert Uytterhoeven wrote:
> > For the common cases where 1000 is a multiple of HZ, or HZ is a multiple
> > of 1000, jiffies_to_msecs() never returns zero when passed a non-zero
> > time period.
> >
> > However, if HZ > 1000 and not an integer multiple of 1000 (e.g. 1024 or
> > 1200, as used on alpha and DECstation), jiffies_to_msecs() may return
> > zero for small non-zero time periods.  This may break code that relies
> > on receiving back a non-zero value.
> >
> > jiffies_to_usecs() does not need such a fix, as <linux/jiffies.h> does
> > not support values of HZ larger than 12287, thus rejecting any
> > problematic huge values of HZ.
>
> Sorry, I'm not understanding that sentence at all.

Sorry for being unclear.

1 jiffy can only be less than 1µs if HZ > 1000000.
But include/linux/jiffies.h checks if HZ >= 12288, and does #error otherwise.
In addition, there's a "BUILD_BUG_ON(HZ > USEC_PER_SEC)" in time.c

> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> This lacks a stable tag, right?

Up to the maintainer to add, isn't it?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
