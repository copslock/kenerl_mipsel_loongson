Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Nov 2008 05:54:27 +0000 (GMT)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:7822 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S23375600AbYKHFyY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 8 Nov 2008 05:54:24 +0000
Received: (qmail 12672 invoked from network); 8 Nov 2008 06:51:50 +0100
Received: from scarran.roarinelk.net (192.168.0.242)
  by fnoeppeil48.netpark.at with SMTP; 8 Nov 2008 06:51:50 +0100
Date:	Sat, 8 Nov 2008 06:54:23 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH 3/3] Alchemy: common reset code is evalboard code.
Message-ID: <20081108065423.04826ed2@scarran.roarinelk.net>
In-Reply-To: <4914CB2E.1020100@ru.mvista.com>
References: <cover.1226082445.git.mano@roarinelk.homelinux.net>
	<0b1dcd4090411d59e2272ca94da0fb4f5a4bbceb.1226083170.git.mano@roarinelk.homelinux.net>
	<7fe9325e464ace53dae1affdb98681f6c4c59d53.1226083170.git.mano@roarinelk.homelinux.net>
	<9bf5c9c78b0e2bada64f8f337d9397efb8781ac1.1226083170.git.mano@roarinelk.homelinux.net>
	<4914CB2E.1020100@ru.mvista.com>
Organization: Private
X-Mailer: Claws Mail 3.6.1 (GTK+ 2.14.4; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21241
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

On Sat, 08 Nov 2008 02:11:42 +0300
Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> Hello.
> 
> Manuel Lauss wrote:
> 
> > Move common/reset.c contents to evalboard code where it belongs.
> >   
> 
>    I'm not sure it belongs there...

Oh yes it does (most of it, anyway).  From my
"Im-not-a-au1200-evalboard" perspective most of the code in
alchemy/common is crap/hackery for the evalboards. reset.c is such a
case. I want it gone ;-) (just like common/platform.c).


> > Add reboot hook initialization to mtx-1 and xxs1500 boards.
> >
> > Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
> 
>    That's all good but doesn't look equivalent to the old code...
cf. end of this mail

> > diff --git a/arch/mips/alchemy/common/setup.c b/arch/mips/alchemy/common/setup.c
> > index 1ac6b06..cfb531e 100644
> > --- a/arch/mips/alchemy/common/setup.c
> > +++ b/arch/mips/alchemy/common/setup.c
> > @@ -28,25 +28,14 @@
> >  #include <linux/init.h>
> >  #include <linux/ioport.h>
> >  #include <linux/module.h>
> > -#include <linux/pm.h>
> > -
> > -#include <asm/mipsregs.h>
> > -#include <asm/reboot.h>
> > -#include <asm/time.h>
> > -
> >  #include <au1000.h>
> > -#include <prom.h>
> >  
> >  extern void __init board_setup(void);
> > -extern void au1000_restart(char *);
> > -extern void au1000_halt(void);
> > -extern void au1000_power_off(void);
> >  extern void set_cpuspec(void);
> >  
> >  void __init plat_mem_setup(void)
> >  {
> >  	struct	cpu_spec *sp;
> > -	char *argptr;
> >  	unsigned long prid, cpufreq, bclk;
> >  
> >  	set_cpuspec();
> > @@ -79,34 +68,6 @@ void __init plat_mem_setup(void)
> >  		/* Clear to obtain best system bus performance */
> >  		clear_c0_config(1 << 19); /* Clear Config[OD] */
> >  
> > -	argptr = prom_getcmdline();
> > -
> > -#ifdef CONFIG_SERIAL_8250_CONSOLE
> > -	argptr = strstr(argptr, "console=");
> > -	if (argptr == NULL) {
> > -		argptr = prom_getcmdline();
> > -		strcat(argptr, " console=ttyS0,115200");
> > -	}
> > -#endif
> > -
> > -#ifdef CONFIG_FB_AU1100
> > -	argptr = strstr(argptr, "video=");
> > -	if (argptr == NULL) {
> > -		argptr = prom_getcmdline();
> > -		/* default panel */
> > -		/*strcat(argptr, " video=au1100fb:panel:Sharp_320x240_16");*/
> > -	}
> > -#endif
> > -
> > -#if defined(CONFIG_SOUND_AU1X00) && !defined(CONFIG_SOC_AU1000)
> > -	/* au1000 does not support vra, au1500 and au1100 do */
> > -	strcat(argptr, " au1000_audio=vra");
> > -	argptr = prom_getcmdline();
> > -#endif
> > -	_machine_restart = au1000_restart;
> > -	_machine_halt = au1000_halt;
> > -	pm_power_off = au1000_power_off;
> > -
> >  	/* IO/MEM resources. */
> >  	set_io_port_base(0);
> >  	ioport_resource.start = IOPORT_RESOURCE_START;
> >   
> 
>    How is this change related to the patch's purpose?

Agrees, most belongs in the previous patch

 
> > diff --git a/arch/mips/alchemy/evalboards/common.c b/arch/mips/alchemy/evalboards/common.c
> > index d112fcf..7c78d54 100644
> > --- a/arch/mips/alchemy/evalboards/common.c
> > +++ b/arch/mips/alchemy/evalboards/common.c
> >   
> [...]
> > +static void evalboard_halt(void)
> > +{
> > +#if defined(CONFIG_MIPS_PB1550) || defined(CONFIG_MIPS_DB1550)
> > +	/* Power off system */
> > +	printk(KERN_NOTICE "\n** Powering off...\n");
> > +	au_writew(au_readw(0xAF00001C) | (3 << 14), 0xAF00001C);
> > +	au_sync();
> > +	while (1)
> > +		; /* should not get here */
> > +#else
> > +	printk(KERN_NOTICE "\n** You can safely turn off the power\n");
> > +#ifdef CONFIG_MIPS_MIRAGE
> > +	au_writel((1 << 26) | (1 << 10), GPIO2_OUTPUT);
> > +#endif
> > +#ifdef CONFIG_MIPS_DB1200
> > +	au_writew(au_readw(0xB980001C) | (1 << 14), 0xB980001C);
> > +#endif
> > +#ifdef CONFIG_PM
> > +	au_sleep();
> > +
> > +	/* Should not get here */
> > +	printk(KERN_ERR "Unable to put CPU in sleep mode\n");
> > +	while (1)
> > +		;
> > +#else
> > +	while (1)
> > +		__asm__(".set\tmips3\n\t"
> > +			"wait\n\t"
> > +			".set\tmips0");
> > +#endif
> > +#endif /* defined(CONFIG_MIPS_PB1550) || defined(CONFIG_MIPS_DB1550) */
> > +}
> >   
> 
>    So you moved this code only to leave the board specific #ifdef'ery 
> where it was? ;-)

Read the patch description: I just moved it out of common.  If you
prefer I could remove this block and add shutdown/reboot hooks in every
board file.


> > +
> > +void __init evalboard_common_init(void)
> > +{
> > +	char *argptr;
> > +
> > +	argptr = prom_getcmdline();
> > +
> > +#ifdef CONFIG_SERIAL_8250_CONSOLE
> > +	argptr = strstr(argptr, "console=");
> > +	if (argptr == NULL) {
> > +		argptr = prom_getcmdline();
> > +		strcat(argptr, " console=ttyS0,115200");
> > +	}
> > +#endif
> > +
> > +#ifdef CONFIG_FB_AU1100
> > +	argptr = strstr(argptr, "video=");
> > +	if (argptr == NULL) {
> > +		argptr = prom_getcmdline();
> > +		/* default panel */
> > +		/*strcat(argptr, " video=au1100fb:panel:Sharp_320x240_16");*/
> > +	}
> > +#endif
> > +
> > +#if defined(CONFIG_SOUND_AU1X00) && !defined(CONFIG_SOC_AU1000)
> > +	/* au1000 does not support vra, au1500 and au1100 do */
> > +	strcat(argptr, " au1000_audio=vra");
> > +	argptr = prom_getcmdline();
> > +#endif
> >   
> 
>    This probably needs to be in another patch...

Agreed,


> > +	_machine_restart = evalboard_restart;
> >   
> 
>    I'm not sure that the name fits well since there's nothing board 
> specific in this particular function, just SoC specific...

My custom au1200 platform reboots just fine without this (as
does the DB1200), and the only in-tree users seem to be the
evalboards.


> > diff --git a/arch/mips/alchemy/mtx-1/board_setup.c b/arch/mips/alchemy/mtx-1/board_setup.c
> > index 2e26465..4712ce4 100644
> > --- a/arch/mips/alchemy/mtx-1/board_setup.c
> > +++ b/arch/mips/alchemy/mtx-1/board_setup.c
> > @@ -122,6 +123,8 @@ void __init board_setup(void)
> >  
> >  	board_pci_idsel = mtx1_pci_idsel;
> >  
> > +	_machine_restart = board_reset;
> >   
> 
>    Hey, that bypasses the restart code that was executed before this 
> patch...

Yes, but are you absolutely sure its really necessary?  I never had any
problems rebooting through the _machine_restart function without that
removed code on the DB1200 or my other AU1200 platform.  Especially
since the default platform init file in yamon takes care of what the
now-bypassed code did (of course I don't know that in the MTX-1/XXS1500
case but I hope the designers of those boards just modified an existing
demoboard init file).

Do you have access to any of the not-DB1200 testboards? Can you please
test whether reboot/shutdown still works after this change?

Thank you!
	Manuel Lauss
