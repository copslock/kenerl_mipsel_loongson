Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 May 2009 09:56:04 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:57867 "EHLO lemote.com"
	rhost-flags-FAIL-FAIL-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20023943AbZEHIz6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 8 May 2009 09:55:58 +0100
Received: from localhost (localhost [127.0.0.1])
	by lemote.com (Postfix) with ESMTP id 26EFB34121;
	Fri,  8 May 2009 16:51:36 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from lemote.com ([127.0.0.1])
	by localhost (www.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VJYmakHlR+aN; Fri,  8 May 2009 16:51:30 +0800 (CST)
Received: from [172.16.1.226] (unknown [222.92.8.142])
	by lemote.com (Postfix) with ESMTP id BF71C34120;
	Fri,  8 May 2009 16:51:30 +0800 (CST)
Subject: Re: [PATCH 3/3] MIPS: handle write_combine in pci_mmap_page_range
From:	yanh <yanh@lemote.com>
Reply-To: yanh@lemote.com
To:	Zhang Le <r0bertz@gentoo.org>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <a892c7470d85f9563cc74c766fb4dd7f2fa0b801.1241764065.git.r0bertz@gentoo.org>
References: <cover.1241764064.git.r0bertz@gentoo.org>
	 <a1356a5b181a188435ff569b4f7abe57cf8fd7eb.1241764065.git.r0bertz@gentoo.org>
	 <fb705e2eb405eea04853ae53639457a295a7dd90.1241764065.git.r0bertz@gentoo.org>
	 <a892c7470d85f9563cc74c766fb4dd7f2fa0b801.1241764065.git.r0bertz@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Date:	Fri, 08 May 2009 16:54:47 +0800
Message-Id: <1241772887.9177.139.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.1 (2.24.1-2.fc10) 
Content-Transfer-Encoding: 8bit
Return-Path: <yanh@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22667
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yanh@lemote.com
Precedence: bulk
X-list: linux-mips


在 2009-05-08五的 14:30 +0800，Zhang Le写道：
> Signed-off-by: Zhang Le <r0bertz@gentoo.org>
> ---
>  arch/mips/pci/pci.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
> index b0eb9e7..4ca53ef 100644
> --- a/arch/mips/pci/pci.c
> +++ b/arch/mips/pci/pci.c
> @@ -346,10 +346,14 @@ int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
>  		return -EINVAL;
>  
>  	/*
> -	 * Ignore write-combine; for now only return uncached mappings.
> +	 * For write-combine, return uncached accelerated mappings if CPU
> +	 * supports; otherwise, return uncached mappings.
>  	 */
>  	prot = pgprot_val(vma->vm_page_prot);
> -	prot = (prot & ~_CACHE_MASK) | _CACHE_UNCACHED;
> +	if (write_combine && cpu_has_uncached_accelerated)
> +		prot = (prot & ~_CACHE_MASK) | _CACHE_UNCACHED_ACCELERATED;
> +	else
> +		prot = (prot & ~_CACHE_MASK) | _CACHE_UNCACHED;
>  	vma->vm_page_prot = __pgprot(prot);
This should be definietely wrong for MMIOs.
uncache accelleration should only be enabled for addresses which have no
side effect when doing write combine such as video memory.
>  
>  	return remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
