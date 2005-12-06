Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Dec 2005 20:27:06 +0000 (GMT)
Received: from web405.biz.mail.mud.yahoo.com ([68.142.201.36]:1455 "HELO
	web405.biz.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133728AbVLFU0s (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 6 Dec 2005 20:26:48 +0000
Received: (qmail 77201 invoked by uid 60001); 6 Dec 2005 20:26:25 -0000
Message-ID: <20051206202625.77199.qmail@web405.biz.mail.mud.yahoo.com>
Received: from [64.163.129.139] by web405.biz.mail.mud.yahoo.com via HTTP; Tue, 06 Dec 2005 12:26:25 PST
Date:	Tue, 6 Dec 2005 12:26:25 -0800 (PST)
From:	Peter Popov <ppopov@embeddedalley.com>
Subject: Re: [PATCH] Philips PNX8550 
To:	"Vladimir A. Barinov" <vbarinov@ru.mvista.com>, ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, ppopov@embeddedalley.com
In-Reply-To: <4395EBFF.9080408@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9622
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

Hi Vladimir,

Is this really for the JBS board or for a different
board?

Pete

--- "Vladimir A. Barinov" <vbarinov@ru.mvista.com>
wrote:

> Hi Ralf, Pete,
> 
> This patch enables NATSEMI eth driver to be used on
> pci bus.
> 
> Does it make sense to push this patch?
> 
> Vladimir
> > ---
>
linux-2.6.15.orig/arch/mips/philips/pnx8550/jbs/irqmap.c
> 2005-12-02 16:37:59.000000000 +0300
> +++
> linux-2.6.15/arch/mips/philips/pnx8550/jbs/irqmap.c
> 2005-12-02 17:33:05.000000000 +0300
> @@ -31,6 +31,7 @@
>  char irq_tab_jbs[][5] __initdata = {
>   [8] =	{ -1, PNX8550_INT_PCI_INTA, 0xff, 0xff,
> 0xff},
>   [9] =	{ -1, PNX8550_INT_PCI_INTA, 0xff, 0xff,
> 0xff},
> + [10] =	{ -1, PNX8550_INT_PCI_INTA, 0xff, 0xff,
> 0xff},
>   [17] =	{ -1, PNX8550_INT_PCI_INTA, 0xff, 0xff,
> 0xff},
>  };
>  
> 
