Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jun 2007 01:29:37 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:45017 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021755AbXFYA3f (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 25 Jun 2007 01:29:35 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l5P0SOhW009554;
	Mon, 25 Jun 2007 01:28:25 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l5P0SMGY009553;
	Mon, 25 Jun 2007 02:28:22 +0200
Date:	Mon, 25 Jun 2007 02:28:22 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, sshtylyov@ru.mvista.com,
	mlachwani@mvista.com
Subject: Re: [PATCH 3/4] rbtx4938: Fix secondary PCIC and glue internal NICs
Message-ID: <20070625002822.GD5814@linux-mips.org>
References: <20070622.232219.48807177.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070622.232219.48807177.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15526
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jun 22, 2007 at 11:22:19PM +0900, Atsushi Nemoto wrote:

> +static int rbtx4938_netdev_event(struct notifier_block *this,
> +				 unsigned long event,
> +				 void *ptr)
>  {
> -	struct pci_controller *channel = (struct pci_controller *)dev->bus->sysdata;
> -	int ch = 0;
> -
> -	if (channel != &tx4938_pci_controller[1])
> -		return -ENODEV;
> -	/* TX4938 PCIC1 */
> -	switch (PCI_SLOT(dev->devfn)) {
> -	case TX4938_PCIC_IDSEL_AD_TO_SLOT(31):
> -		ch = 0;
> -		break;
> -	case TX4938_PCIC_IDSEL_AD_TO_SLOT(30):
> -		ch = 1;
> -		break;
> -	default:
> -		return -ENODEV;
> +	struct net_device *dev = ptr;
> +	if (event == NETDEV_REGISTER) {
> +		int ch = -1;
> +		if (dev->irq == RBTX4938_IRQ_IRC + TX4938_IR_ETH0)
> +			ch = 0;
> +		else if (dev->irq == RBTX4938_IRQ_IRC + TX4938_IR_ETH1)
> +			ch = 1;
> +		if (ch >= 0)
> +			memcpy(dev->dev_addr,
> +			       &rbtx4938_ethaddr[4 + 6 * ch], 6);
>  	}
> -	memcpy(addr, &rbtx4938_ethaddr[4 + 6 * ch], 6);

<jgarzik> Ralf: probably not...  :)
<jgarzik> Ralf: dev->open() assumes dev->dev_addr[] is filled in, when interface goes up, and each NIC driver should use that and write the MAC address in dev->dev_addr[] to its RX filter / MAC address registers
<jgarzik> Ralf: the default value should be filled in before netdev is registers
<jgarzik> registered
<jgarzik> Ralf: well, ->open() is just the manifestation of interface-up operation, with all the notifications that that entails.  At that point, NIC driver should not be touching dev->dev_addr[], because it may have already been supplied by the user via ifconfig, when the interface was down.
<jgarzik> Ralf: dev->dev_addr[] should definitely be filled in before the call to register_netdev()

  Ralf
