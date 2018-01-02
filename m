Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jan 2018 00:55:21 +0100 (CET)
Received: from mail-it0-x242.google.com ([IPv6:2607:f8b0:4001:c0b::242]:41644
        "EHLO mail-it0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990493AbeABXzMh0vAX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Jan 2018 00:55:12 +0100
Received: by mail-it0-x242.google.com with SMTP id x28so12367ita.0
        for <linux-mips@linux-mips.org>; Tue, 02 Jan 2018 15:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cN3exCLxDR+0Qbk/5vBZyf+KtB257iFTAsj4rwYMk3I=;
        b=b0974jyTpvM82syl3wVcZK5urV3dUiKWrnCZH1SNBVJhbOY0eOLzmwobwzDwKQNgjc
         wslGdSo/P8gSnvfuFtWwWWl0qryMB94R4kbwysnpQd+YrVEmhLg3i5U8oMRTt9XzXIz+
         5OWbFHhih3LtFwQ+NCIOJdbvyiDpOQhgJIMXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cN3exCLxDR+0Qbk/5vBZyf+KtB257iFTAsj4rwYMk3I=;
        b=AzoxwwC3tPCT3StEghrqCfVIKfwROmRe8Z6eDF3XaUvOZtM8r+RgvyHZc5B6PlzjnU
         aQjax8iczDS01ZM+6rjZkKIg6c/9wShh665ruOlgFcHg8G637WUJPIlGxGjSd45d1xev
         JVVCKeVStFtC9gLT506V3Z57hQhs53sAibwQDooXlaKK04+pQDYoI+aDOujLQcOn5mpR
         XmGID/fxDWCRDa9nKGkt71tTkpojnywYNrYyG5W9U3sOFc+brFZHn7omTU0c8A/LQE2Z
         tskpUlv5bquSxuINoqZ1vBRYuNQJNGGu16N954yn9vvZADeRyWq1etsE5FW4ZWO6yw90
         nBvg==
X-Gm-Message-State: AKGB3mLeKMRb14JYmTy7rAPojtVtF9cx3/8AVLf6//ETvAQvU8lwWAAj
        NJhQWu9pb31QP5m948ozLnWzYZlQv32CIssNOe8/jg==
X-Google-Smtp-Source: ACJfBosC5kRzW+irZKIzM0gzAvhRMY8HIOSnjpguILGMyz9Fl66G96MRIQlYpY7FWCx7KWXMVIvEFP7RWriY4J6tQS4=
X-Received: by 10.36.219.214 with SMTP id c205mr46847itg.65.1514937306388;
 Tue, 02 Jan 2018 15:55:06 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.37.197 with HTTP; Tue, 2 Jan 2018 15:55:05 -0800 (PST)
In-Reply-To: <nycvar.YSQ.7.76.1801021841410.8567@knanqh.ubzr>
References: <20180102200549.22984-1-ard.biesheuvel@linaro.org>
 <20180102200549.22984-3-ard.biesheuvel@linaro.org> <nycvar.YSQ.7.76.1801021841410.8567@knanqh.ubzr>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 2 Jan 2018 23:55:05 +0000
Message-ID: <CAKv+Gu9x+DeOdMn1CuEDNHtLSi1_cFpx7ZyxMYVGht0qBastmw@mail.gmail.com>
Subject: Re: [PATCH v7 02/10] module: allow symbol exports to be disabled
To:     Nicolas Pitre <nicolas.pitre@linaro.org>
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
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mips <linux-mips@linux-mips.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux@vger.kernel.org,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Matt Fleming <matt@codeblueprint.co.uk>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <ard.biesheuvel@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61881
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

On 2 January 2018 at 23:47, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Tue, 2 Jan 2018, Ard Biesheuvel wrote:
>
>> To allow existing C code to be incorporated into the decompressor or
>> the UEFI stub, introduce a CPP macro that turns all EXPORT_SYMBOL_xxx
>> declarations into nops, and #define it in places where such exports
>> are undesirable. Note that this gets rid of a rather dodgy redefine
>> of linux/export.h's header guard.
> [...]
>
>> --- a/include/linux/export.h
>> +++ b/include/linux/export.h
>> @@ -83,6 +83,15 @@ extern struct module __this_module;
>>   */
>>  #define __EXPORT_SYMBOL(sym, sec)    === __KSYM_##sym ===
>>
>> +#elif defined(__DISABLE_EXPORTS)
>> +
>> +/*
>> + * Allow symbol exports to be disabled completely so that C code may
>> + * be reused in other execution contexts such as the UEFI stub or the
>> + * decompressor.
>> + */
>> +#define __EXPORT_SYMBOL(sym, sec)
>> +
>
> I think you should rather put this first thing in the #if sequence so to
> override the defined(__KSYM_DEPS__) case too.  No need to create build
> dependencies for module symbols that you're going to stub out
> afterwards anyway.
>

I wasn't sure, so thanks for clearing that up.
