Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Dec 2017 22:10:08 +0100 (CET)
Received: from mail-io0-x244.google.com ([IPv6:2607:f8b0:4001:c06::244]:42208
        "EHLO mail-io0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990718AbdLYVJyhr4JN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Dec 2017 22:09:54 +0100
Received: by mail-io0-x244.google.com with SMTP id x67so24972747ioi.9
        for <linux-mips@linux-mips.org>; Mon, 25 Dec 2017 13:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0rec9BGUSMv0S9vmcdN7TZLTIBlKYBghE7xcQkUdNd8=;
        b=TPpOQUw87Gl7Pyf4w8Lo2E4fcYes19yLGo5hkskSwoZ/98OzLtY5RpiIGX1b2iclk7
         gCmUZIlofzGc4TclW+2TzIc0fVsCeDoLFCOmzkfY7YG5hy0AYE0SDixSeUiZEd5CKm0h
         DVB1Hjet65ZtvCQZS7rQFPOUHLd3ajhRwy8GM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0rec9BGUSMv0S9vmcdN7TZLTIBlKYBghE7xcQkUdNd8=;
        b=FpYlI9j96dEPH2iw4xrofW4DKrtwo3FYTs8dB5KbNgOyPzJCehFVQRKK86rL7qj7rM
         yU0FNcUiSc9BeUffEwbPx+HCkQj1fHkx17InHsh7skIpEWE2IB1bA80yJEE4SMAX3PnA
         6Z3/Hd7Cgo/IE8YR/z5GJDNKBzRp3kcz757frhWLMtzjyiIEhcTk0mW67x0Cv03bkFQh
         jeGUATXAGQ3PixRNffa4OGotOJ/CPazIt3g3TLn/6SPA9KDztJvyGgK0y7U2LHVaIA0q
         JlW+RdhMuFXWqrojFzdWcNBHnNKDYl9ExbJvBXg8ZwSoPH9ko72aNT48c6R/bF8zl5BG
         iKEw==
X-Gm-Message-State: AKGB3mKgDNs5Uh4fIENVYovfQNf9PFABeC8U8R3TjZf29FlIR3JIigs4
        WxaB8msEBLDE9a9xkE5oxDlIlClXQ+BLHNgwc7DlUw==
X-Google-Smtp-Source: ACJfBovBg+LfVBMpvBvZZPodpbkR5NMgRXx3Vys7Ac1KbIiDygSRxtgnUl92cZGJ7ZbeUmibWnfY0U+awjbII+IgTB0=
X-Received: by 10.107.133.34 with SMTP id h34mr29993946iod.253.1514236188436;
 Mon, 25 Dec 2017 13:09:48 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.52.14 with HTTP; Mon, 25 Dec 2017 13:09:48 -0800 (PST)
In-Reply-To: <20171225210502.GA635@ravnborg.org>
References: <20171225205440.14575-1-ard.biesheuvel@linaro.org>
 <20171225205440.14575-2-ard.biesheuvel@linaro.org> <20171225210502.GA635@ravnborg.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 25 Dec 2017 21:09:48 +0000
Message-ID: <CAKv+Gu_Ue30XqQ4sok34U0rjcsfkN1caACzQN3En71Hmd6Kc3A@mail.gmail.com>
Subject: Re: [PATCH v5 1/8] arch: enable relative relocations for arm64,
 power, x86, s390 and x86
To:     Sam Ravnborg <sam@ravnborg.org>
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
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <ard.biesheuvel@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61581
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

On 25 December 2017 at 21:05, Sam Ravnborg <sam@ravnborg.org> wrote:
> Hi Ard.
>
> On Mon, Dec 25, 2017 at 08:54:33PM +0000, Ard Biesheuvel wrote:
>> Before updating certain subsystems to use place relative 32-bit
>> relocations in special sections, to save space  and reduce the
>> number of absolute relocations that need to be processed at runtime
>> by relocatable kernels, introduce the Kconfig symbol and define it
>> for some architectures that should be able to support and benefit
>> from it.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
>> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: x86@kernel.org
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  arch/Kconfig                    | 10 ++++++++++
>>  arch/arm64/Kconfig              |  1 +
>
>>  arch/arm64/kernel/vmlinux.lds.S |  2 +-
> The change to arch/arm64/kernel/vmlinux.lds.S is
> not justified in the changelog.
> Did you add it by mistake?
>

No. The PREL32 support adds a __ADDRESSABLE() macro that emits code
into .discard.text, and on arm64, the EFI object sections get a .init
prefix so we need to discard .init.discard.* explicitly as well.

I will add this as a note.

Thanks,
Ard.
