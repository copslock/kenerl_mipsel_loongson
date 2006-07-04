Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Jul 2006 18:03:59 +0100 (BST)
Received: from smtp2.caviumnetworks.com ([209.113.159.134]:22584 "EHLO
	smtp2.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S8133770AbWGDRDo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 4 Jul 2006 18:03:44 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by smtp2.caviumnetworks.com with NetIQ MailMarshal (v6,0,3,8)
	id <B44aa9f730000>; Tue, 04 Jul 2006 13:03:47 -0400
Received: from [192.168.111.13] ([71.202.53.57]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 4 Jul 2006 10:03:36 -0700
Message-ID: <44AA9F67.3090309@caviumnetworks.com>
Date:	Tue, 04 Jul 2006 10:03:35 -0700
From:	Chad Reese <kreese@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060620 Debian/1.7.13-0.2
X-Accept-Language: en
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] sparsemem fix
References: <20060705.012244.96686002.anemo@mba.ocn.ne.jp>
In-Reply-To: <20060705.012244.96686002.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Jul 2006 17:03:37.0133 (UTC) FILETIME=[CA6205D0:01C69F8B]
Return-Path: <Kenneth.Reese@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11907
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kreese@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

I believe Ralf committed a cleaned up version of the patch I created 
5/23/2006. It called memory_present() after the first bootmap memory was 
created. I've been using this and dynamic sparsemem on Mips64 for a 
while now.

Hope this helps,

Chad

Atsushi Nemoto wrote:

>1. MIPS should select SPARSEMEM_STATIC since allocating bootmem in
>   memory_present() will corrupt bootmap area.
>2. pfn_valid() for SPARSEMEM is defined in linux/mmzone.h
>
>Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
>
>diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
>index f151a7e..879a19c 100644
>--- a/arch/mips/Kconfig
>+++ b/arch/mips/Kconfig
>@@ -1690,6 +1690,7 @@ config ARCH_DISCONTIGMEM_ENABLE
> 
> config ARCH_SPARSEMEM_ENABLE
> 	bool
>+	select SPARSEMEM_STATIC
> 
> config NUMA
> 	bool "NUMA Support"
>diff --git a/include/asm-mips/page.h b/include/asm-mips/page.h
>index 6b97744..6ed1151 100644
>--- a/include/asm-mips/page.h
>+++ b/include/asm-mips/page.h
>@@ -138,16 +138,14 @@ #define __va(x)			((void *)((unsigned lo
> 
> #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
> 
>-#ifndef CONFIG_SPARSEMEM
>-#ifndef CONFIG_NEED_MULTIPLE_NODES
>-#define pfn_valid(pfn)		((pfn) < max_mapnr)
>-#endif
>-#endif
>-
> #ifdef CONFIG_FLATMEM
> 
> #define pfn_valid(pfn)		((pfn) < max_mapnr)
> 
>+#elif defined(CONFIG_SPARSEMEM)
>+
>+/* pfn_valid is defined in linux/mmzone.h */
>+
> #elif defined(CONFIG_NEED_MULTIPLE_NODES)
> 
> #define pfn_valid(pfn)							\
>@@ -159,8 +157,6 @@ ({									\
> 	            : 0);						\
> })
> 
>-#else
>-#error Provide a definition of pfn_valid
> #endif
> 
> #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
>
>  
>
