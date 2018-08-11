Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Aug 2018 10:04:29 +0200 (CEST)
Received: from mail-qt0-x244.google.com ([IPv6:2607:f8b0:400d:c0d::244]:34726
        "EHLO mail-qt0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990398AbeHKIE0INaYf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 11 Aug 2018 10:04:26 +0200
Received: by mail-qt0-x244.google.com with SMTP id m13-v6so12756253qth.1;
        Sat, 11 Aug 2018 01:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xAETR19d5IUpzUdaI/152Glto0UkKj2/dMJxnNag+/M=;
        b=Z0nL+iRZN1oUo+2VW2KXuTxk1pbRml6n172x8wDs3uykiM716X0JEnwSfN2+fWHrq9
         eak1AsbuMUhULMcPNHLUnicEWnHLkDLG+zNpYB3MURNKtSaJwjnqejwGB5+363FvUk2k
         22kM646kYpZLWxNOudCXyDf2xgRAeOynfqrsgeFXyTNoeM/GgJpRgPjJDlZ/wZKK0CNk
         UeuvbykQd4Kg3mCd8OvetR/FvgKHl42kLkX++TyEyxz+ef7brtSHWpYQjyGJXB1LGUDB
         s4U3FqYy7+qkuTxJnwtUIrNNOO0fCiVXUyt+YfzRWfhKnZmFPSQpfNW77kLxswVvqJdw
         zmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xAETR19d5IUpzUdaI/152Glto0UkKj2/dMJxnNag+/M=;
        b=cJ+J+Z6FszSWj1EHCs3fx0/RLSNMy0gF2ZuygGDzzW5RronmG+ZYJuc0dAPxYRhTpu
         25CpDn4d3tZAryXoGBdIbz4XHj/TolyPfMIkukKOlvhVdzWphPzPOSrDKZzEL70iJMDN
         oF4u4Mtngf3Jvj0Wh3920xg/XhColOevZ9FAMomywoMuJONm19poFteA3+kCKhAknfeo
         EPafNIVUP4YjvOOWccYbX+f0N/KWqYGnHWvt63jlWp0PSmP93tGmu5Qm0Qm/Orz80LiK
         W7M0Mf6zcXoHmI/mOmKy0WMqT1KVvoNQ0/bdnn6BzuQr/mGraPsfLRBz9wVfth0UHQLt
         eQwA==
X-Gm-Message-State: AOUpUlHqlqV013yfyYKOADSSP2eb2k8wGfQSKJMH5qlE1ACrBb9ZHfGg
        m3C1NXWinG+7+sf4wCyiLyd1BDDw2WXKzsTPbyg=
X-Google-Smtp-Source: AA+uWPx9SUl2dsEigls3jPExN9Uv/wuy8elpqgSgQhzFxZD3gcQfguHAvRHnQMMuoyGgXSVXx4dE7i39aGUKLIeG/EY=
X-Received: by 2002:ac8:1abd:: with SMTP id x58-v6mr9654757qtj.180.1533974660404;
 Sat, 11 Aug 2018 01:04:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:c3cc:0:0:0:0:0 with HTTP; Sat, 11 Aug 2018 01:04:19
 -0700 (PDT)
In-Reply-To: <20180809041856.1547-5-ravi.bangoria@linux.ibm.com>
References: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com> <20180809041856.1547-5-ravi.bangoria@linux.ibm.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Sat, 11 Aug 2018 01:04:19 -0700
Message-ID: <CAPhsuW5GXqS3Ce326Uf2PQQO8qfMkWU3MxOeUDKaCeG3b0euAA@mail.gmail.com>
Subject: Re: [PATCH v8 4/6] Uprobes/sdt: Prevent multiple reference counter
 for same uprobe
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
X-archive-position: 65547
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
> We assume to have only one reference counter for one uprobe.
> Don't allow user to register multiple uprobes having same
> inode+offset but different reference counter.
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>  kernel/events/uprobes.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 61b0481ef417..492a0e005b4d 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -689,6 +689,12 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
>         cur_uprobe = insert_uprobe(uprobe);
>         /* a uprobe exists for this inode:offset combination */
>         if (cur_uprobe) {
> +               if (cur_uprobe->ref_ctr_offset != uprobe->ref_ctr_offset) {
> +                       pr_warn("Reference counter offset mismatch.\n");
We should print more information here, including the inode, the offset
and both ref_ctr_offset.

> +                       put_uprobe(cur_uprobe);
> +                       kfree(uprobe);
> +                       return ERR_PTR(-EINVAL);
> +               }
>                 kfree(uprobe);
>                 uprobe = cur_uprobe;
>         }
> @@ -1103,6 +1109,9 @@ static int __uprobe_register(struct inode *inode, loff_t offset,
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
