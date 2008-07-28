Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jul 2008 08:08:58 +0100 (BST)
Received: from smtp.movial.fi ([62.236.91.34]:53159 "EHLO smtp.movial.fi")
	by ftp.linux-mips.org with ESMTP id S20022597AbYG1HIs (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 28 Jul 2008 08:08:48 +0100
Received: from localhost (mailscanner.hel.movial.fi [172.17.81.9])
	by smtp.movial.fi (Postfix) with ESMTP id 5883FC808B;
	Mon, 28 Jul 2008 10:08:42 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at movial.fi
Received: from smtp.movial.fi ([62.236.91.34])
	by localhost (mailscanner.hel.movial.fi [172.17.81.9]) (amavisd-new, port 10026)
	with ESMTP id h8l8Nrg3NyW7; Mon, 28 Jul 2008 10:08:42 +0300 (EEST)
Received: from [172.17.49.48] (sd048.hel.movial.fi [172.17.49.48])
	by smtp.movial.fi (Postfix) with ESMTP id 2CA74C8084;
	Mon, 28 Jul 2008 10:08:42 +0300 (EEST)
Message-ID: <488D707A.4090800@movial.fi>
Date:	Mon, 28 Jul 2008 10:08:42 +0300
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
Organization: Movial Creative Technologies
User-Agent: Icedove 1.5.0.14eol (X11/20080509)
MIME-Version: 1.0
To:	Kevin Hickey <khickey@rmicorp.com>
CC:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/1] Initialization of Alchemy boards
References: <1217002430.10968.30.camel@kh-ubuntu.razamicroelectronics.com>
In-Reply-To: <1217002430.10968.30.camel@kh-ubuntu.razamicroelectronics.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <dmitri.vorobiev@movial.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19985
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.fi
Precedence: bulk
X-list: linux-mips

Kevin Hickey wrote:
> I found this when I updated to version 2.6.26.  None of my development
> boards would boot.  It appears that a previous update changed some calls
> to simple_strtol to strict_strtol but did not account for the different
> call semantics.

Hi Kevin,

1) you forgot to sign your patch off;
2) please consider using git to generate and submit patches. At least according to my experience, it's much more convenient than any other approach.
3) As I can see, the board-specific code is almost identical for the pb1x00 boards. While at it, would you please try to merge it?

Regards,
Dmitri

> 
> Index: arch/mips/au1000/pb1000/init.c
> ===================================================================
> --- arch/mips/au1000/pb1000/init.c
> +++ arch/mips/au1000/pb1000/init.c
> @@ -52,6 +52,6 @@
>  	if (!memsize_str)
>  		memsize = 0x04000000;
>  	else
> -		memsize = strict_strtol(memsize_str, 0, NULL);
> +		strict_strtol(memsize_str, 0, &memsize);
>  	add_memory_region(0, memsize, BOOT_MEM_RAM);
>  }
> Index: arch/mips/au1000/pb1100/init.c
> ===================================================================
> --- arch/mips/au1000/pb1100/init.c
> +++ arch/mips/au1000/pb1100/init.c
> @@ -54,7 +54,7 @@
>  	if (!memsize_str)
>  		memsize = 0x04000000;
>  	else
> -		memsize = strict_strtol(memsize_str, 0, NULL);
> +		strict_strtol(memsize_str, 0, &memsize);
>  
>  	add_memory_region(0, memsize, BOOT_MEM_RAM);
>  }
> Index: arch/mips/au1000/pb1200/init.c
> ===================================================================
> --- arch/mips/au1000/pb1200/init.c
> +++ arch/mips/au1000/pb1200/init.c
> @@ -53,6 +53,6 @@
>  	if (!memsize_str)
>  		memsize = 0x08000000;
>  	else
> -		memsize = strict_strtol(memsize_str, 0, NULL);
> +		strict_strtol(memsize_str, 0, &memsize);
>  	add_memory_region(0, memsize, BOOT_MEM_RAM);
>  }
> Index: arch/mips/au1000/mtx-1/init.c
> ===================================================================
> --- arch/mips/au1000/mtx-1/init.c
> +++ arch/mips/au1000/mtx-1/init.c
> @@ -55,6 +55,6 @@
>  	if (!memsize_str)
>  		memsize = 0x04000000;
>  	else
> -		memsize = strict_strtol(memsize_str, 0, NULL);
> +		strict_strtol(memsize_str, 0, &memsize);
>  	add_memory_region(0, memsize, BOOT_MEM_RAM);
>  }
> Index: arch/mips/au1000/pb1500/init.c
> ===================================================================
> --- arch/mips/au1000/pb1500/init.c
> +++ arch/mips/au1000/pb1500/init.c
> @@ -53,6 +53,6 @@
>  	if (!memsize_str)
>  		memsize = 0x04000000;
>  	else
> -		memsize = strict_strtol(memsize_str, 0, NULL);
> +		strict_strtol(memsize_str, 0, &memsize);
>  	add_memory_region(0, memsize, BOOT_MEM_RAM);
>  }
> Index: arch/mips/au1000/xxs1500/init.c
> ===================================================================
> --- arch/mips/au1000/xxs1500/init.c
> +++ arch/mips/au1000/xxs1500/init.c
> @@ -53,6 +53,6 @@
>  	if (!memsize_str)
>  		memsize = 0x04000000;
>  	else
> -		memsize = strict_strtol(memsize_str, 0, NULL);
> +		strict_strtol(memsize_str, 0, &memsize);
>  	add_memory_region(0, memsize, BOOT_MEM_RAM);
>  }
> Index: arch/mips/au1000/pb1550/init.c
> ===================================================================
> --- arch/mips/au1000/pb1550/init.c
> +++ arch/mips/au1000/pb1550/init.c
> @@ -53,6 +53,6 @@
>  	if (!memsize_str)
>  		memsize = 0x08000000;
>  	else
> -		memsize = strict_strtol(memsize_str, 0, NULL);
> +		strict_strtol(memsize_str, 0, &memsize);
>  	add_memory_region(0, memsize, BOOT_MEM_RAM);
>  }
> Index: arch/mips/au1000/db1x00/init.c
> ===================================================================
> --- arch/mips/au1000/db1x00/init.c
> +++ arch/mips/au1000/db1x00/init.c
> @@ -57,6 +57,6 @@
>  	if (!memsize_str)
>  		memsize = 0x04000000;
>  	else
> -		memsize = strict_strtol(memsize_str, 0, NULL);
> +		strict_strtol(memsize_str, 0, &memsize);
>  	add_memory_region(0, memsize, BOOT_MEM_RAM);
>  }
> 
