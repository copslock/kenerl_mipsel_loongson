Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2015 14:29:34 +0200 (CEST)
Received: from mail-ob0-f178.google.com ([209.85.214.178]:35182 "EHLO
        mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026193AbbD1M3cxCVQr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Apr 2015 14:29:32 +0200
Received: by obcux3 with SMTP id ux3so106526656obc.2
        for <linux-mips@linux-mips.org>; Tue, 28 Apr 2015 05:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=gGvg95Zw6Z3ZDf1nbZDp2lBsScm5mf3GX+fDkdW1Ba8=;
        b=VqrgyYATT8fmSdzkuffhaTJztHwKWq9+cF4y7LfdBQIbWbGcWJUCcb0qMWptj7YiLv
         xyKho/tyGI399YOjMXgF0N/t0tqRNLe+2TCTVZQV6rErlSGXuQFoIm2TwSw04ck9ODRO
         KOCJwV2HHcVd/M+CZG2fx1WH3JiTwZiso2xOGk/8piipzIEZkoeu+JBvY+jtDZWwz6iP
         7BrTGfL282NO29T4tJfsPEMkj283gzhHw+dsneinE83j5BNjyjUWIV9NrAfZCs2azM4B
         LIm3bkxpTzzGCmM0c17l7ZTC0FkkKAE6NBzzRthSMjG63QPu1PpDzW8We20EVYNzYy+1
         rBvA==
MIME-Version: 1.0
X-Received: by 10.202.174.131 with SMTP id x125mr13601836oie.18.1430224167635;
 Tue, 28 Apr 2015 05:29:27 -0700 (PDT)
Received: by 10.60.103.171 with HTTP; Tue, 28 Apr 2015 05:29:27 -0700 (PDT)
In-Reply-To: <87pp6osaog.fsf@rustcorp.com.au>
References: <1430128286-8952-1-git-send-email-geert@linux-m68k.org>
        <CAMuHMdWoUPZ92GX9fe8eq87buLQOT9GMb6Ru3_bQJpkZTFph0g@mail.gmail.com>
        <871tj4uara.fsf@rustcorp.com.au>
        <CAMuHMdWj=khxL5dw=O3ymdTE+kBfxa0-gFKZ-ngQ-x4Fzzav1Q@mail.gmail.com>
        <87pp6osaog.fsf@rustcorp.com.au>
Date:   Tue, 28 Apr 2015 14:29:27 +0200
X-Google-Sender-Auth: NtRYAQIUI3ZFQqA0z_sh_oXbIi8
Message-ID: <CAMuHMdXEH6ZnTSdBi2uJzPriqTLvJvd0bPYH3NPWV5LjZB5S=A@mail.gmail.com>
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
        Matthew Wilcox <willy@linux.intel.com>,
        Chris Metcalf <cmetcalf@ezchip.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47132
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

cc Chris

On Tue, Apr 28, 2015 at 2:24 PM, Rusty Russell <rusty@rustcorp.com.au> wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>>> Can't see that one with a simple grep: can you post warning?
>>
>> /home/kisskb/slave/src/arch/tile/kernel/setup.c: In function 'zone_sizes_init':
>> /home/kisskb/slave/src/arch/tile/kernel/setup.c:777:3: warning:
>> passing argument 2 of 'cpumask_test_cpu' from incompatible pointer
>> type [enabled by default]
>> /home/kisskb/slave/src/include/linux/cpumask.h:294:19: note: expected
>> 'const struct cpumask *' but argument is of type 'struct nodemask_t *'
>
> Um, I turned the cpu_isset() into cpumask_test_cpu(), but that just
> showed this bug up.  The tile maintainers need to fix this one.
>
> Thanks,
> Rusty.
