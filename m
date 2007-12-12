Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Dec 2007 17:10:44 +0000 (GMT)
Received: from host188-210-dynamic.20-79-r.retail.telecomitalia.it ([79.20.210.188]:18579
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S20034423AbXLLRKf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 12 Dec 2007 17:10:35 +0000
Received: from 89-96-243-184.ip14.fastwebnet.it ([89.96.243.184] helo=[192.168.215.30])
	by eppesuigoccas.homedns.org with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1J2V6C-00062n-GP; Wed, 12 Dec 2007 18:10:22 +0100
Subject: Re: 2.6.24-rc2 crash in kmap_coherent
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Florian Lohoff <flo@rfc822.org>, linux-mips@linux-mips.org,
	David Daney <ddaney@avtrex.com>
In-Reply-To: <20071212153218.GA30291@linux-mips.org>
References: <20071211221327.GB2150@paradigm.rfc822.org>
	 <20071212120610.GB28868@linux-mips.org>
	 <20071212153218.GA30291@linux-mips.org>
Content-Type: text/plain
Date:	Wed, 12 Dec 2007 18:11:11 +0100
Message-Id: <1197479471.25499.48.camel@scarafaggio>
Mime-Version: 1.0
X-Mailer: Evolution 2.10.3 
Content-Transfer-Encoding: 7bit
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17792
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

Hi Ralf,
the change you proposed here give an error since "page" is onlt
available on function copy_user_highpage() while there is not such
variable (nor parameter) in function copy_to_user_page().

I am actually recompiling everything using only the first part of your
patch, but I think it will not be enough.

Bye,
Giuseppe

Il giorno mer, 12/12/2007 alle 15.32 +0000, Ralf Baechle ha scritto:
[...]
> Totally untested because I have other stuff to do but something along the
> lines of below patch, I think.
> 
>   Ralf
> 
> diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
> index 480dec0..db5d608 100644
> --- a/arch/mips/mm/init.c
> +++ b/arch/mips/mm/init.c
> @@ -211,7 +211,8 @@ void copy_user_highpage(struct page *to, struct page *from,
>  	void *vfrom, *vto;
>  
>  	vto = kmap_atomic(to, KM_USER1);
> -	if (cpu_has_dc_aliases && page_mapped(from)) {
> +	if (cpu_has_dc_aliases &&
> +	    page_mapped(from) && !Page_dcache_dirty(from)) {
>  		vfrom = kmap_coherent(from, vaddr);
>  		copy_page(vto, vfrom);
>  		kunmap_coherent();
> @@ -234,7 +235,8 @@ void copy_to_user_page(struct vm_area_struct *vma,
>  	struct page *page, unsigned long vaddr, void *dst, const void *src,
>  	unsigned long len)
>  {
> -	if (cpu_has_dc_aliases && page_mapped(page)) {
> +	if (cpu_has_dc_aliases &&
> +	    page_mapped(page) && !Page_dcache_dirty(from)) {
>  		void *vto = kmap_coherent(page, vaddr) + (vaddr & ~PAGE_MASK);
>  		memcpy(vto, src, len);
>  		kunmap_coherent();
> @@ -253,7 +255,8 @@ void copy_from_user_page(struct vm_area_struct *vma,
>  	struct page *page, unsigned long vaddr, void *dst, const void *src,
>  	unsigned long len)
>  {
> -	if (cpu_has_dc_aliases && page_mapped(page)) {
> +	if (cpu_has_dc_aliases &&
> +	    page_mapped(page) && !Page_dcache_dirty(page)) {
>  		void *vfrom = kmap_coherent(page, vaddr) + (vaddr & ~PAGE_MASK);
>  		memcpy(dst, vfrom, len);
>  		kunmap_coherent();
> 
> 
