Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jan 2014 08:58:19 +0100 (CET)
Received: from mail-pd0-f171.google.com ([209.85.192.171]:52161 "EHLO
        mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825733AbaAWH6RkG2Gh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Jan 2014 08:58:17 +0100
Received: by mail-pd0-f171.google.com with SMTP id g10so1463690pdj.2
        for <multiple recipients>; Wed, 22 Jan 2014 23:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=pF8tJaK+dglj+2Z9saU7GkI5ErogHLHcVD6WURRvlus=;
        b=u+hSfql9oQ12MX4lASRYiGlxxr2FhZRfEcks6m78JTrEOlGDIK4lIR+Nro+T5pu7+H
         B+7ukKt+aArCMZJMQVY03Qh3tKN48kbNaIs6aGRzYyqNpcId6ugJJ76p+kZuFUyPf+/h
         aqlWHm/tQaI/bLVRzhIMBuFvm6N24MtB/51LCaF1K8iaMd/AsOMvXedZ7Z6GorvvsWz6
         htkVTUGsgo4HdAQBleKuufxlpeTPDQ4VeWDt15lr35BB6DOCNVhrQHIV+nV1AlX5S7Ph
         6zVu7XjbUqJN7vgR0742ddIqU2nKCOf2o5xkzX0td8n8EueC0P0z94b0AWykYXWhRCIq
         draw==
MIME-Version: 1.0
X-Received: by 10.68.162.66 with SMTP id xy2mr6744772pbb.46.1390463889335;
 Wed, 22 Jan 2014 23:58:09 -0800 (PST)
Received: by 10.70.53.138 with HTTP; Wed, 22 Jan 2014 23:58:09 -0800 (PST)
In-Reply-To: <52E0C889.6000106@prisktech.co.nz>
References: <1390461166-36440-1-git-send-email-wangyijing@huawei.com>
        <52E0C889.6000106@prisktech.co.nz>
Date:   Thu, 23 Jan 2014 08:58:09 +0100
X-Google-Sender-Auth: m6rMyPgPYt8x7RSt7YClCYGdjdQ
Message-ID: <CAMuHMdUcKb8m71Z7dUo86MQ_KZgPujxsduUUt3Mz8Oke+DLSVw@mail.gmail.com>
Subject: Re: [PATCH 2/2] clocksource: Make clocksource register functions void
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Tony Prisk <linux@prisktech.co.nz>
Cc:     Yijing Wang <wangyijing@huawei.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kevin Hilman <khilman@deeprootsystems.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux <linux@lists.openrisc.net>, Sekhar Nori <nsekhar@ti.com>,
        Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Daniel Walker <dwalker@fifo99.com>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        Jonas Bonn <jonas@southpole.se>,
        Kukjin Kim <kgene.kim@samsung.com>,
        Russell King <linux@arm.linux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Ingo Molnar <mingo@redhat.com>, linux-arm-msm@vger.kernel.org,
        David Brown <davidb@codeaurora.org>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Mike Frysinger <vapier@gentoo.org>,
        uml-devel <user-mode-linux-devel@lists.sourceforge.net>,
        Nicolas Ferre <nicolas.ferre@atmel.com>,
        Jeff Dike <jdike@addtoit.com>, Barry Song <baohua@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        uml-user <user-mode-linux-user@lists.sourceforge.net>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        davinci-linux-open-source@linux.davincidsp.com,
        Michal Simek <monstr@monstr.eu>,
        Jim Cromie <jim.cromie@gmail.com>,
        microblaze-uclinux@itee.uq.edu.au,
        Hanjun Guo <guohanjun@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Bryan Huntsman <bryanh@codeaurora.org>,
        "uclinux-dist-devel@blackfin.uclinux.org" 
        <uclinux-dist-devel@blackfin.uclinux.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39082
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

On Thu, Jan 23, 2014 at 8:45 AM, Tony Prisk <linux@prisktech.co.nz> wrote:
>>   -static inline int clocksource_register_hz(struct clocksource *cs, u32
>> hz)
>> +static inline void clocksource_register_hz(struct clocksource *cs, u32
>> hz)
>>   {
>>         return __clocksource_register_scale(cs, 1, hz);
>>   }
>
>
> This doesn't make sense - you are still returning a value on a function
> declared void, and the return is now from a function that doesn't return
> anything either ?!?!
> Doesn't this throw a compile-time warning??

No, passing on void in functions returning void doesn't cause compiler
warnings.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
