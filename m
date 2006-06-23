Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jun 2006 17:14:39 +0100 (BST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:10375 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133547AbWFWQO2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Jun 2006 17:14:28 +0100
Received: (qmail 8096 invoked from network); 23 Jun 2006 20:25:53 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 23 Jun 2006 20:25:53 -0000
Message-ID: <449C131B.5090406@ru.mvista.com>
Date:	Fri, 23 Jun 2006 20:13:15 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Domen Puncer <domen.puncer@ultra.si>
CC:	linux-mips@linux-mips.org
Subject: Re: [patch 2/8] au1xxx: I2C fixes
References: <20060623095703.GA30980@domen.ultra.si> <20060623095858.GB31017@domen.ultra.si>
In-Reply-To: <20060623095858.GB31017@domen.ultra.si>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11832
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Domen Puncer wrote:
> - I2C fixes from Jordan Crusoe
> - add SMBUS functionality flags
> 
> Signed-off-by: Domen Puncer <domen.puncer@ultra.si>
> 
> Index: linux-mailed/drivers/i2c/busses/i2c-au1550.c
> ===================================================================
> --- linux-mailed.orig/drivers/i2c/busses/i2c-au1550.c
> +++ linux-mailed/drivers/i2c/busses/i2c-au1550.c
> @@ -35,7 +35,7 @@
>  #include <linux/i2c.h>
>  
>  #include <asm/mach-au1x00/au1000.h>

    <asm/mach-au1x00/au1xxx.h> also #include's that file, BTW. So, could be 
omitted here...

> -#include <asm/mach-pb1x00/pb1550.h>
> +#include <asm/mach-au1x00/au1xxx.h>
>  #include <asm/mach-au1x00/au1xxx_psc.h>
>  
>  #include "i2c-au1550.h"

WBR, Sergei
