Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Aug 2017 23:34:57 +0200 (CEST)
Received: from mx1.mailbox.org ([80.241.60.212]:39568 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993901AbdHJVeupRSZi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 10 Aug 2017 23:34:50 +0200
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 3E8F7460AB;
        Thu, 10 Aug 2017 23:34:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id Wv4ixm6Fqq9O; Thu, 10 Aug 2017 23:34:43 +0200 (CEST)
Subject: Re: clock_gettime() may return timestamps out of order
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Rene Nielsen <rene.nielsen@microsemi.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
References: <478589358072764BA7A23B82543788A895AD4ECE@avsrvexchmbx1.microsemi.net>
 <1bd4bad1-5574-7b76-0cd7-d0334c08667f@hauke-m.de>
 <20170623213325.GD31455@jhogan-linux.le.imgtec.org>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <cb142670-3e27-e129-f7f9-064037304c52@hauke-m.de>
Date:   Thu, 10 Aug 2017 23:34:42 +0200
MIME-Version: 1.0
In-Reply-To: <20170623213325.GD31455@jhogan-linux.le.imgtec.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59483
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

On 06/23/2017 11:33 PM, James Hogan wrote:
> On Thu, Jun 22, 2017 at 09:32:33PM +0200, Hauke Mehrtens wrote:
>> On 06/21/2017 10:14 AM, Rene Nielsen wrote:
>>> Hi folks,
>>>
>>> Let me go straight into the problem:
>>> We have a multi-threaded application that runs on a MIPS 24KEc using glibc v.
>>> 2.24 under kernel v. 4.9.29 both compiled with gcc v. 6.3.0.
>>> Our 24KEc has a 4-way 32 KBytes dcache (and similar icache), so it's prone to cache
>>> aliasing (don't know if this matters...).
>>>
>>> We want to be able to do stack backtraces from a signal handler in case our
>>> application makes a glibc call that results in an assert(). The stack
>>> backtracing is made within the signal handler with calls to _Unwind_Backtrace().
>>> With the default set of glibc compiler flags, we can't trace through signal
>>> handlers. Not so long ago, we used uclibc rather than glibc, and experienced the
>>> same problem, but we got it to work by enabling the
>>> '-fasynchronous-unwind-tables' gcc flag during compilation of uclibc.
>>> Using the same flag during compilation of glibc causes unexpected runtime
>>> problems:
>>>
>>> Many of the threads in our application call clock_gettime(CLOCK_MONOTONIC) many
>>> times per second, so we greatly appreciate the existence and utilization of the
>>> VDSO.
>>>
>>> Occassionally, however, clock_gettime(CLOCK_MONOTONIC) returns timestamps out of
>>> order on the same thread. It's not that the returned timestamps seem wrong (they
>>> are mostly off by some hundred microseconds), but they simply appear out of
>>> order.
>>>
>>> Since glibc utilizes VDSO (and uclibc doesn't), my guess is that there's
>>> something wrong in the interface between the two, but I can't figure out what.
>>> Other glibc calls seem OK (I don't know whether there's a problem with the other
>>> VDSO function, gettimeofday(), though). If not compiled with the infamous flag,
>>> we don't see this problem.
>>>
>>> I have tried with a single-threaded test-app, but haven't been able to
>>> reproduce.
>>>
>>> Any help is highly appreciated. Don't hesitate to asking questions, if needed.
>>>
>>> Thank you very much in advance,
>>> Best regards,
>>> René Nielsen
>>
>>
>> Hi Rene
>>
>> I had a problem with the clock_gettime() call over VDSO on a MIPS BE
>> 34Kc CPU, see this:
>> https://www.linux-mips.org/archives/linux-mips/2016-01/msg00727.html
>> It was sometimes off by 1 second.
>>
>> It is gone in the current version of LEDE (former OpenWrt), but when I
>> used git bisect to find the place where it was fixed, I found a place
>> which has nothing to do with MIPS internal or libc stuff.
>>
>> Makeing some pages uncached or flushing them help, but caused
>> performance problems, I have never found the root cause of the problem.
> 
> Hauke: Did that platform have aliasing dcache too?
> 
> I notice that the mips_vdso_data is updated by update_vsyscall() via
> kseg0, however userland will be accessing it via the mapping 1 page
> below the VDSO.
> 
> If the kernel data happened to be placed such that the mips_vdso_data in
> kseg0 and the user mapping had different page colours then you could
> easily hit aliasing issues. A couple of well placed flushes or some more
> careful placement of the VDSO data might well fix it, as could some
> random patch changing the positioning of the data such that it
> coincidentally lined up on the same colour.
> 
> Rene: Would you be able to try the following?
> 1) report the values of data_addr and &vdso_data in
> arch_setup_additional_pages() (arch/mips/kernel/vdso.c)
> 2) apply the (completely untested) patch below and see if it helps
> 3) report those two values with the patch applied to check it has worked
> as expected
> 
> The patch unfortunately hacks arch_get_unmapped_area_common so that it
> does the colour alignment on non-shared anonymous pages, as long as
> non-zero pgoff is provided. Hopefully no userland code would try
> mmap'ing anonymous memory with a file offset, and so it should be
> harmless.
> 
> It doesn't look like we can just pass MAP_SHARED to avoid the hack as
> then pgoff will get cleared by get_unmapped_area()).
> 
> Thanks
> James
> 
> diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
> index 093517e85a6c..4840b20a3756 100644
> --- a/arch/mips/kernel/vdso.c
> +++ b/arch/mips/kernel/vdso.c
> @@ -129,7 +129,12 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
>  	vvar_size = gic_size + PAGE_SIZE;
>  	size = vvar_size + image->size;
>  
> -	base = get_unmapped_area(NULL, 0, size, 0, 0);
> +	/*
> +	 * Hack to get the user mapping of the VDSO data page matching the cache
> +	 * colour of its kseg0 address.
> +	 */
> +	base = get_unmapped_area(NULL, 0, size,
> +			(virt_to_phys(&vdso_data) - gic_size) >> PAGE_SHIFT, 0);
>  	if (IS_ERR_VALUE(base)) {
>  		ret = base;
>  		goto out;
> diff --git a/arch/mips/mm/mmap.c b/arch/mips/mm/mmap.c
> index 64dd8bdd92c3..872cf1fd1744 100644
> --- a/arch/mips/mm/mmap.c
> +++ b/arch/mips/mm/mmap.c
> @@ -81,7 +81,7 @@ static unsigned long arch_get_unmapped_area_common(struct file *filp,
>  	}
>  
>  	do_color_align = 0;
> -	if (filp || (flags & MAP_SHARED))
> +	if (filp || (flags & MAP_SHARED) || pgoff)
>  		do_color_align = 1;
>  
>  	/* requesting a specific address */
> 

Hi James,

This patch also solved my problem with VDSO on the Lantiq VR9 SoC.

Could you please send this as a patch for inclusion into the Linux
mainline kernel and also mark it for backporting to to stable.

We deactivated VDSO gettimeofday support for MIPS in LEDE because of
this bug. With VDSO support a ping would show wrong numbers in about 5%
to 50% of the cases on affected SOCs.

Hauke
