Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 May 2006 17:01:15 +0200 (CEST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:9177 "HELO mail.dev.rtsoft.ru")
	by ftp.linux-mips.org with SMTP id S8133951AbWESPBG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 19 May 2006 17:01:06 +0200
Received: (qmail 28368 invoked from network); 19 May 2006 19:08:05 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 19 May 2006 19:08:05 -0000
Message-ID: <446DDD75.8080700@ru.mvista.com>
Date:	Fri, 19 May 2006 19:00:05 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Jordan Crouse <jordan.crouse@amd.com>
CC:	linux-mips@linux-mips.org
Subject: Re: I2C troubles with Au1550
References: <ecb4efd10605181454v34ef19degf2cdd2535b37fc30@mail.gmail.com> <20060519143247.GC9596@cosmic.amd.com>
In-Reply-To: <20060519143247.GC9596@cosmic.amd.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11496
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Jordan Crouse wrote:
> On 18/05/06 17:54 -0400, Clem Taylor wrote:
> 
>>Maybe Jordan could try again with a fresh patch because it really does
>>seem to help...
> 
>  
> Here you go, fresh out of the oven.. :)

[...]

> --- a/drivers/i2c/busses/i2c-au1550.c
> +++ b/drivers/i2c/busses/i2c-au1550.c
> @@ -35,7 +35,15 @@ #include <linux/errno.h>
>  #include <linux/i2c.h>
>  
>  #include <asm/mach-au1x00/au1000.h>
> -#include <asm/mach-pb1x00/pb1550.h>
> +#if defined(CONFIG_MIPS_PB1550)
> + #include <asm/mach-pb1x00/pb1550.h>
> +#endif
> +#if defined(CONFIG_MIPS_PB1200)
> + #include <asm/mach-pb1x00/pb1200.h>
> +#endif
> +#if defined(CONFIG_MIPS_DB1200)
> + #include <asm/mach-db1x00/db1200.h>
> +#endif

    Instead of all this, just #include <asm/mach-au1x00/au1xxx.h>

WBR, Sergei
