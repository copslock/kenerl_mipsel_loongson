Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Jan 2012 04:25:57 +0100 (CET)
Received: from mail.windriver.com ([147.11.1.11]:62234 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1901161Ab2AUDZu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 Jan 2012 04:25:50 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
        by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q0L3PSRL004771
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Fri, 20 Jan 2012 19:25:29 -0800 (PST)
Received: from [128.224.162.181] (128.224.162.181) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server id 14.1.255.0; Fri, 20 Jan 2012
 19:25:28 -0800
Message-ID: <4F1A2F96.2040106@windriver.com>
Date:   Sat, 21 Jan 2012 11:23:02 +0800
From:   Zumeng Chen <zumeng.chen@windriver.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.24) Gecko/20111108 Lightning/1.0b2 Thunderbird/3.1.16
MIME-Version: 1.0
To:     <linux-mm@kvack.org>, <linux-mips@linux-mips.org>
CC:     <linux-kernel@vger.kernel.org>, <torvalds@linux-foundation.org>,
        <mingo@elte.hu>, <ralf@linux-mips.org>, <bruce.ashfield@gmail.com>
Subject: Re: [PATCH 1/1] mm: msync: fix issues of sys_msync on tmpfs
References: <1327036719-1965-1-git-send-email-zumeng.chen@windriver.com>
In-Reply-To: <1327036719-1965-1-git-send-email-zumeng.chen@windriver.com>
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-archive-position: 32294
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zumeng.chen@windriver.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

To: linux-mm@kvack.org, and linux-mips@linux-mips.org

于 2012年01月20日 13:18, Zumeng Chen 写道:
> This patch fixes two issues as follows:
>
> For some filesystem with fsync == noop_fsync, there is not so much thing
> to do, so sys_msync just passes by for all arches but some CPUs.
>
> For some CPUs with cache aliases(dmesg|grep alias), it maybe has an issue,
> which reported by msync test suites in ltp-full when the memory of memset
> used by msync01 runs into cache alias randomly.
>
> Consider the following scenario used by msync01 in ltp-full:
>   fildes = open(TEMPFILE, O_RDWR | O_CREAT, 0666)) < 0);
>   .../* initialization fildes by write(fildes); */
>   addr = mmap(0, page_sz, PROT_READ | PROT_WRITE, MAP_FILE | MAP_SHARED,
> 	 fildes, 0);
>   /* set buf with memset */
>   memset(addr + OFFSET_1, 1, BUF_SIZE);
>
>   /* msync the addr before using, or MS_SYNC*/
>   msync(addr, page_sz, MS_ASYNC)
>
>   /* Tries to read fildes */
>   lseek(fildes, (off_t) OFFSET_1, SEEK_SET) != (off_t) OFFSET_1) {
>   nread = read(fildes, read_buf, sizeof(read_buf));
>
>   /* Then test the result */
>   if (read_buf[count] != 1) {
>
> The test result is random too for CPUs with cache alias. So in this
> situation, we have to flush the related vma to make sure the read is
> correct.
>
> Signed-off-by: Zumeng Chen <zumeng.chen@windriver.com>
> ---
>  mm/msync.c |   30 ++++++++++++++++++++++++++++++
>  1 files changed, 30 insertions(+), 0 deletions(-)
>
> diff --git a/mm/msync.c b/mm/msync.c
> index 632df45..0021a7e 100644
> --- a/mm/msync.c
> +++ b/mm/msync.c
> @@ -13,6 +13,14 @@
>  #include <linux/file.h>
>  #include <linux/syscalls.h>
>  #include <linux/sched.h>
> +#include <asm/cacheflush.h>
> +
> +/* Cache aliases should be taken into accounts when msync. */
> +#ifdef cpu_has_dc_aliases
> +#define CPU_HAS_CACHE_ALIAS cpu_has_dc_aliases
> +#else
> +#define CPU_HAS_CACHE_ALIAS 0
> +#endif
>  
>  /*
>   * MS_SYNC syncs the entire file - including mappings.
> @@ -78,6 +86,28 @@ SYSCALL_DEFINE3(msync, unsigned long, start, size_t, len, int, flags)
>  		}
>  		file = vma->vm_file;
>  		start = vma->vm_end;
> +
> +		/*
> +		 * For some filesystems with fsync == noop_fsync, msync just
> +		 * passes by but some CPUs.
> +		 * For CPUs with cache alias, msync has to flush the related
> +		 * vma explicitly to make sure data coherency between memory
> +		 * and cache, which includes MS_SYNC or MS_ASYNC. That is to
> +		 * say, cache aliases should not be an async factor, so does
> +		 * msync on other arches without cache aliases.
> +		 */
> +		if (file && file->f_op && file->f_op->fsync == noop_fsync) {
> +			if (CPU_HAS_CACHE_ALIAS)
> +				flush_cache_range(vma, vma->vm_start,
> +							vma->vm_end);
> +			if (start >= end) {
> +				error = 0;
> +				goto out_unlock;
> +			}
> +			vma = find_vma(mm, start);
> +			continue;
> +		}
> +
>  		if ((flags & MS_SYNC) && file &&
>  				(vma->vm_flags & VM_SHARED)) {
>  			get_file(file);
