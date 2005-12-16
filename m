Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Dec 2005 16:25:36 +0000 (GMT)
Received: from smtp102.biz.mail.mud.yahoo.com ([68.142.200.237]:14473 "HELO
	smtp102.biz.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133454AbVLPQZS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 16 Dec 2005 16:25:18 +0000
Received: (qmail 98646 invoked from network); 16 Dec 2005 16:25:53 -0000
Received: from unknown (HELO ?192.168.1.110?) (ppopov@embeddedalley.com@71.128.175.242 with plain)
  by smtp102.biz.mail.mud.yahoo.com with SMTP; 16 Dec 2005 16:25:52 -0000
Subject: Re: Irda support for au1100
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	Rodolfo Giometti <giometti@linux.it>
Cc:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
In-Reply-To: <20051216161842.GN14341@gundam.enneenne.com>
References: <20051216161842.GN14341@gundam.enneenne.com>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date:	Fri, 16 Dec 2005 08:25:54 -0800
Message-Id: <1134750354.4900.50.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9681
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

On Fri, 2005-12-16 at 17:18 +0100, Rodolfo Giometti wrote:
> Doing:
> 
>    giometti@vvonth:/home/develop/linux.git$ rgrep CONFIG_AU1000_FIR *
>    drivers/net/irda/Makefile:obj-$(CONFIG_AU1000_FIR)	+= au1k_ir.o
> 
> so I suppose that current Irda support for au1100 is broken... is that
> right? :)

It hasn't been tested in a very long time. 

> Some suggestions in order to help me to port it to the current kernel
> release?

Compile it, see what's broken, and fix it :) It shouldn't be that bad.
You can see how the chip works in the current driver. All breakage
should be related to new kernel irda apis and such.

Pete
