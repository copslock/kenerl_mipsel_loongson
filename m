Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Nov 2012 02:11:44 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:33421 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823043Ab2KCBLmW0VRd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 3 Nov 2012 02:11:42 +0100
Date:   Sat, 3 Nov 2012 01:11:42 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Sanjay Lal <sanjayl@kymasys.com>
cc:     kvm@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 14/20] MIPS: Use the UM bit instead of the CU0 enable
 bit in  the status register to figure out the stack for  saving regs.
In-Reply-To: <6BC12683-224F-4867-818C-FE4CF722B272@kymasys.com>
Message-ID: <alpine.LFD.2.02.1211030045580.28027@eddie.linux-mips.org>
References: <6BC12683-224F-4867-818C-FE4CF722B272@kymasys.com>
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 34862
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Wed, 31 Oct 2012, Sanjay Lal wrote:

> diff --git a/arch/mips/include/asm/stackframe.h b/arch/mips/include/asm/stackframe.h
> index cb41af5..59c9245 100644
> --- a/arch/mips/include/asm/stackframe.h
> +++ b/arch/mips/include/asm/stackframe.h
> @@ -30,7 +30,7 @@
>  #define STATMASK 0x1f
>  #endif
>  
> -#ifdef CONFIG_MIPS_MT_SMTC
> +#if defined(CONFIG_MIPS_MT_SMTC) || defined (CONFIG_MIPS_HW_FIBERS)
>  #include <asm/mipsmtregs.h>
>  #endif /* CONFIG_MIPS_MT_SMTC */
>  
> @@ -162,9 +162,9 @@
>  		.set	noat
>  		.set	reorder
>  		mfc0	k0, CP0_STATUS
> -		sll	k0, 3		/* extract cu0 bit */
> +		andi    k0,k0,0x10 		/* check user mode bit*/
>  		.set	noreorder
> -		bltz	k0, 8f
> +         beq     k0, $0, 8f
>  		 move	k1, sp
>  		.set	reorder
>  		/* Called from user mode, new stack. */

 Any reason this is needed for?  If so, then given that this is generic 
code a corresponding piece has to be added to support the MIPS I ISA 
processors that have the user mode bit in a different location.  
Presumably you'll update all the other places that fiddle with 
CP0.Status.CU0 too?

  Maciej
