Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2014 22:08:16 +0200 (CEST)
Received: from mail-wi0-f181.google.com ([209.85.212.181]:50514 "EHLO
        mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861307AbaGPUINV-2to (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Jul 2014 22:08:13 +0200
Received: by mail-wi0-f181.google.com with SMTP id bs8so1880181wib.14
        for <linux-mips@linux-mips.org>; Wed, 16 Jul 2014 13:08:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=MwCrgeHrXE5Eoydr+WgeX1ISNQyQp+No++d5v8W/baE=;
        b=G3/4UC7jj1qRNNaIN9hPI7Vywy3T5NdsBr0ZIkIXevia/ZhfBNwvEUt9/pOvrXySZp
         31tZJMQDTrEsywYqS94EHtwx1n1a5ZG/0k4gFfOeZJjJsxc3F9Jvya7uimxzXHnqceuu
         EeLxCO/6ZMUqUmR4xE/035Z0tWN1nHFOIgrHHrVgob23SlvAiYhYA1KJYjYtp+Z6/hE7
         BX1CRMyeszLSIm+lPU8J4Wicf4ER8cY/35LfNwwEhro56oL69+yuNvcp17ULY+QofaTE
         YxU68cXKpg1oC083gManTsv91bz6KiKNfHbRfGw35RQMvegvG5lOz3FDBp3bZuLv/j+Y
         THvA==
X-Gm-Message-State: ALoCoQkPFgArqBBXgcBvQv8hiPaD/pdSr66SEzZMSrw0rXkEAzb4/qYrilYrPK8mHk71RnsmStie
MIME-Version: 1.0
X-Received: by 10.180.9.71 with SMTP id x7mr16114102wia.61.1405541283687; Wed,
 16 Jul 2014 13:08:03 -0700 (PDT)
Received: by 10.194.121.228 with HTTP; Wed, 16 Jul 2014 13:08:03 -0700 (PDT)
In-Reply-To: <3bee564fe07150f11d2e5078d457b6aacde43bec.1405452484.git.luto@amacapital.net>
References: <cover.1405452484.git.luto@amacapital.net>
        <3bee564fe07150f11d2e5078d457b6aacde43bec.1405452484.git.luto@amacapital.net>
Date:   Wed, 16 Jul 2014 13:08:03 -0700
Message-ID: <CAMEtUuywjY8habDJJWyDZLBWtXZXDqpmn2hZ9Dts1hrQ7OWXnA@mail.gmail.com>
Subject: Re: [PATCH 6/7] x86_64,entry: Treat regs->ax the same in fastpath and
 slowpath syscalls
From:   Alexei Starovoitov <ast@plumgrid.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>,
        James Morris <james.l.morris@oracle.com>,
        Oleg Nesterov <oleg@redhat.com>, X86 ML <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <ast@plumgrid.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41231
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ast@plumgrid.com
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

On Tue, Jul 15, 2014 at 12:32 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> For slowpath syscalls, we initialize regs->ax to -ENOSYS and stick
> the syscall number into regs->orig_ax prior to any possible tracing
> and syscall execution.  This is user-visible ABI used by ptrace
> syscall emulation and seccomp.
>
> For fastpath syscalls, there's no good reason not to do the same
> thing.  It's even slightly simpler than what we're currently doing.
> It probably has no measureable performance impact.  It should have
> no user-visible effect.
>
> The purpose of this patch is to prepare for seccomp-based syscall
> emulation in the fast path.  This change is just subtle enough that
> I'm keeping it separate.
>
> Signed-off-by: Andy Lutomirski <luto@amacapital.net>
> ---
>  arch/x86/include/asm/calling.h |  6 +++++-
>  arch/x86/kernel/entry_64.S     | 11 +++--------
>  2 files changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/arch/x86/include/asm/calling.h b/arch/x86/include/asm/calling.h
> index cb4c73b..76659b6 100644
> --- a/arch/x86/include/asm/calling.h
> +++ b/arch/x86/include/asm/calling.h
> @@ -85,7 +85,7 @@ For 32-bit we have the following conventions - kernel is built with
>  #define ARGOFFSET      R11
>  #define SWFRAME                ORIG_RAX
>
> -       .macro SAVE_ARGS addskip=0, save_rcx=1, save_r891011=1
> +       .macro SAVE_ARGS addskip=0, save_rcx=1, save_r891011=1, rax_enosys=0
>         subq  $9*8+\addskip, %rsp
>         CFI_ADJUST_CFA_OFFSET   9*8+\addskip
>         movq_cfi rdi, 8*8
> @@ -96,7 +96,11 @@ For 32-bit we have the following conventions - kernel is built with
>         movq_cfi rcx, 5*8
>         .endif
>
> +       .if \rax_enosys
> +       movq $-ENOSYS, 4*8(%rsp)
> +       .else
>         movq_cfi rax, 4*8
> +       .endif
>
>         .if \save_r891011
>         movq_cfi r8,  3*8
> diff --git a/arch/x86/kernel/entry_64.S b/arch/x86/kernel/entry_64.S
> index b25ca96..432c190 100644
> --- a/arch/x86/kernel/entry_64.S
> +++ b/arch/x86/kernel/entry_64.S
> @@ -405,8 +405,8 @@ GLOBAL(system_call_after_swapgs)
>          * and short:
>          */
>         ENABLE_INTERRUPTS(CLBR_NONE)
> -       SAVE_ARGS 8,0
> -       movq  %rax,ORIG_RAX-ARGOFFSET(%rsp)
> +       SAVE_ARGS 8, 0, rax_enosys=1
> +       movq_cfi rax,(ORIG_RAX-ARGOFFSET)

I think changing store rax to macro is unnecessary,
since it breaks common style of asm with the next line:
>         movq  %rcx,RIP-ARGOFFSET(%rsp)
Also it made the diff harder to grasp.

The change from the next patch 7/7:

> -       ja   int_ret_from_sys_call      /* RAX(%rsp) set to -ENOSYS above */
> +       ja   int_ret_from_sys_call      /* RAX(%rsp) is already set */

probably belongs in this 6/7 patch as well.

The rest look good to me. I think it's a big improvement in readability
comparing to v1.
