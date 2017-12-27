Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Dec 2017 21:13:53 +0100 (CET)
Received: from mail-it0-x242.google.com ([IPv6:2607:f8b0:4001:c0b::242]:41505
        "EHLO mail-it0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990475AbdL0UNqNF38F (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Dec 2017 21:13:46 +0100
Received: by mail-it0-x242.google.com with SMTP id x28so26203051ita.0;
        Wed, 27 Dec 2017 12:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=y1zLnRsmXXGFXesYN0eRihOtHfQLadMIkbeHN6QmeKU=;
        b=O0uNLWPl+yES4teePaloy6NhiEct4/e9c5DLKI6TpSsyp04oowcXizuSvyuHGHcTky
         ed2nAXZEYNNfz6/AcxkoChRcQEI1zStjttiW6/tQY3ZZ/aemK6v3D1Q+iYhyf3QyLV4e
         UjRAh1xvwsgc7c2GipNe320RUDIg03hBnhcvik/1SoqjfrHkZCGw0HRu0g3FvXUXas82
         FYTriSgIPVVjGd7D5bQonWo64vsr3xJIUXRxulUoffPXK7KE0bSmb4/qCL4Q5xVkeTMR
         WzG9esPEFrxJSQi4c7bnzsbVneIU9KReZd4Ea8ZY1Ms6fGO+u82FvWomdvbZRNuApFdn
         yPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=y1zLnRsmXXGFXesYN0eRihOtHfQLadMIkbeHN6QmeKU=;
        b=i6RUetUw1a1p/bigfEk6xHAfmjWL2HFT16myEntxZ+K/IdCX/gVluWBtGkFEL9Ma+4
         6AbAC4uvc3KRhCsbskM75+fdwS7o/FOlp5tfwWW2SwDuUQExg6akZyAEp5FhvzrXYdJv
         DAJCIE3bsXsrbASOEcmVyDspTNonNgYvsICQtvwWAmh6x3AiKoFPU7ZS8tPDtfAuajqW
         c1uIRVPYbMMB2cjnvii8rRRPv0J/di4MTew2n4BMssNvJ06bfs1ZhXQAdL+qE7ODJRpw
         F/Xxn75Ies+4roS6QI18MOdKj9UCxkVyYfInP0LMeI0R2C4bH5T+Rit7ca2RT4maM71u
         TXIA==
X-Gm-Message-State: AKGB3mJaszAnVjCkPvnAjS18rOkbTTYBPjVc7D3jLvfpLsK2+sObBaCH
        7c5zJp6v7S2fM/tYjEfh4b4p3tfMJvb8p+M2dvU=
X-Google-Smtp-Source: ACJfBouHQF3HCwAL6Z7Hr48fXhmEvAfjfuIAjXcFh0K0KgUog6BIjTxv/ralvjD1yDoZCa8vElMmZOQCcyoUYcXXb98=
X-Received: by 10.36.87.79 with SMTP id u76mr37140380ita.123.1514405620280;
 Wed, 27 Dec 2017 12:13:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.20.11 with HTTP; Wed, 27 Dec 2017 12:13:39 -0800 (PST)
In-Reply-To: <CAKv+Gu-2NUzsakN2rcM_5fqD0ubr+6ZXSc+5sjZZPbU3wj_Xsg@mail.gmail.com>
References: <20171227085033.22389-1-ard.biesheuvel@linaro.org>
 <20171227085033.22389-3-ard.biesheuvel@linaro.org> <CA+55aFxqJqJq_7VUzBVTppgXFPc-8Ou55iLsZjp3fr6B2gRyTQ@mail.gmail.com>
 <CAKv+Gu-2NUzsakN2rcM_5fqD0ubr+6ZXSc+5sjZZPbU3wj_Xsg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 27 Dec 2017 12:13:39 -0800
X-Google-Sender-Auth: zVgzX-d_nJG16JgRrmDHiOqLn_4
Message-ID: <CA+55aFzygF6P3v5VxyBucZfn-tg58jeV6qwt0y7QGmmNiKYghQ@mail.gmail.com>
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
X-archive-position: 61640
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

On Wed, Dec 27, 2017 at 12:11 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> I tried to keep the generic patches generic, so perhaps I should just
> put the arm64 vmlinux.lds.S change in a patch on its own?

I guess it doesn't matter, but regardless of where it gets introduced
I would like to see the explanation for where the heck that magical
".init.discard.text" comes from. It's definitely not obvious from the
patches, and is presumably some odd arm64 special case.

                Linus
