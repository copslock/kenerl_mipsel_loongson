Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jun 2007 12:56:04 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:55027 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20021467AbXFUL4C (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 21 Jun 2007 12:56:02 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 831083EC9; Thu, 21 Jun 2007 04:55:58 -0700 (PDT)
Message-ID: <467A67B6.6090909@ru.mvista.com>
Date:	Thu, 21 Jun 2007 15:57:42 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Daniel Laird <daniel.j.laird@nxp.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Philips(NXP)/STB810 changes
References: <11229250.post@talk.nabble.com>
In-Reply-To: <11229250.post@talk.nabble.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15493
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Daniel Laird wrote:

> We have found the following changes are necessary for the Philips(NXP)/STB810
> platform

> Signed-off-by: Daniel Laird <daniel.j.laird@nxp.com> 

> --- kernel/arch/mips/philips/pnx8550/common/setup.c
> +++ kernel-new/arch/mips/philips/pnx8550/common/setup.c 
> @@ -100,11 +100,29 @@
>  
>  	board_setup();  /* board specific setup */
>  
> -        _machine_restart = pnx8550_machine_restart;
> -        _machine_halt = pnx8550_machine_halt;
> -        pm_power_off = pnx8550_machine_power_off;
> +    _machine_restart = pnx8550_machine_restart;
> +    _machine_halt = pnx8550_machine_halt;
> +    pm_power_off = pnx8550_machine_power_off;

> +	board_time_init = pnx8550_time_init;

> -	board_time_init = pnx8550_time_init;

    What is changed here beside the tab being converted to 4 spaces for no 
reason? This violates kernel style and so is not acceptable.

> +    /* Setup CMEM Registers */
> +    /* CMEM0 = MMIO */
> +    write_c0_diag4((0x1be00000 & PR4450_CMEMF_BBA) |
> +                   (PR4450_CMEM_SIZE_2MB << PR4450_CMEMB_SIZE) |
> +                   (1 << PR4450_CMEMB_VALID));
> +
> +    /* CMEM1 = XIO */
> +    write_c0_diag5((0x10000000 & PR4450_CMEMF_BBA) |
> +                   (PR4450_CMEM_SIZE_128MB << PR4450_CMEMB_SIZE) |
> +                   (1 << PR4450_CMEMB_VALID));
> +
> +    /* CMEM2 = PCI */
> +    write_c0_diag6((0x20000000 & PR4450_CMEMF_BBA) |
> +                   (PR4450_CMEM_SIZE_128MB << PR4450_CMEMB_SIZE) |
> +                   (1 << PR4450_CMEMB_VALID));
> +
> +    /* CMEM3 = Not used */
> +    write_c0_diag7(0);

    Please indent these properly too.

>  
>  	/* Clear the Global 2 Register, PCI Inta Output Enable Registers
>  	   Bit 1:Enable DAC Powerdown

> Cheers
> Dan Laird

WBR, Sergei
