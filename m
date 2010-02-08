Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Feb 2010 21:35:01 +0100 (CET)
Received: from imr1.ericy.com ([198.24.6.9]:47342 "EHLO imr1.ericy.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491984Ab0BHUe5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 8 Feb 2010 21:34:57 +0100
Received: from eusaamw0712.eamcs.ericsson.se ([147.117.20.181])
        by imr1.ericy.com (8.13.1/8.13.1) with ESMTP id o18Ka9Lt015312;
        Mon, 8 Feb 2010 14:36:14 -0600
Received: from [155.53.128.103] (147.117.20.212) by
 eusaamw0712.eamcs.ericsson.se (147.117.20.182) with Microsoft SMTP Server id
 8.1.375.2; Mon, 8 Feb 2010 15:34:45 -0500
Subject: Re: [PATCH] MIPS: Don't probe reserved EntryHi bits.
From:   Guenter Roeck <guenter.roeck@ericsson.com>
Reply-To: guenter.roeck@ericsson.com
To:     David Daney <ddaney@caviumnetworks.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>
In-Reply-To: <1265660820-5418-1-git-send-email-ddaney@caviumnetworks.com>
References: <1265660820-5418-1-git-send-email-ddaney@caviumnetworks.com>
Content-Type: text/plain
Organization: Ericsson
Date:   Mon, 8 Feb 2010 12:36:28 -0800
Message-ID: <1265661388.5825.151.camel@groeck-laptop>
MIME-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <guenter.roeck@ericsson.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25901
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guenter.roeck@ericsson.com
Precedence: bulk
X-list: linux-mips

On Mon, 2010-02-08 at 15:27 -0500, David Daney wrote:
> The patch that adds cpu_probe_vmbits is erroneously writing to
> reserved bit 12.  Since we are really only probing high bits, don't
> write this bit with a one.
> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> CC: Guenter Roeck <guenter.roeck@ericsson.com>

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>

> ---
>  arch/mips/kernel/cpu-probe.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
> index 2ff5f64..9ea5ca8 100644
> --- a/arch/mips/kernel/cpu-probe.c
> +++ b/arch/mips/kernel/cpu-probe.c
> @@ -287,9 +287,9 @@ static inline int __cpu_has_fpu(void)
>  static inline void cpu_probe_vmbits(struct cpuinfo_mips *c)
>  {
>  #ifdef __NEED_VMBITS_PROBE
> -	write_c0_entryhi(0x3ffffffffffff000ULL);
> +	write_c0_entryhi(0x3fffffffffffe000ULL);
>  	back_to_back_c0_hazard();
> -	c->vmbits = fls64(read_c0_entryhi() & 0x3ffffffffffff000ULL);
> +	c->vmbits = fls64(read_c0_entryhi() & 0x3fffffffffffe000ULL);
>  #endif
>  }
>  
