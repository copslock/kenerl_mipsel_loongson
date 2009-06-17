Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jun 2009 21:38:57 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:25292 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492005AbZFQTiu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 17 Jun 2009 21:38:50 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a3945490000>; Wed, 17 Jun 2009 15:34:38 -0400
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 17 Jun 2009 12:33:37 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 17 Jun 2009 12:33:37 -0700
Message-ID: <4A394511.6000705@caviumnetworks.com>
Date:	Wed, 17 Jun 2009 12:33:37 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	Zhang Le <r0bertz@gentoo.org>, Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org, manuel.lauss@gmail.com
Subject: Re: [PATCH v2] -git compile fixes for MIPS
References: <1245266590-31999-1-git-send-email-r0bertz@gentoo.org>
In-Reply-To: <1245266590-31999-1-git-send-email-r0bertz@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 17 Jun 2009 19:33:37.0422 (UTC) FILETIME=[82B162E0:01C9EF82]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23455
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Zhang Le wrote:
> Quick fixes for some compile failures which have cropped up
> in linus-git in the last 24 hours:
> 
>    CC      arch/mips/kernel/time.o
> In file included from linux-2.6.git/include/linux/bug.h:4,
>                   from linux-2.6.git/arch/mips/kernel/time.c:13:
> linux-2.6.git/arch/mips/include/asm/bug.h:10: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'BUG'
> linux-2.6.git/arch/mips/include/asm/bug.h: In function '__BUG_ON':
> linux-2.6.git/arch/mips/include/asm/bug.h:26: error: implicit declaration of function 'BUG'
> 
>   CC      arch/mips/kernel/traps.o
> cc1: warnings being treated as errors
> /home/zhangle/linux/arch/mips/kernel/traps.c: In function ‘set_uncached_handler’:
> /home/zhangle/linux/arch/mips/kernel/traps.c:1604: error: format not a string literal and no format arguments
> 
>    CC      arch/mips/mm/uasm.o
> In file included from linux-2.6.git/arch/mips/mm/uasm.c:21:
> linux-2.6.git/arch/mips/include/asm/bugs.h: In function 'check_bugs':
> linux-2.6.git/arch/mips/include/asm/bugs.h:34: error: implicit declaration of function 'smp_processor_id'
> linux-2.6.git/arch/mips/mm/uasm.c: In function 'uasm_copy_handler':
> linux-2.6.git/arch/mips/mm/uasm.c:514: error: implicit declaration of function 'memcpy'
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> Signed-off-by: Zhang Le <r0bertz@gentoo.org>

This one looks better.  However...

> ---
>  arch/mips/include/asm/bug.h  |    1 +
>  arch/mips/include/asm/bugs.h |    1 +
>  arch/mips/kernel/traps.c     |    2 +-
>  arch/mips/mm/uasm.c          |    1 +
>  4 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/mips/include/asm/bug.h b/arch/mips/include/asm/bug.h
> index 08ea468..974b161 100644
> --- a/arch/mips/include/asm/bug.h
> +++ b/arch/mips/include/asm/bug.h
> @@ -6,6 +6,7 @@
>  #ifdef CONFIG_BUG
>  
>  #include <asm/break.h>
> +#include <linux/compiler.h>

... usually you put linux/ before asm/

You could add: Reviewed-by: David Daney <ddaney@caviumnetworks.com>

with that change.


>  
>  static inline void __noreturn BUG(void)
>  {
> diff --git a/arch/mips/include/asm/bugs.h b/arch/mips/include/asm/bugs.h
> index 9dc10df..b160a70 100644
> --- a/arch/mips/include/asm/bugs.h
> +++ b/arch/mips/include/asm/bugs.h
> @@ -11,6 +11,7 @@
>  
>  #include <linux/bug.h>
>  #include <linux/delay.h>
> +#include <linux/smp.h>
>  
>  #include <asm/cpu.h>
>  #include <asm/cpu-info.h>
> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> index 08f1edf..0e9922b 100644
> --- a/arch/mips/kernel/traps.c
> +++ b/arch/mips/kernel/traps.c
> @@ -1601,7 +1601,7 @@ void __cpuinit set_uncached_handler(unsigned long offset, void *addr,
>  #endif
>  
>  	if (!addr)
> -		panic(panic_null_cerr);
> +		panic("%s", panic_null_cerr);
>  
>  	memcpy((void *)(uncached_ebase + offset), addr, size);
>  }
> diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
> index f467199..ba538f7 100644
> --- a/arch/mips/mm/uasm.c
> +++ b/arch/mips/mm/uasm.c
> @@ -15,6 +15,7 @@
>  #include <linux/kernel.h>
>  #include <linux/types.h>
>  #include <linux/init.h>
> +#include <linux/string.h>
>  
>  #include <asm/inst.h>
>  #include <asm/elf.h>
