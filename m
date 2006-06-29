Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jun 2006 16:05:32 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:54371 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S3686488AbWF2PFY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 29 Jun 2006 16:05:24 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id C936F3EBE; Thu, 29 Jun 2006 08:04:55 -0700 (PDT)
Message-ID: <44A3EBD7.8090408@ru.mvista.com>
Date:	Thu, 29 Jun 2006 19:03:51 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Rodolfo Giometti <giometti@linux.it>, linux-mips@linux-mips.org
Subject: Re: au1000_lowlevel_probe on au1000_eth.c
References: <20060626221441.GA10595@enneenne.com> <20060627155914.GD10595@enneenne.com>
In-Reply-To: <20060627155914.GD10595@enneenne.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11886
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Rodolfo Giometti wrote:
> On Tue, Jun 27, 2006 at 12:14:41AM +0200, Rodolfo Giometti wrote:

>>I notice that during sleep/wakeup au1000_lowlevel_probe() tries to
>>access to variables arcs_cmdline,prom_envp & Co.. This sometime does
>>an oops.

> Here my proposal to avoid oops during wake up.

    This is against your rewrite, if I don't mistake?

> Ciao,

> Rodolfo

WBR, Sergei

> ------------------------------------------------------------------------
> 
> diff --git a/drivers/net/au1000_eth.c b/drivers/net/au1000_eth.c
> index 341fdc4..c49004a 100644
> --- a/drivers/net/au1000_eth.c
> +++ b/drivers/net/au1000_eth.c
> @@ -1419,24 +1419,25 @@ au1000_lowlevel_probe(struct net_device 
>  	/* Setup some variables for quick register address access */
>  	if (port_num == 0)
>  	{
> -		/* check env variables first */
> -		if (!get_ethernet_addr(ethaddr)) { 
> -			memcpy(au1000_mac_addr, ethaddr, sizeof(au1000_mac_addr));
> -		} else {
> -			/* Check command line */
> -			argptr = prom_getcmdline();
> -			if ((pmac = strstr(argptr, "ethaddr=")) == NULL) {
> -				printk(KERN_INFO "%s: No mac address found\n", 
> -						ndev->name);
> -				/* use the hard coded mac addresses */
> +		if (!skip_prom) {
> +			/* check env variables first */
> +			if (!get_ethernet_addr(ethaddr)) { 
> +				memcpy(au1000_mac_addr, ethaddr, sizeof(au1000_mac_addr));
>  			} else {
> -				str2eaddr(ethaddr, pmac + strlen("ethaddr="));
> -				memcpy(au1000_mac_addr, ethaddr, 
> -						sizeof(au1000_mac_addr));
> +				/* Check command line */
> +				argptr = prom_getcmdline();
> +				if ((pmac = strstr(argptr, "ethaddr=")) == NULL) {
> +					printk(KERN_INFO "%s: No mac address found\n", 
> +							ndev->name);
> +					/* use the hard coded mac addresses */
> +				} else {
> +					str2eaddr(ethaddr, pmac + strlen("ethaddr="));
> +					memcpy(au1000_mac_addr, ethaddr, 
> +							sizeof(au1000_mac_addr));
> +				}
>  			}

    Hrm, wouldn't it be better to put this stuff into a separate function then?

WBR, Sergei
