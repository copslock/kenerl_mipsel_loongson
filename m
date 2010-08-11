Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Aug 2010 18:36:11 +0200 (CEST)
Received: from relay2.sgi.com ([192.48.179.30]:49849 "EHLO relay.sgi.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492339Ab0HKQgH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 11 Aug 2010 18:36:07 +0200
Received: from estes.americas.sgi.com (estes.americas.sgi.com [128.162.236.10])
        by relay2.corp.sgi.com (Postfix) with ESMTP id 01F57304075;
        Wed, 11 Aug 2010 08:59:47 -0700 (PDT)
Received: from [128.162.232.67] (pfglinux.americas.sgi.com [128.162.232.67])
        by estes.americas.sgi.com (Postfix) with ESMTP id 84D2C700016A;
        Wed, 11 Aug 2010 10:59:47 -0500 (CDT)
Message-ID: <4C62C8F3.3090405@sgi.com>
Date:   Wed, 11 Aug 2010 10:59:47 -0500
From:   Patrick Gefre <pfg@sgi.com>
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
MIME-Version: 1.0
To:     Julia Lawall <julia@diku.dk>
Cc:     linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 5/5] drivers/serial: Return -ENOMEM on memory allocation
 failure
References: <Pine.LNX.4.64.1008111211440.8669@ask.diku.dk>
In-Reply-To: <Pine.LNX.4.64.1008111211440.8669@ask.diku.dk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <pfg@sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27612
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pfg@sgi.com
Precedence: bulk
X-list: linux-mips

Julia Lawall wrote:
> From: Julia Lawall <julia@diku.dk>
> 
> In this code, 0 is returned on memory allocation failure, even though other
> failures return -ENOMEM or other similar values.
> 
> A simplified version of the semantic match that finds this problem is as
> follows: (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> expression ret;
> expression x,e1,e2,e3;
> @@
> 
> ret = 0
> ... when != ret = e1
> *x = \(kmalloc\|kcalloc\|kzalloc\)(...)
> ... when != ret = e2
> if (x == NULL) { ... when != ret = e3
>   return ret;
> }
> // </smpl>
> 
> Signed-off-by: Julia Lawall <julia@diku.dk>
> 

Signed-off-by: Pat Gefre <pfg@sgi.com>



> ---
> I believe this code also leaks earlier instances of port, which are only
> referenced by card_ptr, which is freed in the error handling code at the
> end of the function.  A lot of operations are done on port on each
> iteration, however, so I'm not sure whether it is good enough to just free
> them.  Perhaps there is some way to call ioc3uart_remove?
> 

Yes you are right, there should be something like this for out4:

out4:
	for (phys_port = 0; phys_port < PORTS_PER_CARD; phys_port++) {
		port = card_ptr->ic_port[phys_port].icp_port;
		if (port) {
			pci_free_consistent(port->ip_idd->pdev,
                                        TOTAL_RING_BUF_SIZE,
                                        (void *)port->ip_cpu_ringbuf,
                                        port->ip_dma_ringbuf);
			kfree(port);
		}
	}
	kfree(card_ptr);
	return ret;




>  drivers/serial/ioc3_serial.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/serial/ioc3_serial.c b/drivers/serial/ioc3_serial.c
> index 93de907..800c546 100644
> --- a/drivers/serial/ioc3_serial.c
> +++ b/drivers/serial/ioc3_serial.c
> @@ -2044,6 +2044,7 @@ ioc3uart_probe(struct ioc3_submodule *is, struct ioc3_driver_data *idd)
>  		if (!port) {
>  			printk(KERN_WARNING
>  			       "IOC3 serial memory not available for port\n");
> +			ret = -ENOMEM;
>  			goto out4;
>  		}
>  		spin_lock_init(&port->ip_lock);
