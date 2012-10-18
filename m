Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Oct 2012 13:32:06 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:37796 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6823112Ab2JRLcA3xkSa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 18 Oct 2012 13:32:00 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id q9IBVuBN005372;
        Thu, 18 Oct 2012 13:31:56 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id q9IBVtAV005371;
        Thu, 18 Oct 2012 13:31:55 +0200
Date:   Thu, 18 Oct 2012 13:31:55 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] MIPS: Remove redundant TLB invalidate from
 pmdp_splitting_flush().
Message-ID: <20121018113154.GA2321@linux-mips.org>
References: <1350519620-4582-1-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1350519620-4582-1-git-send-email-ddaney.cavm@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34723
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wed, Oct 17, 2012 at 05:20:20PM -0700, David Daney wrote:

> diff --git a/arch/mips/mm/pgtable-64.c b/arch/mips/mm/pgtable-64.c
> index 6c9a477..5408bb5 100644
> --- a/arch/mips/mm/pgtable-64.c
> +++ b/arch/mips/mm/pgtable-64.c
> @@ -71,7 +71,7 @@ void pmdp_splitting_flush(struct vm_area_struct *vma,
>  	if (!pmd_trans_splitting(*pmdp)) {
>  		pmd_t pmd = pmd_mksplitting(*pmdp);
>  		set_pmd_at(vma->vm_mm, address, pmdp, pmd);
> -		flush_tlb_range(vma, address, address + HPAGE_SIZE);
> +		/* TLB already flushed by set_pmd_at() */

Thanks, folded into the THP patch.

  Ralf
