Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Mar 2008 14:16:21 +0100 (CET)
Received: from h155.mvista.com ([63.81.120.155]:47150 "EHLO imap.sh.mvista.com")
	by lappi.linux-mips.net with ESMTP id S523995AbYC0NQR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 27 Mar 2008 14:16:17 +0100
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 6B61B3EC9; Thu, 27 Mar 2008 06:15:44 -0700 (PDT)
Message-ID: <47EB9E55.4040800@ru.mvista.com>
Date:	Thu, 27 Mar 2008 16:17:09 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] Alchemy: work around clock misdetection on early Au1000
 (take 2)
References: <200803271609.31772.sshtylyov@ru.mvista.com>
In-Reply-To: <200803271609.31772.sshtylyov@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18670
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

I just wrote:

> Index: linux-2.6/arch/mips/au1000/common/setup.c
> ===================================================================
> --- linux-2.6.orig/arch/mips/au1000/common/setup.c
> +++ linux-2.6/arch/mips/au1000/common/setup.c
> @@ -57,7 +57,7 @@ void __init plat_mem_setup(void)
>  {
>  	struct	cpu_spec *sp;
>  	char *argptr;
> -	unsigned long prid, cpupll, bclk = 1;
> +	unsigned long prid, cpufreq, bclk = 1;
>  
>  	set_cpuspec();
>  	sp = cur_cpu_spec[0];
> @@ -65,8 +65,15 @@ void __init plat_mem_setup(void)
>  	board_setup();  /* board specific setup */
>  
>  	prid = read_c0_prid();
> -	cpupll = (au_readl(0xB1900060) & 0x3F) * 12;
> -	printk("(PRId %08lx) @ %ldMHZ\n", prid, cpupll);
> +	if (cur_cpu_spec[0]->cpu_pll_wo)

    Oops! Ralf, could you change 'cur_cpu_spec[0]' to just 'sp' here before 
committing?

WBR, Sergei
