Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Jun 2009 20:55:47 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:33430 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493023AbZF1Szk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 28 Jun 2009 20:55:40 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n5SIomIQ024649;
	Sun, 28 Jun 2009 19:50:48 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n5SIomv1024647;
	Sun, 28 Jun 2009 19:50:48 +0100
Date:	Sun, 28 Jun 2009 19:50:48 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Define  __arch_swab64 for all mips r2 cpus.
Message-ID: <20090628185048.GB23369@linux-mips.org>
References: <1246032168-31411-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1246032168-31411-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23526
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jun 26, 2009 at 09:02:48AM -0700, David Daney wrote:

> Some CPUs implement mipsr2, but because they are a super-set of
> mips64r2 do not define CONFIG_CPU_MIPS64_R2.  Cavium OCTEON falls into
> this category.  We would still like to use the optimized
> implementation, so since we have already checked for
> CONFIG_CPU_MIPSR2, checking for CONFIG_64BIT instead of
> CONFIG_CPU_MIPS64_R2 is sufficient.
> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> ---
>  arch/mips/include/asm/swab.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/mips/include/asm/swab.h b/arch/mips/include/asm/swab.h
> index 99993c0..e5b9161 100644
> --- a/arch/mips/include/asm/swab.h
> +++ b/arch/mips/include/asm/swab.h
> @@ -38,7 +38,7 @@ static inline __attribute_const__ __u32 __arch_swab32(__u32 x)
>  }
>  #define __arch_swab32 __arch_swab32
>  
> -#ifdef CONFIG_CPU_MIPS64_R2
> +#ifdef CONFIG_64BIT

You just broke support for non-R2 64-bit processors.

  Ralf
