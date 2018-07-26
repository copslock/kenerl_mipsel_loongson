Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jul 2018 20:41:58 +0200 (CEST)
Received: from userp2130.oracle.com ([156.151.31.86]:44274 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992279AbeGZSlye7erU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Jul 2018 20:41:54 +0200
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6QIdPtT087581;
        Thu, 26 Jul 2018 18:41:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=XksFvEa4qtN6dX3cv826jX28nJp5tgiVyhdQqP1EueM=;
 b=arOTTObm5bU3L7FnFPFAi+k0mxMFlt2lVFdtVv8b3qrMbrvy7mvaGhKpmuYAxsj+JKdF
 Lw2Ztan3cRSDB3Cs+VdDRXFYG3GJl+yQNUBefXDLQjwb7mcGFaXPokajon1iv1qjF7r4
 DTInn7eSQ84is/jO+3WowudpwGLokKR/OvKEwUtFQQMFVMrxRfwjZczTGdyN8nNTS/BJ
 NLtp32zDFJpiArJO/DduVUy8l5uMyyM6YGr+A+wYd/Tefl2wy0+SgrTAlH6LeqdIX6SX
 0iUfep4eYFpp30hQXjDhVtXA5pusUegFUlDcdgZUq0FImSQCU9OdaZofjPKe0BMjYVgO wQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2kbv8tcd2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jul 2018 18:41:04 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6QIf145018153
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jul 2018 18:41:02 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6QIeqIB023467;
        Thu, 26 Jul 2018 18:40:53 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 26 Jul 2018 11:40:51 -0700
Subject: Re: [PATCH v4 01/11] hugetlb: Harmonize hugetlb.h arch specific
 defines with pgtable.h
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
 <20180705110716.3919-2-alex@ghiti.fr>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <1f95fdc7-378b-9c2a-15ae-da78578a27bf@oracle.com>
Date:   Thu, 26 Jul 2018 11:40:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180705110716.3919-2-alex@ghiti.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8965 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=997
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807260191
Return-Path: <mike.kravetz@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65171
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
> asm-generic/hugetlb.h proposes generic implementations of hugetlb
> related functions: use __HAVE_ARCH_HUGE* defines in order to make arch
> specific implementations of hugetlb functions consistent with pgtable.h
> scheme.
> 

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  arch/arm64/include/asm/hugetlb.h | 2 +-
>  include/asm-generic/hugetlb.h    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
> index e73f68569624..3fcf14663dfa 100644
> --- a/arch/arm64/include/asm/hugetlb.h
> +++ b/arch/arm64/include/asm/hugetlb.h
> @@ -81,9 +81,9 @@ extern void huge_ptep_set_wrprotect(struct mm_struct *mm,
>  				    unsigned long addr, pte_t *ptep);
>  extern void huge_ptep_clear_flush(struct vm_area_struct *vma,
>  				  unsigned long addr, pte_t *ptep);
> +#define __HAVE_ARCH_HUGE_PTE_CLEAR
>  extern void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
>  			   pte_t *ptep, unsigned long sz);
> -#define huge_pte_clear huge_pte_clear
>  extern void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr,
>  				 pte_t *ptep, pte_t pte, unsigned long sz);
>  #define set_huge_swap_pte_at set_huge_swap_pte_at
> diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
> index 9d0cde8ab716..3da7cff52360 100644
> --- a/include/asm-generic/hugetlb.h
> +++ b/include/asm-generic/hugetlb.h
> @@ -32,7 +32,7 @@ static inline pte_t huge_pte_modify(pte_t pte, pgprot_t newprot)
>  	return pte_modify(pte, newprot);
>  }
>  
> -#ifndef huge_pte_clear
> +#ifndef __HAVE_ARCH_HUGE_PTE_CLEAR
>  static inline void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
>  		    pte_t *ptep, unsigned long sz)
>  {
> 
