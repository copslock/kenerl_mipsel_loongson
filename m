Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Mar 2016 19:45:38 +0100 (CET)
Received: from mail-ig0-f182.google.com ([209.85.213.182]:35616 "EHLO
        mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008673AbcCUSpgEOlGe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Mar 2016 19:45:36 +0100
Received: by mail-ig0-f182.google.com with SMTP id cl4so39405056igb.0
        for <linux-mips@linux-mips.org>; Mon, 21 Mar 2016 11:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=v637RjSUcP13UnK3H+BNvo43Lk01jT9dTYtwLplaESs=;
        b=NjkMkcXplPX69KVnJnGP+QrBOKPFqnDB+rE6P2Di1rHqLYO+vE3F61YuLZDxnWyvHK
         AspaWs0TIEQ2T/KcE+eqLakcLnIzfFsZZCWrYZRuYhE7T5al4RAwM+g/dJMVIS09djee
         GsfPnZlmFAcFGswBP0heS7y1Xk1+M2PzY7CgEuI4TXYoKA4DZJ+O7AQkVHGlipWubM+Q
         90NrtL2QgRS2f+OBHb7kpYjHLGGiFetPKJYMY1FG6E9dAbE6rHr5xGwdIxf9Xf3kQAEp
         3/hDSq2KPbw4yK6OYH4r9knX6Q4zA50LlrHbfrGhBGFn9lQsDTJCVzsbaCRfi/Kuxz7i
         MYJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=v637RjSUcP13UnK3H+BNvo43Lk01jT9dTYtwLplaESs=;
        b=T10m9R1lowBAMZhzi0TXJ9Q5E1Xw2LLp7kN5ieN6AdRgSbgcqfxrd4pr8MzEFJalPe
         TiC6BvCfeRfFi680x9rwdJnI6AvxoMUHgCC97kzjoqpAISr19Va9izYrHCtj4Ur0aFLM
         77cNF9UaKwO8uze8NSZkQdOHbvBPQdSTasK6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=v637RjSUcP13UnK3H+BNvo43Lk01jT9dTYtwLplaESs=;
        b=EfTIRA1WTnVf3vvs2jK0gZskhrecTzD/anf3DDAFbxd5/V41hnZJAxy7KnKcnOdWIJ
         0MC72bapKqX8qnEWSYUnX+0GDdcx1SHAefBy8pze7nzk31nJctaByPbJNHUqnjgHaeba
         ZoTZACH+2BELnp5iSuiNqnr8YbnzD7DVoTVx6MusQE88E/Ua9NIIAE5nC5WCjo53wC5M
         T00pC0wJoYTyaD1noNwrak9S3MHr3nXhxCVgg317g81Bn1bzzRaPZdgulonoa/R2OQgp
         bblhSXej0QGxY0XuEIXQMAsS9ZLuxgYAD9AEBiwCLy20pzDTr98Ec7EcAYkCYEywTmj1
         8a2w==
X-Gm-Message-State: AD7BkJL10wgQGjLPIVlpPm7YxAiQh9QIC/oSvJHbzouy3VHP9Fr2mK/TUZchqqsxFu8J9tfxki4eZwBPDmJdqZVf
MIME-Version: 1.0
X-Received: by 10.50.152.41 with SMTP id uv9mr14543939igb.3.1458585930052;
 Mon, 21 Mar 2016 11:45:30 -0700 (PDT)
Received: by 10.64.25.129 with HTTP; Mon, 21 Mar 2016 11:45:29 -0700 (PDT)
In-Reply-To: <1458206798-26592-1-git-send-email-matt.redfearn@imgtec.com>
References: <1458206798-26592-1-git-send-email-matt.redfearn@imgtec.com>
Date:   Mon, 21 Mar 2016 11:45:29 -0700
X-Google-Sender-Auth: JvtYLj4AuT30MKRvlqmE5gbx2Cg
Message-ID: <CAGXu5jLexb=4ySrnz90xRdrK5X3KO0N_hy0gd1Lieaw3p64qqQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/seccomp: add MIPS self-test support
From:   Kees Cook <keescook@chromium.org>
To:     Matt Redfearn <matt.redfearn@imgtec.com>,
        Shuah Khan <shuahkh@osg.samsung.com>
Cc:     milko.leporis@imgtec.com, Ralf Baechle <ralf@linux-mips.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52666
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keescook@chromium.org
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

On Thu, Mar 17, 2016 at 2:26 AM, Matt Redfearn <matt.redfearn@imgtec.com> wrote:
> This adds self-test support on MIPS, based on RFC patch from Kees Cook.
> Modifications from the RFC:
> - support the O32 syscall which passes the real syscall number in a0.
> - Use PTRACE_{GET,SET}REGS
> - Because SYSCALL_NUM and SYSCALL_RET are the same register, it is not
>   possible to test modifying the syscall return value when skipping,
>   since both would need to set the same register. Therefore modify that
>   test case to just detect the skipped test.

I wonder how s390 deals with sharing the register? Seems like it
should be failing the same test in the same way.

> Tested on MIPS32r2 with an O32 userland where 48/48 tests now pass.
>
> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
> ---
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 30 +++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index b9453b838162..92862c828c4a 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -5,6 +5,7 @@
>   * Test code for seccomp bpf.
>   */
>
> +#include <sys/types.h>
>  #include <asm/siginfo.h>
>  #define __have_siginfo_t 1
>  #define __have_sigval_t 1
> @@ -14,7 +15,6 @@
>  #include <linux/filter.h>
>  #include <sys/prctl.h>
>  #include <sys/ptrace.h>
> -#include <sys/types.h>
>  #include <sys/user.h>
>  #include <linux/prctl.h>
>  #include <linux/ptrace.h>
> @@ -1242,6 +1242,12 @@ TEST_F(TRACE_poke, getpid_runs_normally)
>  # define ARCH_REGS     s390_regs
>  # define SYSCALL_NUM   gprs[2]
>  # define SYSCALL_RET   gprs[2]
> +#elif defined(__mips__)
> +# define ARCH_REGS     struct pt_regs
> +# define SYSCALL_NUM   regs[2]
> +# define SYSCALL_SYSCALL_NUM regs[4]
> +# define SYSCALL_RET   regs[2]
> +# define SYSCALL_NUM_RET_SHARE_REG
>  #else
>  # error "Do not know how to find your architecture's registers and syscalls"
>  #endif
> @@ -1249,7 +1255,7 @@ TEST_F(TRACE_poke, getpid_runs_normally)
>  /* Use PTRACE_GETREGS and PTRACE_SETREGS when available. This is useful for
>   * architectures without HAVE_ARCH_TRACEHOOK (e.g. User-mode Linux).
>   */
> -#if defined(__x86_64__) || defined(__i386__)
> +#if defined(__x86_64__) || defined(__i386__) || defined(__mips__)
>  #define HAVE_GETREGS
>  #endif
>
> @@ -1273,6 +1279,10 @@ int get_syscall(struct __test_metadata *_metadata, pid_t tracee)
>         }
>  #endif
>
> +#if defined(__mips__)
> +       if (regs.SYSCALL_NUM == __NR_syscall)
> +               return regs.SYSCALL_SYSCALL_NUM;
> +#endif
>         return regs.SYSCALL_NUM;
>  }
>
> @@ -1297,6 +1307,13 @@ void change_syscall(struct __test_metadata *_metadata,
>         {
>                 regs.SYSCALL_NUM = syscall;
>         }
> +#elif defined(__mips__)
> +       {
> +               if (regs.SYSCALL_NUM == __NR_syscall)
> +                       regs.SYSCALL_SYSCALL_NUM = syscall;
> +               else
> +                       regs.SYSCALL_NUM = syscall;
> +       }
>
>  #elif defined(__arm__)
>  # ifndef PTRACE_SET_SYSCALL
> @@ -1327,7 +1344,11 @@ void change_syscall(struct __test_metadata *_metadata,
>
>         /* If syscall is skipped, change return value. */
>         if (syscall == -1)
> +#ifdef SYSCALL_NUM_RET_SHARE_REG
> +               TH_LOG("Can't modify syscall return on this architecture");
> +#else
>                 regs.SYSCALL_RET = 1;
> +#endif
>
>  #ifdef HAVE_GETREGS
>         ret = ptrace(PTRACE_SETREGS, tracee, 0, &regs);
> @@ -1465,8 +1486,13 @@ TEST_F(TRACE_syscall, syscall_dropped)
>         ret = prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &self->prog, 0, 0);
>         ASSERT_EQ(0, ret);
>
> +#ifdef SYSCALL_NUM_RET_SHARE_REG
> +       /* gettid has been skipped */
> +       EXPECT_EQ(-1, syscall(__NR_gettid));
> +#else
>         /* gettid has been skipped and an altered return value stored. */
>         EXPECT_EQ(1, syscall(__NR_gettid));
> +#endif
>         EXPECT_NE(self->mytid, syscall(__NR_gettid));
>  }
>
> --
> 2.5.0
>

Acked-by: Kees Cook <keescook@chromium.org>

Thanks!

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
