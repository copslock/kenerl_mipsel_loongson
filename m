Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Dec 2017 17:26:24 +0100 (CET)
Received: from mail-io0-x244.google.com ([IPv6:2607:f8b0:4001:c06::244]:38973
        "EHLO mail-io0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990491AbdL1Q0Ow5WKB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Dec 2017 17:26:14 +0100
Received: by mail-io0-x244.google.com with SMTP id g70so26232457ioj.6
        for <linux-mips@linux-mips.org>; Thu, 28 Dec 2017 08:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ylRBslByKSxclqrBXLB0zZYeiiulgdmsKOgxzi0LPQg=;
        b=LC69CaYs/06HR3btgJV0qPxcdMfElRnYcO9oolcPvSywrLEvvw0Eq7SVY1Xx4+8PVN
         pX8yQT1Io0Mkoy4nU4lflaC+H/UvUtsFB9bbS77qEjNZ5j4UqAxzLF4peJElTE+PNMAo
         N1AiuGDes4hSZlwbeSm9e+6PhFcnex3vmenyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ylRBslByKSxclqrBXLB0zZYeiiulgdmsKOgxzi0LPQg=;
        b=GspjBN+Po/fc0PJFFBmP+BnNRCG0IgygxAhMMsKcx56UA2Du8drVnzzl96AfI1Irbm
         ccLWGviCI7IsPZE9Te1Ddl7FzeBa0jAv21OYHFZC2dfvmC2IooY0aq56TJHuLz2406Xm
         t0HRDmji4bVIdgrrfN7/ONNOMrtUY/gO4RkDN3KpIt8QwG9y8DvtlRENNIMMIxOImiF7
         zJ3poNDN/HQitjBg/tsa5Px9SCrBGE5osni7ZweHb8J8bv6kaYkhFcrwlF6+pVIc5ioi
         Kv4xXCkYVPkbKNpHjInPFF66BAxveJJ8ERWEW1/l7Qom0Qm2BoJyzYHotFz+nF5HGep1
         jxAg==
X-Gm-Message-State: AKGB3mI45vbiKQZ/CVmsZfW7L7HXyUFoK4B71wxNL+ITZLQKHuw97Da1
        Rf7OdaTOGQdqToiahnuPBqERZoGve+LhcmpPr2+ihQ==
X-Google-Smtp-Source: ACJfBovn4f/pKgWop+Z6u0HtZ/lxT3TIOjv54GuPjjptgA2nsH4zW5RSxvAtIFUf1JcBxsHa2SWXdDmqvmRB+YcONCo=
X-Received: by 10.107.137.15 with SMTP id l15mr41845857iod.52.1514478368320;
 Thu, 28 Dec 2017 08:26:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.52.14 with HTTP; Thu, 28 Dec 2017 08:26:07 -0800 (PST)
In-Reply-To: <20171228111926.28e82877@gandalf.local.home>
References: <20171227085033.22389-1-ard.biesheuvel@linaro.org>
 <20171227085033.22389-9-ard.biesheuvel@linaro.org> <20171228111926.28e82877@gandalf.local.home>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 28 Dec 2017 16:26:07 +0000
Message-ID: <CAKv+Gu9Gza=RN_v_H-G7m7-qKg9B4Xf4GFvd_H-Gut-V3eabmA@mail.gmail.com>
Subject: Re: [PATCH v6 8/8] x86/kernel: jump_table: use relative references
To:     Steven Rostedt <rostedt@goodmis.org>
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
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mips <linux-mips@linux-mips.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux@vger.kernel.org,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <ard.biesheuvel@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61665
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

On 28 December 2017 at 16:19, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 27 Dec 2017 08:50:33 +0000
> Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
>>  static inline jump_label_t jump_entry_code(const struct jump_entry *entry)
>>  {
>> -     return entry->code;
>> +     return (jump_label_t)&entry->code + entry->code;
>
> I'm paranoid about doing arithmetic on abstract types. What happens in
> the future if jump_label_t becomes a pointer? You will get a different
> result.
>

In general, I share your concern. In this case, however, jump_label_t
is typedef'd three lines up and is never used anywhere else.

> Could we switch these calculations to something like:
>
>         return (jump_label_t)((long)&entrty->code + entry->code);
>

jump_label_t is local to this .h file, so it can be defined as u32 or
u64 depending on the word size. I don't mind adding the extra cast,
but I am not sure if your paranoia is justified in this particular
case. Perhaps we should just use 'unsigned long' throughout?

>> +}
>> +
>> +static inline jump_label_t jump_entry_target(const struct jump_entry *entry)
>> +{
>> +     return (jump_label_t)&entry->target + entry->target;
>>  }
>>
>>  static inline struct static_key *jump_entry_key(const struct jump_entry *entry)
>>  {
>> -     return (struct static_key *)((unsigned long)entry->key & ~1UL);
>> +     unsigned long key = (unsigned long)&entry->key + entry->key;
>> +
>> +     return (struct static_key *)(key & ~1UL);
>>  }
>>
>>  static inline bool jump_entry_is_branch(const struct jump_entry *entry)
>> @@ -99,7 +106,7 @@ static inline void jump_entry_set_module_init(struct jump_entry *entry)
>>       entry->code = 0;
>>  }
>>
>> -#define jump_label_swap              NULL
>> +void jump_label_swap(void *a, void *b, int size);
>>
>>  #else        /* __ASSEMBLY__ */
>>
>> @@ -114,8 +121,8 @@ static inline void jump_entry_set_module_init(struct jump_entry *entry)
>>       .byte           STATIC_KEY_INIT_NOP
>>       .endif
>>       .pushsection __jump_table, "aw"
>> -     _ASM_ALIGN
>> -     _ASM_PTR        .Lstatic_jump_\@, \target, \key
>> +     .balign         4
>> +     .long           .Lstatic_jump_\@ - ., \target - ., \key - .
>>       .popsection
>>  .endm
>>
>> @@ -130,8 +137,8 @@ static inline void jump_entry_set_module_init(struct jump_entry *entry)
>>  .Lstatic_jump_after_\@:
>>       .endif
>>       .pushsection __jump_table, "aw"
>> -     _ASM_ALIGN
>> -     _ASM_PTR        .Lstatic_jump_\@, \target, \key + 1
>> +     .balign         4
>> +     .long           .Lstatic_jump_\@ - ., \target - ., \key - . + 1
>>       .popsection
>>  .endm
>>
>> diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
>> index e56c95be2808..cc5034b42335 100644
>> --- a/arch/x86/kernel/jump_label.c
>> +++ b/arch/x86/kernel/jump_label.c
>> @@ -52,22 +52,24 @@ static void __jump_label_transform(struct jump_entry *entry,
>>                        * Jump label is enabled for the first time.
>>                        * So we expect a default_nop...
>>                        */
>> -                     if (unlikely(memcmp((void *)entry->code, default_nop, 5)
>> -                                  != 0))
>> -                             bug_at((void *)entry->code, __LINE__);
>> +                     if (unlikely(memcmp((void *)jump_entry_code(entry),
>> +                                         default_nop, 5) != 0))
>> +                             bug_at((void *)jump_entry_code(entry),
>
> You have the functions already made before this patch. Perhaps we
> should have a separate patch to use them (here and elsewhere) before
> you make the conversion to using relative references. It will help out
> in debugging and bisects. To know if the use of functions is an issue,
> or the conversion of relative references is an issue.
>
> I suggest splitting this into two patches.
>

Fair enough.


>> +                                    __LINE__);
>>               } else {
>>                       /*
>>                        * ...otherwise expect an ideal_nop. Otherwise
>>                        * something went horribly wrong.
>>                        */
>> -                     if (unlikely(memcmp((void *)entry->code, ideal_nop, 5)
>> -                                  != 0))
>> -                             bug_at((void *)entry->code, __LINE__);
>> +                     if (unlikely(memcmp((void *)jump_entry_code(entry),
>> +                                         ideal_nop, 5) != 0))
>> +                             bug_at((void *)jump_entry_code(entry),
>> +                                    __LINE__);
>>               }
>>
>>               code.jump = 0xe9;
>> -             code.offset = entry->target -
>> -                             (entry->code + JUMP_LABEL_NOP_SIZE);
>> +             code.offset = jump_entry_target(entry) -
>> +                           (jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
>>       } else {
>>               /*
>>                * We are disabling this jump label. If it is not what
>> @@ -76,14 +78,18 @@ static void __jump_label_transform(struct jump_entry *entry,
>>                * are converting the default nop to the ideal nop.
>>                */
>>               if (init) {
>> -                     if (unlikely(memcmp((void *)entry->code, default_nop, 5) != 0))
>> -                             bug_at((void *)entry->code, __LINE__);
>> +                     if (unlikely(memcmp((void *)jump_entry_code(entry),
>> +                                         default_nop, 5) != 0))
>> +                             bug_at((void *)jump_entry_code(entry),
>> +                                    __LINE__);
>>               } else {
>>                       code.jump = 0xe9;
>> -                     code.offset = entry->target -
>> -                             (entry->code + JUMP_LABEL_NOP_SIZE);
>> -                     if (unlikely(memcmp((void *)entry->code, &code, 5) != 0))
>> -                             bug_at((void *)entry->code, __LINE__);
>> +                     code.offset = jump_entry_target(entry) -
>> +                             (jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
>> +                     if (unlikely(memcmp((void *)jump_entry_code(entry),
>> +                                  &code, 5) != 0))
>> +                             bug_at((void *)jump_entry_code(entry),
>> +                                    __LINE__);
>>               }
>>               memcpy(&code, ideal_nops[NOP_ATOMIC5], JUMP_LABEL_NOP_SIZE);
>>       }
>> @@ -97,10 +103,13 @@ static void __jump_label_transform(struct jump_entry *entry,
>>        *
>>        */
>>       if (poker)
>> -             (*poker)((void *)entry->code, &code, JUMP_LABEL_NOP_SIZE);
>> +             (*poker)((void *)jump_entry_code(entry), &code,
>> +                      JUMP_LABEL_NOP_SIZE);
>>       else
>> -             text_poke_bp((void *)entry->code, &code, JUMP_LABEL_NOP_SIZE,
>> -                          (void *)entry->code + JUMP_LABEL_NOP_SIZE);
>> +             text_poke_bp((void *)jump_entry_code(entry), &code,
>> +                          JUMP_LABEL_NOP_SIZE,
>> +                          (void *)jump_entry_code(entry) +
>> +                          JUMP_LABEL_NOP_SIZE);
>>  }
>>
>>  void arch_jump_label_transform(struct jump_entry *entry,
>> @@ -140,4 +149,20 @@ __init_or_module void arch_jump_label_transform_static(struct jump_entry *entry,
>>               __jump_label_transform(entry, type, text_poke_early, 1);
>>  }
>>
>> +void jump_label_swap(void *a, void *b, int size)
>> +{
>> +     long delta = (unsigned long)a - (unsigned long)b;
>> +     struct jump_entry *jea = a;
>> +     struct jump_entry *jeb = b;
>> +     struct jump_entry tmp = *jea;
>> +
>> +     jea->code       = jeb->code - delta;
>> +     jea->target     = jeb->target - delta;
>> +     jea->key        = jeb->key - delta;
>> +
>> +     jeb->code       = tmp.code + delta;
>> +     jeb->target     = tmp.target + delta;
>> +     jeb->key        = tmp.key + delta;
>> +}
>> +
>>  #endif
>> diff --git a/tools/objtool/special.c b/tools/objtool/special.c
>> index 84f001d52322..98ae55b39037 100644
>> --- a/tools/objtool/special.c
>> +++ b/tools/objtool/special.c
>> @@ -30,9 +30,9 @@
>>  #define EX_ORIG_OFFSET               0
>>  #define EX_NEW_OFFSET                4
>>
>> -#define JUMP_ENTRY_SIZE              24
>> +#define JUMP_ENTRY_SIZE              12
>>  #define JUMP_ORIG_OFFSET     0
>> -#define JUMP_NEW_OFFSET              8
>> +#define JUMP_NEW_OFFSET              4
>>
>>  #define ALT_ENTRY_SIZE               13
>>  #define ALT_ORIG_OFFSET              0
>
