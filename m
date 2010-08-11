Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Aug 2010 18:23:36 +0200 (CEST)
Received: from mgw2.diku.dk ([130.225.96.92]:53923 "EHLO mgw2.diku.dk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492319Ab0HKQXb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 11 Aug 2010 18:23:31 +0200
Received: from localhost (localhost [127.0.0.1])
        by mgw2.diku.dk (Postfix) with ESMTP id B804F19BEA9;
        Wed, 11 Aug 2010 18:23:29 +0200 (CEST)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 02245-20; Wed, 11 Aug 2010 18:23:28 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
        by mgw2.diku.dk (Postfix) with ESMTP id 7A13219BEA7;
        Wed, 11 Aug 2010 18:23:28 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
        by nhugin.diku.dk (Postfix) with ESMTP
        id CD5CB6DF894; Wed, 11 Aug 2010 18:22:09 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3767)
        id 55A32200C3; Wed, 11 Aug 2010 18:23:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by ask.diku.dk (Postfix) with ESMTP id 4EE7C200BB;
        Wed, 11 Aug 2010 18:23:28 +0200 (CEST)
Date:   Wed, 11 Aug 2010 18:23:28 +0200 (CEST)
From:   Julia Lawall <julia@diku.dk>
To:     Patrick Gefre <pfg@sgi.com>
Cc:     linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 5/5] drivers/serial: Return -ENOMEM on memory allocation
 failure
In-Reply-To: <4C62C8F3.3090405@sgi.com>
Message-ID: <Pine.LNX.4.64.1008111818380.8669@ask.diku.dk>
References: <Pine.LNX.4.64.1008111211440.8669@ask.diku.dk> <4C62C8F3.3090405@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <julia@diku.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27611
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: julia@diku.dk
Precedence: bulk
X-list: linux-mips

> > I believe this code also leaks earlier instances of port, which are only
> > referenced by card_ptr, which is freed in the error handling code at the
> > end of the function.  A lot of operations are done on port on each
> > iteration, however, so I'm not sure whether it is good enough to just free
> > them.  Perhaps there is some way to call ioc3uart_remove?
> > 
> 
> Yes you are right, there should be something like this for out4:
> 
> out4:
> 	for (phys_port = 0; phys_port < PORTS_PER_CARD; phys_port++) {
> 		port = card_ptr->ic_port[phys_port].icp_port;
> 		if (port) {
> 			pci_free_consistent(port->ip_idd->pdev,
>                                        TOTAL_RING_BUF_SIZE,
>                                        (void *)port->ip_cpu_ringbuf,
>                                        port->ip_dma_ringbuf);
> 			kfree(port);
> 		}
> 	}
> 	kfree(card_ptr);
> 	return ret;

Actually, pci_alloc_consistent is only called when phys_port is 0.  In the 
subsequent cases, the ip_dma_ringbuf field is just initialized to the 
previous value.  So it could be:

out4:
        for (phys_port = 0; phys_port < PORTS_PER_CARD; phys_port++) {
                port = card_ptr->ic_port[phys_port].icp_port;
                if (port) {
			if (phys_port == 0)
	                        pci_free_consistent(port->ip_idd->pdev,
                                       TOTAL_RING_BUF_SIZE,
                                       (void *)port->ip_cpu_ringbuf,
                                       port->ip_dma_ringbuf);
                        kfree(port);
                }
        }
        kfree(card_ptr);
        return ret;

julia
