Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jan 2018 00:47:30 +0100 (CET)
Received: from mail-qt0-x241.google.com ([IPv6:2607:f8b0:400d:c0d::241]:46708
        "EHLO mail-qt0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990493AbeABXrX5HUJX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Jan 2018 00:47:23 +0100
Received: by mail-qt0-x241.google.com with SMTP id r39so81140qtr.13
        for <linux-mips@linux-mips.org>; Tue, 02 Jan 2018 15:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Mw932QmAlKwD6+w99yeClkfW/b6a7BggLs/lQgE2BB8=;
        b=ecGyGDRtw13u5TzXPdB5QFNohBYEUo3m3tfxO0ZHrSJsyWRKV8CFZRd4R7sbXbzqv5
         Vx95q1H7mZo9IGRmeGvmenjZHyAUyvToR4n7C5k84vvNWgaETfqdoIUNhRnMsc1fqFgG
         L8xCPgsvOYmehzFBkSV53/5KZfgVOpTAd+au0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Mw932QmAlKwD6+w99yeClkfW/b6a7BggLs/lQgE2BB8=;
        b=YZQuZ6tC8I2Y/uhyXNBPIcHnAlqebIcMD+U79KCPC1lU47er/mp/vUbeUfRz6MVN3w
         +f574V8YzSz5UKKcUu7eZiEu9NxoOyJi/ma7c9vuhmYriMuP9qO6nkk+YJM4yECMQ8Dh
         Q2QZSI2QX4Nnesif4iX8/7+eqK3gCJFqzECl/s6FmJc4UnbrI+ohGEP376daLPsiewDz
         62gABx/1CaNHd+KbfAv/vGNTS3wrb9DQeXOu6Y2xS671pPTkwx1vImSHBMOvaWzS1hRD
         YXojPID4s29ZUEx6ct6TDAnqXWN8PvaUymrS+8P1bJjOUkCxQ20rMpE4kOMEo/ZsyDl8
         iF6g==
X-Gm-Message-State: AKGB3mIUUgMh77sg5XCYMtrqK3hkd1qU8OBgTORshXf4l7g9rXzUgFGO
        a4ZRXG72s1q1MLTQ9lj9exz17Q==
X-Google-Smtp-Source: ACJfBouLo3OZxOU11hoxUCTCJDU6U/8mpPcwlwMVOQ3t0M0XZCTaBS1EVZ+fIOtYses7EVT9+RZYYQ==
X-Received: by 10.237.62.169 with SMTP id n38mr67207730qtf.42.1514936837193;
        Tue, 02 Jan 2018 15:47:17 -0800 (PST)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.gmail.com with ESMTPSA id q13sm30308057qta.22.2018.01.02.15.47.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jan 2018 15:47:16 -0800 (PST)
Date:   Tue, 2 Jan 2018 18:47:14 -0500 (EST)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
cc:     linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, x86@kernel.org,
        matt@codeblueprint.co.uk
Subject: Re: [PATCH v7 02/10] module: allow symbol exports to be disabled
In-Reply-To: <20180102200549.22984-3-ard.biesheuvel@linaro.org>
Message-ID: <nycvar.YSQ.7.76.1801021841410.8567@knanqh.ubzr>
References: <20180102200549.22984-1-ard.biesheuvel@linaro.org> <20180102200549.22984-3-ard.biesheuvel@linaro.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <nicolas.pitre@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61880
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nicolas.pitre@linaro.org
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

On Tue, 2 Jan 2018, Ard Biesheuvel wrote:

> To allow existing C code to be incorporated into the decompressor or
> the UEFI stub, introduce a CPP macro that turns all EXPORT_SYMBOL_xxx
> declarations into nops, and #define it in places where such exports
> are undesirable. Note that this gets rid of a rather dodgy redefine
> of linux/export.h's header guard.
[...]

> --- a/include/linux/export.h
> +++ b/include/linux/export.h
> @@ -83,6 +83,15 @@ extern struct module __this_module;
>   */
>  #define __EXPORT_SYMBOL(sym, sec)	=== __KSYM_##sym ===
>  
> +#elif defined(__DISABLE_EXPORTS)
> +
> +/*
> + * Allow symbol exports to be disabled completely so that C code may
> + * be reused in other execution contexts such as the UEFI stub or the
> + * decompressor.
> + */
> +#define __EXPORT_SYMBOL(sym, sec)
> +

I think you should rather put this first thing in the #if sequence so to 
override the defined(__KSYM_DEPS__) case too.  No need to create build 
dependencies for module symbols that you're going to stub out 
afterwards anyway.


Nicolas
