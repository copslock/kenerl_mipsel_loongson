Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Oct 2018 09:12:10 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35204 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23990394AbeJOHMDHIDrQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Oct 2018 09:12:03 +0200
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9F7AGK0095376
        for <linux-mips@linux-mips.org>; Mon, 15 Oct 2018 03:12:01 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n4k0yexm7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-mips@linux-mips.org>; Mon, 15 Oct 2018 03:12:01 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <borntraeger@de.ibm.com>;
        Mon, 15 Oct 2018 08:11:57 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 15 Oct 2018 08:11:44 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9F7Bhun6488426
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 Oct 2018 07:11:43 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 956A8AE04D;
        Mon, 15 Oct 2018 10:10:21 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B83CAE051;
        Mon, 15 Oct 2018 10:09:34 +0100 (BST)
Received: from oc7455500831.ibm.com (unknown [9.152.224.212])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 15 Oct 2018 10:09:34 +0100 (BST)
Subject: Re: [PATCH v2 2/2] mm: speed up mremap by 500x on large regions
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, minchan@kernel.org, pantin@google.com,
        hughd@google.com, lokeshgidra@google.com, dancol@google.com,
        mhocko@kernel.org, kirill@shutemov.name, akpm@linux-foundation.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        elfring@users.sourceforge.net, Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guan Xuetao <gxt@pku.edu.cn>, Helge Deller <deller@gmx.de>,
        Ingo Molnar <mingo@redhat.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Jeff Dike <jdike@addtoit.com>, Jonas Bonn <jonas@southpole.se>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        kasan-dev@googlegroups.com, kvmarm@lists.cs.columbia.edu,
        Ley Foon Tan <lftan@altera.com>, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
        linux-mm@kvack.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
        linux-xtensa@linux-xtensa.org, Max Filippov <jcmvbkbc@gmail.com>,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Rich Felker <dalias@libc.org>, Sam Creasey <sammy@sammy.net>,
        sparclinux@vger.kernel.org, Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Will Deacon <will.deacon@arm.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
References: <20181012013756.11285-1-joel@joelfernandes.org>
 <20181012013756.11285-2-joel@joelfernandes.org>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
 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
 syiRa+UVlsKmx1hsEg==
Date:   Mon, 15 Oct 2018 09:10:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181012013756.11285-2-joel@joelfernandes.org>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18101507-0028-0000-0000-000003076E51
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101507-0029-0000-0000-000023C27326
Message-Id: <6580a62b-69c6-f2e3-767c-bd36b977bea2@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-15_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810150069
Return-Path: <borntraeger@de.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66841
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: borntraeger@de.ibm.com
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



On 10/12/2018 03:37 AM, Joel Fernandes (Google) wrote:
> Android needs to mremap large regions of memory during memory management
> related operations. The mremap system call can be really slow if THP is
> not enabled. The bottleneck is move_page_tables, which is copying each
> pte at a time, and can be really slow across a large map. Turning on THP
> may not be a viable option, and is not for us. This patch speeds up the
> performance for non-THP system by copying at the PMD level when possible.
> 
> The speed up is three orders of magnitude. On a 1GB mremap, the mremap
> completion times drops from 160-250 millesconds to 380-400 microseconds.
> 
> Before:
> Total mremap time for 1GB data: 242321014 nanoseconds.
> Total mremap time for 1GB data: 196842467 nanoseconds.
> Total mremap time for 1GB data: 167051162 nanoseconds.
> 
> After:
> Total mremap time for 1GB data: 385781 nanoseconds.
> Total mremap time for 1GB data: 388959 nanoseconds.
> Total mremap time for 1GB data: 402813 nanoseconds.
> 
> Incase THP is enabled, the optimization is skipped. I also flush the
> tlb every time we do this optimization since I couldn't find a way to
> determine if the low-level PTEs are dirty. It is seen that the cost of
> doing so is not much compared the improvement, on both x86-64 and arm64.
> 
> Cc: minchan@kernel.org
> Cc: pantin@google.com
> Cc: hughd@google.com
> Cc: lokeshgidra@google.com
> Cc: dancol@google.com
> Cc: mhocko@kernel.org
> Cc: kirill@shutemov.name
> Cc: akpm@linux-foundation.org
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  mm/mremap.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 9e68a02a52b1..d82c485822ef 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -191,6 +191,54 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
>  		drop_rmap_locks(vma);
>  }
>  
> +static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
> +		  unsigned long new_addr, unsigned long old_end,
> +		  pmd_t *old_pmd, pmd_t *new_pmd, bool *need_flush)
> +{
> +	spinlock_t *old_ptl, *new_ptl;
> +	struct mm_struct *mm = vma->vm_mm;
> +
> +	if ((old_addr & ~PMD_MASK) || (new_addr & ~PMD_MASK)
> +	    || old_end - old_addr < PMD_SIZE)
> +		return false;
> +
> +	/*
> +	 * The destination pmd shouldn't be established, free_pgtables()
> +	 * should have release it.
> +	 */
> +	if (WARN_ON(!pmd_none(*new_pmd)))
> +		return false;
> +
> +	/*
> +	 * We don't have to worry about the ordering of src and dst
> +	 * ptlocks because exclusive mmap_sem prevents deadlock.
> +	 */
> +	old_ptl = pmd_lock(vma->vm_mm, old_pmd);
> +	if (old_ptl) {
> +		pmd_t pmd;
> +
> +		new_ptl = pmd_lockptr(mm, new_pmd);
> +		if (new_ptl != old_ptl)
> +			spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
> +
> +		/* Clear the pmd */
> +		pmd = *old_pmd;
> +		pmd_clear(old_pmd);

Adding Martin Schwidefsky.
Is this mapping maybe still in use on other CPUs? If yes, I think for
s390 we need to flush here as well (in other word we might need to introduce
pmd_clear_flush). On s390 you have to use instructions like CRDTE,IPTE or IDTE
to modify page table entries that are still in use. Otherwise you can get a 
delayed access exception which is - in contrast to page faults - not recoverable.



> +
> +		VM_BUG_ON(!pmd_none(*new_pmd));
> +
> +		/* Set the new pmd */
> +		set_pmd_at(mm, new_addr, new_pmd, pmd);
> +		if (new_ptl != old_ptl)
> +			spin_unlock(new_ptl);
> +		spin_unlock(old_ptl);
> +
> +		*need_flush = true;
> +		return true;
> +	}
> +	return false;
> +}
> +
>  unsigned long move_page_tables(struct vm_area_struct *vma,
>  		unsigned long old_addr, struct vm_area_struct *new_vma,
>  		unsigned long new_addr, unsigned long len,
> @@ -239,7 +287,21 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
>  			split_huge_pmd(vma, old_pmd, old_addr);
>  			if (pmd_trans_unstable(old_pmd))
>  				continue;
> +		} else if (extent == PMD_SIZE) {
> +			bool moved;
> +
> +			/* See comment in move_ptes() */
> +			if (need_rmap_locks)
> +				take_rmap_locks(vma);
> +			moved = move_normal_pmd(vma, old_addr, new_addr,
> +					old_end, old_pmd, new_pmd,
> +					&need_flush);
> +			if (need_rmap_locks)
> +				drop_rmap_locks(vma);
> +			if (moved)
> +				continue;
>  		}
> +
>  		if (pte_alloc(new_vma->vm_mm, new_pmd))
>  			break;
>  		next = (new_addr + PMD_SIZE) & PMD_MASK;
> 
