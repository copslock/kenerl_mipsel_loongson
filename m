Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Oct 2016 08:54:53 +0200 (CEST)
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33600 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992143AbcJMGyplxfht (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Oct 2016 08:54:45 +0200
Received: by mail-lf0-f67.google.com with SMTP id l131so8167130lfl.0
        for <linux-mips@linux-mips.org>; Wed, 12 Oct 2016 23:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=3asvTgfj3GU54OgIYStGKeChrqWlhKte9l3JCr89Xhs=;
        b=TDOoWCNzOXP3ysA46vGEZYsOtgizpu5LEIsJ8MDpwZNyncHu1rYbNWBecZMM0bVohD
         ePRUfY7iXnd1+WT31Hz0sxvHlqUiNTsdNDJD+ZWQdUVwKpOtTEbFh5p2JiU/1OIMnl6x
         Ybh9dxB/2PdNLt2rZ7dVJTSYyBxBqBiYzcpBOyEmigURzEaFybgsA5uJ4epjl5DFMPeW
         34TeltD0i8pWOEQ14qu3Mv7EJHLMpXJBJGrap7t+NRfv7JfDEg/z1sXmTIE9njbpUtGb
         NV9GAIqFC0NCu4504CaNZki9UacQ6RxU6KnL2rgfUqbL+AmOIEqyFXlKbRXBHMsmCvyd
         H4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:subject:to:references:cc:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=3asvTgfj3GU54OgIYStGKeChrqWlhKte9l3JCr89Xhs=;
        b=dO4tLh5svbs7wzO0w+Lzpt9/w2BPsWtBSEDKAYmpizFgHUCnC7djRed9prbr1SDeSt
         PsSpBP76E59cBo8PUam7icew75mOFUI45IIaQE53GuIyXggFTE9wJ3cxsRtXFA2DE0CL
         Kq/f1EQXqRou48nWcOiUxkmjDQIuq5y1EyKRXgyBLlr1NO6kt9zjIgrcJN9B7AGTlYPE
         XDSudoRoJxLlwa7LOrhVlshsBVeN2FOHUgX5JDm6flJd5uzVl7pHkY6eG7g/LG79SEeR
         Y3o2hrKXeGShzAxzSCX8ubcVaKECTdzNWw+BAidzr6SnLt2JfkI36/DkO0FsMkfCKC2Z
         /AuQ==
X-Gm-Message-State: AA6/9RknemRcExMFddy9/sAkkIwiKIEjQPSrpbZzplfLiczjnxRI+tMtJ52jkdkDl6im5Q==
X-Received: by 10.25.26.72 with SMTP id a69mr6873137lfa.0.1476341680062;
        Wed, 12 Oct 2016 23:54:40 -0700 (PDT)
Received: from [192.168.10.165] (94-39-150-81.adsl-ull.clienti.tiscali.it. [94.39.150.81])
        by smtp.googlemail.com with ESMTPSA id s127sm3164535lja.46.2016.10.12.23.54.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Oct 2016 23:54:38 -0700 (PDT)
Subject: Re: [PATCH 02/10] mm: remove write/force parameters from
 __get_user_pages_unlocked()
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org
References: <20161013002020.3062-1-lstoakes@gmail.com>
 <20161013002020.3062-3-lstoakes@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Hugh Dickins <hughd@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Rik van Riel <riel@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        adi-buildroot-devel@lists.sourceforge.net,
        ceph-devel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, kvm@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-cris-kernel@axis.com, linux-fbdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mips@linux-mips.org, linux-rdma@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-sh@vger.kerne
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ce8bd0b0-84e3-4b3a-edeb-27709b0c5ce6@redhat.com>
Date:   Thu, 13 Oct 2016 08:54:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20161013002020.3062-3-lstoakes@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <paolo.bonzini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55415
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pbonzini@redhat.com
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



On 13/10/2016 02:20, Lorenzo Stoakes wrote:
> This patch removes the write and force parameters from
> __get_user_pages_unlocked() to make the use of FOLL_FORCE explicit in callers as
> use of this flag can result in surprising behaviour (and hence bugs) within the
> mm subsystem.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>  include/linux/mm.h     |  3 +--
>  mm/gup.c               | 17 +++++++++--------
>  mm/nommu.c             | 12 +++++++++---
>  mm/process_vm_access.c |  7 +++++--
>  virt/kvm/async_pf.c    |  3 ++-
>  virt/kvm/kvm_main.c    | 11 ++++++++---
>  6 files changed, 34 insertions(+), 19 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index e9caec6..2db98b6 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1285,8 +1285,7 @@ long get_user_pages_locked(unsigned long start, unsigned long nr_pages,
>  		    int write, int force, struct page **pages, int *locked);
>  long __get_user_pages_unlocked(struct task_struct *tsk, struct mm_struct *mm,
>  			       unsigned long start, unsigned long nr_pages,
> -			       int write, int force, struct page **pages,
> -			       unsigned int gup_flags);
> +			       struct page **pages, unsigned int gup_flags);
>  long get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
>  		    int write, int force, struct page **pages);
>  int get_user_pages_fast(unsigned long start, int nr_pages, int write,
> diff --git a/mm/gup.c b/mm/gup.c
> index ba83942..3d620dd 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -865,17 +865,11 @@ EXPORT_SYMBOL(get_user_pages_locked);
>   */
>  __always_inline long __get_user_pages_unlocked(struct task_struct *tsk, struct mm_struct *mm,
>  					       unsigned long start, unsigned long nr_pages,
> -					       int write, int force, struct page **pages,
> -					       unsigned int gup_flags)
> +					       struct page **pages, unsigned int gup_flags)
>  {
>  	long ret;
>  	int locked = 1;
>  
> -	if (write)
> -		gup_flags |= FOLL_WRITE;
> -	if (force)
> -		gup_flags |= FOLL_FORCE;
> -
>  	down_read(&mm->mmap_sem);
>  	ret = __get_user_pages_locked(tsk, mm, start, nr_pages, pages, NULL,
>  				      &locked, false, gup_flags);
> @@ -905,8 +899,15 @@ EXPORT_SYMBOL(__get_user_pages_unlocked);
>  long get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
>  			     int write, int force, struct page **pages)
>  {
> +	unsigned int flags = FOLL_TOUCH;
> +
> +	if (write)
> +		flags |= FOLL_WRITE;
> +	if (force)
> +		flags |= FOLL_FORCE;
> +
>  	return __get_user_pages_unlocked(current, current->mm, start, nr_pages,
> -					 write, force, pages, FOLL_TOUCH);
> +					 pages, flags);
>  }
>  EXPORT_SYMBOL(get_user_pages_unlocked);
>  
> diff --git a/mm/nommu.c b/mm/nommu.c
> index 95daf81..925dcc1 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -185,8 +185,7 @@ EXPORT_SYMBOL(get_user_pages_locked);
>  
>  long __get_user_pages_unlocked(struct task_struct *tsk, struct mm_struct *mm,
>  			       unsigned long start, unsigned long nr_pages,
> -			       int write, int force, struct page **pages,
> -			       unsigned int gup_flags)
> +			       struct page **pages, unsigned int gup_flags)
>  {
>  	long ret;
>  	down_read(&mm->mmap_sem);
> @@ -200,8 +199,15 @@ EXPORT_SYMBOL(__get_user_pages_unlocked);
>  long get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
>  			     int write, int force, struct page **pages)
>  {
> +	unsigned int flags = 0;
> +
> +	if (write)
> +		flags |= FOLL_WRITE;
> +	if (force)
> +		flags |= FOLL_FORCE;
> +
>  	return __get_user_pages_unlocked(current, current->mm, start, nr_pages,
> -					 write, force, pages, 0);
> +					 pages, flags);
>  }
>  EXPORT_SYMBOL(get_user_pages_unlocked);
>  
> diff --git a/mm/process_vm_access.c b/mm/process_vm_access.c
> index 07514d4..be8dc8d 100644
> --- a/mm/process_vm_access.c
> +++ b/mm/process_vm_access.c
> @@ -88,12 +88,16 @@ static int process_vm_rw_single_vec(unsigned long addr,
>  	ssize_t rc = 0;
>  	unsigned long max_pages_per_loop = PVM_MAX_KMALLOC_PAGES
>  		/ sizeof(struct pages *);
> +	unsigned int flags = FOLL_REMOTE;
>  
>  	/* Work out address and page range required */
>  	if (len == 0)
>  		return 0;
>  	nr_pages = (addr + len - 1) / PAGE_SIZE - addr / PAGE_SIZE + 1;
>  
> +	if (vm_write)
> +		flags |= FOLL_WRITE;
> +
>  	while (!rc && nr_pages && iov_iter_count(iter)) {
>  		int pages = min(nr_pages, max_pages_per_loop);
>  		size_t bytes;
> @@ -104,8 +108,7 @@ static int process_vm_rw_single_vec(unsigned long addr,
>  		 * current/current->mm
>  		 */
>  		pages = __get_user_pages_unlocked(task, mm, pa, pages,
> -						  vm_write, 0, process_pages,
> -						  FOLL_REMOTE);
> +						  process_pages, flags);
>  		if (pages <= 0)
>  			return -EFAULT;
>  
> diff --git a/virt/kvm/async_pf.c b/virt/kvm/async_pf.c
> index db96688..8035cc1 100644
> --- a/virt/kvm/async_pf.c
> +++ b/virt/kvm/async_pf.c
> @@ -84,7 +84,8 @@ static void async_pf_execute(struct work_struct *work)
>  	 * mm and might be done in another context, so we must
>  	 * use FOLL_REMOTE.
>  	 */
> -	__get_user_pages_unlocked(NULL, mm, addr, 1, 1, 0, NULL, FOLL_REMOTE);
> +	__get_user_pages_unlocked(NULL, mm, addr, 1, NULL,
> +			FOLL_WRITE | FOLL_REMOTE);
>  
>  	kvm_async_page_present_sync(vcpu, apf);
>  
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 81dfc73..28510e7 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1416,10 +1416,15 @@ static int hva_to_pfn_slow(unsigned long addr, bool *async, bool write_fault,
>  		down_read(&current->mm->mmap_sem);
>  		npages = get_user_page_nowait(addr, write_fault, page);
>  		up_read(&current->mm->mmap_sem);
> -	} else
> +	} else {
> +		unsigned int flags = FOLL_TOUCH | FOLL_HWPOISON;
> +
> +		if (write_fault)
> +			flags |= FOLL_WRITE;
> +
>  		npages = __get_user_pages_unlocked(current, current->mm, addr, 1,
> -						   write_fault, 0, page,
> -						   FOLL_TOUCH|FOLL_HWPOISON);
> +						   page, flags);
> +	}
>  	if (npages != 1)
>  		return npages;
>  
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>
