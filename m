Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Dec 2017 21:11:32 +0100 (CET)
Received: from mail-it0-x244.google.com ([IPv6:2607:f8b0:4001:c0b::244]:37024
        "EHLO mail-it0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990475AbdL0ULZ6UwnF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Dec 2017 21:11:25 +0100
Received: by mail-it0-x244.google.com with SMTP id d137so26646920itc.2
        for <linux-mips@linux-mips.org>; Wed, 27 Dec 2017 12:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VVfQQocN2/lcA25k4kJ1I4Rwj8JbQqo8xX8ZWGTSl94=;
        b=a4cQOZe2sfju8bSqJ0qAmWf5/vMFTmsOJq5hTej7j1gu+XOJ0enWWN+21RX6MmdxNw
         25UlQHFalc98jqrMjB3oo5WErmPqP7v7mbvfY2F6ADttJRnAj/oxVC375PiwZYSqF5Vc
         yZ0GPYGlcKdfdpSAs69o5pohFBvvOJ5aMAr9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VVfQQocN2/lcA25k4kJ1I4Rwj8JbQqo8xX8ZWGTSl94=;
        b=HDXwZ/Fl09A1668s0vbTl7ewIvJG02daqf5/y2MRv2zcnWKqMlAqiMOCfIT+GrW+/q
         jKZjQeBcEbIJvm0HaGg6YbgHQkyfwW1793zP2FUY9u042LCOz+zLM+xSORIr2Q9YvJud
         gOvD6zNKMyNBNRF+zYvnh4QM5KbkU8H3Giq7GfjLGPAvXd9K0g+/3O1RrlX1S2PYNQi2
         PoicnNXByOfi5w05ajsBeTSZFugXA+RGfC4JSgOUCotzwjsyPaP+nCx9OF05RRASqdIf
         ykierAa95Pa2jJkHYtMgqUnD++0B7i3KuDhtYqpygpj3xg7QD4EovZLNyjpou1nJhheW
         sz3Q==
X-Gm-Message-State: AKGB3mIuWKhqLvDygBcct8BlDlZSSB3JPGR9FlYpF89vIaPmTHVKXsL/
        Rv/Y8ss1VI+tqWSJC+syGzZheK+/1OOengS5HyC/gw==
X-Google-Smtp-Source: ACJfBovxOVrb4nV15YNIZBCprDiihlqdv2F49aYrTomyY089VW8RYpbh58RbbT8uZYUF72QDmjT7GFLgUv2YsmXyqVo=
X-Received: by 10.36.55.138 with SMTP id r132mr38187909itr.34.1514405480032;
 Wed, 27 Dec 2017 12:11:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.52.14 with HTTP; Wed, 27 Dec 2017 12:11:19 -0800 (PST)
In-Reply-To: <CA+55aFxqJqJq_7VUzBVTppgXFPc-8Ou55iLsZjp3fr6B2gRyTQ@mail.gmail.com>
References: <20171227085033.22389-1-ard.biesheuvel@linaro.org>
 <20171227085033.22389-3-ard.biesheuvel@linaro.org> <CA+55aFxqJqJq_7VUzBVTppgXFPc-8Ou55iLsZjp3fr6B2gRyTQ@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 27 Dec 2017 20:11:19 +0000
Message-ID: <CAKv+Gu-2NUzsakN2rcM_5fqD0ubr+6ZXSc+5sjZZPbU3wj_Xsg@mail.gmail.com>
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
X-archive-position: 61639
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

On 27 December 2017 at 20:07, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, Dec 27, 2017 at 12:50 AM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
>> index 52e611ab9a6c..fe752d365334 100644
>> --- a/include/linux/compiler.h
>> +++ b/include/linux/compiler.h
>> @@ -327,4 +327,15 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
>>         compiletime_assert(__native_word(t),                            \
>>                 "Need native word sized stores/loads for atomicity.")
>>
>> +/*
>> + * Force the compiler to emit 'sym' as a symbol, so that we can reference
>> + * it from inline assembler. Necessary in case 'sym' could be inlined
>> + * otherwise, or eliminated entirely due to lack of references that are
>> + * visibile to the compiler.
>> + */
>> +#define __ADDRESSABLE(sym) \
>> +       static void *__attribute__((section(".discard.text"), used))    \
>> +               __PASTE(__discard_##sym, __LINE__)(void)                \
>> +                       { return (void *)&sym; }                        \
>> +
>>  #endif /* __LINUX_COMPILER_H */
>
> Isn't this logically the point where you should add the arm64
> vmlinux.lds.S change, and explain how ".discard.text" turns into
> ".init.discard.text" for some odd arm64 reason?
>

I tried to keep the generic patches generic, so perhaps I should just
put the arm64 vmlinux.lds.S change in a patch on its own?
