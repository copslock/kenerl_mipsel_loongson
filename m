Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Sep 2012 23:16:45 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:62288 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903404Ab2IEVQi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Sep 2012 23:16:38 +0200
Received: by dajq27 with SMTP id q27so626477daj.36
        for <multiple recipients>; Wed, 05 Sep 2012 14:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=n2eRk8HJy2h72mDlo+FubrdGL0u0T85eA3044U9Jq6Q=;
        b=pKh8x5anbWiNzLcx9ExV41bhagc2k6DESwk8OTKWWbXRQaQEHmQHM4oa/1tkzdN8O/
         OL10yR3BkseEQ3Kt7CXgr4kxkTlXjR9b7stK2vCG0/wOeUuTzLdLUStVu1859Cq8Z7X/
         ahoFG91AhQ9AMoByR74NCweMN7hMAldd824GmPXUyPc6olgJlyi/I7a6KhpGUlIOfNHH
         Rpxudte1gpciLBLqN4w+vkZumbY+xjGeG9iqG1jihivDC5Qk+Lwch0ekc3GiN+ih8alz
         Yb0VgTauuPOiRjd8fPBmlNZ0mU+ZMv9ZXvBkLGX1ufRWHo6G8yEj+NPe+YiOz2ODDxgX
         6JJA==
Received: by 10.66.76.106 with SMTP id j10mr51420087paw.51.1346879791280;
        Wed, 05 Sep 2012 14:16:31 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id kt2sm149300pbc.73.2012.09.05.14.16.29
        (version=SSLv3 cipher=OTHER);
        Wed, 05 Sep 2012 14:16:30 -0700 (PDT)
Message-ID: <5047C12B.9030002@gmail.com>
Date:   Wed, 05 Sep 2012 14:16:27 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120828 Thunderbird/15.0
MIME-Version: 1.0
To:     "Steven J. Hill" <sjhill@mips.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 3/4] MIPS: Remove kernel_uses_smartmips_rixi from page
 table bits.
References: <1346876878-25965-1-git-send-email-sjhill@mips.com> <1346876878-25965-4-git-send-email-sjhill@mips.com>
In-Reply-To: <1346876878-25965-4-git-send-email-sjhill@mips.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 34425
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 09/05/2012 01:27 PM, Steven J. Hill wrote:
> From: "Steven J. Hill" <sjhill@mips.com>
>
> Remove usage of the 'kernel_uses_smartmips_rixi' macro from all the
> page table bit definitions in 'arch/mips/include/asm' directory.
>
> Signed-off-by: Steven J. Hill <sjhill@mips.com>
> ---
>   arch/mips/include/asm/pgtable-bits.h |   24 ++++++++++++++----------
>   arch/mips/include/asm/pgtable.h      |   12 ++++++------
>   2 files changed, 20 insertions(+), 16 deletions(-)
>
> diff --git a/arch/mips/include/asm/pgtable-bits.h b/arch/mips/include/asm/pgtable-bits.h
> index e9fe7e9..c266cba 100644
> --- a/arch/mips/include/asm/pgtable-bits.h
> +++ b/arch/mips/include/asm/pgtable-bits.h
> @@ -79,9 +79,9 @@
>   /* implemented in software */
>   #define _PAGE_PRESENT_SHIFT	(0)
>   #define _PAGE_PRESENT		(1 << _PAGE_PRESENT_SHIFT)
> -/* implemented in software, should be unused if kernel_uses_smartmips_rixi. */
> -#define _PAGE_READ_SHIFT	(kernel_uses_smartmips_rixi ? _PAGE_PRESENT_SHIFT : _PAGE_PRESENT_SHIFT + 1)
> -#define _PAGE_READ ({if (kernel_uses_smartmips_rixi) BUG(); 1 << _PAGE_READ_SHIFT; })
> +/* implemented in software, should be unused if cpu_has_ri. */
> +#define _PAGE_READ_SHIFT	(cpu_has_ri ? _PAGE_PRESENT_SHIFT + 1: _PAGE_PRESENT_SHIFT)

As per IRC discussion, it would be nice if the shift value were not 
dependent on runtime values (cpu_has_ri)

See this thread for ideas about this:

http://www.linux-mips.org/archives/linux-mips/2011-04/msg00102.html

> +#define _PAGE_READ ({if (!cpu_has_ri) BUG(); 1 << _PAGE_READ_SHIFT; })
>   /* implemented in software */
>   #define _PAGE_WRITE_SHIFT	(_PAGE_READ_SHIFT + 1)
>   #define _PAGE_WRITE		(1 << _PAGE_WRITE_SHIFT)
> @@ -104,12 +104,12 @@
>   #endif
>
>   /* Page cannot be executed */
> -#define _PAGE_NO_EXEC_SHIFT	(kernel_uses_smartmips_rixi ? _PAGE_HUGE_SHIFT + 1 : _PAGE_HUGE_SHIFT)
> -#define _PAGE_NO_EXEC		({if (!kernel_uses_smartmips_rixi) BUG(); 1 << _PAGE_NO_EXEC_SHIFT; })
> +#define _PAGE_NO_EXEC_SHIFT	(cpu_has_xi ? _PAGE_HUGE_SHIFT + 1 : _PAGE_HUGE_SHIFT)
> +#define _PAGE_NO_EXEC		({if (!cpu_has_xi) BUG(); 1 << _PAGE_NO_EXEC_SHIFT; })
>
>   /* Page cannot be read */
> -#define _PAGE_NO_READ_SHIFT	(kernel_uses_smartmips_rixi ? _PAGE_NO_EXEC_SHIFT + 1 : _PAGE_NO_EXEC_SHIFT)
> -#define _PAGE_NO_READ		({if (!kernel_uses_smartmips_rixi) BUG(); 1 << _PAGE_NO_READ_SHIFT; })
> +#define _PAGE_NO_READ_SHIFT	(cpu_has_ri ? _PAGE_NO_EXEC_SHIFT + 1 : _PAGE_NO_EXEC_SHIFT)
> +#define _PAGE_NO_READ		({if (!cpu_has_ri) BUG(); 1 << _PAGE_NO_READ_SHIFT; })
>
>   #define _PAGE_GLOBAL_SHIFT	(_PAGE_NO_READ_SHIFT + 1)
>   #define _PAGE_GLOBAL		(1 << _PAGE_GLOBAL_SHIFT)
> @@ -155,20 +155,24 @@
>    */
>   static inline uint64_t pte_to_entrylo(unsigned long pte_val)
>   {
> -	if (kernel_uses_smartmips_rixi) {
> +	if (cpu_has_ri | cpu_has_xi) {
> +		unsigned long rixi;
>   		int sa;
>   #ifdef CONFIG_32BIT
>   		sa = 31 - _PAGE_NO_READ_SHIFT;
>   #else
>   		sa = 63 - _PAGE_NO_READ_SHIFT;
>   #endif
> +		rixi = ((cpu_has_ri ? _PAGE_NO_READ : 0) |
> +			(cpu_has_xi ? _PAGE_NO_EXEC : 0));
> +
>   		/*
>   		 * C has no way to express that this is a DSRL
>   		 * _PAGE_NO_EXEC_SHIFT followed by a ROTR 2.  Luckily
>   		 * in the fast path this is done in assembly
>   		 */
>   		return (pte_val >> _PAGE_GLOBAL_SHIFT) |
> -			((pte_val & (_PAGE_NO_EXEC | _PAGE_NO_READ)) << sa);
> +			 ((pte_val & rixi) << sa);
>   	}
>
>   	return pte_val >> _PAGE_GLOBAL_SHIFT;
> @@ -220,7 +224,7 @@ static inline uint64_t pte_to_entrylo(unsigned long pte_val)
>
>   #endif
>
> -#define __READABLE	(_PAGE_SILENT_READ | _PAGE_ACCESSED | (kernel_uses_smartmips_rixi ? 0 : _PAGE_READ))
> +#define __READABLE	(_PAGE_SILENT_READ | _PAGE_ACCESSED | (cpu_has_ri ? 0 : _PAGE_READ))
>   #define __WRITEABLE	(_PAGE_WRITE | _PAGE_SILENT_WRITE | _PAGE_MODIFIED)
>
>   #define _PAGE_CHG_MASK  (_PFN_MASK | _PAGE_ACCESSED | _PAGE_MODIFIED | _CACHE_MASK)
> diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
> index b2202a6..748aa6a 100644
> --- a/arch/mips/include/asm/pgtable.h
> +++ b/arch/mips/include/asm/pgtable.h
> @@ -22,15 +22,15 @@ struct mm_struct;
>   struct vm_area_struct;
>
>   #define PAGE_NONE	__pgprot(_PAGE_PRESENT | _CACHE_CACHABLE_NONCOHERENT)
> -#define PAGE_SHARED	__pgprot(_PAGE_PRESENT | _PAGE_WRITE | (kernel_uses_smartmips_rixi ? 0 : _PAGE_READ) | \
> +#define PAGE_SHARED	__pgprot(_PAGE_PRESENT | _PAGE_WRITE | (cpu_has_ri ? 0 : _PAGE_READ) | \
>   				 _page_cachable_default)
> -#define PAGE_COPY	__pgprot(_PAGE_PRESENT | (kernel_uses_smartmips_rixi ? 0 : _PAGE_READ) | \
> -				 (kernel_uses_smartmips_rixi ?  _PAGE_NO_EXEC : 0) | _page_cachable_default)
> -#define PAGE_READONLY	__pgprot(_PAGE_PRESENT | (kernel_uses_smartmips_rixi ? 0 : _PAGE_READ) | \
> +#define PAGE_COPY	__pgprot(_PAGE_PRESENT | (cpu_has_ri ? 0 : _PAGE_READ) | \
> +				 (cpu_has_xi ? _PAGE_NO_EXEC : 0) | _page_cachable_default)
> +#define PAGE_READONLY	__pgprot(_PAGE_PRESENT | (cpu_has_ri ? 0 : _PAGE_READ) | \
>   				 _page_cachable_default)
>   #define PAGE_KERNEL	__pgprot(_PAGE_PRESENT | __READABLE | __WRITEABLE | \
>   				 _PAGE_GLOBAL | _page_cachable_default)
> -#define PAGE_USERIO	__pgprot(_PAGE_PRESENT | (kernel_uses_smartmips_rixi ? 0 : _PAGE_READ) | _PAGE_WRITE | \
> +#define PAGE_USERIO	__pgprot(_PAGE_PRESENT | (cpu_has_ri ? 0 : _PAGE_READ) | _PAGE_WRITE | \
>   				 _page_cachable_default)
>   #define PAGE_KERNEL_UNCACHED __pgprot(_PAGE_PRESENT | __READABLE | \
>   			__WRITEABLE | _PAGE_GLOBAL | _CACHE_UNCACHED)
> @@ -299,7 +299,7 @@ static inline pte_t pte_mkdirty(pte_t pte)
>   static inline pte_t pte_mkyoung(pte_t pte)
>   {
>   	pte_val(pte) |= _PAGE_ACCESSED;
> -	if (kernel_uses_smartmips_rixi) {
> +	if (cpu_has_ri) {
>   		if (!(pte_val(pte) & _PAGE_NO_READ))
>   			pte_val(pte) |= _PAGE_SILENT_READ;
>   	} else {
>
