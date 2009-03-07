Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Mar 2009 09:49:37 +0000 (GMT)
Received: from fnoeppeil36.netpark.at ([217.175.205.164]:22991 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S21103232AbZCGJte (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 7 Mar 2009 09:49:34 +0000
Received: (qmail 20144 invoked from network); 7 Mar 2009 10:49:33 +0100
Received: from scarran.roarinelk.net (192.168.0.242)
  by fnoeppeil36.netpark.at with SMTP; 7 Mar 2009 10:49:33 +0100
Date:	Sat, 7 Mar 2009 10:49:32 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Kevin Hickey <khickey@rmicorp.com>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	Kevin Hickey <khickey@rmicorp.com>
Subject: Re: [PATCH 02/10] Alchemy: Au1300 new interrupt controller
Message-ID: <20090307104932.49408650@scarran.roarinelk.net>
In-Reply-To: <0b447f7e26be90a9179bdf89ca2cfd1f34c5d16e.1236354153.git.khickey@rmicorp.com>
References: <1236356409-32357-1-git-send-email-khickey@rmicorp.com>
	<788248524efc28ba2608ed79bfb7080ee476b12d.1236354153.git.khickey@rmicorp.com>
	<0b447f7e26be90a9179bdf89ca2cfd1f34c5d16e.1236354153.git.khickey@rmicorp.com>
Organization: Private
X-Mailer: Claws Mail 3.7.0 (GTK+ 2.14.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22031
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

On Fri,  6 Mar 2009 10:20:01 -0600
Kevin Hickey <khickey@rmicorp.com> wrote:

> The Au1300 has a new interrupt controller (relative to the rest of the Alchemy
> line).  The differences were great enough to justify adding a whole new module.
> Included in this patch is the new interrupt controller, a new implementation of
> the cascade interrupt controller on the DB1300 board and some code to drive
> LEDs on the DB1300 that is used by the interrupt controller.
> 
> A small change was made to the existing interrupt controller; it is "ifdef'd
> out" for Au1300.
> 
> Since the cascade interrupt controller is virtually indentical (with the
> exception of some constants) between the DB1300 and DB1200, a future
> optimization may be to use the same code for both boards.

> diff --git a/arch/mips/alchemy/common/Makefile b/arch/mips/alchemy/common/Makefile
> index d50d476..85ffa2e 100644
> --- a/arch/mips/alchemy/common/Makefile
> +++ b/arch/mips/alchemy/common/Makefile
> @@ -7,7 +7,9 @@
> 
>  obj-y += prom.o irq.o puts.o time.o reset.o \
>  	clocks.o platform.o power.o setup.o \
> -	sleeper.o dma.o dbdma.o gpio.o
> +	sleeper.o dma.o dbdma.o gpio.o gpio_int.o
> +
> +obj-$(CONFIG_SOC_AU13XX) += au13xx_res.o

belongs to another patch in the series?


> diff --git a/arch/mips/alchemy/common/gpio_int.c b/arch/mips/alchemy/common/gpio_int.c
> new file mode 100644
> index 0000000..c09b793
> --- /dev/null
> +++ b/arch/mips/alchemy/common/gpio_int.c
> @@ -0,0 +1,268 @@
> +/*
> + * Copyright 2008 RMI Corporation
> + * Author: Kevin Hickey <khickey@rmicorp.com>
> + *
> + *  This program is free software; you can redistribute  it and/or modify it
> + *  under  the terms of  the GNU General  Public License as published by the
> + *  Free Software Foundation;  either version 2 of the  License, or (at your
> + *  option) any later version.
> + *
> + *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
> + *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
> + *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
> + *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
> + *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
> + *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
> + *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
> + *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
> + *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
> + *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + *
> + *  You should have received a copy of the  GNU General Public License along
> + *  with this program; if not, write  to the Free Software Foundation, Inc.,
> + *  675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +#ifdef CONFIG_AU_GPIO_INT_CNTLR
> +
> +#include <linux/irq.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>		/* For functions called by do_IRQ */
> +#include <asm/irq_cpu.h>
> +
> +#include <asm/mach-au1x00/gpio_int.h>
> +#include <asm/mach-au1x00/au1000.h>
> +
> +#include <dev_boards.h>

Please try to keep common/ free of anything not related to the chip
itself.



> +asmlinkage void plat_irq_dispatch(void)
> +{
> +	unsigned int intr;
> +	u32 bank;
> +	u32 reg_msk;
> +	unsigned int pending = read_c0_status() & read_c0_cause();
> +	/*
> +	 * C0 timer tick
> +	 */
> +	if (pending & CAUSEF_IP7)
> +		do_IRQ(MIPS_CPU_IRQ_BASE + 7);
> +	else if (pending & (CAUSEF_IP2 | CAUSEF_IP3)) {
> +		intr = au_ioread32(&gpio_int->pri_enc);
> +		bank = GPINT_BANK_FROM_INT(intr);
> +		reg_msk = GPINT_BIT_FROM_INT(bank, intr);
> +
> +		if (intr != 127) {
> +			if (pending & CAUSEF_IP3)
> +				board_irq_dispatch(intr);

What is this supposed to do? (missed debug code?)


> +
> +			do_IRQ(GPINT_LINUX_IRQ_OFFSET + intr);
> +		}
> +	} else {
> +		printk(KERN_WARNING
> +			"ALCHEMY GPIO_INT: Unexpected cause was set. %08x\n",
> +			pending);
> +	}

should probably call spurious_interrupt() here.


> +
> +}
> +
> +#endif
> diff --git a/arch/mips/alchemy/common/irq.c b/arch/mips/alchemy/common/irq.c
> index c88c821..f8742dd 100644
> --- a/arch/mips/alchemy/common/irq.c
> +++ b/arch/mips/alchemy/common/irq.c
> @@ -24,6 +24,7 @@
>   *  with this program; if not, write  to the Free Software Foundation, Inc.,
>   *  675 Mass Ave, Cambridge, MA 02139, USA.
>   */
> +#ifdef CONFIG_AU_INT_CNTLR
> 
>  #include <linux/bitops.h>
>  #include <linux/init.h>
> @@ -609,3 +610,5 @@ void __init arch_init_irq(void)
> 
>  	set_c0_status(IE_IRQ0 | IE_IRQ1 | IE_IRQ2 | IE_IRQ3);
>  }
> +
> +#endif

Why not make compilation of the original irq.c file dependent on
AU_INT_CNTRL?  (i.e. change the Makefile to
obj-$(CONFIG_AU_INT_CNTRL) += irq.o
for non-au1300 parts).

(FWIW, I'm working on getting rid of the explicit CPU-type config
options and instead do runtime detection and configuration of
dma/dbdma/irq/ and so on).


Best regards,
	Manuel Lauss
