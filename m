Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Apr 2018 09:31:10 +0200 (CEST)
Received: from mail-qk0-x241.google.com ([IPv6:2607:f8b0:400d:c09::241]:44053
        "EHLO mail-qk0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990434AbeDKHbDPza9I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Apr 2018 09:31:03 +0200
Received: by mail-qk0-x241.google.com with SMTP id n139so846667qke.11
        for <linux-mips@linux-mips.org>; Wed, 11 Apr 2018 00:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=7yFYxHK6EXr/97H+FTDzxXkHxaWaE7Uj0PiqXtrUG/A=;
        b=Uyd8R7ydl8Y1VhsCEJRwdSekthVSMLREjY72/e/Qz+evaJuvC2wjlaVVjqdORjSFiT
         U0d+3dFlcIP6k4KvfQPtCLHZCnW4BUROhKyJXGKyB4dB0+9S54/3Bwsvw/lODXgWq8eV
         3a1+9nKbgeoHkwiOP5aGFiRFCqb4fKU6o9r67ezl1E18AAOnwETV0/6Pj1YEbH95EcAT
         Y8RK4EswOap9GlEe7bopekeW1zXO26MaJtz3Igzmrt3A1XfT5MCShRZ4FYi1LB9aS26M
         yL3cAaGeCW0JTAujf+gdDb2R4PzDBnCE9CAxWp24qwUWayVra7R+vTNdwACXHj7ATlGV
         /hPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=7yFYxHK6EXr/97H+FTDzxXkHxaWaE7Uj0PiqXtrUG/A=;
        b=aQ3Z4IYKUIo5LSGv6Nu8C/1EVg90Fh6Maw6pGrFUNf4zv/sJskV3zEd7SLx0K4p1QP
         l0hG9FXmITsymDgQjgTHbfgFW9LwrWbh01f7eD4H5JNse8q85G1U6xZdrBMEEZVQGWNg
         dc+ycAUo2cn/SpYK+GHINUjz8A6LG+Q9kInNeUZ6rMdIrr5TpHO8XNTPqDFtBENMVbIC
         /cB/LpNu0Ewjle9tIMpC/FWiklmwEdJuK57hwvC4kgkkMxPlMIsZPYAV7CHEOHBnoAxq
         v+9fdN1/X3tdzl8JWsWKXQTQc7If+Qz7MaeRmyPbUKULWi1UAN6JdYTR+ePPcoRcLOI0
         FKag==
X-Gm-Message-State: ALQs6tDZT5nOh37dip89S0EU7qdI/z0DqMXueeMojiJUoQgCAvU8ad71
        m+Nm40/+IRJ2X7K8511C+O5zDejEb/JF1zeu5zI=
X-Google-Smtp-Source: AIpwx4/584XyGRxMnpM3Qe/IgvufHyCML/GXmw5t2a6eM5Hz4z9Dje5fxYWyNxJH5JeQ8WYDJEjFOXWGkbLMr884JhI=
X-Received: by 10.55.5.8 with SMTP id 8mr5183618qkf.84.1523431856891; Wed, 11
 Apr 2018 00:30:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.185.25 with HTTP; Wed, 11 Apr 2018 00:30:56 -0700 (PDT)
In-Reply-To: <20180410224805.GA21429@saruman>
References: <20171219114112.939391-1-arnd@arndb.de> <20180410224805.GA21429@saruman>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 11 Apr 2018 09:30:56 +0200
X-Google-Sender-Auth: zIrBH2DwpijzqcjQg8mMkwyBu-c
Message-ID: <CAK8P3a0-_u7_FCj-nH0izBv4ub6krm1uA32bwi2jtBzXJePcnQ@mail.gmail.com>
Subject: Re: [PATCH] bug.h: Work around GCC PR82365 in BUG()
To:     James Hogan <jhogan@kernel.org>
Cc:     "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Maciej Rozycki <macro@mips.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Mikael Starvik <starvik@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "David S. Miller" <davem@davemloft.net>,
        Christopher Li <sparse@chrisli.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-cris-kernel@axis.com, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-sparse@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63483
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

On Wed, Apr 11, 2018 at 12:48 AM, James Hogan <jhogan@kernel.org> wrote:
> Hi Arnd,
>
> On Tue, Dec 19, 2017 at 12:39:33PM +0100, Arnd Bergmann wrote:
>> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
>> index 5d595cfdb2c4..66cfdad68f7e 100644
>> --- a/include/linux/compiler-gcc.h
>> +++ b/include/linux/compiler-gcc.h
>> @@ -205,6 +205,15 @@
>>  #endif
>>
>>  /*
>> + * calling noreturn functions, __builtin_unreachable() and __builtin_trap()
>> + * confuse the stack allocation in gcc, leading to overly large stack
>> + * frames, see https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82365
>> + *
>> + * Adding an empty inline assembly before it works around the problem
>> + */
>> +#define barrier_before_unreachable() asm volatile("")
>> +
>> +/*
>>   * Mark a position in code as unreachable.  This can be used to
>>   * suppress control flow warnings after asm blocks that transfer
>>   * control elsewhere.
>> @@ -214,7 +223,11 @@
>>   * unreleased.  Really, we need to have autoconf for the kernel.
>>   */
>>  #define unreachable() \
>> -     do { annotate_unreachable(); __builtin_unreachable(); } while (0)
>> +     do {                                    \
>> +             annotate_unreachable();         \
>> +             barrier_before_unreachable();   \
>> +             __builtin_unreachable();        \
>> +     } while (0)
>
> Unfortunately this breaks microMIPS builds (e.g. MIPS
> micro32r2_defconfig and micro32r2el_defconfig) on gcc 7.2, due to the
> lack of .insn in the asm volatile. Because of the
> __builtin_unreachable() there is no code following it. Without the empty
> asm the compiler will apparently put the .insn there automatically, but
> with the empty asm it doesn't. Therefore the assembler won't treat an
> immediately preceeding label as pointing at 16-bit microMIPS
> instructions which need the ISA bit set, i.e. bit 0 of the address.
> This causes assembler errors since the branch target is treated as a
> different ISA mode:
>
> arch/mips/mm/dma-default.s:3265: Error: branch to a symbol in another ISA mode
> arch/mips/mm/dma-default.s:5027: Error: branch to a symbol in another ISA mode

Ok, I see.

> Due to a compiler bug on gcc 4.9.2 -> somewhere before 7.2, Paul
> submitted these patches a while back:
> https://patchwork.linux-mips.org/patch/13360/
> https://patchwork.linux-mips.org/patch/13361/
>
> Your patch (suitably fixed for microMIPS) would I imagine fix that issue
> too (it certainly fixes the resulting link error on microMIPS builds
> with an old toolchain).
>
> Before I forward port those patches to add .insn for MIPS, is that sort
> of approach (an arch specific asm/compiler-gcc.h to allow MIPS to
> override barrier_before_unreachable()) an acceptable fix?

That sounds fine to me. However, I would suggest making that
asm/compiler.h instead of asm/compiler-gcc.h, so we can also
use the same file to include workarounds for clang if needed.

       Arnd
