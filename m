Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Nov 2004 02:07:28 +0000 (GMT)
Received: from mo01.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:63463 "EHLO
	mo01.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225224AbUKSCHT>;
	Fri, 19 Nov 2004 02:07:19 +0000
Received: MO(mo01)id iAJ27EUU004378; Fri, 19 Nov 2004 11:07:14 +0900 (JST)
Received: MDO(mdo00) id iAJ27DkH029159; Fri, 19 Nov 2004 11:07:13 +0900 (JST)
Received: 4UMRO00 id iAJ27DLc024943; Fri, 19 Nov 2004 11:07:13 +0900 (JST)
	from rally (localhost [127.0.0.1]) (authenticated)
Date: Fri, 19 Nov 2004 11:07:33 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Manish Lachwani <mlachwani@mvista.com>
Cc: yuasa@hh.iij4u.or.jp, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] Support for NEC VR4133 in 2.6
Message-Id: <20041119110733.5ddf14ea.yuasa@hh.iij4u.or.jp>
In-Reply-To: <20041118195219.GA4337@prometheus.mvista.com>
References: <20041118195219.GA4337@prometheus.mvista.com>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6367
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Manish,

I have a few comment ;p

On Thu, 18 Nov 2004 11:52:19 -0800
Manish Lachwani <mlachwani@prometheus.mvista.com> wrote:

> Hi Ralf
> 
> Attached patch implements support for NEC VR4133 and NEC Rockhopper in
> 2.6. Currently there is no ethernet driver for the ports on the CMB-VR4133.
> 
> The board has been booted with the Onboard PcNet32 network interface and with
> an Intel EEPRO100 PCI NIC card.
> 
> Please review ...
> 
> Thanks
> Manish Lachwani
> 
> Index: linux/arch/mips/vr41xx/nec-cmbvr4133/init.c
> ===================================================================
> --- /dev/null
> +++ linux/arch/mips/vr41xx/nec-cmbvr4133/init.c
> @@ -0,0 +1,81 @@
> +/*
> + * arch/mips/vr41xx/nec-cmbvr4133/init.c
> + *
> + * PROM library initialisation code for NEC CMB-VR4133 board.
> + *
> + * Author: Yoichi Yuasa <yyuasa@mvista.com, or source@mvista.com> and
> + *         Jun Sun <jsun@mvista.com, or source@mvista.com> and
> + *         Alex Sapkov <asapkov@ru.mvista.com>
> + *
> + * 2001-2004 (c) MontaVista, Software, Inc. This file is licensed under
> + * the terms of the GNU General Public License version 2. This program
> + * is licensed "as is" without any warranty of any kind, whether express
> + * or implied.
> + *
> + * Support for NEC-CMBVR4133 in 2.6 
> + * Manish Lachwani (mlachwani@mvista.com)
> + */
> +#include <linux/config.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/string.h>
> +
> +#include <asm/bootinfo.h>
> +
> +#ifdef CONFIG_ROCKHOPPER
> +#include <asm/io.h>
> +#include <linux/pci.h>
> +
> +#define PCICONFDREG	0xaf000c14
> +#define PCICONFAREG	0xaf000c18
> +#endif
> +
> +const char *get_system_type(void)
> +{
> +	return "NEC CMB-VR4133";
> +}
> +
> +void __init bus_error_init(void)
> +{
> +	/* Do Nothing */
> +}
> +
> +#ifdef CONFIG_ROCKHOPPER
> +void disable_pcnet(void)
> +{

We don't need bus_error_init().
I think that we should move  get_system_type() and disable_pcnet() to setup.c.

> Index: linux/arch/mips/vr41xx/nec-cmbvr4133/setup.c
> ===================================================================
> --- /dev/null
> +++ linux/arch/mips/vr41xx/nec-cmbvr4133/setup.c

<snip>

> +void vr41xx_restart(char *command)
> +{
> +	change_c0_status((ST0_BEV | ST0_ERL), (ST0_BEV | ST0_ERL));
> +	change_c0_config(CONF_CM_CMASK, CONF_CM_UNCACHED);
> +	flush_cache_all();
> +	write_c0_wired(0);
> +	__asm__ __volatile__("jr\t%0"::"r"(0xbfc00000));
> +}
> +                                                                                             
> +void vr41xx_halt(void)
> +{
> +	printk(KERN_NOTICE "\n** You can safely turn off the power\n");
> +	while (1);
> +}
> +                                                                                             
> +void vr41xx_power_off(void)
> +{
> +	vr41xx_halt();
> +}

We don't need these functions. We already have these in common part.

<snip>
> +static int __init nec_cmbvr4133_setup(void)
> +{
> +#ifdef CONFIG_ROCKHOPPER
> +	extern void disable_pcnet(void);
> +
> +	disable_pcnet();
> +#endif
> +	set_io_port_base(IO_PORT_BASE);

We don't need set_io_port_base().
It already set in common part.

<snip>

> +	_machine_restart = vr41xx_restart;
> +	_machine_halt = vr41xx_halt;
> +	_machine_power_off = vr41xx_power_off;

We don't need these.

> +	late_time_init = vr4133_serial_init;

This should just only do vr4133_serial_init().
This function don't need to late_time_init.

> Index: linux/include/asm-mips/vr41xx/cmbvr4133.h
> ===================================================================
> --- /dev/null
> +++ linux/include/asm-mips/vr41xx/cmbvr4133.h
> @@ -0,0 +1,93 @@
> +/*
> + * include/asm-mips/vr41xx/cmbvr4133.h

<snip>

> +/*
> + * Board specific address mapping
> + */
> +#define VR41XX_PCI_MEM1_BASE		0x10000000
> +#define VR41XX_PCI_MEM1_SIZE		0x04000000
> +#define VR41XX_PCI_MEM1_MASK		0x7c000000
> +
> +#define VR41XX_PCI_MEM2_BASE		0x14000000
> +#define VR41XX_PCI_MEM2_SIZE		0x02000000
> +#define VR41XX_PCI_MEM2_MASK		0x7e000000
> +
> +#define VR41XX_PCI_IO_BASE		0x16000000
> +#define VR41XX_PCI_IO_SIZE		0x02000000
> +#define VR41XX_PCI_IO_MASK		0x7e000000
> +
> +#define VR41XX_PCI_IO_START		0x01000000
> +#define VR41XX_PCI_IO_END		0x01ffffff
> +
> +#define VR41XX_PCI_MEM_START		0x12000000
> +#define VR41XX_PCI_MEM_END		0x15ffffff
> +
> +#define IO_PORT_BASE			KSEG1ADDR(VR41XX_PCI_IO_BASE)
> +#define IO_PORT_RESOURCE_START		0
> +#define IO_PORT_RESOURCE_END		VR41XX_PCI_IO_SIZE
> +#define IO_MEM1_RESOURCE_START		VR41XX_PCI_MEM1_BASE
> +#define IO_MEM1_RESOURCE_END		(VR41XX_PCI_MEM1_BASE + VR41XX_PCI_MEM1_SIZE)
> +#define IO_MEM2_RESOURCE_START		VR41XX_PCI_MEM2_BASE
> +#define IO_MEM2_RESOURCE_END		(VR41XX_PCI_MEM2_BASE + VR41XX_PCI_MEM2_SIZE)
> +

We don't need these definitions.
These definitions are not used.

> Index: linux/arch/mips/vr41xx/common/vr4133.c
> ===================================================================
> --- /dev/null
> +++ linux/arch/mips/vr41xx/common/vr4133.c
> @@ -0,0 +1,75 @@

We don't need these functions. We already have these in common part.

> Index: linux/include/asm-mips/vr41xx/vr4133.h
> ===================================================================
> --- /dev/null
> +++ linux/include/asm-mips/vr41xx/vr4133.h
> @@ -0,0 +1,25 @@

Same, we don't need it.

> Index: linux/arch/mips/pci/pci-vr41xx.h
> ===================================================================
> --- linux.orig/arch/mips/pci/pci-vr41xx.h
> +++ linux/arch/mips/pci/pci-vr41xx.h
> @@ -18,6 +18,8 @@
>   *  You should have received a copy of the GNU General Public License
>   *  along with this program; if not, write to the Free Software
>   *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + *
> + *  Support for NEC VR4133 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
>   */
>  #ifndef __PCI_VR41XX_H
>  #define __PCI_VR41XX_H
> @@ -127,6 +129,10 @@
>  #define PCI_MASTER_MEM1_ADDRESS_MASK		0x7c000000U
>  #define PCI_MASTER_MEM1_PCI_BASE_ADDRESS	0x10000000U
>  
> +#define PCI_MASTER_MEM2_BUS_BASE_ADDRESS	0x14000000U
> +#define PCI_MASTER_MEM2_ADDRESS_MASK		0x7e000000U
> +#define PCI_MASTER_MEM2_PCI_BASE_ADDRESS	0x14000000U
> +
>  #define PCI_TARGET_MEM1_ADDRESS_MASK		0x08000000U
>  #define PCI_TARGET_MEM1_BUS_BASE_ADDRESS	0x00000000U
>  
> Index: linux/arch/mips/pci/pci-vr41xx.c
> ===================================================================
> --- linux.orig/arch/mips/pci/pci-vr41xx.c
> +++ linux/arch/mips/pci/pci-vr41xx.c
> @@ -19,6 +19,8 @@
>   *  You should have received a copy of the GNU General Public License
>   *  along with this program; if not, write to the Free Software
>   *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + *
> + *  Support for NEC VR4133 in 2.6 - Manish Lachwani (mlachwani@mvista.com)
>   */
>  /*
>   * Changes:
> @@ -43,6 +45,12 @@
>  	.pci_base_address	= PCI_MASTER_MEM1_PCI_BASE_ADDRESS,
>  };
>  
> +static struct pci_master_address_conversion pci_master_memory2 = {
> +	.bus_base_address	= PCI_MASTER_MEM2_BUS_BASE_ADDRESS,
> +	.address_mask		= PCI_MASTER_MEM2_ADDRESS_MASK,
> +	.pci_base_address	= PCI_MASTER_MEM2_PCI_BASE_ADDRESS,
> +};
> +
>  static struct pci_target_address_conversion pci_target_memory1 = {
>  	.address_mask		= PCI_TARGET_MEM1_ADDRESS_MASK,
>  	.bus_base_address	= PCI_TARGET_MEM1_BUS_BASE_ADDRESS,
> @@ -76,6 +84,22 @@
>  	.flags  = IORESOURCE_IO,
>  };
>  
> +#ifdef CONFIG_ROCKHOPPER
> +static struct pci_controller_unit_setup vr41xx_pci_controller_unit_setup = {
> +	.master_memory1				= &pci_master_memory1,
> +	.master_memory2				= &pci_master_memory2,
> +	.target_memory1				= &pci_target_memory1,
> +	.master_io				= &pci_master_io,
> +	.exclusive_access			= CANNOT_LOCK_FROM_DEVICE,
> +	.wait_time_limit_from_irdy_to_trdy	= 0,
> +	.mailbox				= &pci_mailbox,
> +	.target_window1				= &pci_target_window1,
> +	.master_latency_timer			= 0x80,
> +	.retry_limit				= 0,
> +	.arbiter_priority_control		= PCI_ARBITRATION_MODE_FAIR,
> +	.take_away_gnt_mode			= PCI_TAKE_AWAY_GNT_DISABLE,
> +};
> +#else
>  static struct pci_controller_unit_setup vr41xx_pci_controller_unit_setup = {
>  	.master_memory1				= &pci_master_memory1,
>  	.target_memory1				= &pci_target_memory1,
> @@ -89,6 +113,7 @@
>  	.arbiter_priority_control		= PCI_ARBITRATION_MODE_FAIR,
>  	.take_away_gnt_mode			= PCI_TAKE_AWAY_GNT_DISABLE,
>  };
> +#endif
>  
>  static struct pci_controller vr41xx_pci_controller = {
>  	.pci_ops        = &vr41xx_pci_ops,

Since pci_master_memory2 was the area which is not used, it was deleted.
If you need this area, please let me know a reason.

> Index: linux/arch/mips/vr41xx/common/serial.c
> ===================================================================
> --- linux.orig/arch/mips/vr41xx/common/serial.c
> +++ linux/arch/mips/vr41xx/common/serial.c
> @@ -52,17 +52,17 @@
>   #define TMICTX			0x10
>   #define TMICMODE		0x20
>  
> -#define SIU_BASE_TYPE1		0x0c000000UL	/* VR4111 and VR4121 */
> -#define SIU_BASE_TYPE2		0x0f000800UL	/* VR4122, VR4131 and VR4133 */
> +#define SIU_BASE_TYPE1		KSEG1ADDR(0x0c000000)	/* VR4111 and VR4121 */
> +#define SIU_BASE_TYPE2		KSEG1ADDR(0x0f000800)	/* VR4122, VR4131 and VR4133 */
>  #define SIU_SIZE		0x8UL
>  
> -#define SIU_BASE_BAUD		1152000
> +#define SIU_BASE_BAUD		115200

SIU base baud is 1152000. This change is wrong.

>  /* VR4122, VR4131 and VR4133 DSIU Registers */
> -#define DSIU_BASE		0x0f000820UL
> +#define DSIU_BASE		KSEG1ADDR(0x0f000820)
>  #define DSIU_SIZE		0x8UL
>  
> -#define DSIU_BASE_BAUD		1152000
> +#define DSIU_BASE_BAUD	 	115200

DSIU base baud is 1152000. This change is wrong.
 
>  int vr41xx_serial_ports = 0;
>  
> @@ -132,7 +132,7 @@
>  	}
>  	port.regshift = 0;
>  	port.iotype = UPIO_MEM;
> -	port.membase = ioremap(port.mapbase, SIU_SIZE);
> +	port.membase = (unsigned char *)port.mapbase;
>  	if (port.membase != NULL) {
>  		if (early_serial_setup(&port) == 0) {
>  			vr41xx_supply_clock(SIU_CLOCK);
> @@ -164,7 +164,7 @@
>  	port.mapbase = DSIU_BASE;
>  	port.regshift = 0;
>  	port.iotype = UPIO_MEM;
> -	port.membase = ioremap(port.mapbase, DSIU_SIZE);
> +	port.membase = (unsigned char *)port.mapbase;
>  	if (port.membase != NULL) {
>  		if (early_serial_setup(&port) == 0) {
>  			vr41xx_supply_clock(DSIU_CLOCK);
> 

These changes are same meaning.
We don't need these.


Yoichi
