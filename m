Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Jun 2013 13:42:47 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:38119 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6824757Ab3FPLmqwsgtV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 16 Jun 2013 13:42:46 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5GBggpq029427;
        Sun, 16 Jun 2013 13:42:42 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5GBgfRC029426;
        Sun, 16 Jun 2013 13:42:41 +0200
Date:   Sun, 16 Jun 2013 13:42:40 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, kvm@vger.kernel.org,
        Sanjay Lal <sanjayl@kymasys.com>, linux-kernel@vger.kernel.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 27/31] mips/kvm: Gate the use of
 kvm_local_flush_tlb_all() by KVM_MIPSTE
Message-ID: <20130616114240.GJ20046@linux-mips.org>
References: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
 <1370646215-6543-28-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1370646215-6543-28-git-send-email-ddaney.cavm@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36932
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

On Fri, Jun 07, 2013 at 04:03:31PM -0700, David Daney wrote:

> From: David Daney <david.daney@cavium.com>
> 
> Only the trap-and-emulate KVM code needs a Special tlb flusher.  All
> other configurations should use the regular version.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  arch/mips/include/asm/mmu_context.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mmu_context.h
> index 5609a32..04d0b74 100644
> --- a/arch/mips/include/asm/mmu_context.h
> +++ b/arch/mips/include/asm/mmu_context.h
> @@ -117,7 +117,7 @@ get_new_asid(unsigned long cpu)
>  	if (! ((asid += ASID_INC) & ASID_MASK) ) {
>  		if (cpu_has_vtag_icache)
>  			flush_icache_all();
> -#ifdef CONFIG_VIRTUALIZATION
> +#if IS_ENABLED(CONFIG_KVM_MIPSTE)
>  		kvm_local_flush_tlb_all();      /* start new asid cycle */
>  #else
>  		local_flush_tlb_all();	/* start new asid cycle */

Sanjay,

it would seem this is actually a bug if KVM is built as a module and should
be fixed for 3.10?

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
