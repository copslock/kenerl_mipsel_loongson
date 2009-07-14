Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jul 2009 17:47:08 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:43841 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492552AbZGNPrC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 14 Jul 2009 17:47:02 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a5ca8680001>; Tue, 14 Jul 2009 11:46:48 -0400
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 14 Jul 2009 08:46:44 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 14 Jul 2009 08:46:44 -0700
Message-ID: <4A5CA864.90206@caviumnetworks.com>
Date:	Tue, 14 Jul 2009 08:46:44 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, ralf@linux-mips.org
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix HPAGE_SIZE redifinition
References: <1247578629-23079-1-git-send-email-anemo@mba.ocn.ne.jp>
In-Reply-To: <1247578629-23079-1-git-send-email-anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Jul 2009 15:46:44.0377 (UTC) FILETIME=[49D6D090:01CA049A]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23738
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> This patch fixes warnings like this:
>   CC      fs/proc/meminfo.o
> In file included from /work/linux/include/linux/mmzone.h:20,
>                  from /work/linux/include/linux/gfp.h:4,
>                  from /work/linux/include/linux/mm.h:8,
>                  from /work/linux/fs/proc/meminfo.c:5:
> /work/linux/arch/mips/include/asm/page.h:36:1: warning: "HPAGE_SIZE" redefined
> In file included from /work/linux/fs/proc/meminfo.c:2:
> /work/linux/include/linux/hugetlb.h:107:1: warning: this is the location of the previous definition
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Acked-by: David Daney <ddaney@caviumnetworks.com>


> ---
>  arch/mips/include/asm/page.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
> index 96a14a4..4320239 100644
> --- a/arch/mips/include/asm/page.h
> +++ b/arch/mips/include/asm/page.h
> @@ -32,10 +32,12 @@
>  #define PAGE_SIZE	(1UL << PAGE_SHIFT)
>  #define PAGE_MASK       (~((1 << PAGE_SHIFT) - 1))
>  
> +#ifdef CONFIG_HUGETLB_PAGE
>  #define HPAGE_SHIFT	(PAGE_SHIFT + PAGE_SHIFT - 3)
>  #define HPAGE_SIZE	((1UL) << HPAGE_SHIFT)
>  #define HPAGE_MASK	(~(HPAGE_SIZE - 1))
>  #define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
> +#endif /* CONFIG_HUGETLB_PAGE */
>  
>  #ifndef __ASSEMBLY__
>  
