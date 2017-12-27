Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Dec 2017 21:00:02 +0100 (CET)
Received: from mail-io0-x244.google.com ([IPv6:2607:f8b0:4001:c06::244]:46856
        "EHLO mail-io0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990493AbdL0T7ys1hVF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Dec 2017 20:59:54 +0100
Received: by mail-io0-x244.google.com with SMTP id x129so36332865iod.13
        for <linux-mips@linux-mips.org>; Wed, 27 Dec 2017 11:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Xfs91tE3NYFRnce+RSnL2Pb8Taf+Hyi37Lrqb7czqH0=;
        b=EprJboss/zq53Ezzq6KNGyGBgTzAfNqd1fYfCOc+76fiLNXwy7UcySKfoSFdpGLYVQ
         qT19czGghnFFicRwh2RRegLbi/IBvP5K5d6QMFGxC2Rzokg0Ra2w/H5kTsh9vhKBw/Yr
         XOvqMmlAL2sPc3xadqyJ0Gbq/TJp4uhFh2Nyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Xfs91tE3NYFRnce+RSnL2Pb8Taf+Hyi37Lrqb7czqH0=;
        b=csrLM6bJWtqSbpFeK8dQM+qWj1VuW/iEul57lUY3YJwnONR3DuB5B+SZNKPurMCM1h
         4MAiAaxOsLEuXGBlLhrGZP+eBr36thRg09wEmYgLNMMH0LAclxC8YZAg6JlgSwZ7ixsL
         LYGVERh3wdE9v3L4ZgMYGbkidTSl6/Ecd0XnTyKTl5DUzbc53OXAxcdb/3kNT2cpgcHT
         CdfUzEa2/izzzMqizbQmo8oCOd+1u/+tVvQH8bkSdRGbnE60a6OExXbZpPxpayQAFKLY
         l4BnxE3Yd2o2a1j6FenkmtXBCh7mcd4bKds/WpMsh+3vTuLqkbGzy7AvcFwLdN3x4Odn
         PzVg==
X-Gm-Message-State: AKGB3mJiaaiM0fNnR895ZwfVnwOoepbWiV0+Csrsk2Y/RsTuvJ9bFIkY
        U037xpfeP+aG59FQEU5TW4pbgmEbwyyOT2se++l1WQ==
X-Google-Smtp-Source: ACJfBosgnJhuEEENvYq+Tv9lrnLXw07tv2H7wXviR/kyi22HwdIkvbCSXs/tTnIA8QURU8/vovHlu1fpsi6GO4+8MN4=
X-Received: by 10.107.133.34 with SMTP id h34mr37848770iod.253.1514404786217;
 Wed, 27 Dec 2017 11:59:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.52.14 with HTTP; Wed, 27 Dec 2017 11:59:45 -0800 (PST)
In-Reply-To: <CA+55aFyJg=-PfrVV1kw_bqKKd9Uk+q2FS4pqPp-og_DDbhhaFw@mail.gmail.com>
References: <20171227085033.22389-1-ard.biesheuvel@linaro.org>
 <20171227085033.22389-2-ard.biesheuvel@linaro.org> <CA+55aFyJg=-PfrVV1kw_bqKKd9Uk+q2FS4pqPp-og_DDbhhaFw@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 27 Dec 2017 19:59:45 +0000
Message-ID: <CAKv+Gu_rzc3=9Uip-CmJHf5rs9mfbx5ap_VZN73tmBMiJZ25TQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/8] arch: enable relative relocations for arm64,
 power, x86, s390 and x86
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
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <ard.biesheuvel@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61637
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

On 27 December 2017 at 19:54, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, Dec 27, 2017 at 12:50 AM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
>> index 7da3e5c366a0..49ae5b43fe2b 100644
>> --- a/arch/arm64/kernel/vmlinux.lds.S
>> +++ b/arch/arm64/kernel/vmlinux.lds.S
>> @@ -156,7 +156,7 @@ SECTIONS
>>                 CON_INITCALL
>>                 SECURITY_INITCALL
>>                 INIT_RAM_FS
>> -               *(.init.rodata.* .init.bss)     /* from the EFI stub */
>> +               *(.init.rodata.* .init.bss .init.discard.*)     /* EFI stub */
>>         }
>>         .exit.data : {
>>                 ARM_EXIT_KEEP(EXIT_DATA)
>
> Weren't you supposed to explain this part in the commit message?
>

Oops. Apologies, I indeed forgot to update the commit log.

> It isn't obvious why this is mixed up with the Kconfig changes, and
> somebody already asked about it. The commit message only talks about
> the Kconfig changes, and then suddenly there's that odd vmlinux.lds.S
> change in there...
>

Yeah. It doesn't make sense to respin right away for just that, so I
will give people some time to respond, and respin in a week or so.
