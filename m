Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Sep 2016 15:27:04 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:48616 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992096AbcIUN050SCG6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 21 Sep 2016 15:26:57 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u8LDQuI3015683;
        Wed, 21 Sep 2016 15:26:56 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u8LDQuDv015682;
        Wed, 21 Sep 2016 15:26:56 +0200
Date:   Wed, 21 Sep 2016 15:26:56 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 7/9] MIPS: uprobes: Flush icache via kernel address
Message-ID: <20160921132656.GF14137@linux-mips.org>
References: <cover.d93e43428f3c573bdd18d7c874830705b39c3a8a.1472747205.git-series.james.hogan@imgtec.com>
 <0d915756776de050b8a92b5bb5d4e7ffbe784d66.1472747205.git-series.james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d915756776de050b8a92b5bb5d4e7ffbe784d66.1472747205.git-series.james.hogan@imgtec.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55221
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Thu, Sep 01, 2016 at 05:30:13PM +0100, James Hogan wrote:

> Update arch_uprobe_copy_ixol() to use the kmap_atomic() based kernel
> address to flush the icache with flush_icache_range(), rather than the
> user mapping. We have the kernel mapping available anyway and this
> avoids having to switch to using the new __flush_icache_user_range() for
> the sake of Enhanced Virtual Addressing (EVA) where flush_icache_range()
> will become ineffective on user addresses.
> 
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
> Cc: linux-mips@linux-mips.org
> ---
>  arch/mips/kernel/uprobes.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/mips/kernel/uprobes.c b/arch/mips/kernel/uprobes.c
> index 8452d933a645..9a507ab1ea38 100644
> --- a/arch/mips/kernel/uprobes.c
> +++ b/arch/mips/kernel/uprobes.c
> @@ -301,19 +301,14 @@ int set_orig_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
>  void __weak arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
>  				  void *src, unsigned long len)
>  {
> -	void *kaddr;
> +	void *kaddr, kstart;
>  
>  	/* Initialize the slot */
>  	kaddr = kmap_atomic(page);
> -	memcpy(kaddr + (vaddr & ~PAGE_MASK), src, len);
> +	kstart = kaddr + (vaddr & ~PAGE_MASK);
> +	memcpy(kstart, src, len);
> +	flush_icache_range(kstart, kstart + len);
>  	kunmap_atomic(kaddr);
> -
> -	/*
> -	 * The MIPS version of flush_icache_range will operate safely on
> -	 * user space addresses and more importantly, it doesn't require a
> -	 * VMA argument.
> -	 */
> -	flush_icache_range(vaddr, vaddr + len);

I can't convince myself this is right wrt. to cache aliases ...

  Ralf
