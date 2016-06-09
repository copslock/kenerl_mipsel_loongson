Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jun 2016 00:46:40 +0200 (CEST)
Received: from mail-oi0-f41.google.com ([209.85.218.41]:36343 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27034973AbcFIWqhs4Mkr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Jun 2016 00:46:37 +0200
Received: by mail-oi0-f41.google.com with SMTP id p204so86683630oih.3
        for <linux-mips@linux-mips.org>; Thu, 09 Jun 2016 15:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aoHCH3fie6sfbrCFxHCvFYiv3N9SppmNvsd1hUGqP9o=;
        b=fyB8JNBsY79Tr5scs5Vz8+U5WJ9lmjjzLgltrZuwCtT6sq+LgLqqZXAqPdwep/1ysw
         M98ITUKHRXdq/s5jrXCQVYVwuDNPL+IXUZYUJbnJ5MPSmLinBzGjCmGbXVKIDsHgTcdC
         DEHvOzEzbmUv/JM8zW45dCIFd0APheZ5/0zzbAhPSFU0xC7cCF64A28E02vw9LtSoCNa
         nQKj5RrcO/DZf/uXhSkLx5yHBTi9vbZwBeC9oSaqRG/dmblrJLnHY+/jC8/4R2IC0gOf
         j3i1mr0E8PPWmeki1VQtlVnFvl7z0F8wSaKhurmiBzmWq+G6LLokj3znaWF9qHaFm4As
         Hmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aoHCH3fie6sfbrCFxHCvFYiv3N9SppmNvsd1hUGqP9o=;
        b=MhyH4bb2x8SJLNh5In8X9qRkE3SB9huLJK/Ji4KBwdpwR0tgGc6Qb+HhCWAGq0YfIo
         8AU/P5ItZKmSEsPWt57TH9CMvXtx6geCOXRi65PYul+zaE04GoU9DwMlDMfUEDUrc7bi
         mpKstL5oOOaildkdI3X3kEaKfKP3UaXpJp2inHW0aW+RrgBCOaSRyTEGaNavPKvddPRf
         e2lWQxPnAU9bddN2ohby9bVseh05GWOvmEZWzw0uq9KJ9pPEZ6AuxEk52RAC01ixrSCX
         tfd95wrAqrwm039A8T+xFq9T/DHqpwM/W1T/4mxw/Qa+KaWnyo3iKx/ZFH37rSyObb02
         kLNQ==
X-Gm-Message-State: ALyK8tLDJAjNxG7r/fOELb0WlKw1lzZGoZ3uluWNtgJorMdFu03IMRXjkkuAxrmBfNyNuqTDiWuB3NOEcz87y/6J
X-Received: by 10.202.48.18 with SMTP id w18mr6057472oiw.61.1465512390172;
 Thu, 09 Jun 2016 15:46:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.202.199.148 with HTTP; Thu, 9 Jun 2016 15:46:10 -0700 (PDT)
In-Reply-To: <1465506124-21866-6-git-send-email-keescook@chromium.org>
References: <1465506124-21866-1-git-send-email-keescook@chromium.org> <1465506124-21866-6-git-send-email-keescook@chromium.org>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Thu, 9 Jun 2016 15:46:10 -0700
Message-ID: <CALCETrUsqr3YbD=5mA9mRmgYqiHeEoLpWi-teyexUo_jR1BaFA@mail.gmail.com>
Subject: Re: [PATCH 05/14] seccomp: recheck the syscall after RET_TRACE
To:     Kees Cook <keescook@chromium.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        James Hogan <james.hogan@imgtec.com>,
        Jeff Dike <jdike@addtoit.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        "user-mode-linux-devel@lists.sourceforge.net" 
        <user-mode-linux-devel@lists.sourceforge.net>,
        Will Deacon <will.deacon@arm.com>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54008
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luto@amacapital.net
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

On Thu, Jun 9, 2016 at 2:01 PM, Kees Cook <keescook@chromium.org> wrote:
> When RET_TRACE triggers, a tracer may change a syscall into something that
> should be filtered by seccomp. This re-runs seccomp after a trace event
> to make sure things continue to pass.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> ---
>  kernel/seccomp.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 14a37d71b612..54d15eb2b701 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -556,7 +556,8 @@ void secure_computing_strict(int this_syscall)
>  #else
>
>  #ifdef CONFIG_SECCOMP_FILTER
> -static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd)
> +static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
> +                           const bool recheck_after_trace)

This patch looks good with one minor nit: I read this as "pass true if
you want to recheck after trace", which is exactly the opposite of how
it works.

--Andy
