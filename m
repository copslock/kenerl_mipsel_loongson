Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Aug 2018 18:50:44 +0200 (CEST)
Received: from mail-qk0-x244.google.com ([IPv6:2607:f8b0:400d:c09::244]:34220
        "EHLO mail-qk0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990398AbeHMQujMYVmF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Aug 2018 18:50:39 +0200
Received: by mail-qk0-x244.google.com with SMTP id b66-v6so11444263qkj.1;
        Mon, 13 Aug 2018 09:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OEjBg8nwkgW4E54U+pNNWobX2iGtUFNT8aQjAG1BP3M=;
        b=fvdjgOXNgGTImOf3zZ572dZGpbPSfxjqOyPmNaBWIYlWotqdhWaGVYajsVIbdWbIJs
         1+Ug1rTjscQnxzDEt9fxYEqACytIXGAKmxYLH9ED0rVnfsxh5H6USNc0Tjgq4/A54/p0
         9jyMXjH52AZT607foKgCviEAo65zcinCJqaBzmQEzpw7VLYTM7IzCW6HpoloWjOnqU40
         SfzgrHgtz1akQQ88ds2NEnFKarx4wr1lB8jxWiXQEsM5PX4n0p8XSvaLPfwLOcapnqJQ
         mwXOXoK5EBGiPd9xjnyXLiLqyNIUm/aitW6KYgTB9c8zpl5LwrN2TK8lphekEK77UOTY
         faag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OEjBg8nwkgW4E54U+pNNWobX2iGtUFNT8aQjAG1BP3M=;
        b=jidXGwFSjPsWbaeFdY0UkTLUkkwNTiTrQezy1Xgq0XNtB7oGm49IkQenVHH8I+EnfO
         XQeDI0lo3qnQ1t6C/ti78fr0eJOIgV8/+bavZKqvjOQYafiBk+1RYdPj2ZgumeQFUeBk
         whKAVjk9z1MXwoGEKE76zgu6hg1giQeUNbpQcb2gggB0DrTjF15SsmQ7Eq57QX1V4Ccx
         mRKXmiPeMuSNIhOm41ci+z3dOpqQEwOBRNNrUzk6rRoM4IpEJ+M9Z+ZQ5woXhD0/9Rzd
         yoQgtqWg3LCEFKIL+qjBMpZF8mjoZsZx+7MwoyVdD20bSXsmgbDSK0dbs+oCdU5fk/kx
         tJVQ==
X-Gm-Message-State: AOUpUlETdwK0GzwFUGaVtX0pTIhtld9Jb6rVZLj9IH0NgOfQqM+un9bl
        +oAK5/mrV25wzzrGP1OcjmvFnn1hYKC0EQgBGmg=
X-Google-Smtp-Source: AA+uWPy5VNlVxg5nXlwej6QDF4bz1gMgNDH8UZY2iwlNV4V21fhdMNuLI49HU+RjZdah9QGYJdK5oswgAxVXlfvLRuU=
X-Received: by 2002:a37:2916:: with SMTP id p22-v6mr16219207qkh.327.1534179032992;
 Mon, 13 Aug 2018 09:50:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:c3cc:0:0:0:0:0 with HTTP; Mon, 13 Aug 2018 09:50:32
 -0700 (PDT)
In-Reply-To: <95a1221e-aecc-42be-5239-a2c2429be176@linux.ibm.com>
References: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com>
 <20180809041856.1547-4-ravi.bangoria@linux.ibm.com> <CAPhsuW49+qA7kT7yE4tgbnAuox-iOzssg-jc2abG8XDo6XeX8A@mail.gmail.com>
 <95a1221e-aecc-42be-5239-a2c2429be176@linux.ibm.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Mon, 13 Aug 2018 09:50:32 -0700
Message-ID: <CAPhsuW5K8+m23qRR3hDxTa1nwZ+1hHH0Mu-2EmjP1-rOjQ03_g@mail.gmail.com>
Subject: Re: [PATCH v8 3/6] Uprobes: Support SDT markers having reference
 count (semaphore)
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
X-archive-position: 65570
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

On Sun, Aug 12, 2018 at 10:47 PM, Ravi Bangoria
<ravi.bangoria@linux.ibm.com> wrote:
> Hi Song,
>
> On 08/11/2018 01:27 PM, Song Liu wrote:
>>> +
>>> +static void delayed_uprobe_delete(struct delayed_uprobe *du)
>>> +{
>>> +       if (!du)
>>> +               return;
>> Do we really need this check?
>
>
> Not necessary though, but I would still like to keep it for a safety.
>
>
>>
>>> +       list_del(&du->list);
>>> +       kfree(du);
>>> +}
>>> +
>>> +static void delayed_uprobe_remove(struct uprobe *uprobe, struct mm_struct *mm)
>>> +{
>>> +       struct list_head *pos, *q;
>>> +       struct delayed_uprobe *du;
>>> +
>>> +       if (!uprobe && !mm)
>>> +               return;
>> And do we really need this check?
>
>
> Yes. delayed_uprobe_remove(uprobe=NULL, mm=NULL) is an invalid case. If I remove
> this check, code below (or more accurately code suggested by Oleg) will remove
> all entries from delayed_uprobe_list. So I will keep this check but put a comment
> above function.
>
>
> [...]
>>> +
>>> +       ret = get_user_pages_remote(NULL, mm, vaddr, 1,
>>> +                       FOLL_WRITE, &page, &vma, NULL);
>>> +       if (unlikely(ret <= 0)) {
>>> +               /*
>>> +                * We are asking for 1 page. If get_user_pages_remote() fails,
>>> +                * it may return 0, in that case we have to return error.
>>> +                */
>>> +               ret = (ret == 0) ? -EBUSY : ret;
>>> +               pr_warn("Failed to %s ref_ctr. (%d)\n",
>>> +                       d > 0 ? "increment" : "decrement", ret);
>> This warning is not really useful. Seems this function has little information
>> about which uprobe is failing here. Maybe we only need warning in the caller
>> (or caller of caller).
>
>
> Sure, I can move this warning to caller of this function but what are the
> exact fields you would like to print with warning? Something like this is
> fine?
>
>     pr_warn("ref_ctr %s failed for 0x%lx, 0x%lx, 0x%lx, 0x%p",
>                 d > 0 ? "increment" : "decrement", inode->i_ino,
>                 offset, ref_ctr_offset, mm);
>
> More importantly, the reason I didn't print more info is because dmesg is
> accessible to unprivileged users in many distros but uprobes are not. So
> printing this information may be a security violation. No?
>
>
>>
>>> +               return ret;
>>> +       }
>>> +
>>> +       kaddr = kmap_atomic(page);
>>> +       ptr = kaddr + (vaddr & ~PAGE_MASK);
>>> +
>>> +       if (unlikely(*ptr + d < 0)) {
>>> +               pr_warn("ref_ctr going negative. vaddr: 0x%lx, "
>>> +                       "curr val: %d, delta: %d\n", vaddr, *ptr, d);
>>> +               ret = -EINVAL;
>>> +               goto out;
>>> +       }
>>> +
>>> +       *ptr += d;
>>> +       ret = 0;
>>> +out:
>>> +       kunmap_atomic(kaddr);
>>> +       put_page(page);
>>> +       return ret;
>>> +}
>>> +
>>> +static int update_ref_ctr(struct uprobe *uprobe, struct mm_struct *mm,
>>> +                         bool is_register)
>> What's the reason of bool is_register here vs. short d in __update_ref_ctr()?
>> Can we use short for both?
>
>
> Yes, I can use short as well.
>
>
>>
>>> +{
>>> +       struct vm_area_struct *rc_vma;
>>> +       unsigned long rc_vaddr;
>>> +       int ret = 0;
>>> +
>>> +       rc_vma = find_ref_ctr_vma(uprobe, mm);
>>> +
>>> +       if (rc_vma) {
>>> +               rc_vaddr = offset_to_vaddr(rc_vma, uprobe->ref_ctr_offset);
>>> +               ret = __update_ref_ctr(mm, rc_vaddr, is_register ? 1 : -1);
>>> +
>>> +               if (is_register)
>>> +                       return ret;
>>> +       }
>> Mixing __update_ref_ctr() here and delayed_uprobe_add() in the same
>> function is a little confusing (at least for me). How about we always use
>> delayed uprobe for uprobe_mmap() and use non-delayed in other case(s)?
>
>
> No. delayed_uprobe_add() is needed for uprobe_register() case to handle race
> between uprobe_register() and process creation.

I see.

>
>
> [...]
>>>
>>> +static int delayed_uprobe_install(struct vm_area_struct *vma)
>> This function name is confusing. How about we call it delayed_ref_ctr_incr() or
>> something similar? Also, we should add comments to highlight this is vma is not
>> the vma containing the uprobe, but the vma containing the ref_ctr.
>
>
> Sure, I'll do that.
>
>
>>
>>> +{
>>> +       struct list_head *pos, *q;
>>> +       struct delayed_uprobe *du;
>>> +       unsigned long vaddr;
>>> +       int ret = 0, err = 0;
>>> +
>>> +       mutex_lock(&delayed_uprobe_lock);
>>> +       list_for_each_safe(pos, q, &delayed_uprobe_list) {
>>> +               du = list_entry(pos, struct delayed_uprobe, list);
>>> +
>>> +               if (!valid_ref_ctr_vma(du->uprobe, vma))
>>> +                       continue;
>>> +
>>> +               vaddr = offset_to_vaddr(vma, du->uprobe->ref_ctr_offset);
>>> +               ret = __update_ref_ctr(vma->vm_mm, vaddr, 1);
>>> +               /* Record an error and continue. */
>>> +               if (ret && !err)
>>> +                       err = ret;
>> I think this is a good place (when ret != 0) to call pr_warn(). I guess we can
>> print which mm get error for which uprobe (inode+offset).
>
>
> __update_ref_ctr() is already printing warning, so I didn't add anything here.
> In case I remove a warning from __update_ref_ctr(), a warning something like
> below is fine?
>
>     pr_warn("ref_ctr increment failed for 0x%lx, 0x%lx, 0x%lx, 0x%p",
>                 inode->i_ino, offset, ref_ctr_offset, vma->vm_mm);
>

I was thinking about a message like:

ref_ctr increment failed for inode XX offset YY ref_ctr ZZ of mm 0xWWW

I didn't thought about the security part of it, but I guess it is OK.

Thanks,
Song

> Again, can this lead to a security violation?
>
> Thanks for detailed review :)
> -Ravi
>
