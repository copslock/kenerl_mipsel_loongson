Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2008 08:07:46 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:27367 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S24006162AbYLRIHn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 18 Dec 2008 08:07:43 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id mBI87fg2028704;
	Thu, 18 Dec 2008 08:07:41 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id mBI87e3F028702;
	Thu, 18 Dec 2008 08:07:40 GMT
Date:	Thu, 18 Dec 2008 08:07:40 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Define  __arch_swab64 for all mips r2 cpus.
Message-ID: <20081218080740.GA15338@linux-mips.org>
References: <1229546644-3030-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1229546644-3030-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21620
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 17, 2008 at 12:44:04PM -0800, David Daney wrote:

> Some CPUs implement mipsr2, but because they are a super-set of
> mips64r2 do not define CONFIG_CPU_MIPS64_R2.  Cavium OCTEON falls into
> this category.  We would still like to use the optimized
> implementation, so since we have already checked for
> CONFIG_CPU_MIPSR2, checking for CONFIG_64BIT instead of
> CONFIG_CPU_MIPS64_R2 is sufficient.
> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> ---
>  arch/mips/include/asm/byteorder.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/mips/include/asm/byteorder.h b/arch/mips/include/asm/byteorder.h
> index 2988d29..92ec1e1 100644
> --- a/arch/mips/include/asm/byteorder.h
> +++ b/arch/mips/include/asm/byteorder.h
> @@ -46,7 +46,7 @@ static inline __attribute_const__ __u32 __arch_swab32(__u32 x)
>  }
>  #define __arch_swab32 __arch_swab32
>  
> -#ifdef CONFIG_CPU_MIPS64_R2
> +#ifdef CONFIG_64BIT

This breaks every non-R2 64-bit processor.

  Ralf
