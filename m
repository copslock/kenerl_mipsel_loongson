Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Aug 2018 10:13:10 +0200 (CEST)
Received: from mail-qt0-x241.google.com ([IPv6:2607:f8b0:400d:c0d::241]:40394
        "EHLO mail-qt0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990474AbeHKINFdieSf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 11 Aug 2018 10:13:05 +0200
Received: by mail-qt0-x241.google.com with SMTP id h4-v6so12720463qtj.7;
        Sat, 11 Aug 2018 01:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=o/M+1IBC3Rqq5DOdqfmm82fc4zlpQX+5ynqgob8xkyE=;
        b=MCqiRjNWlMRXktlq++HNVT/QVra1RpRKyyuAvW0yatC72uRWA+bJjs5whvTcC1quLF
         SegDGq6wPRGTU78e7VGQKhL7AwgrH/7vnjNesF/bcOnrJCkfqHj7qxcF2/NA0+z8D40i
         ci9lgmnDOEdABiQdPFrEJbn+BL5RKyn7cISVWFEypIHYet1ieprsv80hXWg+2R7Aq5fC
         wgRLmtdtP6vHsu+IPvRaeGmlatrMsxJBL43V7RhTKA/9SzUCZuflTfjhlv1J+nsucviW
         hsp/AigDLwUgEFb01OYSDj6/kFthGRxFFVvlJTxG1TdJJ4Jdn/y1HffBBZT/qCdMLcHC
         GrcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=o/M+1IBC3Rqq5DOdqfmm82fc4zlpQX+5ynqgob8xkyE=;
        b=NrcLz5b7qzuLZlo3+j5hgfVzqGh4zymR+qtRsMfUzSgoEqs3KzdAxF/CvJYWlFnEw8
         u2fO++J9lBbzM7U3sjX6epRsTF9MxqVm2usgPbjMIdyhTg23NZImIjN3FJiI0Ml/2UQB
         bkhAak9HooCMVLVZ0It5zv0IBGXvzH9AkGIMUrxLJ0C4VFcZVSacJV1YskRmGDlX+TBP
         5byaUqO42D4itOFd6J+w31Wy++GrLdk5a1O6/zCXUB5vMTzc5gZFjnxMVEEk9QUXUCnN
         NxhprfQ7JmYB0kge192uys8PhC5wbxruGUmbuxvj93Fb5JeHXYbMdYLHTongImSYHPH4
         YbIw==
X-Gm-Message-State: AOUpUlHoKYlUQwV7RT23KhtrdHXCTUERQBNMUAyNx9KsWHlGrwPd1Mbl
        CkX6J9p/Kk5PY9yl9lXnQaswFjiWNsItcS2dfHU=
X-Google-Smtp-Source: AA+uWPzuvJrrrXF8zsaHJbeludt4pcl5U7U1HJXuD5sg0BYjUW0IsPhnTljVwSUtjPzSrO72/CM7UHnyEMUPXEAZ09I=
X-Received: by 2002:aed:3688:: with SMTP id f8-v6mr9656903qtb.276.1533975179248;
 Sat, 11 Aug 2018 01:12:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:c3cc:0:0:0:0:0 with HTTP; Sat, 11 Aug 2018 01:12:58
 -0700 (PDT)
In-Reply-To: <20180809041856.1547-6-ravi.bangoria@linux.ibm.com>
References: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com> <20180809041856.1547-6-ravi.bangoria@linux.ibm.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Sat, 11 Aug 2018 01:12:58 -0700
Message-ID: <CAPhsuW5g1dOnceA=kqfpC+rR6EguJaR+wPwY9nSWLbGSSj5XjQ@mail.gmail.com>
Subject: Re: [PATCH v8 5/6] trace_uprobe/sdt: Prevent multiple reference
 counter for same uprobe
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
X-archive-position: 65548
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

Do we really need this given we already have PATCH 4/6?
uprobe_regsiter() can be called
out of trace_uprobe, this patch won't catch all conflicts anyway.

Song

On Wed, Aug 8, 2018 at 9:18 PM, Ravi Bangoria
<ravi.bangoria@linux.ibm.com> wrote:
> We assume to have only one reference counter for one uprobe.
> Don't allow user to add multiple trace_uprobe entries having
> same inode+offset but different reference counter.
>
> Ex,
>   # echo "p:sdt_tick/loop2 /home/ravi/tick:0x6e4(0x10036)" > uprobe_events
>   # echo "p:sdt_tick/loop2_1 /home/ravi/tick:0x6e4(0xfffff)" >> uprobe_events
>   bash: echo: write error: Invalid argument
>
>   # dmesg
>   trace_kprobe: Reference counter offset mismatch.
>
> There is one exception though:
> When user is trying to replace the old entry with the new
> one, we allow this if the new entry does not conflict with
> any other existing entries.
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>  kernel/trace/trace_uprobe.c | 37 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 35 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index bf2be098eb08..be64d943d7ea 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -324,6 +324,35 @@ static int unregister_trace_uprobe(struct trace_uprobe *tu)
>         return 0;
>  }
>
> +/*
> + * Uprobe with multiple reference counter is not allowed. i.e.
> + * If inode and offset matches, reference counter offset *must*
> + * match as well. Though, there is one exception: If user is
> + * replacing old trace_uprobe with new one(same group/event),
> + * then we allow same uprobe with new reference counter as far
> + * as the new one does not conflict with any other existing
> + * ones.
> + */
> +static struct trace_uprobe *find_old_trace_uprobe(struct trace_uprobe *new)
> +{
> +       struct trace_uprobe *tmp, *old = NULL;
> +       struct inode *new_inode = d_real_inode(new->path.dentry);
> +
> +       old = find_probe_event(trace_event_name(&new->tp.call),
> +                               new->tp.call.class->system);
> +
> +       list_for_each_entry(tmp, &uprobe_list, list) {
> +               if ((old ? old != tmp : true) &&
> +                   new_inode == d_real_inode(tmp->path.dentry) &&
> +                   new->offset == tmp->offset &&
> +                   new->ref_ctr_offset != tmp->ref_ctr_offset) {
> +                       pr_warn("Reference counter offset mismatch.");
> +                       return ERR_PTR(-EINVAL);
> +               }
> +       }
> +       return old;
> +}
> +
>  /* Register a trace_uprobe and probe_event */
>  static int register_trace_uprobe(struct trace_uprobe *tu)
>  {
> @@ -333,8 +362,12 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
>         mutex_lock(&uprobe_lock);
>
>         /* register as an event */
> -       old_tu = find_probe_event(trace_event_name(&tu->tp.call),
> -                       tu->tp.call.class->system);
> +       old_tu = find_old_trace_uprobe(tu);
> +       if (IS_ERR(old_tu)) {
> +               ret = PTR_ERR(old_tu);
> +               goto end;
> +       }
> +
>         if (old_tu) {
>                 /* delete old event */
>                 ret = unregister_trace_uprobe(old_tu);
> --
> 2.14.4
>
