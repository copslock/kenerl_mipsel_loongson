Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 May 2016 03:11:03 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:55703 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27029187AbcELBK4Rvcbb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 May 2016 03:10:56 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id 2D21D1212CAD5;
        Thu, 12 May 2016 02:10:49 +0100 (IST)
Received: from [10.20.78.171] (10.20.78.171) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.266.1; Thu, 12 May 2016
 02:10:49 +0100
Date:   Thu, 12 May 2016 02:10:41 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     James Hogan <james.hogan@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2 2/5] MIPS: Add defs & probing of extended CP0_EBase
In-Reply-To: <1462971053-25622-3-git-send-email-james.hogan@imgtec.com>
Message-ID: <alpine.DEB.2.00.1605120115470.6794@tp.orcam.me.uk>
References: <1462971053-25622-1-git-send-email-james.hogan@imgtec.com> <1462971053-25622-3-git-send-email-james.hogan@imgtec.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.171]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53388
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

> diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
> index a6ce1db191aa..c4795568c1f2 100644
> --- a/arch/mips/kernel/cpu-probe.c
> +++ b/arch/mips/kernel/cpu-probe.c
> @@ -858,6 +858,41 @@ static void decode_configs(struct cpuinfo_mips *c)
>  	if (ok)
>  		ok = decode_config5(c);
>  
> +	/* Probe the EBase.WG bit */
> +	if (cpu_has_mips_r2_r6) {
> +		u64 ebase;
> +		unsigned int status;
> +
> +		/* {read,write}_c0_ebase_64() may be UNDEFINED prior to r6 */
> +		ebase = cpu_has_mips64r6 ? read_c0_ebase_64()
> +					 : (s32)read_c0_ebase();
> +		if (ebase & MIPS_EBASE_WG) {
> +			/* WG bit already set, we can avoid the clumsy probe */
> +			c->options |= MIPS_CPU_EBASE_WG;

 You may additionally check for bits 31:30 != 0b10 as a satisfactory 
condition for WG's presence, under the assumption that 0b10 is not very 
likely if a truly 64-bit exception base has been loaded.  E.g.:

#define MIPS_EBASE_SEG_MASK (3 << 30)
		s32 mask;

		/* Avoid the clumsy probe if contents indicate 64 bits.  */
		mask = MIPS_EBASE_SEG_MASK | MIPS_CPU_EBASE_WG;
		if ((ebase & mask) != CKSEG0) {
			c->options |= MIPS_CPU_EBASE_WG;

or so.

 NB I find the current description of EBase questionable to say the least.  
This statement:

"The addition of the base address and the exception offset is performed 
inhibiting a carry between bits 29 and 30 of the final exception address." 

is repeated twice as if a leftover from the days before WG support.  I 
think this needs to be clarified in the case of bits 31:30 != 0b10.  Also 
I think the effect on the Cache Error exception vector in this case has to 
be better specified.  Can you please raise it with the architecture 
documentation maintainers?

 Also the description of DMFC0 is inconsistent with the corresponding 
pseudo code.  As from r6.04 of the instruction set document the pseudo 
code has been updated to take into account the R6 semantics for 32-bit 
registers you rely on here, however the description still claims such 
operation is UNDEFINED.  Can you please raise it with the architecture 
documentation maintainers as well?

  Maciej
