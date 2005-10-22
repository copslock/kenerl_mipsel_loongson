Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Oct 2005 21:21:52 +0100 (BST)
Received: from [85.21.88.2] ([85.21.88.2]:5333 "HELO mail.dev.rtsoft.ru")
	by ftp.linux-mips.org with SMTP id S8133481AbVJVUVa (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 22 Oct 2005 21:21:30 +0100
Received: (qmail 23300 invoked from network); 22 Oct 2005 20:21:23 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 22 Oct 2005 20:21:23 -0000
Message-ID: <435A9FB2.3070303@ru.mvista.com>
Date:	Sun, 23 Oct 2005 00:23:14 +0400
From:	Sergei Shtylylov <sshtylyov@ru.mvista.com>
Organization: RTSoft, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Linux MIPS Development <linux-mips@linux-mips.org>
CC:	Manish Lachwani <mlachwani@mvista.com>
Subject: Re: Misc. AMD DBAu1550 fixes
References: <4357F774.9010208@ru.mvista.com>
In-Reply-To: <4357F774.9010208@ru.mvista.com>
Content-Type: multipart/mixed;
 boundary="------------050706090906060006000301"
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9342
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------050706090906060006000301
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello, I wrote:

>     Here's a couple of DBAu1550 fixes: the first one fixes BCSR accesses in
> the board setup/reset code (the registers are actually 16-bit, and their
> addresses are different between DBAu1550 and other DBAu1xx0 boards), the

    Here's an updated BCSR patch. Stupid typo. :-/

> second one just selects the proper machine type for DBAu1550.

   It was somewhat incomplete, more #ifdef's are needed to set the proper 
machine types for DB1100/DB1500...

> ------------------------------------------------------------------------
> 
> Index: linux/arch/mips/au1000/db1x00/board_setup.c
> ===================================================================
> --- linux.orig/arch/mips/au1000/db1x00/board_setup.c
> +++ linux/arch/mips/au1000/db1x00/board_setup.c
> @@ -45,13 +45,12 @@
>  #include <asm/mach-au1x00/au1000.h>
>  #include <asm/mach-db1x00/db1x00.h>
>  
> -/* not correct for db1550 */
> -static BCSR * const bcsr = (BCSR *)0xAE000000;
> +static BCSR * const bcsr = (BCSR *)BCSR_KSEG1_ADDR;
>  
>  void board_reset (void)
>  {
>  	/* Hit BCSR.SYSTEM_CONTROL[SW_RST] */
> -	au_writel(0x00000000, 0xAE00001C);
> +	bcsr->swreset = 0x0000);

   My bad. Really don't know how this paren got there. :-/

WBR, Sergei

--------------050706090906060006000301
Content-Type: text/plain;
 name="db1550-bcsr-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="db1550-bcsr-fix.patch"

Index: linux/arch/mips/au1000/db1x00/board_setup.c
===================================================================
--- linux.orig/arch/mips/au1000/db1x00/board_setup.c
+++ linux/arch/mips/au1000/db1x00/board_setup.c
@@ -45,13 +45,12 @@
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-db1x00/db1x00.h>
 
-/* not correct for db1550 */
-static BCSR * const bcsr = (BCSR *)0xAE000000;
+static BCSR * const bcsr = (BCSR *)BCSR_KSEG1_ADDR;
 
 void board_reset (void)
 {
 	/* Hit BCSR.SYSTEM_CONTROL[SW_RST] */
-	au_writel(0x00000000, 0xAE00001C);
+	bcsr->swreset = 0x0000;
 }
 
 void __init board_setup(void)
@@ -75,7 +75,7 @@ void __init board_setup(void)
 	bcsr->resets |= BCSR_RESETS_IRDA_MODE_OFF;
 	au_sync();
 #endif
-	au_writel(0, 0xAE000010); /* turn off pcmcia power */
+	bcsr->pcmcia = 0x0000; /* turn off PCMCIA power */
 
 #ifdef CONFIG_MIPS_MIRAGE
 	/* enable GPIO[31:0] inputs */

--------------050706090906060006000301--
