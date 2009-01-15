Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jan 2009 19:40:05 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:16165 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S21365961AbZAOTkD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 Jan 2009 19:40:03 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B496f90ca0000>; Thu, 15 Jan 2009 14:38:50 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 15 Jan 2009 11:38:19 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 15 Jan 2009 11:38:18 -0800
Message-ID: <496F90AA.7070407@caviumnetworks.com>
Date:	Thu, 15 Jan 2009 11:38:18 -0800
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
MIME-Version: 1.0
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
CC:	Linux-MIPS <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 06/14] MIPS: print irq handler description
References: <cover.1229846410.git.mano@roarinelk.homelinux.net> <caebb02f97491d8e5830438e1a746b0e02fa2c7c.1229846411.git.mano@roarinelk.homelinux.net> <80cf5c7a0db39a7230bae7766264acbfc68d200e.1229846412.git.mano@roarinelk.homelinux.net> <e6862a9acc480a4f00d0b7ae738e8a355a7e4810.1229846412.git.mano@roarinelk.homelinux.net> <ac2064c64b746420a21008fa4e9e7c4ecf048d7a.1229846413.git.mano@roarinelk.homelinux.net> <dc79b2a4d9da426f867de084c75940109eff1287.1229846413.git.mano@roarinelk.homelinux.net> <535458cb8c8f570089b2712a1e73ca7314d5b7c7.1229846413.git.mano@roarinelk.homelinux.net>
In-Reply-To: <535458cb8c8f570089b2712a1e73ca7314d5b7c7.1229846413.git.mano@roarinelk.homelinux.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Jan 2009 19:38:18.0739 (UTC) FILETIME=[D12B3430:01C97748]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21757
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Manuel Lauss wrote:
> Add the name set by set_irq_chip_and_handler_name() to the output of

Alchemy is the only mips cpu that uses set_irq_chip_and_handler_name()...

> /proc/interrupts, like so:
> 
> db1200 ~ # cat /proc/interrupts
>            CPU0
>   8:         52     Alchemy-IC0-hilevel   serial
>  10:        171     Alchemy-IC0-hilevel   au1xxx-mmc
>  11:         47     Alchemy-IC0-hilevel   Au1xxx dbdma
>  18:          1     Alchemy-IC0-hilevel   au1550-spi
>  29:    1250997     Alchemy-IC0-riseedge  timer
>  37:        211     Alchemy-IC0-hilevel   ehci_hcd:usb1, ohci_hcd:usb2
>  38:          0     Alchemy-IC0-hilevel   lcd
>  72:       2623     DB1200 CPLD-level     ide0
>  73:        257     DB1200 CPLD-level     eth0
>  84:          1     DB1200 CPLD-level     sd_insert
>  85:          0     DB1200 CPLD-level     sd_eject
> 
> ERR:          0
> 
> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
> ---
>  arch/mips/kernel/irq.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
> index 4b4007b..a0ff2b6 100644
> --- a/arch/mips/kernel/irq.c
> +++ b/arch/mips/kernel/irq.c
> @@ -111,6 +111,7 @@ int show_interrupts(struct seq_file *p, void *v)
>  			seq_printf(p, "%10u ", kstat_cpu(j).irqs[i]);
>  #endif
>  		seq_printf(p, " %14s", irq_desc[i].chip->name);
> +		seq_printf(p, "-%-8s", irq_desc[i].name);
>  		seq_printf(p, "  %s", action->name);
>  

... so for most mips CPUs we now get something ugly like this:

octeon:~# cat /proc/interrupts
            CPU0       CPU1       CPU2       CPU3
  23:       7371       7120       5747       5373            Core-<NULL> 
    timer
  56:       6171       9482       7023       8102            CIU0-<NULL> 
    mailbox0
  57:          0          0          0          0            CIU0-<NULL> 
    mailbox1
  58:        156          0          0          0            CIU0-<NULL> 
    serial
  64:        376          0          0          0            CIU0-<NULL> 
    MSI[0:63]
  86:          0          0          0          0            CIU0-<NULL> 
    mgmt0
  87:       1928          0          0          0            CIU0-<NULL> 
    pata_octeon_cf
  88:          7          0          0          0            CIU1-<NULL> 
    watchdog
  89:          0          7          0          0            CIU1-<NULL> 
    watchdog
  90:          0          0          7          0            CIU1-<NULL> 
    watchdog
  91:          0          0          0          7            CIU1-<NULL> 
    watchdog
106:          0          0          0          0            CIU1-<NULL> 
    mgmt1
152:        376          0          0          0             MSI-<NULL> 
    eth0
