Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Aug 2018 07:54:44 +0200 (CEST)
Received: from mail-qt0-x243.google.com ([IPv6:2607:f8b0:400d:c0d::243]:39594
        "EHLO mail-qt0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990434AbeHTFyl2OSvp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Aug 2018 07:54:41 +0200
Received: by mail-qt0-x243.google.com with SMTP id o15-v6so8996640qtk.6;
        Sun, 19 Aug 2018 22:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aCEercaU21ic7AarRefdSPPQevCBnjd97aDqkigi4Ks=;
        b=jE4rK1QOZtd2lK2W84xF1GzVA6c0US7SE06xn8tZ8v4Bk419DKHtS1uKiva2M90WoZ
         zcBcR6UmATXG9LhY5bXzkp1tN/RqN4v75XM1oHZ+Venj8Ry4W5zd8RpypbfZO5AvpaS/
         KfS1jRhRUmo4BKgw/7NRq9vdT9PGGWBHviQq9I5wHQ1jTua9V8dq5jG1vL0Ga+Krecxj
         Z85dpBB6wQ9IHOK9AXhp1O48uG/PpIU2aKuAIF5+a8Qkn2LaVDjtl3QAXqWq2d5S/bFj
         WNzxmc1uE1egV/K042cfcXQrmnCk3wVs4QWap50HCWKec+5dWLFHiEgW/IMZrSaoCmlw
         Bxdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aCEercaU21ic7AarRefdSPPQevCBnjd97aDqkigi4Ks=;
        b=Ukfpd2krZvExKy8YtAc/G0Muri7V9mpd2SdC8C7F8/88tfVV3zWyV+BUvQvVi+MCLQ
         U6/VB7JRg0OQyT1TXx+JEPeCCvO8pvrhAR+rkrv83ae+WxjPntG9nMtLwALQyPGoohPU
         6p2LrHAnKOCT1HVvyRkdKDtAbKhT/a8cJvpN2E5cc+i3rDdXkY9r3EB8N9OXUOcJEVzZ
         oh0erflVxQPWS/ALVy/3/o7V7M6COw6Zq451+wo1/XG3Cc4evoGuMZ963fCveRXSvoxg
         TGZPMCR2ffu6O3SGTPjlrU1D29A+qYwiPymg3v9Oihp1oZRW2X4az+3Mv0wxViMxetWs
         7jxw==
X-Gm-Message-State: APzg51AHcU8icL+JQGsWjTjHJicfGZajhfWfMPTbZXqacNblwGOv+k9e
        uNsDuzIylbd38G0LK05KvYUhpZ2gNK8Dwr8vlu0=
X-Google-Smtp-Source: ANB0VdbcCKrFR18GN9ijIeCeZR8Zs5MmgNCXl32u6U22Yb14LE9Kg1c8O79mE8Bp4iwU+SV61uaGMRZYG2dyekf/Dm0=
X-Received: by 2002:a0c:bf96:: with SMTP id s22-v6mr803321qvj.48.1534744475410;
 Sun, 19 Aug 2018 22:54:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:c3cc:0:0:0:0:0 with HTTP; Sun, 19 Aug 2018 22:54:35
 -0700 (PDT)
In-Reply-To: <20180820044250.11659-3-ravi.bangoria@linux.ibm.com>
References: <20180820044250.11659-1-ravi.bangoria@linux.ibm.com> <20180820044250.11659-3-ravi.bangoria@linux.ibm.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Sun, 19 Aug 2018 22:54:35 -0700
Message-ID: <CAPhsuW4QbT+0wHYW-A7G8z-Xp=8M+0w1Efmc1006PbqNTfOSxg@mail.gmail.com>
Subject: Re: [PATCH v9 2/4] Uprobes/sdt: Prevent multiple reference counter
 for same uprobe
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>,
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
X-archive-position: 65649
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

On Sun, Aug 19, 2018 at 9:42 PM, Ravi Bangoria
<ravi.bangoria@linux.ibm.com> wrote:
> We assume to have only one reference counter for one uprobe.
> Don't allow user to register multiple uprobes having same
> inode+offset but different reference counter.
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> Acked-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>

Reviewed-by: Song Liu <songliubraving@fb.com>

> ---
>  kernel/events/uprobes.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 35065febcb6c..ecee371a59c7 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -679,6 +679,16 @@ static struct uprobe *insert_uprobe(struct uprobe *uprobe)
>         return u;
>  }
>
> +static void
> +ref_ctr_mismatch_warn(struct uprobe *cur_uprobe, struct uprobe *uprobe)
> +{
> +       pr_warn("ref_ctr_offset mismatch. inode: 0x%lx offset: 0x%llx "
> +               "ref_ctr_offset(old): 0x%llx ref_ctr_offset(new): 0x%llx\n",
> +               uprobe->inode->i_ino, (unsigned long long) uprobe->offset,
> +               (unsigned long long) cur_uprobe->ref_ctr_offset,
> +               (unsigned long long) uprobe->ref_ctr_offset);
> +}
> +
>  static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
>                                    loff_t ref_ctr_offset)
>  {
> @@ -698,6 +708,12 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
>         cur_uprobe = insert_uprobe(uprobe);
>         /* a uprobe exists for this inode:offset combination */
>         if (cur_uprobe) {
> +               if (cur_uprobe->ref_ctr_offset != uprobe->ref_ctr_offset) {
> +                       ref_ctr_mismatch_warn(cur_uprobe, uprobe);
> +                       put_uprobe(cur_uprobe);
> +                       kfree(uprobe);
> +                       return ERR_PTR(-EINVAL);
> +               }
>                 kfree(uprobe);
>                 uprobe = cur_uprobe;
>         }
> @@ -1112,6 +1128,9 @@ static int __uprobe_register(struct inode *inode, loff_t offset,
>         uprobe = alloc_uprobe(inode, offset, ref_ctr_offset);
>         if (!uprobe)
>                 return -ENOMEM;
> +       if (IS_ERR(uprobe))
> +               return PTR_ERR(uprobe);
> +
>         /*
>          * We can race with uprobe_unregister()->delete_uprobe().
>          * Check uprobe_is_active() and retry if it is false.
> --
> 2.14.4
>
