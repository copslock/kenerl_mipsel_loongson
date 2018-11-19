Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Nov 2018 16:58:01 +0100 (CET)
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34286 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993144AbeKSP5uPaIKA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Nov 2018 16:57:50 +0100
Received: by mail-qk1-f196.google.com with SMTP id a132so49392557qkg.1;
        Mon, 19 Nov 2018 07:57:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gKVycHfx9VTyJfwD26xokE+/t85CmcDhT6zn9T7WMW8=;
        b=L1CbTZAsNbknI0yH8RfSbTXGimGfqLAer1ZW+587Qd9vK+TATwYFCTE+qPO3sWtnfL
         QYIUfYkNwe8dbX5kPfPYZ2Nd+H1MiijficRd6vO75TcZvj+JwwP/3Tg9i9QtD4igmMjL
         28LZ+8JdUXx9J4Q5yjIkFfT6oiO6UKihUu7RqdrcUSxD++HPUDPq22mON1mMdBNCYD5/
         FFSG12XqK5hzT+QrdV6c99LOe5fbHb7TOUBUhOL8h3/3zWNdTnqZ5QgzUDWhe5lq2ENx
         dC3Xth8UBGHNX80VqXTEP17A9SxWxNYfbaJhvmlMYVRBKdFjxTS5Uv/X/49chxiEmk/x
         cMDA==
X-Gm-Message-State: AGRZ1gLvRy0MePXP1XHScFLytd0wGVfy01t+gRBZ6+N4nDJpG66Erhbx
        h+eqqgqHNGux9YdsWj4uJOSmH0nQ9AVGtPdkzwY=
X-Google-Smtp-Source: AJdET5eeZflQQnKevaRUjecuFpzfTcHB0FNkGNZkkbT+jXVXZzZVyLGpoFMdqN5TaSsNg7YTeUFdHJ9gtynGYBjzZAQ=
X-Received: by 2002:ae9:d8c2:: with SMTP id u185mr19976776qkf.107.1542643069437;
 Mon, 19 Nov 2018 07:57:49 -0800 (PST)
MIME-Version: 1.0
References: <1542262461-29024-1-git-send-email-firoz.khan@linaro.org> <1542262461-29024-3-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1542262461-29024-3-git-send-email-firoz.khan@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 19 Nov 2018 16:57:32 +0100
Message-ID: <CAK8P3a2+W64=-pFaGyN27fdYOSpOrS7oRAzvZqaJUakB0aXtCg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] mips: add +1 to __NR_syscalls in uapi header
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        gregkh <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67354
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Thu, Nov 15, 2018 at 7:15 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>
> All other architectures are hold a value for __NR_syscalls will
> be equal to the last system call number +1.
>
> But in mips architecture, __NR_syscalls hold the value equal to
> total number of system exits in the architecture. One of the
> patch in this patch series will genarate uapi header files.
>
> In order to make the implementation common across all architect-
> ures, add +1 to __NR_syscalls, which will be equal to the last
> system call number +1.
>
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>

The patch looks correct to me, and is a nice cleanup, but I found a
couple of things remaining that could be done slightly better.

> diff --git a/arch/mips/include/asm/unistd.h b/arch/mips/include/asm/unistd.h
> index c68b8ae..16f21c3 100644
> --- a/arch/mips/include/asm/unistd.h
> +++ b/arch/mips/include/asm/unistd.h
> @@ -15,11 +15,11 @@
>  #include <uapi/asm/unistd.h>
>
>  #ifdef CONFIG_MIPS32_N32
> -#define NR_syscalls  (__NR_N32_Linux + __NR_N32_Linux_syscalls)
> +#define NR_syscalls  (__NR_N32_Linux + __NR_N32_Linux_syscalls - 1)
>  #elif defined(CONFIG_64BIT)
> -#define NR_syscalls  (__NR_64_Linux + __NR_64_Linux_syscalls)
> +#define NR_syscalls  (__NR_64_Linux + __NR_64_Linux_syscalls - 1)
>  #else
> -#define NR_syscalls  (__NR_O32_Linux + __NR_O32_Linux_syscalls)
> +#define NR_syscalls  (__NR_O32_Linux + __NR_O32_Linux_syscalls - 1)
>  #endif

I suppose these can simply get removed, there are no users of NR_syscalls
in MIPS kernels.

> diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
> index 7f3dfdb..add4301 100644
> --- a/arch/mips/kernel/ftrace.c
> +++ b/arch/mips/kernel/ftrace.c
> @@ -410,13 +410,13 @@ unsigned long __init arch_syscall_addr(int nr)
>  unsigned long __init arch_syscall_addr(int nr)
>  {
>  #ifdef CONFIG_MIPS32_N32
> -       if (nr >= __NR_N32_Linux && nr <= __NR_N32_Linux + __NR_N32_Linux_syscalls)
> +       if (nr >= __NR_N32_Linux && nr <= __NR_N32_Linux + __NR_N32_Linux_syscalls - 1)
>                 return (unsigned long)sysn32_call_table[nr - __NR_N32_Linux];
>  #endif
> -       if (nr >= __NR_64_Linux  && nr <= __NR_64_Linux + __NR_64_Linux_syscalls)
> +       if (nr >= __NR_64_Linux  && nr <= __NR_64_Linux + __NR_64_Linux_syscalls - 1)
>                 return (unsigned long)sys_call_table[nr - __NR_64_Linux];
>  #ifdef CONFIG_MIPS32_O32
> -       if (nr >= __NR_O32_Linux && nr <= __NR_O32_Linux + __NR_O32_Linux_syscalls)
> +       if (nr >= __NR_O32_Linux && nr <= __NR_O32_Linux + __NR_O32_Linux_syscalls - 1)
>                 return (unsigned long)sys32_call_table[nr - __NR_O32_Linux];
>  #endif

Here I would drop the '-1' and instead replace the '<=' with '<' for
better readability

> diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
> index 91d3c8c..a9b895f 100644
> --- a/arch/mips/kernel/scall32-o32.S
> +++ b/arch/mips/kernel/scall32-o32.S
> @@ -23,7 +23,7 @@
>  #include <asm/asm-offsets.h>
>
>  /* Highest syscall used of any syscall flavour */
> -#define MAX_SYSCALL_NO __NR_O32_Linux + __NR_O32_Linux_syscalls
> +#define MAX_SYSCALL_NO __NR_O32_Linux + __NR_O32_Linux_syscalls - 1

This is also unused as of commit 2957c9e61ee9 ("[MIPS] IRIX: Goodbye and
thanks for all the fish"), eight years ago, so I'd remove this as well.

I'd suggest doing one patch for the removal of the unused macros, and another
patch for the other changes.

       Arnd
