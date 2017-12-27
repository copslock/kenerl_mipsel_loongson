Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Dec 2017 21:07:49 +0100 (CET)
Received: from mail-it0-x243.google.com ([IPv6:2607:f8b0:4001:c0b::243]:42927
        "EHLO mail-it0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990506AbdL0UHmT3k-F (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Dec 2017 21:07:42 +0100
Received: by mail-it0-x243.google.com with SMTP id p139so26198817itb.1;
        Wed, 27 Dec 2017 12:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=e8LDvXhFewhWWJQFr4VpCqHhFJulwHRtSZbpM5zrZek=;
        b=bXPwtMsPsSiR38vVNpM7W5C8MQ8QUXVsuvOGxelXQaJOMFMOu7Y+GN9mr/p+BNScbx
         aLLBAOfrSmcXmGd62fety2qSCPLBuZjLDP1JLBOSpWC0ifSDFJFMHTjfKl54mFfP6Reg
         +55x7noU6dvLhaeI28mczbygPzTfd2VYtjy7QjRTlvVkplVZOZTKxQEZCPLSDK1F9eTw
         7Aa+NwDoSR9WxJO6V8ObaHM8KBQVRnEkJG+MLfOQH0jJWfLENlkey0Ykr+LYvHhW6zF/
         j0ppzIMs/576d1uQEPVhwArJjwHeX8OG1mEUYP+2OKx0MVM//SSncErDKCuuzSNzPnjr
         zESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=e8LDvXhFewhWWJQFr4VpCqHhFJulwHRtSZbpM5zrZek=;
        b=nwzhPiD/3LugciejOFJnWssCsIAxiPKdyFzGjcMPSW3XISzaaF6dQqY/gV6F89l2HG
         GOHY+C29R8mbNmbgZPKra3RdO59DEIb0ySO4kCzBBd3nEezWxI9RmD8UoEeYXcRUEbc8
         fQ75pJkVaWZpCPZVN2S/wnExNd3Hffze6UbIH4zpoce918XCBZdsQxHeOmEXyuiEwznV
         fC2WCtoT2538lQtA2LVLUcWjdOHWNuwi2WNfYog68lPpxXB/U+5SFz5QqGSW1m0j6ZGt
         MH8BE2j8ifMNp1tnxiQHswme2EX7w/2UBtNtbGQNBQ4mwj36Ihr5+QSp29zI4tIz0iCT
         Pnug==
X-Gm-Message-State: AKGB3mKmCQlG6V0tmq+2Qreln1nl+GTWXO+xpHuPJXXgQjGrR4n6o8Y9
        r8ZDawKmqD/9tscrV9ARphgZ1yfTXzjIp2xIX/Y=
X-Google-Smtp-Source: ACJfBospJYNx2n2Eplugwl1EAoM85joO+5IXz6XFZjds1umiBdQrCSsKQk3Uqoq+sTLa6b277nHhhWnxPydvAH+Zwzg=
X-Received: by 10.36.151.198 with SMTP id k189mr39954081ite.100.1514405255876;
 Wed, 27 Dec 2017 12:07:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.20.11 with HTTP; Wed, 27 Dec 2017 12:07:34 -0800 (PST)
In-Reply-To: <20171227085033.22389-3-ard.biesheuvel@linaro.org>
References: <20171227085033.22389-1-ard.biesheuvel@linaro.org> <20171227085033.22389-3-ard.biesheuvel@linaro.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 27 Dec 2017 12:07:34 -0800
X-Google-Sender-Auth: aUv6oYuAXo70yGNy9HXD05d4MJo
Message-ID: <CA+55aFxqJqJq_7VUzBVTppgXFPc-8Ou55iLsZjp3fr6B2gRyTQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/8] module: use relative references for __ksymtab entries
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Garnier <thgarnie@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Russell King <linux@armlinux.org.uk>,
        Paul Mackerras <paulus@samba.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@redhat.com>,
        James Morris <james.l.morris@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Pitre <nico@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Jessica Yu <jeyu@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mips <linux-mips@linux-mips.org>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux@vger.kernel.org,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <linus971@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61638
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: torvalds@linux-foundation.org
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

On Wed, Dec 27, 2017 at 12:50 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 52e611ab9a6c..fe752d365334 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -327,4 +327,15 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
>         compiletime_assert(__native_word(t),                            \
>                 "Need native word sized stores/loads for atomicity.")
>
> +/*
> + * Force the compiler to emit 'sym' as a symbol, so that we can reference
> + * it from inline assembler. Necessary in case 'sym' could be inlined
> + * otherwise, or eliminated entirely due to lack of references that are
> + * visibile to the compiler.
> + */
> +#define __ADDRESSABLE(sym) \
> +       static void *__attribute__((section(".discard.text"), used))    \
> +               __PASTE(__discard_##sym, __LINE__)(void)                \
> +                       { return (void *)&sym; }                        \
> +
>  #endif /* __LINUX_COMPILER_H */

Isn't this logically the point where you should add the arm64
vmlinux.lds.S change, and explain how ".discard.text" turns into
".init.discard.text" for some odd arm64 reason?

                   Linus
