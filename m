Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 May 2014 22:27:47 +0200 (CEST)
Received: from mail-ee0-f52.google.com ([74.125.83.52]:49749 "EHLO
        mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6821198AbaEUU1pbGDyy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 May 2014 22:27:45 +0200
Received: by mail-ee0-f52.google.com with SMTP id e53so1994117eek.39
        for <multiple recipients>; Wed, 21 May 2014 13:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=UZzG4ppiNd9aGUSCuVVD50LECn3EF+1UYdRylWWHlTo=;
        b=z7/p2ew5yrEixfG7+VdDpYVPVtO3KOuysYfgqdAtEVaB1wv0ukUlbine7oCzWycwG7
         4kP2BNFgPV3pwMJF0g49C4ZaLmEFnmOmW4vAYKcUrVJRb4Nkj9GwUn2fOP9uv9ksL/C9
         TJE+Lw5e2ONhgkIo8NeCaOqFLwcwC6ED4nfRBk46XpUQvhv3F7HEBNyf31Lv1T/m32xU
         se0b0i2KrHabHe8YQlVMNivuZY/0pKgnm2kuGqTdLEReu3R6CYj6YoXd5QJ9i9xWb7OX
         WCNLDzUxlSm8M56Re3HIUTo/Gol7lh8a3OHPyPrts5eRDVclAzO8zpJlVrsJBBdsu87V
         qaoQ==
X-Received: by 10.15.36.8 with SMTP id h8mr68061278eev.12.1400704060150;
        Wed, 21 May 2014 13:27:40 -0700 (PDT)
Received: from alberich ([46.78.192.208])
        by mx.google.com with ESMTPSA id cj41sm14427033eeb.34.2014.05.21.13.27.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 21 May 2014 13:27:39 -0700 (PDT)
Date:   Wed, 21 May 2014 22:27:35 +0200
From:   Andreas Herrmann <herrmann.der.user@googlemail.com>
To:     Paul Bolle <pebolle@tiscali.nl>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: cavium-octeon: remove checks for CONFIG_CAVIUM_GDB
Message-ID: <20140521202735.GC23153@alberich>
References: <1400602574.4912.43.camel@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1400602574.4912.43.camel@x220>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <herrmann.der.user@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40225
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: herrmann.der.user@googlemail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Tue, May 20, 2014 at 06:16:14PM +0200, Paul Bolle wrote:
> Three checks for CONFIG_CAVIUM_GDB were added in v2.6.29. But the
> Kconfig symbol CAVIUM_GDB was never added to the tree. Remove these
> checks.
> 
> Also remove the last reference to octeon_get_boot_debug_flag(). There is
> no definition of that function anyway.

Hmm, yes, this was added with commit
5b3b16880f404ca54126210ca86141cceeafc0cf (MIPS: Add Cavium OCTEON
processor support files to arch/mips/cavium-octeon.) and incomplete
ever since (in mainline kernel).
 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> Untested.

Removing this dead code shouldn't harm. I also did a quick test of a
kernel with your patch with an octeon system -- as expected no issues
observed. (So it's
Tested-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>)

> A follow up might be to remove plat_smp_ops.cpus_done. All these
> callbacks are now (basically) nops.

I am not sure about completely removing cpus_done from
plat_smp_ops. Maybe some platform will really make use of this in the
future.


Thanks,
Andreas
 
>  arch/mips/cavium-octeon/setup.c       | 11 -----------
>  arch/mips/cavium-octeon/smp.c         | 17 -----------------
>  arch/mips/include/asm/octeon/octeon.h |  1 -
>  3 files changed, 29 deletions(-)
> 
> diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
> index 953ca85f84fa..989781fbae76 100644
> --- a/arch/mips/cavium-octeon/setup.c
> +++ b/arch/mips/cavium-octeon/setup.c
> @@ -729,17 +729,6 @@ void __init prom_init(void)
>  	octeon_write_lcd("Linux");
>  #endif
>  
> -#ifdef CONFIG_CAVIUM_GDB
> -	/*
> -	 * When debugging the linux kernel, force the cores to enter
> -	 * the debug exception handler to break in.
> -	 */
> -	if (octeon_get_boot_debug_flag()) {
> -		cvmx_write_csr(CVMX_CIU_DINT, 1 << cvmx_get_core_num());
> -		cvmx_read_csr(CVMX_CIU_DINT);
> -	}
> -#endif
> -
>  	octeon_setup_delays();
>  
>  	/*
> diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
> index 67a078ffc464..78e1abebc854 100644
> --- a/arch/mips/cavium-octeon/smp.c
> +++ b/arch/mips/cavium-octeon/smp.c
> @@ -218,15 +218,6 @@ void octeon_prepare_cpus(unsigned int max_cpus)
>   */
>  static void octeon_smp_finish(void)
>  {
> -#ifdef CONFIG_CAVIUM_GDB
> -	unsigned long tmp;
> -	/* Pulse MCD0 signal on Ctrl-C to stop all the cores. Also set the MCD0
> -	   to be not masked by this core so we know the signal is received by
> -	   someone */
> -	asm volatile ("dmfc0 %0, $22\n"
> -		      "ori   %0, %0, 0x9100\n" "dmtc0 %0, $22\n" : "=r" (tmp));
> -#endif
> -
>  	octeon_user_io_init();
>  
>  	/* to generate the first CPU timer interrupt */
> @@ -239,14 +230,6 @@ static void octeon_smp_finish(void)
>   */
>  static void octeon_cpus_done(void)
>  {
> -#ifdef CONFIG_CAVIUM_GDB
> -	unsigned long tmp;
> -	/* Pulse MCD0 signal on Ctrl-C to stop all the cores. Also set the MCD0
> -	   to be not masked by this core so we know the signal is received by
> -	   someone */
> -	asm volatile ("dmfc0 %0, $22\n"
> -		      "ori   %0, %0, 0x9100\n" "dmtc0 %0, $22\n" : "=r" (tmp));
> -#endif
>  }
>  
>  #ifdef CONFIG_HOTPLUG_CPU
> diff --git a/arch/mips/include/asm/octeon/octeon.h b/arch/mips/include/asm/octeon/octeon.h
> index f5d77b91537f..d781f9e66884 100644
> --- a/arch/mips/include/asm/octeon/octeon.h
> +++ b/arch/mips/include/asm/octeon/octeon.h
> @@ -211,7 +211,6 @@ union octeon_cvmemctl {
>  
>  extern void octeon_write_lcd(const char *s);
>  extern void octeon_check_cpu_bist(void);
> -extern int octeon_get_boot_debug_flag(void);
>  extern int octeon_get_boot_uart(void);
>  
>  struct uart_port;
> -- 
> 1.9.0
> 
> 
