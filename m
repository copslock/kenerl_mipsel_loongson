Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 May 2018 05:04:32 +0200 (CEST)
Received: from mail-qt0-x243.google.com ([IPv6:2607:f8b0:400d:c0d::243]:43449
        "EHLO mail-qt0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990396AbeEFDEZDytdL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 6 May 2018 05:04:25 +0200
Received: by mail-qt0-x243.google.com with SMTP id f13-v6so22458139qtp.10;
        Sat, 05 May 2018 20:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ZaLxQ/yP9Tn1dHEFitr4GXCdTEDWcl6RdFI6jXRG61k=;
        b=QWABn7r9paNawwvjSsbf0ag1xu32x0r6acGzvEMgZieAWEMJFso5JziebtlvEsZXR3
         WBk891fe0fLZG8tkNtTfMc7pJaadBrJndBInfAqgmMWppvxtf3018Mmr1omeRPymU5Bi
         ZRJV2H0S1doCSQk0pf0Bl2Pthc0QFRrTVI4nUqRm8Ppib07HEwC6FsO197ZhH90iyxXH
         o0MBizHlsBzaLdigUfrwQbjtTt+ci2aClv5hH73i0bG5gxvtK2ikdzaE2hioKOCrSCg5
         NCwzZBRoLcVKx7dtvp28bey2vGaa5AwOXHnCU+4r6BGBTSWO3UpLnmuqxwCy6C1Kg+VY
         qw5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ZaLxQ/yP9Tn1dHEFitr4GXCdTEDWcl6RdFI6jXRG61k=;
        b=X8HhfqImS0RYDARdqIqQsHCO08/7i7BqM2vXLzniCkJHhXHCwPA1UnuzjwrTq1M6B5
         cFWJ7tiJlIQ05T4WtJinkQFFf4gTvw+3kN8TMAEgrhqpwbo3MKMKph24DsBut5nRj7x5
         S0WGeqheSVLYfWtRJpAoQjYWnyUDXHa1AZG3XQLzzsdD1GpUAm3iA0KD7ywmriH1nirx
         /WMEy1ekTQ1JighKGgqfNwesX7kWjomZKgBVjjJiadqfnLnqAlzeYQVl2G6NskX6HxMV
         rXcYC54ENtaA8z9/XCwzBP4caGclBodDZLSYlba3HmUhVmm187NdH+4payPD4ErUWiAb
         4KpQ==
X-Gm-Message-State: ALQs6tB82p2gV4uw+SpPvok00mYADQdWs5arlo+SIl0cZouiXXEXpDfj
        q+gNb9dhushIhhGmggYe8Egxxqp1++m0L2CRh80=
X-Google-Smtp-Source: AB8JxZoQZfzWXE3QFmUNcLpqrsPLSDIglqjH1BXmEAq0hLXMj3BgvLEguBYK7FAr+tXq8nvlGvwBc6wYMG68Xk8Ib+M=
X-Received: by 2002:a0c:bda4:: with SMTP id n36-v6mr26409930qvg.151.1525575858528;
 Sat, 05 May 2018 20:04:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.185.3 with HTTP; Sat, 5 May 2018 20:04:18 -0700 (PDT)
In-Reply-To: <2d0bcca30f61036e413ba01c686ce6506f187462.1525417306.git.baolin.wang@linaro.org>
References: <c26982955db16b8f790e7f5f2a5b63e42bc78192.1525417306.git.baolin.wang@linaro.org>
 <2d0bcca30f61036e413ba01c686ce6506f187462.1525417306.git.baolin.wang@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 5 May 2018 23:04:18 -0400
X-Google-Sender-Auth: 5GLMkONbr88zeF4D7OZDrDugpqY
Message-ID: <CAK8P3a2eXo6MkLLkzQVDtk_W+2x+68iphsX3MXAtzpTYDaREiQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] MIPS: Convert update_persistent_clock() to update_persistent_clock64()
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, chenhc@lemote.com,
        Kate Stewart <kstewart@linuxfoundation.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Mark Brown <broonie@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63876
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Fri, May 4, 2018 at 3:07 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
> Since struct timespec is not y2038 safe on 32bit machines, this patch
> converts update_persistent_clock() to update_persistent_clock64() using
> struct timespec64.
>
> The rtc_mips_set_time() and rtc_mips_set_mmss() interfaces were using
> 'unsigned long' type that is not y2038 safe on 32bit machines, moreover
> there is only one platform implementing rtc_mips_set_time() and two
> platforms implementing rtc_mips_set_mmss(), so we can just make them each
> implement update_persistent_clock64() directly, to get that helper out
> of the common mips code by removing rtc_mips_set_time() and
> rtc_mips_set_mmss() interfaces.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Looks good overall, but I still found a bug and one minor issue. With
those fixed,

Acked-by: Arnd Bergmann <arnd@arndb.de>

> diff --git a/arch/mips/dec/time.c b/arch/mips/dec/time.c
> index 9e992cf..934db6f 100644
> --- a/arch/mips/dec/time.c
> +++ b/arch/mips/dec/time.c
> @@ -59,14 +59,15 @@ void read_persistent_clock64(struct timespec64 *ts)
>  }
>
>  /*
> - * In order to set the CMOS clock precisely, rtc_mips_set_mmss has to
> + * In order to set the CMOS clock precisely, update_persistent_clock64 has to
>   * be called 500 ms after the second nowtime has started, because when
>   * nowtime is written into the registers of the CMOS clock, it will
>   * jump to the next second precisely 500 ms later.  Check the Dallas
>   * DS1287 data sheet for details.
>   */
> -int rtc_mips_set_mmss(unsigned long nowtime)
> +int update_persistent_clock64(struct timespec64 now)
>  {
> +       time64_t nowtime = now.tv_sec;
>         int retval = 0;
>         int real_seconds, real_minutes, cmos_minutes;
>         unsigned char save_control, save_freq_select;


It looks like you now get an invalid 64-bit division in here,
you have to change it to either use div_u64_rem() or possibly
time64_to_tm() or rtc_time64_to_tm() (the latter requires
CONFIG_RTC_LIB).

> diff --git a/arch/mips/lasat/ds1603.c b/arch/mips/lasat/ds1603.c
> index d75c887..061815e 100644
> --- a/arch/mips/lasat/ds1603.c
> +++ b/arch/mips/lasat/ds1603.c
> @@ -98,7 +98,7 @@ static void rtc_write_byte(unsigned int byte)
>         }
>  }
>
> -static void rtc_write_word(unsigned long word)
> +static void rtc_write_word(time64_t word)
>  {
>         int i;
>

I would say this function should take a 'u32' argument (or keep the
unsigned long) to match the name and implementation, but then have a
type cast in the caller with a comment about the loss of range and overflow
in y2106.

> diff --git a/arch/mips/lasat/sysctl.c b/arch/mips/lasat/sysctl.c
> index 6f74224..76f7b62 100644
> --- a/arch/mips/lasat/sysctl.c
> +++ b/arch/mips/lasat/sysctl.c
> @@ -73,8 +73,12 @@ int proc_dolasatrtc(struct ctl_table *table, int write,
>         if (r)
>                 return r;
>
> -       if (write)
> -               rtc_mips_set_mmss(rtctmp);
> +       if (write) {
> +               ts.tv_sec = rtctmp;
> +               ts.tv_nsec = 0;
> +
> +               update_persistent_clock64(ts);
> +       }
>
... and probably also a comment here to explain that we can't actually use
the full 64-bit range because of HW limits.

         Arnd
