Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jul 2006 16:55:19 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:27383 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S8133505AbWGTPzK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 20 Jul 2006 16:55:10 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 79DE23EBE; Thu, 20 Jul 2006 08:54:47 -0700 (PDT)
Message-ID: <44BFA700.7040202@ru.mvista.com>
Date:	Thu, 20 Jul 2006 19:53:36 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Thiemo Seufer <ths@networkno.de>
Cc:	Gary Smith <gary.smith@3phoenix.com>, linux-mips@linux-mips.org
Subject: Re: IDE on Swarm
References: <000601c6ac09$0c262f30$6dacaac0@3PiGAS> <20060720153208.GC4350@networkno.de>
In-Reply-To: <20060720153208.GC4350@networkno.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12042
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Thiemo Seufer wrote:

> The SWARM onboard IDE works for me with the appended patch. (Originally from
> Peter Horton <pdh@colonel-panic.org>.)

> Thiemo
> 
> --- a/drivers/ide/mips/swarm.c
> +++ b/drivers/ide/mips/swarm.c
> @@ -127,6 +127,7 @@ static int __devinit swarm_ide_probe(str
>  	memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->io_ports));
>  	hwif->irq = hwif->hw.irq;
>  
> +	probe_hwif_init(hwif);
>  	dev_set_drvdata(dev, hwif);
>  
>  	return 0;

    Has it been submitted anywhere?

WBR, Sergei
