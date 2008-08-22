Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Aug 2008 10:41:31 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:10043 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20035044AbYHVJlY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 22 Aug 2008 10:41:24 +0100
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 9EA093ECB; Fri, 22 Aug 2008 02:41:19 -0700 (PDT)
Message-ID: <48AE89BC.3070204@ru.mvista.com>
Date:	Fri, 22 Aug 2008 13:41:16 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
MIME-Version: 1.0
To:	Florian Fainelli <florian@openwrt.org>
Cc:	linux-mips <linux-mips@linux-mips.org>, ralf@linux-mips.org
Subject: Re: [PATCH 3/6] rb532: do not KSEG1ADDR an already virtual address
References: <200808220014.39030.florian@openwrt.org>
In-Reply-To: <200808220014.39030.florian@openwrt.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20321
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Florian Fainelli wrote:
> This patch removes the superfluous double KSEG1ADDR
> against the base register in the setup code.
>
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
> diff --git a/arch/mips/rb532/setup.c b/arch/mips/rb532/setup.c
> index 7aafa95..6d3286e 100644
> --- a/arch/mips/rb532/setup.c
> +++ b/arch/mips/rb532/setup.c
> @@ -10,6 +10,7 @@
>  #include <linux/ioport.h>
>  
>  #include <asm/mach-rc32434/rc32434.h>
> +#include <asm/mach-rc32434/rb.h>
>  #include <asm/mach-rc32434/pci.h>
>  
>  struct pci_reg __iomem *pci_reg;
> @@ -27,7 +28,7 @@ static struct resource pci0_res[] = {
>  static void rb_machine_restart(char *command)
>  {
>  	/* just jump to the reset vector */
> -	writel(0x80000001, (void *)KSEG1ADDR(RC32434_REG_BASE + RC32434_RST));
> +	writel(0x80000001, (void *)KSEG1ADDR(REG_BASE + RC32434_RST));
>   

   Why not just leave RC32434_REG_BASE + RC32434_RST and remove 
KSEG1ADDR? BTW, the cast could be removed as well, since it's already a 
part of RC32434_REG_BASE...

WBR, Sergei
