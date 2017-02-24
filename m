Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Feb 2017 23:10:05 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:22505 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992155AbdBXWJ6S0hOB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Feb 2017 23:09:58 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 4451A41F8E91;
        Fri, 24 Feb 2017 23:14:18 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Fri, 24 Feb 2017 23:14:18 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Fri, 24 Feb 2017 23:14:18 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 42608EEA330EE;
        Fri, 24 Feb 2017 22:09:48 +0000 (GMT)
Received: from np-p-burton.localnet (10.20.1.33) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 24 Feb
 2017 22:09:52 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     "Steven J. Hill" <steven.hill@cavium.com>
CC:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: Octeon: Cleanup of core PCIe file.
Date:   Fri, 24 Feb 2017 14:09:43 -0800
Message-ID: <1631008.KKB1CGQd07@np-p-burton>
Organization: Imagination Technologies
In-Reply-To: <1487886594-2161-1-git-send-email-steven.hill@cavium.com>
References: <1487886594-2161-1-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1620368.gIyHYvCFNz";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Originating-IP: [10.20.1.33]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56896
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

--nextPart1620368.gIyHYvCFNz
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Steven,

On Thursday, 23 February 2017 13:49:54 PST Steven J. Hill wrote:
> From: "Steven J. Hill" <Steven.Hill@cavium.com>
> 
>  * Remove unused header files and sort them by filename.
>  * Convert 'union cvmx_pcie_address' to a bitfield.

It's already a bitfield - this patch is about making that bitfield endian-
safe, right? That seems to be the only significant change here so I'd suggest 
changing the commit subject & message to reflect that.

>  * Update copyright date.

I really don't see the point of mentioning trivia like that when you could 
instead describe what your use of the __BITFIELD_FIELD macro is for (ie. 
endianness).

Additionally it looks like this & your other patch "MIPS: Octeon: Enable PCIe 
for little endian" probably ought to be a series, I imagine with this one 
coming first.

Thanks,
    Paul

> 
> Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  arch/mips/pci/pcie-octeon.c | 84
> ++++++++++++++++++++++++--------------------- 1 file changed, 44
> insertions(+), 40 deletions(-)
> 
> diff --git a/arch/mips/pci/pcie-octeon.c b/arch/mips/pci/pcie-octeon.c
> index 9f672ce..8f267bf 100644
> --- a/arch/mips/pci/pcie-octeon.c
> +++ b/arch/mips/pci/pcie-octeon.c
> @@ -3,27 +3,24 @@
>   * License.  See the file "COPYING" in the main directory of this archive
>   * for more details.
>   *
> - * Copyright (C) 2007, 2008, 2009, 2010, 2011 Cavium Networks
> + * Copyright (C) 2007, 2008, 2009, 2010, 2017 Cavium Networks
>   */
> -#include <linux/kernel.h>
> -#include <linux/init.h>
>  #include <linux/pci.h>
>  #include <linux/interrupt.h>
> -#include <linux/time.h>
>  #include <linux/delay.h>
>  #include <linux/moduleparam.h>
> 
>  #include <asm/octeon/octeon.h>
> +#include <asm/octeon/pci-octeon.h>
> +#include <asm/octeon/cvmx-dpi-defs.h>
> +#include <asm/octeon/cvmx-helper-errata.h>
>  #include <asm/octeon/cvmx-npei-defs.h>
>  #include <asm/octeon/cvmx-pciercx-defs.h>
> +#include <asm/octeon/cvmx-pemx-defs.h>
>  #include <asm/octeon/cvmx-pescx-defs.h>
>  #include <asm/octeon/cvmx-pexp-defs.h>
> -#include <asm/octeon/cvmx-pemx-defs.h>
> -#include <asm/octeon/cvmx-dpi-defs.h>
>  #include <asm/octeon/cvmx-sli-defs.h>
>  #include <asm/octeon/cvmx-sriox-defs.h>
> -#include <asm/octeon/cvmx-helper-errata.h>
> -#include <asm/octeon/pci-octeon.h>
> 
>  #define MRRS_CN5XXX 0 /* 128 byte Max Read Request Size */
>  #define MPS_CN5XXX  0 /* 128 byte Max Packet Size (Limit of most PCs) */
> @@ -40,55 +37,62 @@
>  union cvmx_pcie_address {
>  	uint64_t u64;
>  	struct {
> -		uint64_t upper:2;	/* Normally 2 for XKPHYS */
> -		uint64_t reserved_49_61:13;	/* Must be zero */
> -		uint64_t io:1;	/* 1 for IO space access */
> -		uint64_t did:5; /* PCIe DID = 3 */
> -		uint64_t subdid:3;	/* PCIe SubDID = 1 */
> -		uint64_t reserved_36_39:4;	/* Must be zero */
> -		uint64_t es:2;	/* Endian swap = 1 */
> -		uint64_t port:2;	/* PCIe port 0,1 */
> -		uint64_t reserved_29_31:3;	/* Must be zero */
> +		__BITFIELD_FIELD(uint64_t upper:2,  /* Normally 2 for XKPHYS */
> +		__BITFIELD_FIELD(uint64_t reserved_49_61:13,  /* Must be zero */
> +		__BITFIELD_FIELD(uint64_t io:1, /* 1 for IO space access */
> +		__BITFIELD_FIELD(uint64_t did:5,  /* PCIe DID = 3 */
> +		__BITFIELD_FIELD(uint64_t subdid:3,  /* PCIe SubDID = 1 */
> +		__BITFIELD_FIELD(uint64_t reserved_36_39:4,  /* Must be zero */
> +		__BITFIELD_FIELD(uint64_t es:2,  /* Endian swap = 1 */
> +		__BITFIELD_FIELD(uint64_t port:2,  /* PCIe port 0,1 */
> +		__BITFIELD_FIELD(uint64_t reserved_29_31:3,  /* Must be zero */
>  		/*
>  		 * Selects the type of the configuration request (0 = type 0,
>  		 * 1 = type 1).
>  		 */
> -		uint64_t ty:1;
> -		/* Target bus number sent in the ID in the request. */
> -		uint64_t bus:8;
> +		__BITFIELD_FIELD(uint64_t ty:1,
> +		/*
> +		 * Target bus number sent in the ID in the request.
> +		 */
> +		__BITFIELD_FIELD(uint64_t bus:8,
>  		/*
>  		 * Target device number sent in the ID in the
>  		 * request. Note that Dev must be zero for type 0
>  		 * configuration requests.
>  		 */
> -		uint64_t dev:5;
> -		/* Target function number sent in the ID in the request. */
> -		uint64_t func:3;
> +		__BITFIELD_FIELD(uint64_t dev:5,
> +		/*
> +		 * Target function number sent in the ID in the request.
> +		 */
> +		__BITFIELD_FIELD(uint64_t func:3,
>  		/*
>  		 * Selects a register in the configuration space of
>  		 * the target.
>  		 */
> -		uint64_t reg:12;
> +		__BITFIELD_FIELD(uint64_t reg:12,
> +		;))))))))))))))
>  	} config;
>  	struct {
> -		uint64_t upper:2;	/* Normally 2 for XKPHYS */
> -		uint64_t reserved_49_61:13;	/* Must be zero */
> -		uint64_t io:1;	/* 1 for IO space access */
> -		uint64_t did:5; /* PCIe DID = 3 */
> -		uint64_t subdid:3;	/* PCIe SubDID = 2 */
> -		uint64_t reserved_36_39:4;	/* Must be zero */
> -		uint64_t es:2;	/* Endian swap = 1 */
> -		uint64_t port:2;	/* PCIe port 0,1 */
> -		uint64_t address:32;	/* PCIe IO address */
> +		__BITFIELD_FIELD(uint64_t upper:2,  /* Normally 2 for XKPHYS */
> +		__BITFIELD_FIELD(uint64_t reserved_49_61:13,  /* Must be zero */
> +		__BITFIELD_FIELD(uint64_t io:1,  /* 1 for IO space access */
> +		__BITFIELD_FIELD(uint64_t did:5,  /* PCIe DID = 3 */
> +		__BITFIELD_FIELD(uint64_t subdid:3,  /* PCIe SubDID = 2 */
> +		__BITFIELD_FIELD(uint64_t reserved_36_39:4,  /* Must be zero */
> +		__BITFIELD_FIELD(uint64_t es:2,  /* Endian swap = 1 */
> +		__BITFIELD_FIELD(uint64_t port:2,  /* PCIe port 0,1 */
> +		__BITFIELD_FIELD(uint64_t address:32,  /* PCIe IO address */
> +		;)))))))))
>  	} io;
>  	struct {
> -		uint64_t upper:2;	/* Normally 2 for XKPHYS */
> -		uint64_t reserved_49_61:13;	/* Must be zero */
> -		uint64_t io:1;	/* 1 for IO space access */
> -		uint64_t did:5; /* PCIe DID = 3 */
> -		uint64_t subdid:3;	/* PCIe SubDID = 3-6 */
> -		uint64_t reserved_36_39:4;	/* Must be zero */
> -		uint64_t address:36;	/* PCIe Mem address */
> +		__BITFIELD_FIELD(uint64_t upper:2,  /* Normally 2 for XKPHYS */
> +		__BITFIELD_FIELD(uint64_t reserved_49_61:13,  /* Must be zero */
> +		__BITFIELD_FIELD(uint64_t io:1,  /* 1 for IO space access */
> +		__BITFIELD_FIELD(uint64_t did:5,  /* PCIe DID = 3 */
> +		__BITFIELD_FIELD(uint64_t subdid:3,  /* PCIe SubDID = 3-6 */
> +		__BITFIELD_FIELD(uint64_t reserved_36_39:4,  /* Must be zero */
> +		__BITFIELD_FIELD(uint64_t address:36,  /* PCIe Mem address */
> +		;)))))))
>  	} mem;
>  };


--nextPart1620368.gIyHYvCFNz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEELIGR03D5+Fg+69wPgiDZ+mk8HGUFAliwrygACgkQgiDZ+mk8
HGWz8g//cMMnTp/xPXiWW0HgFHEDA+Cnb75uuqgYJ/ARPYmpy5Ex3q6qFMAr2G0G
FCEC11Bd0hD4ufhllSIYew0LkEwjurf4j/hSIX1xtvc5xev8S+OJchbG655H5cb7
Fiyv+eeKBWIFR70nkKoyW8mRqXOp4XTkC05mkdKhZpCIHb02giplm6wHxEd11Bau
lUHCQL6sjcesnmlrT92OPgX51Hop1EsbjFMN1POsXPkeVef83ZwWJcuaaa5LlueK
iI+q2MeX/xqT1UfVqR5sqTVzn+8lCaFAuIAsKxKIvUE6qpq+5EypuPnxiL8GzHca
yMV3d0g7384REtoWG07mfa1CHYyhA1fG99zJxKFpqp9jqmywyxePoJ0r8DR2Bndc
Ef5uJ0x9SMC4qeJVUBY/COHJFlCk5MjoFIwJ5ncMkvES1bdQGVTpW0HQbyweOSwE
fCupiAWOFPPFEdYeg5cCyNGDMZ6e/MZ526k7glOpZRxxzR4TvLAqZKq+dPP2ZvEK
Hvih1YazxJ+tmNBwYgzssyAXC0rCzMStH79oavBumN/2tY/1SKkEH05GPQyWcOE2
PdVqPaTDs2YQdp7TrcBsEalBIUsZ72MweKf4mdroFAAcbJBOcK+NsFS+HZ9ouMZg
UiBwQ0E2DlG7KDVpY6nyKPvLDKd43KU9GLFvSKJR8xNJz8xZw2M=
=1D0q
-----END PGP SIGNATURE-----

--nextPart1620368.gIyHYvCFNz--
