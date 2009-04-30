Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Apr 2009 17:00:27 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:19372 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20026594AbZD3QAV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 30 Apr 2009 17:00:21 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49f9caf60000>; Thu, 30 Apr 2009 11:59:50 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 30 Apr 2009 08:54:10 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 30 Apr 2009 08:54:10 -0700
Message-ID: <49F9C9A2.2000602@caviumnetworks.com>
Date:	Thu, 30 Apr 2009 08:54:10 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	Florian Fainelli <florian@openwrt.org>,
	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH] flash_setup should only be built when CONFIG_MTD is enabled
References: <200904301748.52718.florian@openwrt.org>
In-Reply-To: <200904301748.52718.florian@openwrt.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Apr 2009 15:54:10.0643 (UTC) FILETIME=[E6DA5A30:01C9C9AB]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22555
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Florian Fainelli wrote:

> This patch makes flash_setup be compiled only when CONFIG_MTD
> which solves issue, the MTD driver then fails to register but this is
> less critical.
> 
> CC: David Daney <ddaney@caviumnetworks.com>
> Signed-off-by: Florian Fainelli <florian@openwrt.org>

Acked-by: David Daney <ddaney@caviumnetworks.com>

> ---
> diff --git a/arch/mips/cavium-octeon/Makefile b/arch/mips/cavium-octeon/Makefile
> index d6903c3..32bdc81 100644
> --- a/arch/mips/cavium-octeon/Makefile
> +++ b/arch/mips/cavium-octeon/Makefile
> @@ -10,9 +10,10 @@
>  #
>  
>  obj-y := setup.o serial.o octeon-irq.o csrc-octeon.o
> -obj-y += dma-octeon.o flash_setup.o
> +obj-y += dma-octeon.o
>  obj-y += octeon-memcpy.o
>  
>  obj-$(CONFIG_SMP)                     += smp.o
> +obj-$(CONFIG_MTD)		+= flash_setup.o
>  
>  EXTRA_CFLAGS += -Werror
> 
