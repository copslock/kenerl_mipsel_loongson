Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Dec 2008 21:28:58 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:50377 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S24207989AbYLQV2v (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 17 Dec 2008 21:28:51 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49496f0d0002>; Wed, 17 Dec 2008 16:28:45 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 17 Dec 2008 13:21:00 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 17 Dec 2008 13:20:59 -0800
Message-ID: <49496D3B.4090608@caviumnetworks.com>
Date:	Wed, 17 Dec 2008 13:20:59 -0800
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.18 (X11/20081119)
MIME-Version: 1.0
To:	David Daney <ddaney@caviumnetworks.com>
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Define  __arch_swab64 for all mips r2 cpus.
References: <1229546644-3030-1-git-send-email-ddaney@caviumnetworks.com>
In-Reply-To: <1229546644-3030-1-git-send-email-ddaney@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Dec 2008 21:20:59.0901 (UTC) FILETIME=[5B872AD0:01C9608D]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21612
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

David Daney wrote:
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
>  static inline __attribute_const__ __u64 __arch_swab64(__u64 x)
>  {
>  	__asm__(

Although this patch is correct, it is not sufficient.  The
implementation of __arch_swab64 is incorrect and unusable.

My next patch, which fixes it, should probably be applied before this
one.

David Daney
