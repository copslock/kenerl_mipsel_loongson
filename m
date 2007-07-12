Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jul 2007 19:53:24 +0100 (BST)
Received: from smtp2.linux-foundation.org ([207.189.120.14]:29316 "EHLO
	smtp2.linux-foundation.org") by ftp.linux-mips.org with ESMTP
	id S20022672AbXGLSxV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Jul 2007 19:53:21 +0100
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6CIlIvW013396
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 12 Jul 2007 11:47:19 -0700
Received: from akpm.corp.google.com (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id l6CIlCRx026844;
	Thu, 12 Jul 2007 11:47:12 -0700
Date:	Thu, 12 Jul 2007 11:47:12 -0700
From:	Andrew Morton <akpm@linux-foundation.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Mark Mason <mason@broadcom.com>,
	Andy Whitcroft <apw@shadowen.org>,
	Randy Dunlap <rdunlap@xenotime.net>,
	Joel Schopp <jschopp@austin.ibm.com>,
	linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sb1250-duart.c: SB1250 DUART serial support
Message-Id: <20070712114712.de5d6c9d.akpm@linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64N.0707121745010.3029@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0707121745010.3029@blysk.ds.pg.gda.pl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15754
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips

On Thu, 12 Jul 2007 18:39:00 +0100 (BST)
"Maciej W. Rozycki" <macro@linux-mips.org> wrote:

>  This is a driver for the SB1250 DUART, a dual serial port implementation 
> included in the Broadcom family of SOCs descending from the SiByte SB1250 
> MIPS64 chip multiprocessor.  It is a new implementation replacing the 
> old-fashioned driver currently present in the linux-mips.org tree.  It 
> supports all the usual features one would expect from a(n asynchronous) 
> serial driver, including modem line control (as far as hardware supports 
> it -- there is edge detection logic missing from the DCD and RI lines and 
> the driver does not implement polling of these lines at the moment), the 
> serial console, BREAK transmission and reception, including the magic 
> SysRq.  The receive FIFO threshold is not maintained though.
> 
> ...
>
> +
> +#if defined(CONFIG_SIBYTE_BCM1x55) || defined(CONFIG_SIBYTE_BCM1x80)
> +#include <asm/sibyte/bcm1480_regs.h>
> +#include <asm/sibyte/bcm1480_int.h>
> +
> +#define SBD_CHANREGS(line)	A_BCM1480_DUART_CHANREG((line), 0)
> +#define SBD_CTRLREGS(line)	A_BCM1480_DUART_CTRLREG((line), 0)
> +#define SBD_INT(line)		(K_BCM1480_INT_UART_0 + (line))
> +
> +#elif defined(CONFIG_SIBYTE_SB1250) || defined(CONFIG_SIBYTE_BCM112X)
> +#include <asm/sibyte/sb1250_regs.h>
> +#include <asm/sibyte/sb1250_int.h>
> +
> +#define SBD_CHANREGS(line)	A_DUART_CHANREG((line), 0)
> +#define SBD_CTRLREGS(line)	A_DUART_CTRLREG(0)
> +#define SBD_INT(line)		(K_INT_UART_0 + (line))
> +
> +#else
> +#error invalid SB1250 UART configuration
> +
> +#endif

If the #error can trigger, the Kconfig is broken, yes?  (No action is
required though - it's always good to have checks)

> +#define to_sport(uport) container_of(uport, struct sbd_port, port)

That didn't need to be implemented as a macro.

> +#define __unused __attribute__((__unused__))

Please use the generic implementations here.  `grep unused
include/linux/compiler*.h'.

> +/*
> + * In bug 1956, we get glitches that can mess up uart registers.  This
> + * "read-mode-reg after any register access" is an accepted workaround.
> + */

<looks in bugzilla.kernel.org>

<wonders how a uart driver can fix an smbfs bug>

Perhaps a reference to where that bug number came from?

> +static void __war_sbd1956(struct sbd_port *sport)
> +{
> +	__read_sbdchn(sport, R_DUART_MODE_REG_1);
> +	__read_sbdchn(sport, R_DUART_MODE_REG_2);
> +}
>
> ...
>
> +static struct uart_ops sbd_ops = {

I suppose if we made this const, something would blow up.




There is no power management support in this driver.
