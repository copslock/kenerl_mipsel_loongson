Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jul 2018 21:04:13 +0200 (CEST)
Received: from userp2130.oracle.com ([156.151.31.86]:60444 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992279AbeGZTEJdJGdU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Jul 2018 21:04:09 +0200
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6QIwc04101605;
        Thu, 26 Jul 2018 19:03:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=XaCKTGgknQiyIleu3JBnhY19yJEG6ouT4JpwQs99P8E=;
 b=xn5xaqFWXTTFBCOqKCk+67RwmxdfyPE6yhSThjjdplOGjW7uzF+J0dv5vqSagM2PjJoT
 qq5p/XGXheMbz/r2XVbnYHRks4ng90s8XJZJEZPNhGfCb42QPRfbVCeCkU/pXZ08xcqT
 ehvr/jI8QGgXL+Uk8UoRzq2qKtSljDAeG1lBen0GYk9qirz3kwSfKfA9+qqybL4U8iml
 IdBquapmXxaP3gMeLwwjsOa+586wKeKwwZE2DjXNahV2yTyhg7XSZQ8PkBCL7pRWuOf2
 llOoqydgMQdFYxpJ5DCHuIRnORQLl+59P7zuO/ndaA15KVVUmxIYVYPSycZncyDaTxTR Nw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2kbv8tcfgh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jul 2018 19:03:35 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6QJ3Yf0026750
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jul 2018 19:03:34 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6QJ3TnC012231;
        Thu, 26 Jul 2018 19:03:29 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 26 Jul 2018 12:03:28 -0700
Subject: Re: [PATCH v4 05/11] hugetlb: Introduce generic version of
 huge_ptep_clear_flush
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
 <20180705110716.3919-6-alex@ghiti.fr>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <fa83effc-c848-59fc-e941-179ee7686b22@oracle.com>
Date:   Thu, 26 Jul 2018 12:03:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180705110716.3919-6-alex@ghiti.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8965 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807260194
Return-Path: <mike.kravetz@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65175
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
> arm, x86 architectures use the same version of
> huge_ptep_clear_flush, so move this generic implementation into
> asm-generic/hugetlb.h.
> 

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  arch/arm/include/asm/hugetlb-3level.h | 6 ------
>  arch/arm64/include/asm/hugetlb.h      | 1 +
>  arch/ia64/include/asm/hugetlb.h       | 1 +
>  arch/mips/include/asm/hugetlb.h       | 1 +
>  arch/parisc/include/asm/hugetlb.h     | 1 +
>  arch/powerpc/include/asm/hugetlb.h    | 1 +
>  arch/sh/include/asm/hugetlb.h         | 1 +
>  arch/sparc/include/asm/hugetlb.h      | 1 +
>  arch/x86/include/asm/hugetlb.h        | 6 ------
>  include/asm-generic/hugetlb.h         | 8 ++++++++
>  10 files changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/include/asm/hugetlb-3level.h b/arch/arm/include/asm/hugetlb-3level.h
> index ad36e84b819a..b897541520ef 100644
> --- a/arch/arm/include/asm/hugetlb-3level.h
> +++ b/arch/arm/include/asm/hugetlb-3level.h
> @@ -37,12 +37,6 @@ static inline pte_t huge_ptep_get(pte_t *ptep)
>  	return retval;
>  }
>  
> -static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
> -					 unsigned long addr, pte_t *ptep)
> -{
> -	ptep_clear_flush(vma, addr, ptep);
> -}
> -
>  static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
>  					   unsigned long addr, pte_t *ptep)
>  {
> diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
> index 6ae0bcafe162..4c8dd488554d 100644
> --- a/arch/arm64/include/asm/hugetlb.h
> +++ b/arch/arm64/include/asm/hugetlb.h
> @@ -71,6 +71,7 @@ extern pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
>  				     unsigned long addr, pte_t *ptep);
>  extern void huge_ptep_set_wrprotect(struct mm_struct *mm,
>  				    unsigned long addr, pte_t *ptep);
> +#define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
>  extern void huge_ptep_clear_flush(struct vm_area_struct *vma,
>  				  unsigned long addr, pte_t *ptep);
>  #define __HAVE_ARCH_HUGE_PTE_CLEAR
> diff --git a/arch/ia64/include/asm/hugetlb.h b/arch/ia64/include/asm/hugetlb.h
> index 6719c74da0de..41b5f6adeee4 100644
> --- a/arch/ia64/include/asm/hugetlb.h
> +++ b/arch/ia64/include/asm/hugetlb.h
> @@ -20,6 +20,7 @@ static inline int is_hugepage_only_range(struct mm_struct *mm,
>  		REGION_NUMBER((addr)+(len)-1) == RGN_HPAGE);
>  }
>  
> +#define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
>  static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
>  					 unsigned long addr, pte_t *ptep)
>  {
> diff --git a/arch/mips/include/asm/hugetlb.h b/arch/mips/include/asm/hugetlb.h
> index 0959cc5a41fa..7df1f116a3cc 100644
> --- a/arch/mips/include/asm/hugetlb.h
> +++ b/arch/mips/include/asm/hugetlb.h
> @@ -48,6 +48,7 @@ static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
>  	return pte;
>  }
>  
> +#define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
>  static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
>  					 unsigned long addr, pte_t *ptep)
>  {
> diff --git a/arch/parisc/include/asm/hugetlb.h b/arch/parisc/include/asm/hugetlb.h
> index 6e281e1bb336..9afff26747a1 100644
> --- a/arch/parisc/include/asm/hugetlb.h
> +++ b/arch/parisc/include/asm/hugetlb.h
> @@ -32,6 +32,7 @@ static inline int prepare_hugepage_range(struct file *file,
>  	return 0;
>  }
>  
> +#define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
>  static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
>  					 unsigned long addr, pte_t *ptep)
>  {
> diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
> index 970101cf9c82..0b02856aa85b 100644
> --- a/arch/powerpc/include/asm/hugetlb.h
> +++ b/arch/powerpc/include/asm/hugetlb.h
> @@ -143,6 +143,7 @@ static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
>  #endif
>  }
>  
> +#define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
>  static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
>  					 unsigned long addr, pte_t *ptep)
>  {
> diff --git a/arch/sh/include/asm/hugetlb.h b/arch/sh/include/asm/hugetlb.h
> index 08ee6c00b5e9..9abf9c86b769 100644
> --- a/arch/sh/include/asm/hugetlb.h
> +++ b/arch/sh/include/asm/hugetlb.h
> @@ -25,6 +25,7 @@ static inline int prepare_hugepage_range(struct file *file,
>  	return 0;
>  }
>  
> +#define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
>  static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
>  					 unsigned long addr, pte_t *ptep)
>  {
> diff --git a/arch/sparc/include/asm/hugetlb.h b/arch/sparc/include/asm/hugetlb.h
> index 944e3a4bfaff..651a9593fcee 100644
> --- a/arch/sparc/include/asm/hugetlb.h
> +++ b/arch/sparc/include/asm/hugetlb.h
> @@ -42,6 +42,7 @@ static inline int prepare_hugepage_range(struct file *file,
>  	return 0;
>  }
>  
> +#define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
>  static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
>  					 unsigned long addr, pte_t *ptep)
>  {
> diff --git a/arch/x86/include/asm/hugetlb.h b/arch/x86/include/asm/hugetlb.h
> index 48b8d9b13cc6..8347d5abf882 100644
> --- a/arch/x86/include/asm/hugetlb.h
> +++ b/arch/x86/include/asm/hugetlb.h
> @@ -27,12 +27,6 @@ static inline int prepare_hugepage_range(struct file *file,
>  	return 0;
>  }
>  
> -static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
> -					 unsigned long addr, pte_t *ptep)
> -{
> -	ptep_clear_flush(vma, addr, ptep);
> -}
> -
>  static inline int huge_pte_none(pte_t pte)
>  {
>  	return pte_none(pte);
> diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
> index 0f6f151780dd..ffa63fd8388d 100644
> --- a/include/asm-generic/hugetlb.h
> +++ b/include/asm-generic/hugetlb.h
> @@ -65,4 +65,12 @@ static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
>  }
>  #endif
>  
> +#ifndef __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
> +static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
> +		unsigned long addr, pte_t *ptep)
> +{
> +	ptep_clear_flush(vma, addr, ptep);
> +}
> +#endif
> +
>  #endif /* _ASM_GENERIC_HUGETLB_H */
> 
