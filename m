Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Dec 2017 21:24:43 +0100 (CET)
Received: from mail-io0-x244.google.com ([IPv6:2607:f8b0:4001:c06::244]:40542
        "EHLO mail-io0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990475AbdL0UYfTicpp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Dec 2017 21:24:35 +0100
Received: by mail-io0-x244.google.com with SMTP id v30so4621864iov.7
        for <linux-mips@linux-mips.org>; Wed, 27 Dec 2017 12:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GuQxXFML0Wn4s0cVbibY/a5Gq/rU8fF16au7Ke5sbyY=;
        b=bJOvBIlmgNSg/ZuoypuGjxwxRXsusf8PU9tZcnFAXLtNzOdAi0dJX7q8fbGYqVzLx5
         GC1o0gf9MbsMDT5CaFLe2dUruWDdXmSLznKrgTTG0UtkbNtGrdEnydeDKgI//eUCFJhf
         TK2wlElo0/RvngtHpX38BzLSUhacOu7ucE/zo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GuQxXFML0Wn4s0cVbibY/a5Gq/rU8fF16au7Ke5sbyY=;
        b=NCJ2WyArhZ0NbN/cZpCSXbVkhSs9LlNKi6guncVAgbFKbDZ9mOH9z5dqbT+jQ7ODw1
         3ilioNIM5IcVPrM0MQ3OL5K6z6fG8ysxq6oa/PntkWrOYR/g7xD3QQ3PuXbmQ/1mCA9B
         AfOZryZuzddbQZmMTymhRIMGA+gKzfNFiB+p8l2lwm2sQW/3F6rIgxJrBgs5uZWFIPr3
         madLjFGhiuCmL06FLBptUJsh7LLDkFPEqI4OJp5TMK3GB6tGrziR4VB8YdkS6T+bAzqY
         mNG/n934xxn+bvsD/bKG85PF2FwDMvbSoMD8wRKruvliCl29UHV8SlrrNlMX1wj0Et82
         FsQg==
X-Gm-Message-State: AKGB3mKlN7G385hRCFvFNoUcxaq7N+GwvXFVf474Ziatv2MCdhPnZqJj
        CjU9SnMSKMz0xypAPMXP7AapniDINYIeWj2zwco2Yg==
X-Google-Smtp-Source: ACJfBov9A4nNJzH0iR2TE9ZvkbCIX4jshWLiuCepN3FdiTi85cN1ncf3zXXviEcOsbuAjRZt9eLg74Urm6wSNZCG3Jk=
X-Received: by 10.107.151.142 with SMTP id z136mr39631376iod.248.1514406267768;
 Wed, 27 Dec 2017 12:24:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.52.14 with HTTP; Wed, 27 Dec 2017 12:24:27 -0800 (PST)
In-Reply-To: <CA+55aFzygF6P3v5VxyBucZfn-tg58jeV6qwt0y7QGmmNiKYghQ@mail.gmail.com>
References: <20171227085033.22389-1-ard.biesheuvel@linaro.org>
 <20171227085033.22389-3-ard.biesheuvel@linaro.org> <CA+55aFxqJqJq_7VUzBVTppgXFPc-8Ou55iLsZjp3fr6B2gRyTQ@mail.gmail.com>
 <CAKv+Gu-2NUzsakN2rcM_5fqD0ubr+6ZXSc+5sjZZPbU3wj_Xsg@mail.gmail.com> <CA+55aFzygF6P3v5VxyBucZfn-tg58jeV6qwt0y7QGmmNiKYghQ@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 27 Dec 2017 20:24:27 +0000
Message-ID: <CAKv+Gu-wRtfnGfrEjuxR5YkCpZM-nQHZShROEdbcEh=fSiWf5A@mail.gmail.com>
Subject: Re: [PATCH v6 2/8] module: use relative references for __ksymtab entries
To:     Linus Torvalds <torvalds@linux-foundation.org>
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
Return-Path: <ard.biesheuvel@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61641
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ard.biesheuvel@linaro.org
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

On 27 December 2017 at 20:13, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, Dec 27, 2017 at 12:11 PM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>>
>> I tried to keep the generic patches generic, so perhaps I should just
>> put the arm64 vmlinux.lds.S change in a patch on its own?
>
> I guess it doesn't matter, but regardless of where it gets introduced
> I would like to see the explanation for where the heck that magical
> ".init.discard.text" comes from. It's definitely not obvious from the
> patches, and is presumably some odd arm64 special case.
>

This has to do with the EFI stub. x86 and ARM link it into the
decompressor, and so the code and data are not annotated as __init
(and doing so would involve modifying a lot of code). arm64 does not
have a decompressor, and so the EFI stub is linked into the kernel
proper. To make sure the code ends up in the .init segment, all
sections are prepended with .init at the object level, using objcopy.

Annoyingly, we need this because there is a single instance of a
special section that ends up in the EFI stub code: we build lib/sort.c
again as a EFI libstub object, and given that sort() is exported, we
end up with a ksymtab section in the EFI stub. The sort() thing has
caused issues before [0], so perhaps I should just clone sort.c into
drivers/firmware/efi/libstub and get rid of that hack.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=29f9007b3182ab3f328a31da13e6b1c9072f7a95
