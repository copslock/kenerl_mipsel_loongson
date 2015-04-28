Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2015 09:12:43 +0200 (CEST)
Received: from mail-ob0-f174.google.com ([209.85.214.174]:34228 "EHLO
        mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011729AbbD1HMmaEf0T (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Apr 2015 09:12:42 +0200
Received: by obfe9 with SMTP id e9so101656965obf.1
        for <linux-mips@linux-mips.org>; Tue, 28 Apr 2015 00:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=XHJOer0KPHJYnKhyvhtILJDGqVMieOJ0V3zBojzpq64=;
        b=HeSRT3GPqVHPaG9Atd0Wei0N22uIxMKWrgPgTBPjCAi1yyZ+EwvonrFuDNwVxpFJ4P
         lg8ZY89LCITT0lwWQsubtcwU1WS1rmUuCV+023+ImKn5aFQewd3unPkRYf0i9p5i1W06
         aZlkFmaG0yRSEvmRIbYDN/F/EQyh9gF39YeEK0FpUt4+/1I8EGIBOav8flRMdeY4PdOW
         bShPsyZ51oEQ2bC/ynxQKJBkvlms/kZ028KZp4boYk/U7Vn99/6TyD/TIcbz8m8KQFQ7
         ScG8Vu9NZf6TR35jFxlOUQ2jChgAgQ3abb7Mrr84PUsVwM34XYfb44EgJGIDGlrP7JJM
         OzJA==
MIME-Version: 1.0
X-Received: by 10.202.174.131 with SMTP id x125mr12713597oie.18.1430205158201;
 Tue, 28 Apr 2015 00:12:38 -0700 (PDT)
Received: by 10.60.103.171 with HTTP; Tue, 28 Apr 2015 00:12:38 -0700 (PDT)
In-Reply-To: <871tj4uara.fsf@rustcorp.com.au>
References: <1430128286-8952-1-git-send-email-geert@linux-m68k.org>
        <CAMuHMdWoUPZ92GX9fe8eq87buLQOT9GMb6Ru3_bQJpkZTFph0g@mail.gmail.com>
        <871tj4uara.fsf@rustcorp.com.au>
Date:   Tue, 28 Apr 2015 09:12:38 +0200
X-Google-Sender-Auth: 7eau4UYMjudTia6HzpY60g3ksc8
Message-ID: <CAMuHMdWj=khxL5dw=O3ymdTE+kBfxa0-gFKZ-ngQ-x4Fzzav1Q@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.1-rc1
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Rusty Russell <rusty@rustcorp.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Mark Brown <broonie@kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Matthew Wilcox <willy@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47114
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

On Tue, Apr 28, 2015 at 6:39 AM, Rusty Russell <rusty@rustcorp.com.au> wrote:
>>>   + /home/kisskb/slave/src/arch/mips/cavium-octeon/smp.c: error: passing argument 2 of 'cpumask_clear_cpu' discards 'volatile' qualifier from pointer target type [-Werror]:  => 242:2
>>>   + /home/kisskb/slave/src/arch/mips/kernel/process.c: error: passing argument 2 of 'cpumask_test_cpu' discards 'volatile' qualifier from pointer target type [-Werror]:  => 52:2
>>>   + /home/kisskb/slave/src/arch/mips/kernel/smp.c: error: passing argument 2 of 'cpumask_set_cpu' discards 'volatile' qualifier from pointer target type [-Werror]:  => 149:2, 211:2
>>>   + /home/kisskb/slave/src/arch/mips/kernel/smp.c: error: passing argument 2 of 'cpumask_test_cpu' discards 'volatile' qualifier from pointer target type [-Werror]:  => 221:2

> and related warnings due to lack of -Werror on

>> tilegx_defconfig
>
> Can't see that one with a simple grep: can you post warning?

/home/kisskb/slave/src/arch/tile/kernel/setup.c: In function 'zone_sizes_init':
/home/kisskb/slave/src/arch/tile/kernel/setup.c:777:3: warning:
passing argument 2 of 'cpumask_test_cpu' from incompatible pointer
type [enabled by default]
/home/kisskb/slave/src/include/linux/cpumask.h:294:19: note: expected
'const struct cpumask *' but argument is of type 'struct nodemask_t *'

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
