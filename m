Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Mar 2003 19:39:58 +0000 (GMT)
Received: from il-la.la.idealab.com ([IPv6:::ffff:63.251.211.5]:51333 "HELO
	idealab.com") by linux-mips.org with SMTP id <S8225194AbTCUTj5>;
	Fri, 21 Mar 2003 19:39:57 +0000
Received: (qmail 5090 invoked by uid 6180); 21 Mar 2003 19:39:40 -0000
Date: Fri, 21 Mar 2003 11:39:40 -0800
From: Jeff Baitis <baitisj@evolution.com>
To: Hartvig Ekner <hartvig@ekner.info>
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Re: Patches for all four au1000 setup.c files
Message-ID: <20030321113940.O26687@luca.pas.lab>
Reply-To: baitisj@evolution.com
References: <3E7AD36E.26E2EA94@ekner.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3E7AD36E.26E2EA94@ekner.info>; from hartvig@ekner.info on Fri, Mar 21, 2003 at 09:55:10AM +0100
Return-Path: <baitisj@idealab.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1787
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: baitisj@evolution.com
Precedence: bulk
X-list: linux-mips

On the subject of __wbflush():

It seems to me that setup.c should be exporting __wbflush, since there are some
modules that require this symbol. Try compiling the 8139 ethernet module, or
HostAP wireless drivers :)

Are the following patches correct?
Thanks!

-Jeff

Index: Makefile
===================================================================
RCS file: /home/cvs/linux/arch/mips/au1000/db1x00/Attic/Makefile,v
retrieving revision 1.1.2.2
diff -u -r1.1.2.2 Makefile
--- Makefile    5 Mar 2003 08:18:58 -0000       1.1.2.2
+++ Makefile    21 Mar 2003 19:34:11 -0000
@@ -19,4 +19,6 @@
 
 obj-y := init.o setup.o
 
+export-objs := setup.o
+
 include $(TOPDIR)/Rules.make


Index: setup.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/au1000/db1x00/Attic/setup.c,v
retrieving revision 1.1.2.3
diff -u -r1.1.2.3 setup.c
--- setup.c     7 Jan 2003 10:41:30 -0000       1.1.2.3
+++ setup.c     21 Mar 2003 19:34:19 -0000
@@ -242,3 +242,7 @@
                return phys_addr;
 }
 #endif
+
+#include <linux/module.h>
+EXPORT_SYMBOL(__wbflush);
+






On Fri, Mar 21, 2003 at 09:55:10AM +0100, Hartvig Ekner wrote:
> Hi,
> 
> the patches below for all four au1000 setup.c files removes the wbflush() routine, as this is no longer necessary
> (handled by the generic code now, which does a sync). This also means that it is not necessary to say yes to
> CONFIG_CPU_ADVANCED and override the CPU_HAS_WB setting, as the generic MIPS32 code will do just fine.
> 
> The patch for the db1x00 setup.c file also fixes a bug which prevented VRA from being used with Audio Codecs
> which support it.
> 
> /Hartvig
> 
> 

> Index: db1x00/setup.c
> ===================================================================
> RCS file: /home/cvs/linux/arch/mips/au1000/db1x00/Attic/setup.c,v
> retrieving revision 1.1.2.3
> diff -u -r1.1.2.3 setup.c
> --- db1x00/setup.c	7 Jan 2003 10:41:30 -0000	1.1.2.3
> +++ db1x00/setup.c	21 Mar 2003 08:44:49 -0000
> @@ -61,7 +61,6 @@
>  extern struct ide_ops *ide_ops;
>  #endif
>  
> -void (*__wbflush) (void);
>  extern struct rtc_ops no_rtc_ops;
>  extern char * __init prom_getcmdline(void);
>  extern void au1000_restart(char *);
> @@ -76,11 +75,6 @@
>  
>  void __init bus_error_init(void) { /* nothing */ }
>  
> -void au1x00_wbflush(void)
> -{
> -	__asm__ volatile ("sync");
> -}
> -
>  void __init au1x00_setup(void)
>  {
>  	char *argptr;
> @@ -109,14 +103,13 @@
>      }
>  #endif
>  
> -#if defined(CONFIG_SOUND_AU1000) && !defined(CONFIG_CPU_AU1000)
> +#if defined(CONFIG_SOUND_AU1X00) && !defined(CONFIG_CPU_AU1000)
>  	// au1000 does not support vra, au1500 and au1100 do
> -    strcat(argptr, " au1000_audio=vra");
> -    argptr = prom_getcmdline();
> +	strcat(argptr, " au1000_audio=vra");
> +	argptr = prom_getcmdline();
>  #endif
>  
>  	rtc_ops = &no_rtc_ops;
> -	__wbflush = au1x00_wbflush;
>  	_machine_restart = au1000_restart;
>  	_machine_halt = au1000_halt;
>  	_machine_power_off = au1000_power_off;
> Index: pb1000/setup.c
> ===================================================================
> RCS file: /home/cvs/linux/arch/mips/au1000/pb1000/setup.c,v
> retrieving revision 1.8.2.8
> diff -u -r1.8.2.8 setup.c
> --- pb1000/setup.c	11 Dec 2002 06:12:29 -0000	1.8.2.8
> +++ pb1000/setup.c	21 Mar 2003 08:44:50 -0000
> @@ -67,7 +67,6 @@
>  extern struct ide_ops *ide_ops;
>  #endif
>  
> -void (*__wbflush) (void);
>  extern struct rtc_ops no_rtc_ops;
>  extern char * __init prom_getcmdline(void);
>  extern void au1000_restart(char *);
> @@ -78,11 +77,6 @@
>  
>  void __init bus_error_init(void) { /* nothing */ }
>  
> -void au1000_wbflush(void)
> -{
> -	__asm__ volatile ("sync");
> -}
> -
>  void __init au1x00_setup(void)
>  {
>  	char *argptr;
> @@ -103,7 +97,6 @@
>  #endif
>  
>  	rtc_ops = &no_rtc_ops;
> -        __wbflush = au1000_wbflush;
>  	_machine_restart = au1000_restart;
>  	_machine_halt = au1000_halt;
>  	_machine_power_off = au1000_power_off;
> Index: pb1100/setup.c
> ===================================================================
> RCS file: /home/cvs/linux/arch/mips/au1000/pb1100/setup.c,v
> retrieving revision 1.1.2.6
> diff -u -r1.1.2.6 setup.c
> --- pb1100/setup.c	31 Dec 2002 05:00:22 -0000	1.1.2.6
> +++ pb1100/setup.c	21 Mar 2003 08:44:50 -0000
> @@ -71,7 +71,6 @@
>  extern struct rtc_ops pb1500_rtc_ops;
>  #endif
>  
> -void (*__wbflush) (void);
>  extern char * __init prom_getcmdline(void);
>  extern void au1000_restart(char *);
>  extern void au1000_halt(void);
> @@ -82,11 +81,6 @@
>  
>  void __init bus_error_init(void) { /* nothing */ }
>  
> -void au1100_wbflush(void)
> -{
> -	__asm__ volatile ("sync");
> -}
> -
>  void __init au1x00_setup(void)
>  {
>  	char *argptr;
> @@ -112,7 +106,6 @@
>  	argptr = prom_getcmdline();
>  #endif
>  
> -        __wbflush = au1100_wbflush;
>  	_machine_restart = au1000_restart;
>  	_machine_halt = au1000_halt;
>  	_machine_power_off = au1000_power_off;
> Index: pb1500/setup.c
> ===================================================================
> RCS file: /home/cvs/linux/arch/mips/au1000/pb1500/setup.c,v
> retrieving revision 1.1.2.10
> diff -u -r1.1.2.10 setup.c
> --- pb1500/setup.c	29 Dec 2002 10:30:35 -0000	1.1.2.10
> +++ pb1500/setup.c	21 Mar 2003 08:44:50 -0000
> @@ -43,7 +43,6 @@
>  #include <asm/mipsregs.h>
>  #include <asm/reboot.h>
>  #include <asm/pgtable.h>
> -#include <asm/wbflush.h>
>  #include <asm/au1000.h>
>  #include <asm/pb1500.h>
>  
> @@ -72,7 +71,6 @@
>  extern struct rtc_ops pb1500_rtc_ops;
>  #endif
>  
> -void (*__wbflush) (void);
>  extern char * __init prom_getcmdline(void);
>  extern void au1000_restart(char *);
>  extern void au1000_halt(void);
> @@ -87,11 +85,6 @@
>  
>  void __init bus_error_init(void) { /* nothing */ }
>  
> -void au1500_wbflush(void)
> -{
> -	__asm__ volatile ("sync");
> -}
> -
>  void __init au1x00_setup(void)
>  {
>  	char *argptr;
> @@ -117,7 +110,6 @@
>  	argptr = prom_getcmdline();
>  #endif
>  
> -        __wbflush = au1500_wbflush;
>  	_machine_restart = au1000_restart;
>  	_machine_halt = au1000_halt;
>  	_machine_power_off = au1000_power_off;


-- 
         Jeffrey Baitis - Associate Software Engineer

                    Evolution Robotics, Inc.
                     130 West Union Street
                       Pasadena CA 91103

 tel: 626.535.2776  |  fax: 626.535.2777  |  baitisj@evolution.com 
