Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 13:52:07 +0200 (CEST)
Received: from mail-vn0-f49.google.com ([209.85.216.49]:33777 "EHLO
        mail-vn0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006150AbbDDLwF2R6Up (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 13:52:05 +0200
Received: by vnbf1 with SMTP id f1so214884vnb.0
        for <linux-mips@linux-mips.org>; Sat, 04 Apr 2015 04:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=LkV8HBiGLXbcTdpAR+C7sBIpSnqE7eb7P9J1YfDDKjs=;
        b=QAzDEgjXL/yKWrnebb1mctCcdt/KPhxWIFdLcfIgkdNqo+5HKhhJV31LIY++124UCA
         F8HRgSOtZymGJXk8qCZQkmihUb8VlcEOxwRPvc966FNRpd8RJ9wOQdDYiqG4N3o9g58R
         S6O5l+5MXGug0TQxEqVSsjsJpdjPqoRdB+VVkrN3n8EIsHyw3lSVZZ4sO/8PIxX0inX0
         hT90RrZ6FDvHSQq58b0yU9RdjWiIK2cEijqGqsG4LeDITeLpVjfqxdBqv2tTDBFkA+Hh
         5xw1v9wwXxiOfVBEpJrRDUrCA5AM9XcmU4+dli3ayClD4YCOA1zxF808H1vJYzqiJtqt
         ZpuQ==
MIME-Version: 1.0
X-Received: by 10.52.110.226 with SMTP id id2mr3725036vdb.23.1428148320623;
 Sat, 04 Apr 2015 04:52:00 -0700 (PDT)
Received: by 10.52.170.225 with HTTP; Sat, 4 Apr 2015 04:52:00 -0700 (PDT)
In-Reply-To: <1428146533-2208-1-git-send-email-yury.norov@gmail.com>
References: <1428146533-2208-1-git-send-email-yury.norov@gmail.com>
Date:   Sat, 4 Apr 2015 13:52:00 +0200
Message-ID: <CAFLxGvxXY0Y3m0eL913VppobgRp-1AG8AzrAzJ54jwk=WcK_MQ@mail.gmail.com>
Subject: Re: [PATCH] signal: optimize 'sigaction' call path
From:   Richard Weinberger <richard.weinberger@gmail.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     rth@twiddle.net, ink@jurassic.park.msu.ru,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>, klimov.linux@gmail.com,
        LKML <linux-kernel@vger.kernel.org>, linux-alpha@vger.kernel.org,
        linux-mips@linux-mips.org, sparclinux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <richard.weinberger@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46776
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: richard.weinberger@gmail.com
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

On Sat, Apr 4, 2015 at 1:22 PM, Yury Norov <yury.norov@gmail.com> wrote:
> There is a set of syscalls in the kernel about 'sigaction'.
> All they end up with calling the helper 'do_sigaction',
> so the generic scheme is:
>
> - copy user data to kernel;
> - 'do_sigaction';
> - copy kernel data to user.
>
> 'do_sigaction' checks 'signum' parameter before doing its main job.
> If this check fails syscall fails immediately, as well. But at this
> stage first copy is already done. And so there's a potential chance
> having it useless. It may affect performance significantly if user
> data was, say, swapped, and a fault was handled to obtain it.
>
> In this patch, 'signum' sanity check is moved out of 'do_sigaction'
> to a small function 'user_signal'. So we can call it before any copying.

Do you have benchmark results that show the performance impact of that change?
Moving the checks out of do_sigaction() and spreading them all over the kernel
is not nice and needs a good justification.
Having the checks at a central point is much clearer.

> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  arch/alpha/kernel/signal.c       | 19 +++++++-------
>  arch/mips/kernel/signal.c        | 10 +++++---
>  arch/mips/kernel/signal32.c      | 10 +++++---
>  arch/sparc/kernel/sys_sparc32.c  | 10 ++++----
>  arch/sparc/kernel/sys_sparc_32.c | 10 ++++----
>  arch/sparc/kernel/sys_sparc_64.c | 10 ++++----
>  include/linux/sched.h            |  2 +-
>  include/linux/signal.h           |  5 ++++
>  kernel/signal.c                  | 54 +++++++++++++++++++++-------------------
>  9 files changed, 71 insertions(+), 59 deletions(-)

You add more lines than you delete, please post some hard facts why
it is worth the hassle. :-)

> diff --git a/arch/alpha/kernel/signal.c b/arch/alpha/kernel/signal.c
> index 8dbfb15..5a5db6f 100644
> --- a/arch/alpha/kernel/signal.c
> +++ b/arch/alpha/kernel/signal.c
> @@ -59,7 +59,9 @@ SYSCALL_DEFINE3(osf_sigaction, int, sig,
>                 struct osf_sigaction __user *, oact)
>  {
>         struct k_sigaction new_ka, old_ka;
> -       int ret;
> +
> +       if (!user_signal(sig))
> +               return -EINVAL;
>
>         if (act) {
>                 old_sigset_t mask;
> @@ -72,9 +74,9 @@ SYSCALL_DEFINE3(osf_sigaction, int, sig,
>                 new_ka.ka_restorer = NULL;
>         }
>
> -       ret = do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
> +       do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
>
> -       if (!ret && oact) {
> +       if (oact) {
>                 if (!access_ok(VERIFY_WRITE, oact, sizeof(*oact)) ||
>                     __put_user(old_ka.sa.sa_handler, &oact->sa_handler) ||
>                     __put_user(old_ka.sa.sa_flags, &oact->sa_flags) ||
> @@ -82,7 +84,7 @@ SYSCALL_DEFINE3(osf_sigaction, int, sig,
>                         return -EFAULT;
>         }
>
> -       return ret;
> +       return 0;
>  }
>
>  SYSCALL_DEFINE5(rt_sigaction, int, sig, const struct sigaction __user *, act,
> @@ -90,10 +92,9 @@ SYSCALL_DEFINE5(rt_sigaction, int, sig, const struct sigaction __user *, act,
>                 size_t, sigsetsize, void __user *, restorer)
>  {
>         struct k_sigaction new_ka, old_ka;
> -       int ret;
>
>         /* XXX: Don't preclude handling different sized sigset_t's.  */
> -       if (sigsetsize != sizeof(sigset_t))
> +       if (sigsetsize != sizeof(sigset_t) || !user_signal(sig))
>                 return -EINVAL;
>
>         if (act) {
> @@ -102,14 +103,14 @@ SYSCALL_DEFINE5(rt_sigaction, int, sig, const struct sigaction __user *, act,
>                         return -EFAULT;
>         }
>
> -       ret = do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
> +       do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
>
> -       if (!ret && oact) {
> +       if (oact) {
>                 if (copy_to_user(oact, &old_ka.sa, sizeof(*oact)))
>                         return -EFAULT;
>         }
>
> -       return ret;
> +       return 0;
>  }
>
>  /*
> diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
> index 6a28c79..461a54f 100644
> --- a/arch/mips/kernel/signal.c
> +++ b/arch/mips/kernel/signal.c
> @@ -316,9 +316,11 @@ SYSCALL_DEFINE3(sigaction, int, sig, const struct sigaction __user *, act,
>         struct sigaction __user *, oact)
>  {
>         struct k_sigaction new_ka, old_ka;
> -       int ret;
>         int err = 0;
>
> +       if (!user_signal(sig))
> +               return -EINVAL;
> +
>         if (act) {
>                 old_sigset_t mask;
>
> @@ -333,9 +335,9 @@ SYSCALL_DEFINE3(sigaction, int, sig, const struct sigaction __user *, act,
>                 siginitset(&new_ka.sa.sa_mask, mask);
>         }
>
> -       ret = do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
> +       do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
>
> -       if (!ret && oact) {
> +       if (oact) {
>                 if (!access_ok(VERIFY_WRITE, oact, sizeof(*oact)))
>                         return -EFAULT;
>                 err |= __put_user(old_ka.sa.sa_flags, &oact->sa_flags);
> @@ -348,7 +350,7 @@ SYSCALL_DEFINE3(sigaction, int, sig, const struct sigaction __user *, act,
>                         return -EFAULT;
>         }
>
> -       return ret;
> +       return 0;
>  }
>  #endif
>
> diff --git a/arch/mips/kernel/signal32.c b/arch/mips/kernel/signal32.c
> index 19a7705..7850b02 100644
> --- a/arch/mips/kernel/signal32.c
> +++ b/arch/mips/kernel/signal32.c
> @@ -317,9 +317,11 @@ SYSCALL_DEFINE3(32_sigaction, long, sig, const struct compat_sigaction __user *,
>         struct compat_sigaction __user *, oact)
>  {
>         struct k_sigaction new_ka, old_ka;
> -       int ret;
>         int err = 0;
>
> +       if (!user_signal(sig))
> +               return -EINVAL;
> +
>         if (act) {
>                 old_sigset_t mask;
>                 s32 handler;
> @@ -336,9 +338,9 @@ SYSCALL_DEFINE3(32_sigaction, long, sig, const struct compat_sigaction __user *,
>                 siginitset(&new_ka.sa.sa_mask, mask);
>         }
>
> -       ret = do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
> +       do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
>
> -       if (!ret && oact) {
> +       if (oact) {
>                 if (!access_ok(VERIFY_WRITE, oact, sizeof(*oact)))
>                         return -EFAULT;
>                 err |= __put_user(old_ka.sa.sa_flags, &oact->sa_flags);
> @@ -352,7 +354,7 @@ SYSCALL_DEFINE3(32_sigaction, long, sig, const struct compat_sigaction __user *,
>                         return -EFAULT;
>         }
>
> -       return ret;
> +       return 0;
>  }
>
>  int copy_siginfo_to_user32(compat_siginfo_t __user *to, const siginfo_t *from)
> diff --git a/arch/sparc/kernel/sys_sparc32.c b/arch/sparc/kernel/sys_sparc32.c
> index 022c30c..5c83f7b 100644
> --- a/arch/sparc/kernel/sys_sparc32.c
> +++ b/arch/sparc/kernel/sys_sparc32.c
> @@ -162,7 +162,7 @@ COMPAT_SYSCALL_DEFINE5(rt_sigaction, int, sig,
>         compat_sigset_t set32;
>
>          /* XXX: Don't preclude handling different sized sigset_t's.  */
> -        if (sigsetsize != sizeof(compat_sigset_t))
> +       if (sigsetsize != sizeof(compat_sigset_t) || !user_signal(sig))
>                  return -EINVAL;
>
>          if (act) {
> @@ -180,19 +180,19 @@ COMPAT_SYSCALL_DEFINE5(rt_sigaction, int, sig,
>                         return -EFAULT;
>         }
>
> -       ret = do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
> +       do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
>
> -       if (!ret && oact) {
> +       if (oact) {
>                 sigset_to_compat(&set32, &old_ka.sa.sa_mask);
>                 ret = put_user(ptr_to_compat(old_ka.sa.sa_handler), &oact->sa_handler);
>                 ret |= copy_to_user(&oact->sa_mask, &set32, sizeof(compat_sigset_t));
>                 ret |= put_user(old_ka.sa.sa_flags, &oact->sa_flags);
>                 ret |= put_user(ptr_to_compat(old_ka.sa.sa_restorer), &oact->sa_restorer);
>                 if (ret)
> -                       ret = -EFAULT;
> +                       return -EFAULT;
>          }
>
> -        return ret;
> +       return 0;
>  }
>
>  asmlinkage compat_ssize_t sys32_pread64(unsigned int fd,
> diff --git a/arch/sparc/kernel/sys_sparc_32.c b/arch/sparc/kernel/sys_sparc_32.c
> index 646988d..ee5b598 100644
> --- a/arch/sparc/kernel/sys_sparc_32.c
> +++ b/arch/sparc/kernel/sys_sparc_32.c
> @@ -20,6 +20,7 @@
>  #include <linux/utsname.h>
>  #include <linux/smp.h>
>  #include <linux/ipc.h>
> +#include <linux/signal.h>
>
>  #include <asm/uaccess.h>
>  #include <asm/unistd.h>
> @@ -177,10 +178,9 @@ SYSCALL_DEFINE5(rt_sigaction, int, sig,
>                  size_t, sigsetsize)
>  {
>         struct k_sigaction new_ka, old_ka;
> -       int ret;
>
>         /* XXX: Don't preclude handling different sized sigset_t's.  */
> -       if (sigsetsize != sizeof(sigset_t))
> +       if (sigsetsize != sizeof(sigset_t) || !user_signal(sig))
>                 return -EINVAL;
>
>         if (act) {
> @@ -189,14 +189,14 @@ SYSCALL_DEFINE5(rt_sigaction, int, sig,
>                         return -EFAULT;
>         }
>
> -       ret = do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
> +       do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
>
> -       if (!ret && oact) {
> +       if (oact) {
>                 if (copy_to_user(oact, &old_ka.sa, sizeof(*oact)))
>                         return -EFAULT;
>         }
>
> -       return ret;
> +       return 0;
>  }
>
>  asmlinkage long sys_getdomainname(char __user *name, int len)
> diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
> index c85403d..b22a753 100644
> --- a/arch/sparc/kernel/sys_sparc_64.c
> +++ b/arch/sparc/kernel/sys_sparc_64.c
> @@ -25,6 +25,7 @@
>  #include <linux/random.h>
>  #include <linux/export.h>
>  #include <linux/context_tracking.h>
> +#include <linux/signal.h>
>
>  #include <asm/uaccess.h>
>  #include <asm/utrap.h>
> @@ -619,10 +620,9 @@ SYSCALL_DEFINE5(rt_sigaction, int, sig, const struct sigaction __user *, act,
>                 size_t, sigsetsize)
>  {
>         struct k_sigaction new_ka, old_ka;
> -       int ret;
>
>         /* XXX: Don't preclude handling different sized sigset_t's.  */
> -       if (sigsetsize != sizeof(sigset_t))
> +       if (sigsetsize != sizeof(sigset_t) || !user_signal(sig))
>                 return -EINVAL;
>
>         if (act) {
> @@ -631,14 +631,14 @@ SYSCALL_DEFINE5(rt_sigaction, int, sig, const struct sigaction __user *, act,
>                         return -EFAULT;
>         }
>
> -       ret = do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
> +       do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
>
> -       if (!ret && oact) {
> +       if (oact) {
>                 if (copy_to_user(oact, &old_ka.sa, sizeof(*oact)))
>                         return -EFAULT;
>         }
>
> -       return ret;
> +       return 0;
>  }
>
>  asmlinkage long sys_kern_features(void)
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 6d77432..4643b7d 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -2394,7 +2394,7 @@ extern int zap_other_threads(struct task_struct *p);
>  extern struct sigqueue *sigqueue_alloc(void);
>  extern void sigqueue_free(struct sigqueue *);
>  extern int send_sigqueue(struct sigqueue *,  struct task_struct *, int group);
> -extern int do_sigaction(int, struct k_sigaction *, struct k_sigaction *);
> +extern void do_sigaction(int, struct k_sigaction *, struct k_sigaction *);
>
>  static inline void restore_saved_sigmask(void)
>  {
> diff --git a/include/linux/signal.h b/include/linux/signal.h
> index ab1e039..129e975 100644
> --- a/include/linux/signal.h
> +++ b/include/linux/signal.h
> @@ -437,6 +437,11 @@ int __save_altstack(stack_t __user *, unsigned long);
>         put_user_ex(t->sas_ss_size, &__uss->ss_size); \
>  } while (0);
>
> +static inline int user_signal(unsigned long sig)
> +{
> +       return sig && valid_signal(sig) && !sig_kernel_only(sig);
> +}
> +
>  #ifdef CONFIG_PROC_FS
>  struct seq_file;
>  extern void render_sigset_t(struct seq_file *, const char *, sigset_t *);
> diff --git a/kernel/signal.c b/kernel/signal.c
> index a390499..5537435 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -3099,15 +3099,12 @@ void kernel_sigaction(int sig, __sighandler_t action)
>  }
>  EXPORT_SYMBOL(kernel_sigaction);
>
> -int do_sigaction(int sig, struct k_sigaction *act, struct k_sigaction *oact)
> +void do_sigaction(int sig, struct k_sigaction *act, struct k_sigaction *oact)
>  {
>         struct task_struct *p = current, *t;
>         struct k_sigaction *k;
>         sigset_t mask;
>
> -       if (!valid_signal(sig) || sig < 1 || (act && sig_kernel_only(sig)))
> -               return -EINVAL;
> -
>         k = &p->sighand->action[sig-1];
>
>         spin_lock_irq(&p->sighand->siglock);
> @@ -3139,8 +3136,8 @@ int do_sigaction(int sig, struct k_sigaction *act, struct k_sigaction *oact)
>         }
>
>         spin_unlock_irq(&p->sighand->siglock);
> -       return 0;
>  }
> +EXPORT_SYMBOL(do_sigaction);
>
>  static int
>  do_sigaltstack (const stack_t __user *uss, stack_t __user *uoss, unsigned long sp)
> @@ -3356,25 +3353,24 @@ SYSCALL_DEFINE4(rt_sigaction, int, sig,
>                 size_t, sigsetsize)
>  {
>         struct k_sigaction new_sa, old_sa;
> -       int ret = -EINVAL;
>
>         /* XXX: Don't preclude handling different sized sigset_t's.  */
> -       if (sigsetsize != sizeof(sigset_t))
> -               goto out;
> +       if (sigsetsize != sizeof(sigset_t) || !user_signal(sig))
> +               return -EINVAL;
>
>         if (act) {
>                 if (copy_from_user(&new_sa.sa, act, sizeof(new_sa.sa)))
>                         return -EFAULT;
>         }
>
> -       ret = do_sigaction(sig, act ? &new_sa : NULL, oact ? &old_sa : NULL);
> +       do_sigaction(sig, act ? &new_sa : NULL, oact ? &old_sa : NULL);
>
> -       if (!ret && oact) {
> +       if (!oact) {
>                 if (copy_to_user(oact, &old_sa.sa, sizeof(old_sa.sa)))
>                         return -EFAULT;
>         }
> -out:
> -       return ret;
> +
> +       return 0;
>  }
>  #ifdef CONFIG_COMPAT
>  COMPAT_SYSCALL_DEFINE4(rt_sigaction, int, sig,
> @@ -3390,7 +3386,7 @@ COMPAT_SYSCALL_DEFINE4(rt_sigaction, int, sig,
>         int ret;
>
>         /* XXX: Don't preclude handling different sized sigset_t's.  */
> -       if (sigsetsize != sizeof(compat_sigset_t))
> +       if (sigsetsize != sizeof(compat_sigset_t) || !user_signal(sig))
>                 return -EINVAL;
>
>         if (act) {
> @@ -3408,8 +3404,8 @@ COMPAT_SYSCALL_DEFINE4(rt_sigaction, int, sig,
>                 sigset_from_compat(&new_ka.sa.sa_mask, &mask);
>         }
>
> -       ret = do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
> -       if (!ret && oact) {
> +       do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
> +       if (oact) {
>                 sigset_to_compat(&mask, &old_ka.sa.sa_mask);
>                 ret = put_user(ptr_to_compat(old_ka.sa.sa_handler),
>                                &oact->sa_handler);
> @@ -3431,7 +3427,9 @@ SYSCALL_DEFINE3(sigaction, int, sig,
>                 struct old_sigaction __user *, oact)
>  {
>         struct k_sigaction new_ka, old_ka;
> -       int ret;
> +
> +       if (!user_signal(sig))
> +               return -EINVAL;
>
>         if (act) {
>                 old_sigset_t mask;
> @@ -3447,9 +3445,9 @@ SYSCALL_DEFINE3(sigaction, int, sig,
>                 siginitset(&new_ka.sa.sa_mask, mask);
>         }
>
> -       ret = do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
> +       do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
>
> -       if (!ret && oact) {
> +       if (oact) {
>                 if (!access_ok(VERIFY_WRITE, oact, sizeof(*oact)) ||
>                     __put_user(old_ka.sa.sa_handler, &oact->sa_handler) ||
>                     __put_user(old_ka.sa.sa_restorer, &oact->sa_restorer) ||
> @@ -3458,7 +3456,7 @@ SYSCALL_DEFINE3(sigaction, int, sig,
>                         return -EFAULT;
>         }
>
> -       return ret;
> +       return 0;
>  }
>  #endif
>  #ifdef CONFIG_COMPAT_OLD_SIGACTION
> @@ -3467,10 +3465,12 @@ COMPAT_SYSCALL_DEFINE3(sigaction, int, sig,
>                 struct compat_old_sigaction __user *, oact)
>  {
>         struct k_sigaction new_ka, old_ka;
> -       int ret;
>         compat_old_sigset_t mask;
>         compat_uptr_t handler, restorer;
>
> +       if (!user_signal(sig))
> +               return -EINVAL;
> +
>         if (act) {
>                 if (!access_ok(VERIFY_READ, act, sizeof(*act)) ||
>                     __get_user(handler, &act->sa_handler) ||
> @@ -3487,9 +3487,9 @@ COMPAT_SYSCALL_DEFINE3(sigaction, int, sig,
>                 siginitset(&new_ka.sa.sa_mask, mask);
>         }
>
> -       ret = do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
> +        do_sigaction(sig, act ? &new_ka : NULL, oact ? &old_ka : NULL);
>
> -       if (!ret && oact) {
> +       if (oact) {
>                 if (!access_ok(VERIFY_WRITE, oact, sizeof(*oact)) ||
>                     __put_user(ptr_to_compat(old_ka.sa.sa_handler),
>                                &oact->sa_handler) ||
> @@ -3499,7 +3499,7 @@ COMPAT_SYSCALL_DEFINE3(sigaction, int, sig,
>                     __put_user(old_ka.sa.sa_mask.sig[0], &oact->sa_mask))
>                         return -EFAULT;
>         }
> -       return ret;
> +       return 0;
>  }
>  #endif
>
> @@ -3533,15 +3533,17 @@ SYSCALL_DEFINE1(ssetmask, int, newmask)
>  SYSCALL_DEFINE2(signal, int, sig, __sighandler_t, handler)
>  {
>         struct k_sigaction new_sa, old_sa;
> -       int ret;
> +
> +       if (!user_signal(sig))
> +               return -EINVAL;
>
>         new_sa.sa.sa_handler = handler;
>         new_sa.sa.sa_flags = SA_ONESHOT | SA_NOMASK;
>         sigemptyset(&new_sa.sa.sa_mask);
>
> -       ret = do_sigaction(sig, &new_sa, &old_sa);
> +       do_sigaction(sig, &new_sa, &old_sa);
>
> -       return ret ? ret : (unsigned long)old_sa.sa.sa_handler;
> +       return (unsigned long) old_sa.sa.sa_handler;
>  }
>  #endif /* __ARCH_WANT_SYS_SIGNAL */
>
> --
> 2.1.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



-- 
Thanks,
//richard
