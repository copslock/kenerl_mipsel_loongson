Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Dec 2017 20:55:11 +0100 (CET)
Received: from mail-io0-x243.google.com ([IPv6:2607:f8b0:4001:c06::243]:33822
        "EHLO mail-io0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990475AbdL0TzFI160F (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Dec 2017 20:55:05 +0100
Received: by mail-io0-x243.google.com with SMTP id q188so12068327iod.1;
        Wed, 27 Dec 2017 11:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=8dE6k4Y9YtFyT/mk5ZWXCmhZmPUhg/Os7HUQamu5w8w=;
        b=DQJFyankOkMTCbWbXWAU6L6RnLaJxWvXNfylsJSb3OjLlNIjXplTHpAxY2j7iFwTE6
         +zTeXGxa3KVDytpXJaky6tp9JOUwPTNoak4dZ1KTOVk3KC94dR7YFcccnyV6tpd4eKKk
         O5d49r9REHyglx+NggqY970QmOn13pwnCIXFEy0cBJg05vhp5lWFCAsKo6gMi/HzbAkf
         uvvE/XgV7d98P1Ja3y/p7bFwgXm3PQaNag/gu3Szeks2MplQbRkDj+DzP4j3jRb2sRZp
         Nrzrm93poMPRLS8w335Ny4+zojFCvmzL0JP8e/2A8LNHzPsH6mAWUmWwKRqhtjunxl/T
         i0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=8dE6k4Y9YtFyT/mk5ZWXCmhZmPUhg/Os7HUQamu5w8w=;
        b=OV+DXow22Cwid9jolqX5UQiUsNecdom+SMRHjpyYy4uYJtFRx2gKvRRxBOBcd1HbRD
         0EroCzxZS4flM/pAzxlyxzhUGaEGk6CD5pR/Vgggg55QE8MMbbGJtK45a5UpV8hNWHjs
         +9tCf7li4HKGxvnt9nwVLInGCPw4syPAuBRQBFVL/UHq50/quBhM9iStdoTtxy7Q3sRd
         luJ7NNImjoxeJHYNrci6Y7lTTZb62Nv16Sl0qbarBBhCNyncKwn6lq+7bqISc1sm3de2
         aAVV1Q+1G6Esk9CAbVMdvfWhQePVSC2eP2PjxivG+kDtz2siQnwr/UrOqoVJtKS0t2pa
         gDsQ==
X-Gm-Message-State: AKGB3mKJTJRCyyPDkzh8/Mx0TXdMmVcGvryPpM2PoiMlvxy4Z2MFO2Tk
        yxCB7S/623ILtTNQk+UH+Dm8GB8VBYI1YVEMUpI=
X-Google-Smtp-Source: ACJfBovho/EPwV1aFmboR5wymxSm+gjGCUOe5GvdwyhUKDTtCTbtec/WXjZv6hSoUnCnmGZipLyayhevFAQsEs/1rE8=
X-Received: by 10.107.132.75 with SMTP id g72mr35132894iod.46.1514404498735;
 Wed, 27 Dec 2017 11:54:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.20.11 with HTTP; Wed, 27 Dec 2017 11:54:58 -0800 (PST)
In-Reply-To: <20171227085033.22389-2-ard.biesheuvel@linaro.org>
References: <20171227085033.22389-1-ard.biesheuvel@linaro.org> <20171227085033.22389-2-ard.biesheuvel@linaro.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 27 Dec 2017 11:54:58 -0800
X-Google-Sender-Auth: 6bjh7dFtl7Zli1Z_Vx_qS2q2nLY
Message-ID: <CA+55aFyJg=-PfrVV1kw_bqKKd9Uk+q2FS4pqPp-og_DDbhhaFw@mail.gmail.com>
Subject: Re: [PATCH v6 1/8] arch: enable relative relocations for arm64,
 power, x86, s390 and x86
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
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <linus971@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61636
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

On Wed, Dec 27, 2017 at 12:50 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 7da3e5c366a0..49ae5b43fe2b 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -156,7 +156,7 @@ SECTIONS
>                 CON_INITCALL
>                 SECURITY_INITCALL
>                 INIT_RAM_FS
> -               *(.init.rodata.* .init.bss)     /* from the EFI stub */
> +               *(.init.rodata.* .init.bss .init.discard.*)     /* EFI stub */
>         }
>         .exit.data : {
>                 ARM_EXIT_KEEP(EXIT_DATA)

Weren't you supposed to explain this part in the commit message?

It isn't obvious why this is mixed up with the Kconfig changes, and
somebody already asked about it. The commit message only talks about
the Kconfig changes, and then suddenly there's that odd vmlinux.lds.S
change in there...

              Linus
