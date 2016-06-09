Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jun 2016 00:52:34 +0200 (CEST)
Received: from mail-oi0-f52.google.com ([209.85.218.52]:35387 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041333AbcFIWw3ciuPr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Jun 2016 00:52:29 +0200
Received: by mail-oi0-f52.google.com with SMTP id w5so7904251oib.2
        for <linux-mips@linux-mips.org>; Thu, 09 Jun 2016 15:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FRLXaTUCXeN7l2F5J/LPJINGA4lDrC+OyG6muXYlBik=;
        b=L155FD68E17xOn1T28U4AydsouGnxLR5KchvnMsdMWyGtr7jXgxLpGGed2FohED/A0
         PA/YUBIsDOVXWpxHf3Dz+wu7ldO+hOE/dTjbXorqryZZDDRHFKqNx6Ibv3xSvoAFWy4Z
         roMdCGceDN/EMH1MUx0j+NFY10k2xtBRXdXvykZSeSJ9UTPNS98uOmZLx1EfMYSASpQX
         Oq8afBhN3Y8PkLY9/wpRHhAXK3JbM60W0VLWRqIuthTdxJlYAIU0eKhXyEN4lQlwCXWZ
         eUpOFxUtM87qG66FSyOzfFkerlb/7u0ttadAoujrn+H+o7sgfe18BY80lpkbqjd4mH7A
         gs1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FRLXaTUCXeN7l2F5J/LPJINGA4lDrC+OyG6muXYlBik=;
        b=MUMhKYTfzqbXVI/BI5b2FPH4yQooFy4pUXKA/ZV36428mRKLvYVFaiKbXCOj6jS70+
         2fKxRKAgTvdrLdn9bkDU2eZkuUhIVQ0GNgmQo1wcB0l+zVqu7oKBVjamd8MRxdZSEXcD
         JLMMTXEBw2o03gaPk5bC3qh2Eym90JgAumr38Ajx7YvFGCUZC2W3wJHafpY1tgzFWe5u
         UWehT0KQ0qwDSp3BLqJbsio+qV+6vFYulDyDU3LKe7CpwS9t6HsJ2pCxKaMmcIyik1E6
         RzNVjnI4i64kSoTMS9W/ZMOXOl1VUHUNG2JIFxUSZICn46W59cSL4lbI9kJVSideaR3F
         5uwA==
X-Gm-Message-State: ALyK8tKhEqhWd9ZSlXMa3nZDJ+I29YyJaCIqMmx0An4Y5aohahmQfqAblZOqMNZL8secpkKn1g2bOw9L5EIt8Ocs
X-Received: by 10.157.20.101 with SMTP id h92mr7437087oth.114.1465512743679;
 Thu, 09 Jun 2016 15:52:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.202.199.148 with HTTP; Thu, 9 Jun 2016 15:52:04 -0700 (PDT)
In-Reply-To: <1465506124-21866-7-git-send-email-keescook@chromium.org>
References: <1465506124-21866-1-git-send-email-keescook@chromium.org> <1465506124-21866-7-git-send-email-keescook@chromium.org>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Thu, 9 Jun 2016 15:52:04 -0700
Message-ID: <CALCETrVk-UauwaRtZZR0fKQO6kyAx-r=ZCurKRdhQk9nA-TqeQ@mail.gmail.com>
Subject: Re: [PATCH 06/14] x86/ptrace: run seccomp after ptrace
To:     Kees Cook <keescook@chromium.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Andy Lutomirski <luto@kernel.org>,
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
        Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54009
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
> This moves seccomp after ptrace on x86 to that seccomp can catch changes
> made by ptrace. Emulation should skip the rest of processing too.
>
> We can get rid of test_thread_flag because there's no longer any
> opportunity for seccomp to mess with ptrace state before invoking
> ptrace.
>
> Suggested-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Cc: x86@kernel.org
> Cc: Andy Lutomirski <luto@kernel.org>
> ---
>  arch/x86/entry/common.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> index df56ca394877..81c0e12d831c 100644
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -73,6 +73,7 @@ static long syscall_trace_enter(struct pt_regs *regs)
>
>         struct thread_info *ti = pt_regs_to_thread_info(regs);
>         unsigned long ret = 0;
> +       bool emulated = false;
>         u32 work;
>
>         if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
> @@ -80,11 +81,19 @@ static long syscall_trace_enter(struct pt_regs *regs)
>
>         work = ACCESS_ONCE(ti->flags) & _TIF_WORK_SYSCALL_ENTRY;
>
> +       if (unlikely(work & _TIF_SYSCALL_EMU))
> +               emulated = true;
> +
> +       if ((emulated || (work & _TIF_SYSCALL_TRACE)) &&
> +           tracehook_report_syscall_entry(regs))
> +               return -1L;
> +
> +       if (emulated)
> +               return -1L;
> +

I think that this code will result in ptrace-induced skips calling the
audit exit hook but not the audit entry hook.  I don't know whether
this is a problem.  It's also worth making sure that ptracing a
seccomp-skipped syscall calls the exit hook with the right regs.

I suspect it's fine, but I want to think about it a little bit more.

--Andy
