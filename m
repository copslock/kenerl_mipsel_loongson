Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Nov 2004 01:33:37 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:8696 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8224941AbUKWBdd>; Tue, 23 Nov 2004 01:33:33 +0000
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id C238D18503; Mon, 22 Nov 2004 17:33:31 -0800 (PST)
Message-ID: <41A2936B.2000403@mvista.com>
Date: Mon, 22 Nov 2004 17:33:31 -0800
From: Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Manish Lachwani <mlachwani@prometheus.mvista.com>
Cc: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] PCMCIA Subsystem of Toshiba TX4927
References: <20041123013102.GA20638@prometheus.mvista.com>
In-Reply-To: <20041123013102.GA20638@prometheus.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6412
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Hello !

Missed it. This is a 2.4 only patch

Thanks
Manish Lachwani


Manish Lachwani wrote:
> Hi Ralf
> 
> Attached patch gets the PCMCIA to work for the Toshiba TX4927. This has been
> tested with a Linksys PCMCIA ethernet controller. Please review ...
> 
> Thanks
> Manish Lachwani
> 
> 
> 
> ------------------------------------------------------------------------
> 
> --- include/asm-mips/pci.h.orig	2004-11-22 17:37:59.000000000 -0800
> +++ include/asm-mips/pci.h	2004-11-22 17:37:08.000000000 -0800
> @@ -23,6 +23,11 @@
>  #define PCIBIOS_MIN_IO		0x1000
>  #define PCIBIOS_MIN_MEM		0x10000000
>  
> +#ifdef CONFIG_TOSHIBA_RBTX4927
> +#undef PCIBIOS_MIN_MEM
> +#define PCIBIOS_MIN_MEM		0x1000000
> +#endif
> +
>  
>  extern void pcibios_set_master(struct pci_dev *dev);
>  
