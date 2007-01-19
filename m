Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Jan 2007 14:18:09 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:3227 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20049432AbXASOSI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 19 Jan 2007 14:18:08 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l0JEI227000979;
	Fri, 19 Jan 2007 14:18:02 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l0JEI1QG000978;
	Fri, 19 Jan 2007 14:18:01 GMT
Date:	Fri, 19 Jan 2007 14:18:01 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
Cc:	linux-mips@linux-mips.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial driver PMC MSP71xx, kernel linux-mips.git master
Message-ID: <20070119141801.GA10735@linux-mips.org>
References: <45B00F65.6000406@pmc-sierra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45B00F65.6000406@pmc-sierra.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13721
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jan 18, 2007 at 04:23:01PM -0800, Marc St-Jean wrote:

> Index: linux_2_6/drivers/serial/8250.c
> ===================================================================
> RCS file: linux_2_6/drivers/serial/8250.c,v
> retrieving revision 1.1.1.7
> retrieving revision 1.9
> diff -u -r1.1.1.7 -r1.9
> --- linux_2_6/drivers/serial/8250.c	19 Oct 2006 21:00:58 -0000	1.1.1.7
> +++ linux_2_6/drivers/serial/8250.c	19 Oct 2006 22:08:15 -0000	1.9
> @@ -44,6 +44,10 @@
>   #include <asm/io.h>
>   #include <asm/irq.h>
> 
> +#ifdef CONFIG_PMC_MSP
> +#include <msp_regs.h>
> +#endif

CONFIG_PMC_MSP is not defined anywhere.  msp_regs.h does not exist.

  Ralf
