Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Mar 2011 09:30:31 +0100 (CET)
Received: from ozlabs.org ([203.10.76.45]:46837 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491017Ab1CEIaH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 5 Mar 2011 09:30:07 +0100
Received: by ozlabs.org (Postfix, from userid 1007)
        id 02AB2B70E3; Sat,  5 Mar 2011 19:30:02 +1100 (EST)
Date:   Sat, 5 Mar 2011 19:24:09 +1100
From:   David Gibson <david@gibson.dropbear.id.au>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 02/12] of: Allow scripts/dtc/libfdt to be used
 from kernel code
Message-ID: <20110305082409.GB3312@yookeroo>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
        David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org, devicetree-discuss@lists.ozlabs.org,
        grant.likely@secretlab.ca, linux-kernel@vger.kernel.org
References: <1299267744-17278-1-git-send-email-ddaney@caviumnetworks.com>
 <1299267744-17278-3-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1299267744-17278-3-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <dgibson@ozlabs.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29369
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david@gibson.dropbear.id.au
Precedence: bulk
X-list: linux-mips

On Fri, Mar 04, 2011 at 11:42:14AM -0800, David Daney wrote:
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
[snip]
> --- /dev/null
> +++ b/lib/libfdt/libfdt_env.h
> @@ -0,0 +1,21 @@
> +#ifndef _LIBFDT_ENV_H
> +#define _LIBFDT_ENV_H
> +
> +#include <linux/string.h>
> +
> +#define _B(n)	((unsigned long long)((uint8_t *)&x)[n])
> +static inline uint32_t fdt32_to_cpu(uint32_t x)
> +{
> +	return (_B(0) << 24) | (_B(1) << 16) | (_B(2) << 8) | _B(3);
> +}
> +#define cpu_to_fdt32(x) fdt32_to_cpu(x)
> +
> +static inline uint64_t fdt64_to_cpu(uint64_t x)
> +{
> +	return (_B(0) << 56) | (_B(1) << 48) | (_B(2) << 40) | (_B(3) << 32)
> +		| (_B(4) << 24) | (_B(5) << 16) | (_B(6) << 8) | _B(7);
> +}
> +#define cpu_to_fdt64(x) fdt64_to_cpu(x)
> +#undef _B

Ah, yuck.  I only used those nasty macros in the userspace version of
libfdt_env.h because bytesex.h is such a portability nightmare.  The
kernel already has cpu_to_be{32,64}(), and the fdt byteswapping
functions should just be aliased to them.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
