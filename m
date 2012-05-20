Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 May 2012 07:23:34 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:53690 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903258Ab2ETFXb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 20 May 2012 07:23:31 +0200
Received: by dadm1 with SMTP id m1so6275811dad.36
        for <linux-mips@linux-mips.org>; Sat, 19 May 2012 22:23:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:subject:to:cc:in-reply-to:references:date:message-id
         :x-gm-message-state;
        bh=ZhqD1G/pZvtD5obSqsVaLuPpc01Xc/CL3m1+csdQoW0=;
        b=O7snxMFb27Kg0cXSwY7lteY3NohekKA8CCyiNLwa9EHzb4rSI/H7hCCZf/jvRmYSHh
         XXtnJDYZ5NWnqy1yVhRQooGAtLuCT6XvxdACrBtZlMqOVctD4szbZ2rpGfCGQrJCpBuB
         3IlenG91EDcXaUOi2XVB5cQW2xAfot8bv/T6l+yfpmCHRP0i/T+wHH/RVtwZSXSjDZpJ
         eCYiNb4ukKLTa6p4r3RAEg+vXhNF2c+Re+BixqeoxXT9gtBcblv1i2pKuzHfeFT3SXLA
         0R5s6Akv/SQFIA2ukHPqvOQVdm0CV4yCHSD8xHXYAQoEhP70ALVDHgen904ihNfUPMgu
         2fpg==
Received: by 10.68.222.74 with SMTP id qk10mr9546147pbc.67.1337491404658;
        Sat, 19 May 2012 22:23:24 -0700 (PDT)
Received: from localhost (S0106d8b37715ee14.cg.shawcable.net. [68.146.14.168])
        by mx.google.com with ESMTPS id os2sm13050811pbc.12.2012.05.19.22.23.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 19 May 2012 22:23:24 -0700 (PDT)
Received: by localhost (Postfix, from userid 1000)
        id 1CDE53E03B8; Sat, 19 May 2012 23:23:23 -0600 (MDT)
From:   Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/2] MIPS: OCTEON: Add register definitions for SPI host hardware.
To:     David Daney <ddaney.cavm@gmail.com>,
        devicetree-discuss@lists.ozlabs.org,
        Rob Herring <rob.herring@calxeda.com>,
        spi-devel-general@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-doc@vger.kernel.org, David Daney <david.daney@cavium.com>
In-Reply-To: <1336772086-17248-2-git-send-email-ddaney.cavm@gmail.com>
References: <1336772086-17248-1-git-send-email-ddaney.cavm@gmail.com> <1336772086-17248-2-git-send-email-ddaney.cavm@gmail.com>
Date:   Sat, 19 May 2012 23:23:23 -0600
Message-Id: <20120520052323.1CDE53E03B8@localhost>
X-Gm-Message-State: ALoCoQm8G334flucEVdJ6fz3TOVcHTKQ6gis9AChYLrK6k8gDjhr8qsGPPCIZdBQ/Paj3jMQx/FM
X-archive-position: 33378
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Fri, 11 May 2012 14:34:45 -0700, David Daney <ddaney.cavm@gmail.com> wrote:
> From: David Daney <david.daney@cavium.com>
> 
> Needed by SPI driver.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  arch/mips/include/asm/octeon/cvmx-mpi-defs.h |  328 ++++++++++++++++++++++++++
>  1 files changed, 328 insertions(+), 0 deletions(-)
>  create mode 100644 arch/mips/include/asm/octeon/cvmx-mpi-defs.h
> 
> diff --git a/arch/mips/include/asm/octeon/cvmx-mpi-defs.h b/arch/mips/include/asm/octeon/cvmx-mpi-defs.h
> new file mode 100644
> index 0000000..4615b10
> --- /dev/null
> +++ b/arch/mips/include/asm/octeon/cvmx-mpi-defs.h
> @@ -0,0 +1,328 @@
> +/***********************license start***************
> + * Author: Cavium Networks
> + *
> + * Contact: support@caviumnetworks.com
> + * This file is part of the OCTEON SDK
> + *
> + * Copyright (c) 2003-2012 Cavium Networks
> + *
> + * This file is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License, Version 2, as
> + * published by the Free Software Foundation.
> + *
> + * This file is distributed in the hope that it will be useful, but
> + * AS-IS and WITHOUT ANY WARRANTY; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE, TITLE, or
> + * NONINFRINGEMENT.  See the GNU General Public License for more
> + * details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this file; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
> + * or visit http://www.gnu.org/licenses/.
> + *
> + * This file may also be available under a different license from Cavium.
> + * Contact Cavium Networks for more information
> + ***********************license end**************************************/
> +
> +#ifndef __CVMX_MPI_DEFS_H__
> +#define __CVMX_MPI_DEFS_H__
> +
> +#define CVMX_MPI_CFG (CVMX_ADD_IO_SEG(0x0001070000001000ull))
> +#define CVMX_MPI_DATX(offset) (CVMX_ADD_IO_SEG(0x0001070000001080ull) + ((offset) & 15) * 8)
> +#define CVMX_MPI_STS (CVMX_ADD_IO_SEG(0x0001070000001008ull))
> +#define CVMX_MPI_TX (CVMX_ADD_IO_SEG(0x0001070000001010ull))
> +
> +union cvmx_mpi_cfg {
> +	uint64_t u64;
> +	struct cvmx_mpi_cfg_s {
> +#ifdef __BIG_ENDIAN_BITFIELD
> +		uint64_t reserved_29_63:35;
> +		uint64_t clkdiv:13;
> +		uint64_t csena3:1;
> +		uint64_t csena2:1;
> +		uint64_t csena1:1;
> +		uint64_t csena0:1;
> +		uint64_t cslate:1;
> +		uint64_t tritx:1;
> +		uint64_t idleclks:2;
> +		uint64_t cshi:1;
> +		uint64_t csena:1;
> +		uint64_t int_ena:1;
> +		uint64_t lsbfirst:1;
> +		uint64_t wireor:1;
> +		uint64_t clk_cont:1;
> +		uint64_t idlelo:1;
> +		uint64_t enable:1;
> +#else
> +		uint64_t enable:1;
> +		uint64_t idlelo:1;
> +		uint64_t clk_cont:1;
> +		uint64_t wireor:1;
> +		uint64_t lsbfirst:1;
> +		uint64_t int_ena:1;
> +		uint64_t csena:1;
> +		uint64_t cshi:1;
> +		uint64_t idleclks:2;
> +		uint64_t tritx:1;
> +		uint64_t cslate:1;
> +		uint64_t csena0:1;
> +		uint64_t csena1:1;
> +		uint64_t csena2:1;
> +		uint64_t csena3:1;
> +		uint64_t clkdiv:13;
> +		uint64_t reserved_29_63:35;
> +#endif
> +	} s;

:-/  I'm not a fan of bitfields for register access. I'd much rather
have macros the various bit positions; but given that this live under
arch/mips I can't really say much and you can add my acked-by if you
need to.
