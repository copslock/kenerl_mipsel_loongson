Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2006 16:28:01 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.134]:6585 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S28573724AbWJSP1x (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Oct 2006 16:27:53 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id DC195D634E;
	Thu, 19 Oct 2006 11:27:45 -0400 (EDT)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Thu, 19 Oct 2006 11:27:45 -0400 (EDT)
Received: from [192.168.7.26] ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 19 Oct 2006 08:27:45 -0700
Message-ID: <45379971.6070803@avtrex.com>
Date:	Thu, 19 Oct 2006 08:27:45 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] Use "long" for 64-bit values on 64-bit kernel.
References: <20061019.231645.126573493.anemo@mba.ocn.ne.jp>
In-Reply-To: <20061019.231645.126573493.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Oct 2006 15:27:45.0241 (UTC) FILETIME=[20303490:01C6F393]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13037
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> Just resend again to avoid being obscured by discussion.
> 
> This would get rid of some warnings about "long" vs. "long long".
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> 
> diff --git a/include/asm-mips/addrspace.h b/include/asm-mips/addrspace.h
> index 45c706e..7401711 100644
> --- a/include/asm-mips/addrspace.h
> +++ b/include/asm-mips/addrspace.h
> @@ -19,12 +19,17 @@ #ifdef __ASSEMBLY__
>  #define _ATYPE_
>  #define _ATYPE32_
>  #define _ATYPE64_
> -#define _LLCONST_(x)	x
> +#define _CONST64_(x)	x
>  #else
>  #define _ATYPE_		__PTRDIFF_TYPE__
>  #define _ATYPE32_	int
> +#ifdef CONFIG_64BIT
> +#define _ATYPE64_	long
> +#define _CONST64_(x)	x ## L
> +#else
>  #define _ATYPE64_	long long
> -#define _LLCONST_(x)	x ## LL
> +#define _CONST64_(x)	x ## LL
> +#endif
>  #endif

This duplicates the things in asm-mips/types.h.  Is there some reason 
that we cannot use s64/u64 instead of long/long long?


David Daney.
