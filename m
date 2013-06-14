Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Jun 2013 15:09:41 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:32773 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6823020Ab3FNNJjnkTd1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 14 Jun 2013 15:09:39 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5ED9ZbW025048;
        Fri, 14 Jun 2013 15:09:35 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5ED9XpV025047;
        Fri, 14 Jun 2013 15:09:33 +0200
Date:   Fri, 14 Jun 2013 15:09:33 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, kvm@vger.kernel.org,
        Sanjay Lal <sanjayl@kymasys.com>, linux-kernel@vger.kernel.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 03/31] mips/kvm: Fix 32-bitisms in kvm_locore.S
Message-ID: <20130614130933.GE15775@linux-mips.org>
References: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
 <1370646215-6543-4-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1370646215-6543-4-git-send-email-ddaney.cavm@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36881
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

On Fri, Jun 07, 2013 at 04:03:07PM -0700, David Daney wrote:

> diff --git a/arch/mips/kvm/kvm_locore.S b/arch/mips/kvm/kvm_locore.S
> index dca2aa6..e86fa2a 100644
> --- a/arch/mips/kvm/kvm_locore.S
> +++ b/arch/mips/kvm/kvm_locore.S
> @@ -310,7 +310,7 @@ NESTED (MIPSX(GuestException), CALLFRAME_SIZ, ra)
>      LONG_S  t0, VCPU_R26(k1)
>  
>      /* Get GUEST k1 and save it in VCPU */
> -    la      t1, ~0x2ff
> +	PTR_LI	t1, ~0x2ff
>      mfc0    t0, CP0_EBASE
>      and     t0, t0, t1
>      LONG_L  t0, 0x3000(t0)
> @@ -384,14 +384,14 @@ NESTED (MIPSX(GuestException), CALLFRAME_SIZ, ra)
>      mtc0        k0, CP0_DDATA_LO
>  
>      /* Restore RDHWR access */
> -    la      k0, 0x2000000F
> +	PTR_LI	k0, 0x2000000F
>      mtc0    k0,  CP0_HWRENA
>  
>      /* Jump to handler */
>  FEXPORT(__kvm_mips_jump_to_handler)
>      /* XXXKYMA: not sure if this is safe, how large is the stack?? */
>      /* Now jump to the kvm_mips_handle_exit() to see if we can deal with this in the kernel */
> -    la          t9,kvm_mips_handle_exit
> +	PTR_LA	t9, kvm_mips_handle_exit
>      jalr.hb     t9
>      addiu       sp,sp, -CALLFRAME_SIZ           /* BD Slot */
>  
> @@ -566,7 +566,7 @@ __kvm_mips_return_to_host:
>      mtlo    k0
>  
>      /* Restore RDHWR access */
> -    la      k0, 0x2000000F
> +	PTR_LI	k0, 0x2000000F
>      mtc0    k0,  CP0_HWRENA

Technically ok, there's only a formatting issue because you indent the
changed lines with tabs while the existing file uses tab characters.
I suggest you insert an extra cleanup patch to properly re-indent the
entire file into the series before this one?

So with that sorted:

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
