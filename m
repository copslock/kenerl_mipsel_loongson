Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Dec 2015 13:50:23 +0100 (CET)
Received: from mail-ob0-f171.google.com ([209.85.214.171]:32841 "EHLO
        mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013651AbbLKMuWIF08S convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 11 Dec 2015 13:50:22 +0100
Received: by obbsd4 with SMTP id sd4so32916139obb.0
        for <linux-mips@linux-mips.org>; Fri, 11 Dec 2015 04:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=OQqrZHbBiGsLzvp1hzGXEUcVKZdHXSkE4biDYd/J6rE=;
        b=myO4yTvMYDnSnAV/7deSv3qt22g/Plso6EBX7P1RCRmj3eBTjFgb3QKQQQM/JCggBy
         YzhA+YtqhYajTJR1NZYRxJ2InjdvWhjF2SJqNL2Xn9PxjJkl69RhZd3/8OGs4KYbKwFU
         RjNzO88yS9b6rLWaKiGWed/XSRLGVGhAqw5NpKxVYgRYzJoykn2gtNs4yX4bk81Dpksk
         x33uKDSM5f+juRr1liha/cDzTXTUqaD6yyOfSiW92/3WxSBJoMEhf90mBWL9B4tvkEZQ
         O6dwzTpKysElVAMRfYsnQ2OEZqs/x/zRJVQ4mRHwJ8cfTUMidflHqwLV/oCTCeqzqyA9
         ypnQ==
MIME-Version: 1.0
X-Received: by 10.182.120.4 with SMTP id ky4mr13881659obb.16.1449838216121;
 Fri, 11 Dec 2015 04:50:16 -0800 (PST)
Received: by 10.60.233.35 with HTTP; Fri, 11 Dec 2015 04:50:16 -0800 (PST)
In-Reply-To: <20151211124159.GB3729@pathway.suse.cz>
References: <1449667265-17525-1-git-send-email-pmladek@suse.com>
        <1449667265-17525-5-git-send-email-pmladek@suse.com>
        <CAMuHMdXVgr58YjoePGrRbMyMncQ27f85prL7G5SpeHeNxoYrXQ@mail.gmail.com>
        <20151211124159.GB3729@pathway.suse.cz>
Date:   Fri, 11 Dec 2015 13:50:16 +0100
X-Google-Sender-Auth: -DK7eicFw73OJxLZM7NLOUVCdnQ
Message-ID: <CAMuHMdW0CQYgs2Cz3REf6FHM5dj9LGN6AnmDZnFfaw0084ekSg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] printk/nmi: Increase the size of NMI buffer and
 make it configurable
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jiri Kosina <jkosina@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "adi-buildroot-devel@lists.sourceforge.net" 
        <adi-buildroot-devel@lists.sourceforge.net>,
        Cris <linux-cris-kernel@axis.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50546
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

On Fri, Dec 11, 2015 at 1:41 PM, Petr Mladek <pmladek@suse.com> wrote:
> On Fri 2015-12-11 12:10:02, Geert Uytterhoeven wrote:
>> On Wed, Dec 9, 2015 at 2:21 PM, Petr Mladek <pmladek@suse.com> wrote:
>> > --- a/init/Kconfig
>> > +++ b/init/Kconfig
>> > @@ -866,6 +866,28 @@ config LOG_CPU_MAX_BUF_SHIFT
>> >                      13 =>   8 KB for each CPU
>> >                      12 =>   4 KB for each CPU
>> >
>> > +config NMI_LOG_BUF_SHIFT
>> > +       int "Temporary per-CPU NMI log buffer size (12 => 4KB, 13 => 8KB)"
>> > +       range 10 21
>> > +       default 13
>> > +       depends on PRINTK && HAVE_NMI
>>
>> Symbol NMI_LOG_BUF_SHIFT does not exist if its dependencies are not met.
>
> Åh, the NMI buffer is enabled on arm via NEED_PRINTK_NMI.
>
> The buffer is compiled when CONFIG_PRINTK_NMI is defined. I am going
> to fix it the following way:
>
>
> diff --git a/init/Kconfig b/init/Kconfig
> index efcff25a112d..61cfd96a3c96 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -870,7 +870,7 @@ config NMI_LOG_BUF_SHIFT
>         int "Temporary per-CPU NMI log buffer size (12 => 4KB, 13 => 8KB)"
>         range 10 21
>         default 13
> -       depends on PRINTK && HAVE_NMI
> +       depends on PRINTK_NMI
>         help
>           Select the size of a per-CPU buffer where NMI messages are temporary
>           stored. They are copied to the main log buffer in a safe context

Makes sense, as kernel/printk/nmi.c is compiled if PRINTK_NMI is set.

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
