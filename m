Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Jul 2005 00:22:35 +0100 (BST)
Received: from web81403.mail.yahoo.com ([IPv6:::ffff:206.190.37.92]:29304 "HELO
	web81403.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8226755AbVGOXWJ>; Sat, 16 Jul 2005 00:22:09 +0100
Received: (qmail 96161 invoked by uid 60001); 15 Jul 2005 23:23:25 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=pxAGFQLcCpQOdzWapWhYICKVvceIxxpsAWA8Nk2rb4GOBIUW8H0LkEgzuDml4g6DsrsQFCC3XIk8TWdAdM36AgoeKm/MhXp71Kkoj2eS7Sg35A/qFlN+AiU6H5TD55U48OI7I2TN9HZJ0iRsw2o2Z4+0bIJbwf/d4eeU9zKNfVA=  ;
Message-ID: <20050715232325.96159.qmail@web81403.mail.yahoo.com>
Received: from [71.35.66.81] by web81403.mail.yahoo.com via HTTP; Fri, 15 Jul 2005 16:23:24 PDT
Date:	Fri, 15 Jul 2005 16:23:24 -0700 (PDT)
From:	Pete Popov <pete_popov@yahoo.com>
Subject: Re: CVS Update@linux-mips.org: linux
To:	Yoichi Yuasa <yuasa@hh.iij4u.or.jp>, ppopov@linux-mips.org
Cc:	yuasa@hh.iij4u.or.jp, linux-mips@linux-mips.org
In-Reply-To: <20050716001621.6d9d607a.yuasa@hh.iij4u.or.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <pete_popov@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8509
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pete_popov@yahoo.com
Precedence: bulk
X-list: linux-mips



--- Yoichi Yuasa <yuasa@hh.iij4u.or.jp> wrote:

> Hi Pete,
> 
> On Thu, 14 Jul 2005 18:48:00 +0100
> ppopov@linux-mips.org wrote:
> 
> > 
> > Log message:
> > 	Philips PNX8550 support: MIPS32-like core with 2
> Trimedias on it.
> 
> I think the following include path is better.

Thanks :)! I thought I cleaned up everything ;)

Pete

> 
> Yoichi
> 
> Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
> 
> diff -urN -X dontdiff
> a-orig/arch/mips/philips/pnx8550/common/gdb_hook.c
> a/arch/mips/philips/pnx8550/common/gdb_hook.c
> ---
> a-orig/arch/mips/philips/pnx8550/common/gdb_hook.c
> 2005-07-15 02:47:58.000000000 +0900
> +++ a/arch/mips/philips/pnx8550/common/gdb_hook.c
> 2005-07-15 23:44:03.361056952 +0900
> @@ -31,7 +31,7 @@
>  #include <asm/serial.h>
>  #include <asm/io.h>
>  
> -#include <asm/mach-pnx8550/uart.h>
> +#include <uart.h>
>  
>  static struct serial_state rs_table[RS_TABLE_SIZE]
> = {
>  	SERIAL_PORT_DFNS	/* Defined in serial.h */
> diff -urN -X dontdiff
> a-orig/arch/mips/philips/pnx8550/common/int.c
> a/arch/mips/philips/pnx8550/common/int.c
> --- a-orig/arch/mips/philips/pnx8550/common/int.c
> 2005-07-15 02:47:58.000000000 +0900
> +++ a/arch/mips/philips/pnx8550/common/int.c
> 2005-07-15 23:44:32.008701848 +0900
> @@ -35,8 +35,8 @@
>  
>  #include <asm/io.h>
>  #include <asm/gdb-stub.h>
> -#include <asm/mach-pnx8550/int.h>
> -#include <asm/mach-pnx8550/uart.h>
> +#include <int.h>
> +#include <uart.h>
>  
>  extern asmlinkage void cp0_irqdispatch(void);
>  
> diff -urN -X dontdiff
> a-orig/arch/mips/philips/pnx8550/common/pci.c
> a/arch/mips/philips/pnx8550/common/pci.c
> --- a-orig/arch/mips/philips/pnx8550/common/pci.c
> 2005-07-15 02:47:58.000000000 +0900
> +++ a/arch/mips/philips/pnx8550/common/pci.c
> 2005-07-15 23:44:52.444595120 +0900
> @@ -24,9 +24,9 @@
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  
> -#include <asm/mach-pnx8550/pci.h>
> -#include <asm/mach-pnx8550/glb.h>
> -#include <asm/mach-pnx8550/nand.h>
> +#include <pci.h>
> +#include <glb.h>
> +#include <nand.h>
>  
>  static struct resource pci_io_resource = {
>  	"pci IO space",
> diff -urN -X dontdiff
> a-orig/arch/mips/philips/pnx8550/common/platform.c
> a/arch/mips/philips/pnx8550/common/platform.c
> ---
> a-orig/arch/mips/philips/pnx8550/common/platform.c
> 2005-07-15 02:47:58.000000000 +0900
> +++ a/arch/mips/philips/pnx8550/common/platform.c
> 2005-07-15 23:45:16.826888448 +0900
> @@ -17,9 +17,9 @@
>  #include <linux/init.h>
>  #include <linux/resource.h>
>  
> -#include <asm/mach-pnx8550/int.h>
> -#include <asm/mach-pnx8550/usb.h>
> -#include <asm/mach-pnx8550/uart.h>
> +#include <int.h>
> +#include <usb.h>
> +#include <uart.h>
>  
>  static struct resource pnx8550_usb_ohci_resources[]
> = {
>  	[0] = {
> diff -urN -X dontdiff
> a-orig/arch/mips/philips/pnx8550/common/proc.c
> a/arch/mips/philips/pnx8550/common/proc.c
> --- a-orig/arch/mips/philips/pnx8550/common/proc.c
> 2005-07-15 02:47:58.000000000 +0900
> +++ a/arch/mips/philips/pnx8550/common/proc.c
> 2005-07-15 23:45:33.076418144 +0900
> @@ -24,8 +24,8 @@
>  
>  #include <asm/io.h>
>  #include <asm/gdb-stub.h>
> -#include <asm/mach-pnx8550/int.h>
> -#include <asm/mach-pnx8550/uart.h>
> +#include <int.h>
> +#include <uart.h>
>  
>  
>  static int pnx8550_timers_read (char* page, char**
> start, off_t offset, int count, int* eof, void*
> data)
> diff -urN -X dontdiff
> a-orig/arch/mips/philips/pnx8550/common/prom.c
> a/arch/mips/philips/pnx8550/common/prom.c
> --- a-orig/arch/mips/philips/pnx8550/common/prom.c
> 2005-07-15 02:47:58.000000000 +0900
> +++ a/arch/mips/philips/pnx8550/common/prom.c
> 2005-07-15 23:45:44.729646584 +0900
> @@ -15,7 +15,7 @@
>  #include <linux/string.h>
>  
>  #include <asm/bootinfo.h>
> -#include <asm/mach-pnx8550/uart.h>
> +#include <uart.h>
>  
>  /* #define DEBUG_CMDLINE */
>  
> diff -urN -X dontdiff
> a-orig/arch/mips/philips/pnx8550/common/reset.c
> a/arch/mips/philips/pnx8550/common/reset.c
> --- a-orig/arch/mips/philips/pnx8550/common/reset.c
> 2005-07-15 02:47:58.000000000 +0900
> +++ a/arch/mips/philips/pnx8550/common/reset.c
> 2005-07-15 23:45:55.884950720 +0900
> @@ -23,7 +23,7 @@
>  #include <linux/config.h>
>  #include <linux/slab.h>
>  #include <asm/reboot.h>
> -#include <asm/mach-pnx8550/glb.h>
> +#include <glb.h>
>  
>  void pnx8550_machine_restart(char *command)
>  {
> diff -urN -X dontdiff
> a-orig/arch/mips/philips/pnx8550/common/setup.c
> a/arch/mips/philips/pnx8550/common/setup.c
> --- a-orig/arch/mips/philips/pnx8550/common/setup.c
> 2005-07-15 02:47:58.000000000 +0900
> +++ a/arch/mips/philips/pnx8550/common/setup.c
> 2005-07-15 23:43:38.693806944 +0900
> @@ -33,11 +33,11 @@
>  #include <asm/pgtable.h>
>  #include <asm/time.h>
>  
> -#include <asm/mach-pnx8550/glb.h>
> -#include <asm/mach-pnx8550/int.h>
> -#include <asm/mach-pnx8550/pci.h>
> -#include <asm/mach-pnx8550/uart.h>
> -#include <asm/mach-pnx8550/nand.h>
> +#include <glb.h>
> +#include <int.h>
> +#include <pci.h>
> +#include <uart.h>
> +#include <nand.h>
>  
>  extern void prom_printf(char *fmt, ...);
>  
> diff -urN -X dontdiff
> a-orig/arch/mips/philips/pnx8550/common/time.c
> a/arch/mips/philips/pnx8550/common/time.c
> --- a-orig/arch/mips/philips/pnx8550/common/time.c
> 2005-07-15 02:47:58.000000000 +0900
> +++ a/arch/mips/philips/pnx8550/common/time.c
> 2005-07-15 23:46:11.606560672 +0900
> @@ -31,8 +31,8 @@
>  #include <asm/div64.h>
>  #include <asm/debug.h>
>  
> -#include <asm/mach-pnx8550/int.h>
> -#include <asm/mach-pnx8550/cm.h>
> +#include <int.h>
> +#include <cm.h>
>  
>  extern unsigned int mips_hpt_frequency;
>  
> diff -urN -X dontdiff
> a-orig/arch/mips/philips/pnx8550/jbs/board_setup.c
> a/arch/mips/philips/pnx8550/jbs/board_setup.c
> ---
> a-orig/arch/mips/philips/pnx8550/jbs/board_setup.c
> 2005-07-15 02:47:59.000000000 +0900
> +++ a/arch/mips/philips/pnx8550/jbs/board_setup.c
> 2005-07-15 23:46:28.102052976 +0900
> @@ -39,7 +39,7 @@
>  #include <asm/reboot.h>
>  #include <asm/pgtable.h>
>  
> -#include <asm/mach-pnx8550/glb.h>
> 
=== message truncated ===
