Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Aug 2018 10:00:55 +0200 (CEST)
Received: from mail-qt0-x243.google.com ([IPv6:2607:f8b0:400d:c0d::243]:45953
        "EHLO mail-qt0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990398AbeHKIAvf-H6f (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 11 Aug 2018 10:00:51 +0200
Received: by mail-qt0-x243.google.com with SMTP id y5-v6so12667357qti.12;
        Sat, 11 Aug 2018 01:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Sv0P22Iv02OrqwVXx+cIPzWSnuWnVlAhCTSZIIH/v30=;
        b=anIOopKC7wTPGRnsliOyyaQgepTUqTwB3VIbiZ9XiiVR5bRXGhzWgmuFIKvbHtBXYg
         F8Yj7FAfWfVwlTzF8yJO1ZZv8B8NVoTE0EqcoIuB03YtTEuvwkNn/wi/BdQUDaPf8Aeb
         e3AuVhPOIV4t8Jc9muSyKjaCc444wEkLz7EGTEtNCadKi7jep15YYeq92Qhq8pVd9BFn
         rgvtpXt0fJzuICiMyuV0DL1VPTE8yUoxSG0GdN0QlKc1u1q+fabWU77OfWPDD/TDlSKb
         S3j+p5sByzUOAAL2akh7ATJQ+ILj45YrZFX5Amjv+0mleKv7TyvIxofGs5s1bemN8Krs
         TJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Sv0P22Iv02OrqwVXx+cIPzWSnuWnVlAhCTSZIIH/v30=;
        b=tfv1SuJ81HcT/mgtFCIvbF1Qd6gSMsc8ZuhFy/uD1jq+COBPRQotpvkwguEWFdIVc1
         i8HvYDqrnr6v6+TEFfWplXvVRLkApxmA+JaVmTuwTQCaNH9qZgRUNjl7q5TxRk+74EsJ
         uWsbT8GX03qGF0hqPhY6W0HryrDp00+TJzPrIPFdUlWyRvhCGyEuLHW3ufIgMsZ+VBch
         YBnZQ+vICToGfBiDZNUdwHNItOLJNl3Z/9/QSWwnj9lq9no4kbV6TWfUst7AusYO/a7H
         Om15rAzaKxSVjowCu535qYln4czWtN7oM0cJqPPzhfogK/hcrxOUiI/piCuxbz5z19V7
         zqig==
X-Gm-Message-State: AOUpUlH61EKKHeeorgxLTdwnJGuqbRZUojgrHkYzQgj4+PDRKnVh4hGl
        9o5adk1RjbYD+wG0ixn4RJLgErXyPz/jtCcPMJo=
X-Google-Smtp-Source: AA+uWPxT7a8lgIu2GQ6T5o5T8uXOQ65aKjeGQXNX3m1wDGgNtbYMnPLeR47g6YJmRIiloEUkD8AS/ls5dW1466fdr+M=
X-Received: by 2002:a0c:f883:: with SMTP id u3-v6mr8538230qvn.28.1533974445859;
 Sat, 11 Aug 2018 01:00:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:c3cc:0:0:0:0:0 with HTTP; Sat, 11 Aug 2018 01:00:45
 -0700 (PDT)
In-Reply-To: <20180809041856.1547-2-ravi.bangoria@linux.ibm.com>
References: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com> <20180809041856.1547-2-ravi.bangoria@linux.ibm.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Sat, 11 Aug 2018 01:00:45 -0700
Message-ID: <CAPhsuW4zyC1v59bwe4D7j-K3Nw90FbDs2FZ5HuT2HOgR_oooUg@mail.gmail.com>
Subject: Re: [PATCH v8 1/6] Uprobes: Simplify uprobe_register() body
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     srikar@linux.vnet.ibm.com, Oleg Nesterov <oleg@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, mhiramat@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        ananth@linux.vnet.ibm.com,
        Alexis Berlemont <alexis.berlemont@gmail.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com
Content-Type: text/plain; charset="UTF-8"
Return-Path: <liu.song.a23@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65545
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: liu.song.a23@gmail.com
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

On Wed, Aug 8, 2018 at 9:18 PM, Ravi Bangoria
<ravi.bangoria@linux.ibm.com> wrote:
> Simplify uprobe_register() function body and let __uprobe_register()
> handle everything. Also move dependency functions around to fix build
> failures.
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

Reviewed-by: Song Liu <songliubraving@fb.com>

> ---
>  kernel/events/uprobes.c | 69 ++++++++++++++++++++++++++-----------------------
>  1 file changed, 36 insertions(+), 33 deletions(-)
>
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index ccc579a7d32e..471eac896635 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -840,13 +840,8 @@ register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
>         return err;
>  }
>
> -static int __uprobe_register(struct uprobe *uprobe, struct uprobe_consumer *uc)
> -{
> -       consumer_add(uprobe, uc);
> -       return register_for_each_vma(uprobe, uc);
> -}
> -
> -static void __uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
> +static void
> +__uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
>  {
>         int err;
>
> @@ -860,24 +855,46 @@ static void __uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *u
>  }
>
>  /*
> - * uprobe_register - register a probe
> + * uprobe_unregister - unregister a already registered probe.
> + * @inode: the file in which the probe has to be removed.
> + * @offset: offset from the start of the file.
> + * @uc: identify which probe if multiple probes are colocated.
> + */
> +void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc)
> +{
> +       struct uprobe *uprobe;
> +
> +       uprobe = find_uprobe(inode, offset);
> +       if (WARN_ON(!uprobe))
> +               return;
> +
> +       down_write(&uprobe->register_rwsem);
> +       __uprobe_unregister(uprobe, uc);
> +       up_write(&uprobe->register_rwsem);
> +       put_uprobe(uprobe);
> +}
> +EXPORT_SYMBOL_GPL(uprobe_unregister);
> +
> +/*
> + * __uprobe_register - register a probe
>   * @inode: the file in which the probe has to be placed.
>   * @offset: offset from the start of the file.
>   * @uc: information on howto handle the probe..
>   *
> - * Apart from the access refcount, uprobe_register() takes a creation
> + * Apart from the access refcount, __uprobe_register() takes a creation
>   * refcount (thro alloc_uprobe) if and only if this @uprobe is getting
>   * inserted into the rbtree (i.e first consumer for a @inode:@offset
>   * tuple).  Creation refcount stops uprobe_unregister from freeing the
>   * @uprobe even before the register operation is complete. Creation
>   * refcount is released when the last @uc for the @uprobe
> - * unregisters. Caller of uprobe_register() is required to keep @inode
> + * unregisters. Caller of __uprobe_register() is required to keep @inode
>   * (and the containing mount) referenced.
>   *
>   * Return errno if it cannot successully install probes
>   * else return 0 (success)
>   */
> -int uprobe_register(struct inode *inode, loff_t offset, struct uprobe_consumer *uc)
> +static int __uprobe_register(struct inode *inode, loff_t offset,
> +                            struct uprobe_consumer *uc)
>  {
>         struct uprobe *uprobe;
>         int ret;
> @@ -904,7 +921,8 @@ int uprobe_register(struct inode *inode, loff_t offset, struct uprobe_consumer *
>         down_write(&uprobe->register_rwsem);
>         ret = -EAGAIN;
>         if (likely(uprobe_is_active(uprobe))) {
> -               ret = __uprobe_register(uprobe, uc);
> +               consumer_add(uprobe, uc);
> +               ret = register_for_each_vma(uprobe, uc);
>                 if (ret)
>                         __uprobe_unregister(uprobe, uc);
>         }
> @@ -915,6 +933,12 @@ int uprobe_register(struct inode *inode, loff_t offset, struct uprobe_consumer *
>                 goto retry;
>         return ret;
>  }
> +
> +int uprobe_register(struct inode *inode, loff_t offset,
> +                   struct uprobe_consumer *uc)
> +{
> +       return __uprobe_register(inode, offset, uc);
> +}
>  EXPORT_SYMBOL_GPL(uprobe_register);
>
>  /*
> @@ -946,27 +970,6 @@ int uprobe_apply(struct inode *inode, loff_t offset,
>         return ret;
>  }
>
> -/*
> - * uprobe_unregister - unregister a already registered probe.
> - * @inode: the file in which the probe has to be removed.
> - * @offset: offset from the start of the file.
> - * @uc: identify which probe if multiple probes are colocated.
> - */
> -void uprobe_unregister(struct inode *inode, loff_t offset, struct uprobe_consumer *uc)
> -{
> -       struct uprobe *uprobe;
> -
> -       uprobe = find_uprobe(inode, offset);
> -       if (WARN_ON(!uprobe))
> -               return;
> -
> -       down_write(&uprobe->register_rwsem);
> -       __uprobe_unregister(uprobe, uc);
> -       up_write(&uprobe->register_rwsem);
> -       put_uprobe(uprobe);
> -}
> -EXPORT_SYMBOL_GPL(uprobe_unregister);
> -
>  static int unapply_uprobe(struct uprobe *uprobe, struct mm_struct *mm)
>  {
>         struct vm_area_struct *vma;
> --
> 2.14.4
>
