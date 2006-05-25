Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 May 2006 20:48:03 +0200 (CEST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:2210 "HELO mail.dev.rtsoft.ru")
	by ftp.linux-mips.org with SMTP id S8134086AbWEYSrz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 25 May 2006 20:47:55 +0200
Received: (qmail 20020 invoked from network); 25 May 2006 22:55:42 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 25 May 2006 22:55:42 -0000
Message-ID: <4475FBA5.7050101@ru.mvista.com>
Date:	Thu, 25 May 2006 22:47:01 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Linux-MIPS <linux-mips@linux-mips.org>
CC:	Ralf Baechle <ralf@linux-mips.org>,
	Jordan Crouse <jordan.crouse@amd.com>
Subject: Re: [PATCH] Au1xx0: OHCI region size off-by-one
References: <441F4EBB.6000906@ru.mvista.com>
In-Reply-To: <441F4EBB.6000906@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11550
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello, I wrote:

>    Au1xx0 OHCI driver claims one byte too many for the memory mapped
> controller registers.

> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> ------------------------------------------------------------------------
> 
> diff --git a/arch/mips/au1000/common/platform.c b/arch/mips/au1000/common/platform.c
> index d7a8f0a..79407ab 100644
> --- a/arch/mips/au1000/common/platform.c
> +++ b/arch/mips/au1000/common/platform.c
> @@ -20,7 +20,7 @@
>  static struct resource au1xxx_usb_ohci_resources[] = {
>  	[0] = {
>  		.start		= USB_OHCI_BASE,
> -		.end		= USB_OHCI_BASE + USB_OHCI_LEN,
> +		.end		= USB_OHCI_BASE + USB_OHCI_LEN - 1,
>  		.flags		= IORESOURCE_MEM,
>  	},
>  	[1] = {

   There's no need to apply this anymore -- was covered by Au1200 OCHI patch...

WBR, Sergei
