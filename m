Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jul 2018 21:13:22 +0200 (CEST)
Received: from aserp2130.oracle.com ([141.146.126.79]:52954 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992279AbeGZTNSTX6CU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Jul 2018 21:13:18 +0200
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6QJBUV6137109;
        Thu, 26 Jul 2018 19:12:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=wQQk0mpr625mfR8WiZSKVICv2kjWoNOcAHdaIiYlrlA=;
 b=4SzkTIymCbkW+mEYXyHuFcxaaU9gYWen1zNWtNdYoWBKjv/Bzlr5HoNaiQYwtpBU+6Ev
 cEFd+5UKLMzPeepCjHdfbaXRNIMbDlWzClDB3tORgZxMBTjaOXXq6t8ZoF8hYqN2R5aI
 muxiP20v7SXJI5nusF4uWI2MWajFUwzXiwfbqutfdjDqiaAKzV9jit7QRG3mnZVQlZMZ
 LBtLAGTurigkVNSYyv15VuaXQuKyDhKDO7VUy1V+1u9h2F/K2ltvC+bQunZXQ2/dpj75
 oZSutKx2V3gEdGc4AasNNYg/9Aq57TXvtFydRjgbS9b2YFboiQ9gnScYHhbhQ6M2rYNo NA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2kbtbd4ku2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jul 2018 19:12:40 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6QJCdJv031607
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jul 2018 19:12:39 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6QJCcN5013259;
        Thu, 26 Jul 2018 19:12:38 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 26 Jul 2018 12:12:38 -0700
Subject: Re: [PATCH v4 10/11] hugetlb: Introduce generic version of
 huge_ptep_set_access_flags
To:     Alexandre Ghiti <alex@ghiti.fr>, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, tony.luck@intel.com,
        fenghua.yu@intel.com, ralf@linux-mips.org, paul.burton@mips.com,
        jhogan@kernel.org, jejb@parisc-linux.org, deller@gmx.de,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org
References: <20180705110716.3919-1-alex@ghiti.fr>
 <20180705110716.3919-11-alex@ghiti.fr>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <ff7be1ec-be87-1691-93d4-8c055b93d054@oracle.com>
Date:   Thu, 26 Jul 2018 12:12:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180705110716.3919-11-alex@ghiti.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8966 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=919
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807260196
Return-Path: <mike.kravetz@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65180
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mike.kravetz@oracle.com
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

On 07/05/2018 04:07 AM, Alexandre Ghiti wrote:
> arm, ia64, sh, x86 architectures use the same version
> of huge_ptep_set_access_flags, so move this generic implementation
> into asm-generic/hugetlb.h.
> 

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  arch/arm/include/asm/hugetlb-3level.h | 7 -------
>  arch/arm64/include/asm/hugetlb.h      | 1 +
>  arch/ia64/include/asm/hugetlb.h       | 7 -------
>  arch/mips/include/asm/hugetlb.h       | 1 +
>  arch/parisc/include/asm/hugetlb.h     | 1 +
>  arch/powerpc/include/asm/hugetlb.h    | 1 +
>  arch/sh/include/asm/hugetlb.h         | 7 -------
>  arch/sparc/include/asm/hugetlb.h      | 1 +
>  arch/x86/include/asm/hugetlb.h        | 7 -------
>  include/asm-generic/hugetlb.h         | 9 +++++++++
>  10 files changed, 14 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/arm/include/asm/hugetlb-3level.h b/arch/arm/include/asm/hugetlb-3level.h
> index 8247cd6a2ac6..54e4b097b1f5 100644
> --- a/arch/arm/include/asm/hugetlb-3level.h
> +++ b/arch/arm/include/asm/hugetlb-3level.h
> @@ -37,11 +37,4 @@ static inline pte_t huge_ptep_get(pte_t *ptep)
>  	return retval;
>  }
>  
> -static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
> -					     unsigned long addr, pte_t *ptep,
> -					     pte_t pte, int dirty)
> -{
> -	return ptep_set_access_flags(vma, addr, ptep, pte, dirty);
> -}
> -
>  #endif /* _ASM_ARM_HUGETLB_3LEVEL_H */
> diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
> index f4f69ae5466e..80887abcef7f 100644
> --- a/arch/arm64/include/asm/hugetlb.h
> +++ b/arch/arm64/include/asm/hugetlb.h
> @@ -42,6 +42,7 @@ extern pte_t arch_make_huge_pte(pte_t entry, struct vm_area_struct *vma,
>  #define __HAVE_ARCH_HUGE_SET_HUGE_PTE_AT
>  extern void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
>  			    pte_t *ptep, pte_t pte);
> +#define __HAVE_ARCH_HUGE_PTEP_SET_ACCESS_FLAGS
>  extern int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>  				      unsigned long addr, pte_t *ptep,
>  				      pte_t pte, int dirty);
> diff --git a/arch/ia64/include/asm/hugetlb.h b/arch/ia64/include/asm/hugetlb.h
> index 49d1f7949f3a..e9b42750fdf5 100644
> --- a/arch/ia64/include/asm/hugetlb.h
> +++ b/arch/ia64/include/asm/hugetlb.h
> @@ -27,13 +27,6 @@ static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
>  {
>  }
>  
> -static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
> -					     unsigned long addr, pte_t *ptep,
> -					     pte_t pte, int dirty)
> -{
> -	return ptep_set_access_flags(vma, addr, ptep, pte, dirty);
> -}
> -
>  static inline pte_t huge_ptep_get(pte_t *ptep)
>  {
>  	return *ptep;
> diff --git a/arch/mips/include/asm/hugetlb.h b/arch/mips/include/asm/hugetlb.h
> index 3dcf5debf8c4..120adc3b2ffd 100644
> --- a/arch/mips/include/asm/hugetlb.h
> +++ b/arch/mips/include/asm/hugetlb.h
> @@ -63,6 +63,7 @@ static inline int huge_pte_none(pte_t pte)
>  	return !val || (val == (unsigned long)invalid_pte_table);
>  }
>  
> +#define __HAVE_ARCH_HUGE_PTEP_SET_ACCESS_FLAGS
>  static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>  					     unsigned long addr,
>  					     pte_t *ptep, pte_t pte,
> diff --git a/arch/parisc/include/asm/hugetlb.h b/arch/parisc/include/asm/hugetlb.h
> index 9c3950ca2974..165b4e5a6f32 100644
> --- a/arch/parisc/include/asm/hugetlb.h
> +++ b/arch/parisc/include/asm/hugetlb.h
> @@ -43,6 +43,7 @@ static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
>  void huge_ptep_set_wrprotect(struct mm_struct *mm,
>  					   unsigned long addr, pte_t *ptep);
>  
> +#define __HAVE_ARCH_HUGE_PTEP_SET_ACCESS_FLAGS
>  int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>  					     unsigned long addr, pte_t *ptep,
>  					     pte_t pte, int dirty);
> diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
> index 69c14ecac133..658bf7136a3c 100644
> --- a/arch/powerpc/include/asm/hugetlb.h
> +++ b/arch/powerpc/include/asm/hugetlb.h
> @@ -137,6 +137,7 @@ static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
>  	flush_hugetlb_page(vma, addr);
>  }
>  
> +#define __HAVE_ARCH_HUGE_PTEP_SET_ACCESS_FLAGS
>  extern int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>  				      unsigned long addr, pte_t *ptep,
>  				      pte_t pte, int dirty);
> diff --git a/arch/sh/include/asm/hugetlb.h b/arch/sh/include/asm/hugetlb.h
> index 8df4004977b9..c87195ae0cfa 100644
> --- a/arch/sh/include/asm/hugetlb.h
> +++ b/arch/sh/include/asm/hugetlb.h
> @@ -32,13 +32,6 @@ static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
>  {
>  }
>  
> -static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
> -					     unsigned long addr, pte_t *ptep,
> -					     pte_t pte, int dirty)
> -{
> -	return ptep_set_access_flags(vma, addr, ptep, pte, dirty);
> -}
> -
>  static inline pte_t huge_ptep_get(pte_t *ptep)
>  {
>  	return *ptep;
> diff --git a/arch/sparc/include/asm/hugetlb.h b/arch/sparc/include/asm/hugetlb.h
> index c41754a113f3..028a1465fbe7 100644
> --- a/arch/sparc/include/asm/hugetlb.h
> +++ b/arch/sparc/include/asm/hugetlb.h
> @@ -40,6 +40,7 @@ static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
>  	set_huge_pte_at(mm, addr, ptep, pte_wrprotect(old_pte));
>  }
>  
> +#define __HAVE_ARCH_HUGE_PTEP_SET_ACCESS_FLAGS
>  static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>  					     unsigned long addr, pte_t *ptep,
>  					     pte_t pte, int dirty)
> diff --git a/arch/x86/include/asm/hugetlb.h b/arch/x86/include/asm/hugetlb.h
> index de370836a17d..1df8944904c6 100644
> --- a/arch/x86/include/asm/hugetlb.h
> +++ b/arch/x86/include/asm/hugetlb.h
> @@ -12,13 +12,6 @@ static inline int is_hugepage_only_range(struct mm_struct *mm,
>  	return 0;
>  }
>  
> -static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
> -					     unsigned long addr, pte_t *ptep,
> -					     pte_t pte, int dirty)
> -{
> -	return ptep_set_access_flags(vma, addr, ptep, pte, dirty);
> -}
> -
>  static inline pte_t huge_ptep_get(pte_t *ptep)
>  {
>  	return *ptep;
> diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
> index 9b9039845278..f3c99a03ee83 100644
> --- a/include/asm-generic/hugetlb.h
> +++ b/include/asm-generic/hugetlb.h
> @@ -110,4 +110,13 @@ static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
>  }
>  #endif
>  
> +#ifndef __HAVE_ARCH_HUGE_PTEP_SET_ACCESS_FLAGS
> +static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
> +		unsigned long addr, pte_t *ptep,
> +		pte_t pte, int dirty)
> +{
> +	return ptep_set_access_flags(vma, addr, ptep, pte, dirty);
> +}
> +#endif
> +
>  #endif /* _ASM_GENERIC_HUGETLB_H */
> 
