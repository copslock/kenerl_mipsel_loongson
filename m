Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Jan 2005 16:58:33 +0000 (GMT)
Received: from 209-232-97-206.ded.pacbell.net ([IPv6:::ffff:209.232.97.206]:2554
	"EHLO dns0.mips.com") by linux-mips.org with ESMTP
	id <S8225250AbVAQQ61>; Mon, 17 Jan 2005 16:58:27 +0000
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id j0HGwHbR024624;
	Mon, 17 Jan 2005 08:58:17 -0800 (PST)
Received: from [192.168.236.16] (grendel [192.168.236.16])
	by mercury.mips.com (8.12.9/8.12.11) with ESMTP id j0HGwFGl003477;
	Mon, 17 Jan 2005 08:58:15 -0800 (PST)
Message-ID: <41EBEEFA.6040701@mips.com>
Date: Mon, 17 Jan 2005 17:59:38 +0100
From: "Kevin D. Kissell" <kevink@mips.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
CC: Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2.6.11-rc1] add local_irq_enable() to cpu_idle()
References: <20050118014958.1d9e484e.yuasa@hh.iij4u.or.jp>
In-Reply-To: <20050118014958.1d9e484e.yuasa@hh.iij4u.or.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.39
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6934
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

There have been times when having local_irq_enable() in my idle loop
would have prevented a hang in some of my experimental kernels, too,
but it's always been because I had screwed up somewhere else and
forgotten to re-enable interrupts.  Is there some good reason why
the kernel should end up in idle with interrupts turned off?

		Regards,

		Kevin K.

Yoichi Yuasa wrote:
> Hi Ralf,
> 
> We need to add local_irq_enable() to cpu_idle().
> Please add this patch to v2.6.
> 
> I don't have any information about R3081.
> I didn't fix r3081_wait().
> 
> Yoichi
> 
> Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
> 
> diff -urN -X dontdiff a-orig/arch/mips/kernel/cpu-probe.c a/arch/mips/kernel/cpu-probe.c
> --- a-orig/arch/mips/kernel/cpu-probe.c	Sun Oct 31 21:49:07 2004
> +++ a/arch/mips/kernel/cpu-probe.c	Tue Jan 18 00:26:12 2005
> @@ -42,10 +42,12 @@
>  {
>  	unsigned long cfg = read_c0_conf();
>  	write_c0_conf(cfg | TX39_CONF_HALT);
> +	local_irq_enable();
>  }
>  
>  static void r4k_wait(void)
>  {
> +	local_irq_enable();
>  	__asm__(".set\tmips3\n\t"
>  		"wait\n\t"
>  		".set\tmips0");
> @@ -61,6 +63,7 @@
>  
>  void au1k_wait(void)
>  {
> +	local_irq_enable();
>  #ifdef CONFIG_PM
>  	/* using the wait instruction makes CP0 counter unusable */
>  	__asm__(".set\tmips3\n\t"
> diff -urN -X dontdiff a-orig/arch/mips/kernel/process.c a/arch/mips/kernel/process.c
> --- a-orig/arch/mips/kernel/process.c	Sat Jan  8 23:19:16 2005
> +++ a/arch/mips/kernel/process.c	Mon Jan 17 21:43:08 2005
> @@ -58,6 +58,8 @@
>  		while (!need_resched())
>  			if (cpu_wait)
>  				(*cpu_wait)();
> +			else
> +				local_irq_enable();
>  		schedule();
>  	}
>  }
> 
