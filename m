Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Aug 2006 15:33:31 +0100 (BST)
Received: from [63.81.120.155] ([63.81.120.155]:20598 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20037546AbWHPOd1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 16 Aug 2006 15:33:27 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 498FC3ED6; Wed, 16 Aug 2006 07:33:23 -0700 (PDT)
Message-ID: <44E32CFB.6030601@ru.mvista.com>
Date:	Wed, 16 Aug 2006 18:34:35 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Vitaly Wool <vitalywool@gmail.com>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] fix compilation breakage for PNX8550
References: <20060816172906.5a2cafb1.vitalywool@gmail.com>
In-Reply-To: <20060816172906.5a2cafb1.vitalywool@gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12346
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Vitaly Wool wrote:

> finally I've got some time to poke around PNX8550 compilation issue I've signalled some time ago. 
> This patch fixes the compilation errors on PNX8550. It also starts migration to using standard 8250 
 > serial driver iso the custom driver for IP3106 Philips UART.

    That shouldn't have touched the KGDB code.

>  Signed-off-by: Vitaly Wool <vitalywool@gmail.com>

>  arch/mips/philips/pnx8550/common/Makefile   |    1
>  arch/mips/philips/pnx8550/common/gdb_hook.c |  109 ----------------------------

    NAK these two files -- you're effectively deleting KGDB support for PNX8550.

> Index: linux-2.6.git/arch/mips/philips/pnx8550/common/setup.c
> ===================================================================
> --- linux-2.6.git.orig/arch/mips/philips/pnx8550/common/setup.c
> +++ linux-2.6.git/arch/mips/philips/pnx8550/common/setup.c
> @@ -143,21 +142,9 [...] @@ void __init plat_mem_setup(void)
[...]
>
> -#ifdef CONFIG_KGDB
> -	argptr = prom_getcmdline();
> -	if ((argptr = strstr(argptr, "kgdb=ttyS")) != NULL) {
> -		int line;
> -		argptr += strlen("kgdb=ttyS");
> -		line = *argptr == '0' ? 0 : 1;
> -		rs_kgdb_hook(line);
> -		prom_printf("KGDB: Using ttyS%i for session, "
> -				"please connect your debugger\n", line ? 1 : 0);
> -	}
> -#endif
>  	return;
>  }

    This also should remain I think.

> Index: linux-2.6.git/arch/mips/philips/pnx8550/common/Makefile
> ===================================================================
> --- linux-2.6.git.orig/arch/mips/philips/pnx8550/common/Makefile
> +++ linux-2.6.git/arch/mips/philips/pnx8550/common/Makefile
> @@ -24,4 +24,3 @@
>  
>  obj-y := setup.o prom.o int.o reset.o time.o proc.o platform.o
>  obj-$(CONFIG_PCI) += pci.o
> -obj-$(CONFIG_KGDB) += gdb_hook.o
> Index: linux-2.6.git/arch/mips/philips/pnx8550/common/gdb_hook.c
> ===================================================================
> --- linux-2.6.git.orig/arch/mips/philips/pnx8550/common/gdb_hook.c
> +++ /dev/null
> @@ -1,109 +0,0 @@
> -/*
> - * Carsten Langgaard, carstenl@mips.com
> - * Copyright (C) 2000 MIPS Technologies, Inc.  All rights reserved.
> - *
> - * ########################################################################
> - *
> - *  This program is free software; you can distribute it and/or modify it
> - *  under the terms of the GNU General Public License (Version 2) as
> - *  published by the Free Software Foundation.
> - *
> - *  This program is distributed in the hope it will be useful, but WITHOUT
> - *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> - *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> - *  for more details.
> - *
> - *  You should have received a copy of the GNU General Public License along
> - *  with this program; if not, write to the Free Software Foundation, Inc.,
> - *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
> - *
> - * ########################################################################
> - *
> - * This is the interface to the remote debugger stub.
> - *
> - */
> -#include <linux/types.h>
> -#include <linux/serial.h>
> -#include <linux/serialP.h>
> -#include <linux/serial_reg.h>
> -#include <linux/serial_ip3106.h>
> -
> -#include <asm/serial.h>
> -#include <asm/io.h>
> -
> -#include <uart.h>
> -
> -static struct serial_state rs_table[IP3106_NR_PORTS] = {
> -};
> -static struct async_struct kdb_port_info = {0};
> -
> -void rs_kgdb_hook(int tty_no)
> -{
> -	struct serial_state *ser = &rs_table[tty_no];
> -
> -	kdb_port_info.state = ser;
> -	kdb_port_info.magic = SERIAL_MAGIC;
> -	kdb_port_info.port  = tty_no;
> -	kdb_port_info.flags = ser->flags;
> -
> -	/*
> -	 * Clear all interrupts
> -	 */
> -	/* Clear all the transmitter FIFO counters (pointer and status) */
> -	ip3106_lcr(UART_BASE, tty_no) |= IP3106_UART_LCR_TX_RST;
> -	/* Clear all the receiver FIFO counters (pointer and status) */
> -	ip3106_lcr(UART_BASE, tty_no) |= IP3106_UART_LCR_RX_RST;
> -	/* Clear all interrupts */
> -	ip3106_iclr(UART_BASE, tty_no) = IP3106_UART_INT_ALLRX |
> -		IP3106_UART_INT_ALLTX;
> -
> -	/*
> -	 * Now, initialize the UART
> -	 */
> -	ip3106_lcr(UART_BASE, tty_no) = IP3106_UART_LCR_8BIT;
> -	ip3106_baud(UART_BASE, tty_no) = 5; // 38400 Baud
> -}
> -
> -int putDebugChar(char c)
> -{
> -	/* Wait until FIFO not full */
> -	while (((ip3106_fifo(UART_BASE, kdb_port_info.port) & IP3106_UART_FIFO_TXFIFO) >> 16) >= 16)
> -		;
> -	/* Send one char */
> -	ip3106_fifo(UART_BASE, kdb_port_info.port) = c;
> -
> -	return 1;
> -}
> -
> -char getDebugChar(void)
> -{
> -	char ch;
> -
> -	/* Wait until there is a char in the FIFO */
> -	while (!((ip3106_fifo(UART_BASE, kdb_port_info.port) &
> -					IP3106_UART_FIFO_RXFIFO) >> 8))
> -		;
> -	/* Read one char */
> -	ch = ip3106_fifo(UART_BASE, kdb_port_info.port) &
> -		IP3106_UART_FIFO_RBRTHR;
> -	/* Advance the RX FIFO read pointer */
> -	ip3106_lcr(UART_BASE, kdb_port_info.port) |= IP3106_UART_LCR_RX_NEXT;
> -	return (ch);
> -}
> -
> -void rs_disable_debug_interrupts(void)
> -{
> -	ip3106_ien(UART_BASE, kdb_port_info.port) = 0; /* Disable all interrupts */
> -}
> -
> -void rs_enable_debug_interrupts(void)
> -{
> -	/* Clear all the transmitter FIFO counters (pointer and status) */
> -	ip3106_lcr(UART_BASE, kdb_port_info.port) |= IP3106_UART_LCR_TX_RST;
> -	/* Clear all the receiver FIFO counters (pointer and status) */
> -	ip3106_lcr(UART_BASE, kdb_port_info.port) |= IP3106_UART_LCR_RX_RST;
> -	/* Clear all interrupts */
> -	ip3106_iclr(UART_BASE, kdb_port_info.port) = IP3106_UART_INT_ALLRX |
> -		IP3106_UART_INT_ALLTX;
> -	ip3106_ien(UART_BASE, kdb_port_info.port)  = IP3106_UART_INT_ALLRX; /* Enable RX interrupts */
> -}

WBR, Sergei
