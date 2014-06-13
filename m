Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jun 2014 23:22:17 +0200 (CEST)
Received: from mail-wg0-f49.google.com ([74.125.82.49]:64533 "EHLO
        mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817115AbaFMVWOd8DkA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Jun 2014 23:22:14 +0200
Received: by mail-wg0-f49.google.com with SMTP id y10so3210119wgg.8
        for <linux-mips@linux-mips.org>; Fri, 13 Jun 2014 14:22:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=HRMsXeW/IkZswcNUsqbpB6MndPCKgxCR0H1ZjtZDXtc=;
        b=kUj2BuyhVHlAo4wPIHrfRoQeTAYp8dKPyBxYkFE39LgKl3iBUUwdWmDSzjHZ7GSK9Q
         MVqnFDsd3us9GuOg0tyd46ALxgtm6fMHn5XiY9FAo4AfMlNS/lssFAgxlZ9G2mH8TECn
         UWUx2J5LaI0YuEEDBdxWzNH15Sb4qjRB5EDXTNHmwon+iFqYXZUxTiV1/izm4TXyT3nj
         PMeevV2BJlmBUr9FTWDEaZGGKcFwBao4YeJiT0v2nI9q5SySEjP+MDwFmM011YxYqVUe
         0soz96O4M+rCCqejpENLOxDRfOU4Tp4GqNfSJrtPVFZ9P+4iZkTvtEJZgg5Luz0YNxL9
         L4hg==
X-Gm-Message-State: ALoCoQn3BrmtWJQFy4J8BDmpIw1ALb/qV+yYGhbp2vA/vQJZMd0x6DCP+7XRsX+0AqFbK8sMIQo6
MIME-Version: 1.0
X-Received: by 10.194.57.208 with SMTP id k16mr7702949wjq.51.1402694528984;
 Fri, 13 Jun 2014 14:22:08 -0700 (PDT)
Received: by 10.194.121.228 with HTTP; Fri, 13 Jun 2014 14:22:08 -0700 (PDT)
In-Reply-To: <1402457121-8410-7-git-send-email-keescook@chromium.org>
References: <1402457121-8410-1-git-send-email-keescook@chromium.org>
        <1402457121-8410-7-git-send-email-keescook@chromium.org>
Date:   Fri, 13 Jun 2014 14:22:08 -0700
Message-ID: <CAMEtUuwKRUYN_qdnCj42G3Z1UT3vMYPoJqXd2_PjV+_J3WA+8w@mail.gmail.com>
Subject: Re: [PATCH v6 6/9] seccomp: add "seccomp" syscall
From:   Alexei Starovoitov <ast@plumgrid.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        Will Drewry <wad@chromium.org>,
        Julien Tinnes <jln@chromium.org>,
        David Drysdale <drysdale@google.com>,
        John Johansen <john.johansen@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <ast@plumgrid.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40516
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

On Tue, Jun 10, 2014 at 8:25 PM, Kees Cook <keescook@chromium.org> wrote:
> This adds the new "seccomp" syscall with both an "operation" and "flags"
> parameter for future expansion. The third argument is a pointer value,
> used with the SECCOMP_SET_MODE_FILTER operation. Currently, flags must
> be 0. This is functionally equivalent to prctl(PR_SET_SECCOMP, ...).
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Cc: linux-api@vger.kernel.org
> ---
>  arch/x86/syscalls/syscall_32.tbl  |    1 +
>  arch/x86/syscalls/syscall_64.tbl  |    1 +
>  include/linux/syscalls.h          |    2 ++
>  include/uapi/asm-generic/unistd.h |    4 ++-
>  include/uapi/linux/seccomp.h      |    4 +++
>  kernel/seccomp.c                  |   63 ++++++++++++++++++++++++++++++++-----
>  kernel/sys_ni.c                   |    3 ++
>  7 files changed, 69 insertions(+), 9 deletions(-)
>
> diff --git a/arch/x86/syscalls/syscall_32.tbl b/arch/x86/syscalls/syscall_32.tbl
> index d6b867921612..7527eac24122 100644
> --- a/arch/x86/syscalls/syscall_32.tbl
> +++ b/arch/x86/syscalls/syscall_32.tbl
> @@ -360,3 +360,4 @@
>  351    i386    sched_setattr           sys_sched_setattr
>  352    i386    sched_getattr           sys_sched_getattr
>  353    i386    renameat2               sys_renameat2
> +354    i386    seccomp                 sys_seccomp
> diff --git a/arch/x86/syscalls/syscall_64.tbl b/arch/x86/syscalls/syscall_64.tbl
> index ec255a1646d2..16272a6c12b7 100644
> --- a/arch/x86/syscalls/syscall_64.tbl
> +++ b/arch/x86/syscalls/syscall_64.tbl
> @@ -323,6 +323,7 @@
>  314    common  sched_setattr           sys_sched_setattr
>  315    common  sched_getattr           sys_sched_getattr
>  316    common  renameat2               sys_renameat2
> +317    common  seccomp                 sys_seccomp
>
>  #
>  # x32-specific system call numbers start at 512 to avoid cache impact
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index b0881a0ed322..1713977ee26f 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -866,4 +866,6 @@ asmlinkage long sys_process_vm_writev(pid_t pid,
>  asmlinkage long sys_kcmp(pid_t pid1, pid_t pid2, int type,
>                          unsigned long idx1, unsigned long idx2);
>  asmlinkage long sys_finit_module(int fd, const char __user *uargs, int flags);
> +asmlinkage long sys_seccomp(unsigned int op, unsigned int flags,
> +                           const char __user *uargs);

It looks odd to add 'flags' argument to syscall that is not even used.
It don't think it will be extensible this way.
'uargs' is used only in 2nd command as well and it's not 'char __user *'
but rather 'struct sock_fprog __user *'
I think it makes more sense to define only first argument as 'int op' and the
rest as variable length array.
Something like:
long sys_seccomp(unsigned int op, struct nlattr *attrs, int len);
then different commands can interpret 'attrs' differently.
if op == mode_strict, then attrs == NULL, len == 0
if op == mode_filter, then attrs->nla_type == seccomp_bpf_filter
and nla_data(attrs) is 'struct sock_fprog'
If we decide to add new types of filters or new commands, the syscall prototype
won't need to change. New commands can be added preserving backward
compatibility.
The basic TLV concept has been around forever in netlink world. imo makes
sense to use it with new syscalls. Passing 'struct xxx' into syscalls
is the thing
of the past. TLV style is more extensible. Fields of structures can become
optional in the future, new fields added, etc.
'struct nlattr' brings the same benefits to kernel api as protobuf did
to user land.

>  #endif
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index 333640608087..65acbf0e2867 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -699,9 +699,11 @@ __SYSCALL(__NR_sched_setattr, sys_sched_setattr)
>  __SYSCALL(__NR_sched_getattr, sys_sched_getattr)
>  #define __NR_renameat2 276
>  __SYSCALL(__NR_renameat2, sys_renameat2)
> +#define __NR_seccomp 277
> +__SYSCALL(__NR_seccomp, sys_seccomp)
>
>  #undef __NR_syscalls
> -#define __NR_syscalls 277
> +#define __NR_syscalls 278
>
>  /*
>   * All syscalls below here should go away really,
> diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
> index ac2dc9f72973..b258878ba754 100644
> --- a/include/uapi/linux/seccomp.h
> +++ b/include/uapi/linux/seccomp.h
> @@ -10,6 +10,10 @@
>  #define SECCOMP_MODE_STRICT    1 /* uses hard-coded filter. */
>  #define SECCOMP_MODE_FILTER    2 /* uses user-supplied filter. */
>
> +/* Valid operations for seccomp syscall. */
> +#define SECCOMP_SET_MODE_STRICT        0
> +#define SECCOMP_SET_MODE_FILTER        1
> +
>  /*
>   * All BPF programs must return a 32-bit value.
>   * The bottom 16-bits are for optional return data.
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 39d32c2904fc..c0cafa9e84af 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -19,6 +19,7 @@
>  #include <linux/sched.h>
>  #include <linux/seccomp.h>
>  #include <linux/slab.h>
> +#include <linux/syscalls.h>
>
>  /* #define SECCOMP_DEBUG 1 */
>
> @@ -301,8 +302,8 @@ free_prog:
>   *
>   * Returns filter on success and ERR_PTR otherwise.
>   */
> -static
> -struct seccomp_filter *seccomp_prepare_user_filter(char __user *user_filter)
> +static struct seccomp_filter *
> +seccomp_prepare_user_filter(const char __user *user_filter)
>  {
>         struct sock_fprog fprog;
>         struct seccomp_filter *filter = ERR_PTR(-EFAULT);
> @@ -325,19 +326,25 @@ out:
>
>  /**
>   * seccomp_attach_filter: validate and attach filter
> + * @flags:  flags to change filter behavior
>   * @filter: seccomp filter to add to the current process
>   *
>   * Caller must be holding current->sighand->siglock lock.
>   *
>   * Returns 0 on success, -ve on error.
>   */
> -static long seccomp_attach_filter(struct seccomp_filter *filter)
> +static long seccomp_attach_filter(unsigned int flags,
> +                                 struct seccomp_filter *filter)
>  {
>         unsigned long total_insns;
>         struct seccomp_filter *walker;
>
>         BUG_ON(!spin_is_locked(&current->sighand->siglock));
>
> +       /* Validate flags. */
> +       if (flags != 0)
> +               return -EINVAL;
> +
>         /* Validate resulting filter length. */
>         total_insns = filter->len;
>         for (walker = current->seccomp.filter; walker; walker = filter->prev)
> @@ -541,6 +548,7 @@ out:
>  #ifdef CONFIG_SECCOMP_FILTER
>  /**
>   * seccomp_set_mode_filter: internal function for setting seccomp filter
> + * @flags:  flags to change filter behavior
>   * @filter: struct sock_fprog containing filter
>   *
>   * This function may be called repeatedly to install additional filters.
> @@ -551,7 +559,8 @@ out:
>   *
>   * Returns 0 on success or -EINVAL on failure.
>   */
> -static long seccomp_set_mode_filter(char __user *filter)
> +static long seccomp_set_mode_filter(unsigned int flags,
> +                                   const char __user *filter)
>  {
>         const unsigned long seccomp_mode = SECCOMP_MODE_FILTER;
>         struct seccomp_filter *prepared = NULL;
> @@ -569,7 +578,7 @@ static long seccomp_set_mode_filter(char __user *filter)
>         if (!seccomp_check_mode(current, seccomp_mode))
>                 goto out;
>
> -       ret = seccomp_attach_filter(prepared);
> +       ret = seccomp_attach_filter(flags, prepared);
>         if (ret)
>                 goto out;
>         /* Do not free the successfully attached filter. */
> @@ -583,12 +592,35 @@ out_free:
>         return ret;
>  }
>  #else
> -static inline long seccomp_set_mode_filter(char __user *filter)
> +static inline long seccomp_set_mode_filter(unsigned int flags,
> +                                          const char __user *filter)
>  {
>         return -EINVAL;
>  }
>  #endif
>
> +/* Common entry point for both prctl and syscall. */
> +static long do_seccomp(unsigned int op, unsigned int flags,
> +                      const char __user *uargs)
> +{
> +       switch (op) {
> +       case SECCOMP_SET_MODE_STRICT:
> +               if (flags != 0 || uargs != NULL)
> +                       return -EINVAL;
> +               return seccomp_set_mode_strict();
> +       case SECCOMP_SET_MODE_FILTER:
> +               return seccomp_set_mode_filter(flags, uargs);
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
> +SYSCALL_DEFINE3(seccomp, unsigned int, op, unsigned int, flags,
> +                        const char __user *, uargs)
> +{
> +       return do_seccomp(op, flags, uargs);
> +}
> +
>  /**
>   * prctl_set_seccomp: configures current->seccomp.mode
>   * @seccomp_mode: requested mode to use
> @@ -598,12 +630,27 @@ static inline long seccomp_set_mode_filter(char __user *filter)
>   */
>  long prctl_set_seccomp(unsigned long seccomp_mode, char __user *filter)
>  {
> +       unsigned int op;
> +       char __user *uargs;
> +
>         switch (seccomp_mode) {
>         case SECCOMP_MODE_STRICT:
> -               return seccomp_set_mode_strict();
> +               op = SECCOMP_SET_MODE_STRICT;
> +               /*
> +                * Setting strict mode through prctl always ignored filter,
> +                * so make sure it is always NULL here to pass the internal
> +                * check in do_seccomp().
> +                */
> +               uargs = NULL;
> +               break;
>         case SECCOMP_MODE_FILTER:
> -               return seccomp_set_mode_filter(filter);
> +               op = SECCOMP_SET_MODE_FILTER;
> +               uargs = filter;
> +               break;
>         default:
>                 return -EINVAL;
>         }
> +
> +       /* prctl interface doesn't have flags, so they are always zero. */
> +       return do_seccomp(op, 0, uargs);
>  }
> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> index 36441b51b5df..2904a2105914 100644
> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -213,3 +213,6 @@ cond_syscall(compat_sys_open_by_handle_at);
>
>  /* compare kernel pointers */
>  cond_syscall(sys_kcmp);
> +
> +/* operate on Secure Computing state */
> +cond_syscall(sys_seccomp);
> --
> 1.7.9.5
>
