Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jan 2018 19:01:50 +0100 (CET)
Received: from mail-it0-x242.google.com ([IPv6:2607:f8b0:4001:c0b::242]:38721
        "EHLO mail-it0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992615AbeAESBlfIfO8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Jan 2018 19:01:41 +0100
Received: by mail-it0-x242.google.com with SMTP id r6so2536956itr.3
        for <linux-mips@linux-mips.org>; Fri, 05 Jan 2018 10:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LjkAWcK2lN+BfSDjI0DTdqAaFpq6j7cdGnlaCRCx8lc=;
        b=bQqMBU+rZD4gvfBc9lwDBvW5OwvnMXJJR7eJoi0yp50gKDGyJ9UmwgYXMw1V5vUBMj
         4zKMYYn/KP15dDLEseR9FiKWSDVn4fBNv51VevFbuFhjdn/bcawh6iot+fJyNMosENoN
         twZH7C/dGWRH5sR2mOygVe+dCDBpc7dFzvPfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LjkAWcK2lN+BfSDjI0DTdqAaFpq6j7cdGnlaCRCx8lc=;
        b=RnAwOslp/T0/7uuaNXgd5KfBfOiPdnDP9YHNx7Fw+WnF2yYvg4QDFiHGSdunP5Jbdf
         Zuvn3H1JU/+0+ogFDT15dTVf9azscHUqSar7QayvH6lKXPGSruW2mZ0S5f090OmxpcZp
         Hly9jG1gd+d9qo59riB8kM35pVocbEoqnuwJrMps7DksahRhwuOkav8uRGuFyTVwiiq8
         +x2d+G8WpwVdheLAsFGSd5J7QP0sO43tSspZoHvm88RoBJalVQfwVqBuR4gBRmWYGjVk
         lD5iosTlH+uVIEKOeBzyjOPGzMzxsUAmO+19sCNk+mquWTzDgt3E+h23Y0m/8H3+Tugl
         /Frg==
X-Gm-Message-State: AKGB3mKVgjlXZ2vMKWDsoNVcGdqbCQaoLlgeRMAtjlsN80ooYcplvXJJ
        bGzshso8ou7y2XcWKWMx9+mV/aCMX9rNDXn4dpZbhQ==
X-Google-Smtp-Source: ACJfBosn5RZW0OidvqlJ7SdlLuYZAFPe2MAipjvlXnPFrUlZTmJHHErqQhv6ld/Yae6pjQr7FR1uHekiyWzNzBui+qE=
X-Received: by 10.36.184.3 with SMTP id m3mr3761132ite.65.1515175294061; Fri,
 05 Jan 2018 10:01:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.37.197 with HTTP; Fri, 5 Jan 2018 10:01:33 -0800 (PST)
In-Reply-To: <20180105175834.vqgpsme7itsdg54u@armageddon.cambridge.arm.com>
References: <20180102200549.22984-1-ard.biesheuvel@linaro.org>
 <20180102200549.22984-8-ard.biesheuvel@linaro.org> <20180105175834.vqgpsme7itsdg54u@armageddon.cambridge.arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 5 Jan 2018 18:01:33 +0000
Message-ID: <CAKv+Gu8zROE-TDpfbbVi3RPOr8BNcsN_s27Gr-VvMN+-eMU+Hg@mail.gmail.com>
Subject: Re: [PATCH v7 07/10] kernel/jump_label: abstract jump_entry member accessors
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips <linux-mips@linux-mips.org>,
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
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Garnier <thgarnie@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Jessica Yu <jeyu@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <ard.biesheuvel@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61916
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

On 5 January 2018 at 17:58, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Tue, Jan 02, 2018 at 08:05:46PM +0000, Ard Biesheuvel wrote:
>> diff --git a/arch/arm/include/asm/jump_label.h b/arch/arm/include/asm/jump_label.h
>> index e12d7d096fc0..7b05b404063a 100644
>> --- a/arch/arm/include/asm/jump_label.h
>> +++ b/arch/arm/include/asm/jump_label.h
>> @@ -45,5 +45,32 @@ struct jump_entry {
>>       jump_label_t key;
>>  };
>>
>> +static inline jump_label_t jump_entry_code(const struct jump_entry *entry)
>> +{
>> +     return entry->code;
>> +}
>> +
>> +static inline struct static_key *jump_entry_key(const struct jump_entry *entry)
>> +{
>> +     return (struct static_key *)((unsigned long)entry->key & ~1UL);
>> +}
>> +
>> +static inline bool jump_entry_is_branch(const struct jump_entry *entry)
>> +{
>> +     return (unsigned long)entry->key & 1UL;
>> +}
>> +
>> +static inline bool jump_entry_is_module_init(const struct jump_entry *entry)
>> +{
>> +     return entry->code == 0;
>> +}
>> +
>> +static inline void jump_entry_set_module_init(struct jump_entry *entry)
>> +{
>> +     entry->code = 0;
>> +}
>> +
>> +#define jump_label_swap              NULL
>
> Is there any difference between these functions on any of the
> architectures touched? Even with the relative offset, arm64 and x86
> looked the same to me (well, I may have missed some detail).
>

No, the latter two are identical everywhere, and the others are the
same modulo absolute vs relative.

The issue is that the struct definition is per-arch so the accessors
should be as well. Perhaps I should introduce two variants two
asm-generic, similar to how we have different flavors of unaligned
accessors.
