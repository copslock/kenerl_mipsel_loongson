Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jan 2018 19:32:03 +0100 (CET)
Received: from mail-io0-x241.google.com ([IPv6:2607:f8b0:4001:c06::241]:36361
        "EHLO mail-io0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992917AbeAES3QUBLUs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Jan 2018 19:29:16 +0100
Received: by mail-io0-x241.google.com with SMTP id i143so6666227ioa.3
        for <linux-mips@linux-mips.org>; Fri, 05 Jan 2018 10:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=natVfQ+IpNfDeB80W6ycCTiDBBIXVjnw+pa8DYIT330=;
        b=KALrnFDy8MM9pLP5bOU9GYBonxmPcfISD8r6q+GxCOItQmVdWwPF7KeS0fJH2MPHWI
         eDhf30aZiVZmPPC0WVE7F0iG3Y3AAWw1MJ8r0d1ccTycxhROWrOQCVdobiiiLGwPmAbS
         yxvpzmjSas3TSTkXiUjftVshhjIrCwW9dniII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=natVfQ+IpNfDeB80W6ycCTiDBBIXVjnw+pa8DYIT330=;
        b=MiC/bhAtgbeobtNqJd0JiIZRwrhz188LTLaXEbuPOZP+MIm2NwmeW2dcz0LMuhCXoQ
         6LuEn+NXaBgSxsa1onu2xA0+cS6h6D3bxHwQaKeqIPta4jZ4IY1aXyafTCkSujjynMuv
         FZRz/Q6JY2TfwTCQRtA9VaQv8oETnTnfK1+sNhwVKSI5k8LCulpKytO8PkAZyTrqX4iw
         j2i1dGmlJq/vQnwr9+9vFG5Cr07Zxr10WyWzAw+AeInqaObB9iOh/ZgaOowS0pBFunoU
         mmhGxcEMSH5s1pFCFDHu5KLS49sINM5QabkISGW+N5Q+9RGWbASN3UsuvdaGDhZ5NMQA
         e7rQ==
X-Gm-Message-State: AKGB3mJfTJN+BQv9kNYRT+e8+BhC0devLuByxXFABkmuPbjqUVTNw6Ma
        IbWpD0IUxe08SDPtA3dOpUofzyw5EPkh/PmVMIaTvQ==
X-Google-Smtp-Source: ACJfBotnQeUAaLZnAlB/88WUGMI/ztwB/HqCJ6ZvSjMZR5M+rmV9/DAcmMSw28UHw4m24o+UHEqliFcE9Z6EW3K001A=
X-Received: by 10.107.160.196 with SMTP id j187mr4176769ioe.186.1515176949978;
 Fri, 05 Jan 2018 10:29:09 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.37.197 with HTTP; Fri, 5 Jan 2018 10:29:09 -0800 (PST)
In-Reply-To: <20180105182229.pjnlq3l5hzfac4na@armageddon.cambridge.arm.com>
References: <20180102200549.22984-1-ard.biesheuvel@linaro.org>
 <20180102200549.22984-8-ard.biesheuvel@linaro.org> <20180105175834.vqgpsme7itsdg54u@armageddon.cambridge.arm.com>
 <CAKv+Gu8zROE-TDpfbbVi3RPOr8BNcsN_s27Gr-VvMN+-eMU+Hg@mail.gmail.com> <20180105182229.pjnlq3l5hzfac4na@armageddon.cambridge.arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 5 Jan 2018 18:29:09 +0000
Message-ID: <CAKv+Gu9R=Dmog+omP0xAGmsBiH0rseHAVjob4VA5P3c7i4++hQ@mail.gmail.com>
Subject: Re: [PATCH v7 07/10] kernel/jump_label: abstract jump_entry member accessors
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Will Deacon <will.deacon@arm.com>,
        Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        Nicolas Pitre <nico@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Petr Mladek <pmladek@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        James Morris <james.l.morris@oracle.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Jessica Yu <jeyu@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Thomas Garnier <thgarnie@google.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <ard.biesheuvel@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61937
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

On 5 January 2018 at 18:22, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Fri, Jan 05, 2018 at 06:01:33PM +0000, Ard Biesheuvel wrote:
>> On 5 January 2018 at 17:58, Catalin Marinas <catalin.marinas@arm.com> wrote:
>> > On Tue, Jan 02, 2018 at 08:05:46PM +0000, Ard Biesheuvel wrote:
>> >> diff --git a/arch/arm/include/asm/jump_label.h b/arch/arm/include/asm/jump_label.h
>> >> index e12d7d096fc0..7b05b404063a 100644
>> >> --- a/arch/arm/include/asm/jump_label.h
>> >> +++ b/arch/arm/include/asm/jump_label.h
>> >> @@ -45,5 +45,32 @@ struct jump_entry {
>> >>       jump_label_t key;
>> >>  };
>> >>
>> >> +static inline jump_label_t jump_entry_code(const struct jump_entry *entry)
>> >> +{
>> >> +     return entry->code;
>> >> +}
>> >> +
>> >> +static inline struct static_key *jump_entry_key(const struct jump_entry *entry)
>> >> +{
>> >> +     return (struct static_key *)((unsigned long)entry->key & ~1UL);
>> >> +}
>> >> +
>> >> +static inline bool jump_entry_is_branch(const struct jump_entry *entry)
>> >> +{
>> >> +     return (unsigned long)entry->key & 1UL;
>> >> +}
>> >> +
>> >> +static inline bool jump_entry_is_module_init(const struct jump_entry *entry)
>> >> +{
>> >> +     return entry->code == 0;
>> >> +}
>> >> +
>> >> +static inline void jump_entry_set_module_init(struct jump_entry *entry)
>> >> +{
>> >> +     entry->code = 0;
>> >> +}
>> >> +
>> >> +#define jump_label_swap              NULL
>> >
>> > Is there any difference between these functions on any of the
>> > architectures touched? Even with the relative offset, arm64 and x86
>> > looked the same to me (well, I may have missed some detail).
>>
>> No, the latter two are identical everywhere, and the others are the
>> same modulo absolute vs relative.
>>
>> The issue is that the struct definition is per-arch so the accessors
>> should be as well.
>
> Up to this patch, even the jump_entry structure is the same on all
> architectures (the jump_label_t type differs).
>
> With relative offset, can you not just define jump_label_t to s32? At a
> quick grep in mainline, it doesn't seem to be used outside the structure
> definition.
>

I think we can just remove jump_label_t entirely, and replace it with
unsigned long for absolute, and s32 for relative. Maybe I am missing
something, but things like

#ifdef CONFIG_X86_64
typedef u64 jump_label_t;
#else
typedef u32 jump_label_t;
#endif

seem a bit pointless to me anyway.


>> Perhaps I should introduce two variants two asm-generic, similar to
>> how we have different flavors of unaligned accessors.
>
> You could as well define them directly in kernel/jump_label.h or, if
> used outside this file, include/linux/jump_label.h.
>

Perhaps I should define a Kconfig symbol after all for relative jump
labels, and just keep everything in the same file. The question is
whether I should use CONFIG_HAVE_ARCH_PREL32_RELOCATIONS for this as
well.
