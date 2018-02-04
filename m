Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Feb 2018 00:53:26 +0100 (CET)
Received: from icp-osb-irony-out5.external.iinet.net.au ([203.59.1.221]:40305
        "EHLO icp-osb-irony-out5.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991172AbeBDXxSxob2t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Feb 2018 00:53:18 +0100
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2CIAACCnHda/zXSMGcNThkBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEHAQEBAQGDJIIrg2WZEwEBAQEBAQaBNJJMhxSFRQKDEBQBAQEBAQEBAQK?=
 =?us-ascii?q?GNwEBAQMjVhALDQEKAgImAgJXBgEMBgIBAYokwBBugichhF+DcoIGAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBASKBD4NbgySCMCmDBYMvBIUGgmUFpCQBmA+GJoQKh2lImGo2gXI?=
 =?us-ascii?q?zGggoCIMDg3sBCIEFZo5dAQEB?=
X-IPAS-Result: =?us-ascii?q?A2CIAACCnHda/zXSMGcNThkBAQEBAQEBAQEBAQEHAQEBAQG?=
 =?us-ascii?q?DJIIrg2WZEwEBAQEBAQaBNJJMhxSFRQKDEBQBAQEBAQEBAQKGNwEBAQMjVhALD?=
 =?us-ascii?q?QEKAgImAgJXBgEMBgIBAYokwBBugichhF+DcoIGAQEBAQEBAQEBAQEBAQEBASK?=
 =?us-ascii?q?BD4NbgySCMCmDBYMvBIUGgmUFpCQBmA+GJoQKh2lImGo2gXIzGggoCIMDg3sBC?=
 =?us-ascii?q?IEFZo5dAQEB?=
X-IronPort-AV: E=Sophos;i="5.46,462,1511798400"; 
   d="scan'208";a="39848583"
Received: from unknown (HELO [172.16.0.22]) ([103.48.210.53])
  by icp-osb-irony-out5.iinet.net.au with ESMTP; 05 Feb 2018 07:52:57 +0800
Subject: Re: [PATCH] MIPS: CPS: Fix MIPS_ISA_LEVEL_RAW fallout
To:     James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>, stable@vger.kernel.org
References: <20180202120658.GA8479@saruman>
 <20180202143640.24490-1-jhogan@kernel.org>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <acb31926-bd04-ebaf-f83f-b699b0500425@linux-m68k.org>
Date:   Mon, 5 Feb 2018 09:53:02 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180202143640.24490-1-jhogan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <gerg@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62436
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gerg@linux-m68k.org
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

Hi James,

On 03/02/18 00:36, James Hogan wrote:
> Commit 17278a91e04f ("MIPS: CPS: Fix r1 .set mt assembler warning")
> added .set MIPS_ISA_LEVEL_RAW to silence warnings about .set mt on r1,
> however this can result in a MOVE being encoded as a 64-bit DADDU
> instruction on certain version of binutils (e.g. 2.22), and reserved
> instruction exceptions at runtime on 32-bit hardware.
> 
> Reduce the sizes of the push/pop sections to include only instructions
> that are part of the MT ASE or which won't convert to 64-bit
> instructions after .set mips64r2/mips64r6.
> 
> Reported-by: Greg Ungerer <gerg@linux-m68k.org>
> Fixes: 17278a91e04f ("MIPS: CPS: Fix r1 .set mt assembler warning")
> Signed-off-by: James Hogan <jhogan@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: linux-mips@linux-mips.org
> Cc: <stable@vger.kernel.org> # 4.15
> ---
> Greg: Please can you test this patch.

Tested and works. Thanks for the quick response and turn around.

Tested-by: Greg Ungerer <gerg@linux-m68k.org>

Regards
Greg


> ---
>  arch/mips/kernel/cps-vec.S | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
> index e68e6e04063a..1025f937ab0e 100644
> --- a/arch/mips/kernel/cps-vec.S
> +++ b/arch/mips/kernel/cps-vec.S
> @@ -388,15 +388,16 @@ LEAF(mips_cps_boot_vpes)
>  
>  #elif defined(CONFIG_MIPS_MT)
>  
> -	.set	push
> -	.set	MIPS_ISA_LEVEL_RAW
> -	.set	mt
> -
>  	/* If the core doesn't support MT then return */
>  	has_mt	t0, 5f
>  
>  	/* Enter VPE configuration state */
> +	.set	push
> +	.set	MIPS_ISA_LEVEL_RAW
> +	.set	mt
>  	dvpe
> +	.set	pop
> +
>  	PTR_LA	t1, 1f
>  	jr.hb	t1
>  	 nop
> @@ -422,6 +423,10 @@ LEAF(mips_cps_boot_vpes)
>  	mtc0	t0, CP0_VPECONTROL
>  	ehb
>  
> +	.set	push
> +	.set	MIPS_ISA_LEVEL_RAW
> +	.set	mt
> +
>  	/* Skip the VPE if its TC is not halted */
>  	mftc0	t0, CP0_TCHALT
>  	beqz	t0, 2f
> @@ -495,6 +500,8 @@ LEAF(mips_cps_boot_vpes)
>  	ehb
>  	evpe
>  
> +	.set	pop
> +
>  	/* Check whether this VPE is meant to be running */
>  	li	t0, 1
>  	sll	t0, t0, a1
> @@ -509,7 +516,7 @@ LEAF(mips_cps_boot_vpes)
>  1:	jr.hb	t0
>  	 nop
>  
> -2:	.set	pop
> +2:
>  
>  #endif /* CONFIG_MIPS_MT_SMP */
>  
> 
