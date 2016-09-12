Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Sep 2016 23:03:23 +0200 (CEST)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:35071 "EHLO
        emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992186AbcILVDPpCssX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Sep 2016 23:03:15 +0200
Received: from raspberrypi.musicnaut.iki.fi (85-76-14-194-nat.elisa-mobile.fi [85.76.14.194])
        by emh03.mail.saunalahti.fi (Postfix) with ESMTP id 317CA1887CF;
        Tue, 13 Sep 2016 00:03:15 +0300 (EEST)
Date:   Tue, 13 Sep 2016 00:03:14 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Asbjoern Sloth Toennesen <asbjorn@asbjorn.st>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Octeon: Use defines instead of magic numbers
Message-ID: <20160912210314.GB1658@raspberrypi.musicnaut.iki.fi>
References: <20160912203343.26751-1-asbjorn@asbjorn.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160912203343.26751-1-asbjorn@asbjorn.st>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55117
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

On Mon, Sep 12, 2016 at 08:33:43PM +0000, Asbjoern Sloth Toennesen wrote:
> The patch will be followed by a similar patch to
> drivers/staging/octeon/ethernet.c

I think you should:

	1. Move this function to staging/octeon

	2. Do required cleanups there

	3. Finally delete the function under arch/mips

We shouldn't start making cleanups (except code removal) to ethernet code
under mips/cavium-octeon/executive as it really does not belong there...

A.

> Signed-off-by: Asbjoern Sloth Toennesen <asbjorn@asbjorn.st>
> ---
>  arch/mips/cavium-octeon/executive/cvmx-helper.c | 15 ++++++++++-----
>  arch/mips/include/asm/octeon/cvmx-ipd-defs.h    |  2 ++
>  2 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper.c b/arch/mips/cavium-octeon/executive/cvmx-helper.c
> index ff26d02..9b938c8 100644
> --- a/arch/mips/cavium-octeon/executive/cvmx-helper.c
> +++ b/arch/mips/cavium-octeon/executive/cvmx-helper.c
> @@ -46,6 +46,8 @@
>  #include <asm/octeon/cvmx-smix-defs.h>
>  #include <asm/octeon/cvmx-asxx-defs.h>
>  
> +#include <linux/if_ether.h>
> +
>  /**
>   * cvmx_override_pko_queue_priority(int ipd_port, uint64_t
>   * priorities[16]) is a function pointer. It is meant to allow
> @@ -918,7 +920,8 @@ int __cvmx_helper_errata_fix_ipd_ptr_alignment(void)
>  		p64 = (uint64_t *) cvmx_phys_to_ptr(pkt_buffer.s.addr);
>  		p64[0] = 0xffffffffffff0000ull;
>  		p64[1] = 0x08004510ull;
> -		p64[2] = ((uint64_t) (size - 14) << 48) | 0x5ae740004000ull;
> +		p64[2] = ((uint64_t) (size - ETH_HLEN) << 48)
> +			| 0x5ae740004000ull;
>  		p64[3] = 0x3a5fc0a81073c0a8ull;
>  
>  		for (i = 0; i < num_segs; i++) {
> @@ -954,11 +957,13 @@ int __cvmx_helper_errata_fix_ipd_ptr_alignment(void)
>  			       1 << INDEX(FIX_IPD_OUTPORT));
>  
>  		cvmx_write_csr(CVMX_GMXX_RXX_JABBER
> -			       (INDEX(FIX_IPD_OUTPORT),
> -				INTERFACE(FIX_IPD_OUTPORT)), 65392 - 14 - 4);
> +				(INDEX(FIX_IPD_OUTPORT),
> +					INTERFACE(FIX_IPD_OUTPORT)),
> +				CVMX_IPD_MAX_MTU - ETH_HLEN - ETH_FCS_LEN);
>  		cvmx_write_csr(CVMX_GMXX_RXX_FRM_MAX
> -			       (INDEX(FIX_IPD_OUTPORT),
> -				INTERFACE(FIX_IPD_OUTPORT)), 65392 - 14 - 4);
> +				(INDEX(FIX_IPD_OUTPORT),
> +					INTERFACE(FIX_IPD_OUTPORT)),
> +				CVMX_IPD_MAX_MTU - ETH_HLEN - ETH_FCS_LEN);
>  
>  		cvmx_pko_send_packet_prepare(FIX_IPD_OUTPORT,
>  					     cvmx_pko_get_base_queue
> diff --git a/arch/mips/include/asm/octeon/cvmx-ipd-defs.h b/arch/mips/include/asm/octeon/cvmx-ipd-defs.h
> index 1193f73..a877917 100644
> --- a/arch/mips/include/asm/octeon/cvmx-ipd-defs.h
> +++ b/arch/mips/include/asm/octeon/cvmx-ipd-defs.h
> @@ -28,6 +28,8 @@
>  #ifndef __CVMX_IPD_DEFS_H__
>  #define __CVMX_IPD_DEFS_H__
>  
> +#define CVMX_IPD_MAX_MTU 65392
> +
>  #define CVMX_IPD_1ST_MBUFF_SKIP (CVMX_ADD_IO_SEG(0x00014F0000000000ull))
>  #define CVMX_IPD_1st_NEXT_PTR_BACK (CVMX_ADD_IO_SEG(0x00014F0000000150ull))
>  #define CVMX_IPD_2nd_NEXT_PTR_BACK (CVMX_ADD_IO_SEG(0x00014F0000000158ull))
> -- 
> 2.9.3
> 
> 
