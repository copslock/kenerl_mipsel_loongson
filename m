Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Aug 2007 02:34:43 +0100 (BST)
Received: from smtp2.linux-foundation.org ([207.189.120.14]:61867 "EHLO
	smtp2.linux-foundation.org") by ftp.linux-mips.org with ESMTP
	id S20026394AbXHHBec (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 8 Aug 2007 02:34:32 +0100
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l781X9fc001236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 7 Aug 2007 18:33:10 -0700
Received: from akpm.corp.google.com (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id l781X2lh014826;
	Tue, 7 Aug 2007 18:33:02 -0700
Date:	Tue, 7 Aug 2007 18:33:02 -0700
From:	Andrew Morton <akpm@linux-foundation.org>
To:	Aurelien Jarno <aurelien@aurel32.net>
Cc:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>, mb@bu3sch.de,
	linux-mips@linux-mips.org, nbd@openwrt.org, jolt@tuxbox.org
Subject: Re: [PATCH -mm 2/4] MIPS: BCM947xx support (v3)
Message-Id: <20070807183302.1e38a4df.akpm@linux-foundation.org>
In-Reply-To: <20070807121638.GA9953@hall.aurel32.net>
References: <20070806150900.GG24308@hall.aurel32.net>
	<200708062005.29657.mb@bu3sch.de>
	<20070806183316.GB32465@hall.aurel32.net>
	<200708062037.05995.mb@bu3sch.de>
	<20070806191712.GA2019@hall.aurel32.net>
	<20070807094045.2c6eaa38.yoichi_yuasa@tripeaks.co.jp>
	<20070807121638.GA9953@hall.aurel32.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: lf$Revision: 1.184 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16122
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips

On Tue, 7 Aug 2007 14:16:38 +0200
Aurelien Jarno <aurelien@aurel32.net> wrote:

> The patch below against 2.6.23-rc1-mm2 adds support for BCM947xx CPUs.
> It originally comes from the OpenWrt patches.
> 
> Cc: Michael Buesch <mb@bu3sch.de>
> Cc: Felix Fietkau <nbd@openwrt.org>
> Cc: Florian Schirmer <jolt@tuxbox.org>
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> 
> --- a/arch/mips/bcm947xx/irq.c
> +++ b/arch/mips/bcm947xx/irq.c

It's a MIPS patch.  I can merge it, I guess, if Ralf is OK with that.

> ...
>
> +void __init plat_mem_setup(void)
> +{
> +	int i, err;
> +	struct ssb_mipscore *mcore;
> +
> +	err = ssb_bus_ssbbus_register(&ssb_bcm947xx, SSB_ENUM_BASE, bcm947xx_get_invariants);
> +	if (err)
> +		panic("Failed to initialize SSB bus (err %d)\n", err);
> +	mcore = &ssb_bcm947xx.mipscore;
> +
> +#ifdef CONFIG_SERIAL_8250
> +	for (i = 0; i < mcore->nr_serial_ports; i++) {
> +		struct ssb_serial_port *port = &(mcore->serial_ports[i]);
> +		struct uart_port s;
> +	
> +		memset(&s, 0, sizeof(s));
> +		s.line = i;
> +		s.membase = port->regs;
> +		s.irq = port->irq + 2;
> +		s.uartclk = port->baud_base;
> +		s.flags = UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ;
> +		s.iotype = SERIAL_IO_MEM;
> +		s.regshift = port->reg_shift;
> +
> +		early_serial_setup(&s);
> +	}
> +#endif
> +
> +	_machine_restart = bcm947xx_machine_restart;
> +	_machine_halt = bcm947xx_machine_halt;
> +	pm_power_off = bcm947xx_machine_halt;
> +	board_time_init = bcm947xx_time_init;
> +}

Won't this break if CONFIG_SERIAL_8250=m?

> +EXPORT_SYMBOL(ssb_bcm947xx);
> --- a/arch/mips/bcm947xx/time.c
> +++ b/arch/mips/bcm947xx/time.c
> @@ -0,0 +1,62 @@
> +/*
> + *  Copyright (C) 2004 Florian Schirmer <jolt@tuxbox.org>
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
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/sched.h>
> +#include <linux/serial_reg.h>
> +#include <linux/interrupt.h>
> +#include <linux/ssb/ssb.h>
> +#include <asm/addrspace.h>
> +#include <asm/io.h>
> +#include <asm/time.h>
> +
> +extern struct ssb_bus ssb_bcm947xx;

No.  Please, never ever put extern declarations in C files.  Find a
suitable header file for it.

We have scripts/checkpatch.pl which will tell you this (and a lot of other
stuff too).  Please incorporate checkpatch into your workflow.

> +void __init
> +bcm947xx_time_init(void)
> +{
> +	unsigned long hz;
> +
> +	/*
> +	 * Use deterministic values for initial counter interrupt
> +	 * so that calibrate delay avoids encountering a counter wrap.
> +	 */
> +	write_c0_count(0);
> +	write_c0_compare(0xffff);
> +
> +	hz = ssb_cpu_clock(&ssb_bcm947xx.mipscore) / 2;
> +	if (!hz)
> +		hz = 100000000;
> +
> +	/* Set MIPS counter frequency for fixed_rate_gettimeoffset() */
> +	mips_hpt_frequency = hz;
> +}
> +
> +void __init
> +plat_timer_setup(struct irqaction *irq)
> +{
> +	/* Enable the timer interrupt */
> +	setup_irq(7, irq);
> +}
