Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 Jun 2013 10:34:35 +0200 (CEST)
Received: from mail-pa0-f54.google.com ([209.85.220.54]:38073 "EHLO
        mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817128Ab3F2IeebJ4bC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 29 Jun 2013 10:34:34 +0200
Received: by mail-pa0-f54.google.com with SMTP id kx10so3305486pab.27
        for <multiple recipients>; Sat, 29 Jun 2013 01:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=2QSERyhtTKvn9XMk9XlJcLdFX/joSK4ci1iomfcF7Co=;
        b=WRLjM2MxVmZ6S060afRm0i0/moc7uXABb47U/3iwL1I6m1OM9StIUNH2PKgBTpKg/8
         GbuX/zOO/Gvlq/JNL9isbTzOpzF6pBUtqHKQfsngutUie61kc1xqtTo02Kn9gTekbVPH
         cVlAq+pR4OwE0M/EGR04zzU3XDYEW9cuvYGP08rjIYY4MziH5ovqVhU/8J1nfFH9P7rE
         RE3hD5NnJnBCYGZNciTQ+nucGK3j3LmvSSxg7LdQttLeGz6Go+lf8edZJTVrveIb8CKP
         VPp2UEr/eERfUlLQv4HqR+FRraPQd5X8KPgcFkpsTFtiDRxcMF7TdrNV5pa//we3k2sJ
         9NLw==
MIME-Version: 1.0
X-Received: by 10.66.231.7 with SMTP id tc7mr14860454pac.143.1372494867124;
 Sat, 29 Jun 2013 01:34:27 -0700 (PDT)
Received: by 10.70.78.197 with HTTP; Sat, 29 Jun 2013 01:34:27 -0700 (PDT)
In-Reply-To: <51CE1F92.3070802@ti.com>
References: <1371775956-16453-1-git-send-email-santosh.shilimkar@ti.com>
        <51C4171C.9050908@linutronix.de>
        <51C48B5A.2040404@ti.com>
        <51CCA67C.2010803@gmail.com>
        <CACxGe6vOH0sCFVVXrYqD3dbYdOvithVu7-d1cvy5885i8x_Myw@mail.gmail.com>
        <20130628134931.GD21034@game.jcrosoft.org>
        <51CE1F92.3070802@ti.com>
Date:   Sat, 29 Jun 2013 10:34:27 +0200
X-Google-Sender-Auth: z3x9TG9RabuTzn6BamYCxFgeBw4
Message-ID: <CAMuHMdWjaakS-hvor7Ftyr=g-iF2kbrLryn_+YFXDDN5tS_QOw@mail.gmail.com>
Subject: Re: [PATCH] of: Specify initrd location using 64-bit
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Santosh Shilimkar <santosh.shilimkar@ti.com>,
        Rob Herring <robherring2@gmail.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
        Grant Likely <grant.likely@linaro.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Aurelien Jacquiot <a-jacquiot@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Jonas Bonn <jonas@southpole.se>,
        Russell King <linux@arm.linux.org.uk>,
        linux-c6x-dev@linux-c6x.org,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "arm@kernel.org" <arm@kernel.org>, linux-xtensa@linux-xtensa.org,
        James Hogan <james.hogan@imgtec.com>,
        devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
        Rob Herring <rob.herring@calxeda.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Chris Zankel <chris@zankel.net>,
        Vineet Gupta <vgupta@synopsys.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37219
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

On Sat, Jun 29, 2013 at 1:43 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
>>>>> Rob,
>>>>> Are you ok with phys_addr_t since your concern was about rest
>>>>> of the memory specific bits of the device-tree code use u64 ?
>>>>
>>>> No. I still think it should be u64 for same reasons I said originally.
>>>
>>> +1
>>>
>> +1
>>
>> fix type
>>
> Apart from waste of 32bit, what is the other concern you
> have ? I really want to converge on this patch because it
> has been a open ended discussion for quite some time. Does
> that really break any thing on x86 or your concern is more
> from semantics of the physical address.

As the "original reasons" were not in this thread, I had to search a bit.
I suppose you mean this one: https://lkml.org/lkml/2012/9/13/544 ?

Summarized:
| The address to load the initrd is decided by the bootloader/user and set
| at that point later in time.
| The dtb should not be tied to the kernel you are booting.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
