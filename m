Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Mar 2012 23:08:53 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:52669 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903594Ab2CZVIf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Mar 2012 23:08:35 +0200
Received: by pbcun4 with SMTP id un4so7255153pbc.36
        for <linux-mips@linux-mips.org>; Mon, 26 Mar 2012 14:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        bh=PNY7l+ycCaMh4eq/pnhng52CYH29ubBQRrcDXmprKzw=;
        b=hcMnZOxh4AqILVASkRDn7l3XJtMDWHMsKuy5DzRPTnnplcfyB2OZkZV1vym55k35xD
         ckgECh2kHiztsDCI+7iA7Upc55kIF38wYk6CSDb2WD84+2TJZOg2k9aatZrVqposxD4B
         kQiIwRpckhUHEHFRtHU2nymdxoTzKP36GDy5qIXGFhmnQ0AZ4RT8BDN50+4BKBUFlAEV
         zHTOvOd8uGWCW6/AaS9Os8m6JXNcOANKARMrhxm3r08rPv/8o56rrFVXbka5AiIxv+D1
         WfZ2clpnGl75ZsTBANScY0wA7/hGElte3wfGOVl9M7qNdc5tWGsrt/pc8022q/Obcjbq
         VTkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type:x-gm-message-state;
        bh=PNY7l+ycCaMh4eq/pnhng52CYH29ubBQRrcDXmprKzw=;
        b=dQzn5A37DU96PXOfC8xv6wUbIgcWNKDnoPIL8rHXNxpjsH3hfWI/I/9kl40lLHrXhg
         UrWvSh5CGDiAV4nxLElsqReeIG6djKFqNDhZVXG16bdYu0O7K2sWvl3Yv51SdxSEj5bn
         rv4UkOSaV6ySEYRZNp7xaAKHxVeogMsx3rZZoh4rf51Feia90C8W7Wu2eF3PSfC+xNuj
         L/B56C/98nBnK6MQ6GBNv5vloLiRCKuCP20pzvQlSrJaUUYUL4wjXTFxu6bx9EesT/pF
         OAuyutDuFNoVag9J6kYgfGKg6eZ1oQPlBY27RyiUBkR5yFlG6Fowbf3wFHHgPd71DH42
         HY9g==
Received: by 10.68.125.134 with SMTP id mq6mr57201861pbb.74.1332796108775;
        Mon, 26 Mar 2012 14:08:28 -0700 (PDT)
Received: by 10.68.125.134 with SMTP id mq6mr57201792pbb.74.1332796108534;
        Mon, 26 Mar 2012 14:08:28 -0700 (PDT)
Received: from [192.168.1.8] (c-67-188-178-35.hsd1.ca.comcast.net. [67.188.178.35])
        by mx.google.com with ESMTPS id p4sm833480pbp.13.2012.03.26.14.08.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 26 Mar 2012 14:08:27 -0700 (PDT)
Date:   Mon, 26 Mar 2012 14:08:00 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Kautuk Consul <consul.kautuk@gmail.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] mmap.c: find_vma: replace if(mm) check with
 BUG_ON(!mm)
In-Reply-To: <1332777965-2534-1-git-send-email-consul.kautuk@gmail.com>
Message-ID: <alpine.LSU.2.00.1203261346360.3443@eggly.anvils>
References: <1332777965-2534-1-git-send-email-consul.kautuk@gmail.com>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Gm-Message-State: ALoCoQk4s34thV74z4X/U4ABbjfEOLHe0+y1Lj3yiowIB1bHpMgYijIOswSN8n4hAthGyQ5KMF+4bIXSdyDw33rXoFMwMDLa/ytFXGR+g3AAG6psvZ4aFQXC9zZ38JhFqX8zvCvHUqX/Q4lIAM9FomUz15fpFodmoG+UHH5siYyd+MUhlBskYoE=
X-archive-position: 32759
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hughd@google.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Mon, 26 Mar 2012, Kautuk Consul wrote:
> find_vma is called from kernel code where it is absolutely
> sure that the mm_struct arg being passed to it is non-NULL.
> 
> Convert the if check to a BUG_ON.
> This will also serve the purpose of mandating that the execution
> context(user-mode/kernel-mode) be known before find_vma is called.
> 
> Also fixed 2 checkpatch.pl errors in this function for the rb_node
> and vma_tmp local variables.
> 
> I have tested this patch on my x86 PC and there are no BUG_ON crashes
> due to this in the course of normal desktop execution.
> 
> Signed-off-by: Kautuk Consul <consul.kautuk@gmail.com>

That seems very reasonable: perhaps there was a reason for checking
find_vma()'s mm way back in the distant past, but I cannot see it now.
But please make two small changes noted below before resubmitting.

Since we ask for mm->mmap_sem to be held before calling find_vma(),
it's hard to reach here with NULL mm.  There are a few strange places
in arch and drivers/media/video which appear to be taking risks by
not holding mmap_sem, but only one of them looks like it _might_ be
endangered by your change.

Ralf, that octeon_flush_cache_sigtramp() in arch/mips/mm/c-octeon.c:
is there ever a danger that it can be called with NULL current->mm?  Is
current->mm set to &init_mm in the initial call from octeon_cache_init()?

> ---
>  mm/mmap.c |   52 ++++++++++++++++++++++++++--------------------------
>  1 files changed, 26 insertions(+), 26 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index a7bf6a3..7589965 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1589,33 +1589,33 @@ struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
>  {
>  	struct vm_area_struct *vma = NULL;

Please remove the " = NULL": vma is immediately set to mm->mmap_cache.

>  
> -	if (mm) {
> -		/* Check the cache first. */
> -		/* (Cache hit rate is typically around 35%.) */
> -		vma = mm->mmap_cache;
> -		if (!(vma && vma->vm_end > addr && vma->vm_start <= addr)) {
> -			struct rb_node * rb_node;
> -
> -			rb_node = mm->mm_rb.rb_node;
> -			vma = NULL;
> -
> -			while (rb_node) {
> -				struct vm_area_struct * vma_tmp;
> -
> -				vma_tmp = rb_entry(rb_node,
> -						struct vm_area_struct, vm_rb);
> -
> -				if (vma_tmp->vm_end > addr) {
> -					vma = vma_tmp;
> -					if (vma_tmp->vm_start <= addr)
> -						break;
> -					rb_node = rb_node->rb_left;
> -				} else
> -					rb_node = rb_node->rb_right;
> -			}
> -			if (vma)
> -				mm->mmap_cache = vma;
> +	BUG_ON(!mm);

And please remove the BUG_ON(!mm): it's a waste of space and time,
it gives very little value over the easily recognizable oops we
shall get from "vma = mm->mmap_cache" with NULL mm.

Thanks,
Hugh

> +
> +	/* Check the cache first. */
> +	/* (Cache hit rate is typically around 35%.) */
> +	vma = mm->mmap_cache;
> +	if (!(vma && vma->vm_end > addr && vma->vm_start <= addr)) {
> +		struct rb_node *rb_node;
> +
> +		rb_node = mm->mm_rb.rb_node;
> +		vma = NULL;
> +
> +		while (rb_node) {
> +			struct vm_area_struct *vma_tmp;
> +
> +			vma_tmp = rb_entry(rb_node,
> +					struct vm_area_struct, vm_rb);
> +
> +			if (vma_tmp->vm_end > addr) {
> +				vma = vma_tmp;
> +				if (vma_tmp->vm_start <= addr)
> +					break;
> +				rb_node = rb_node->rb_left;
> +			} else
> +				rb_node = rb_node->rb_right;
>  		}
> +		if (vma)
> +			mm->mmap_cache = vma;
>  	}
>  	return vma;
>  }
> -- 
> 1.7.5.4
