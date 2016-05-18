Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 May 2016 17:05:07 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:27541 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27028108AbcERPFCZus5Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 May 2016 17:05:02 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id 24EBC2E63E41F;
        Wed, 18 May 2016 16:04:51 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 18 May 2016 16:04:54 +0100
Received: from localhost (10.100.200.96) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Wed, 18 May
 2016 16:04:54 +0100
Date:   Wed, 18 May 2016 16:04:52 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     Matt Redfearn <matt.redfearn@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: Re: [PATCH 2/2] MIPS: CPS: Copy EVA configuration when starting
 secondary VPs.
Message-ID: <20160518150452.GA30917@NP-P-BURTON>
References: <1463582722-31420-1-git-send-email-matt.redfearn@imgtec.com>
 <1463582722-31420-2-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <1463582722-31420-2-git-send-email-matt.redfearn@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [10.100.200.96]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53513
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

On Wed, May 18, 2016 at 03:45:22PM +0100, Matt Redfearn wrote:
> When starting secondary VPEs which support EVA and the SegCtl registers,
> copy the memory segmentation configuration from the running VPE to ensure
> that all VPEs in the core have a consitent virtual memory map.
> 
> The EVA configuration of secondary cores is dealt with when starting the
> core via the CM.
> 
> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
> ---
> 
>  arch/mips/kernel/cps-vec.S | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
> index ac81edd44563..07b3274c8ae1 100644
> --- a/arch/mips/kernel/cps-vec.S
> +++ b/arch/mips/kernel/cps-vec.S
> @@ -431,6 +431,22 @@ LEAF(mips_cps_boot_vpes)
>  	mfc0	t0, CP0_CONFIG
>  	mttc0	t0, CP0_CONFIG
>  
> +	/* Copy the EVA config from this VPE if the CPU supports it */
> +	mfc0	t0, CP0_CONFIG, 1
> +	bgez	t0, 1f
> +	 mfc0	t0, CP0_CONFIG, 2
> +	bgez	t0, 1f
> +	 mfc0	t0, CP0_CONFIG, 3
> +	and	t0, t0, MIPS_CONF3_SC
> +	beqz	t0, 1f
> +	 nop

Hi Matt,

The checks here aren't *quite* right since they do the mfc0 of the next
register in the delay slot which will happen even if the M bit of the
preceeding register wasn't set. There are other cases in cps-vec.S where
I've made that mistake... Luckily, in this particular case, we know that
we have MT ASE support which means we know that Config3 exists. So I
think you can just remove the checks of Config1.M & Config2.M and just
read Config3 straight away.

Thanks,
    Paul

> +	mfc0    t0, CP0_SEGCTL0
> +	mttc0	t0, CP0_SEGCTL0
> +	mfc0    t0, CP0_SEGCTL1
> +	mttc0	t0, CP0_SEGCTL1
> +	mfc0    t0, CP0_SEGCTL2
> +	mttc0	t0, CP0_SEGCTL2
> +1:
>  	/* Ensure no software interrupts are pending */
>  	mttc0	zero, CP0_CAUSE
>  	mttc0	zero, CP0_STATUS
> -- 
> 2.5.0
> 
