Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Nov 2004 20:00:07 +0000 (GMT)
Received: from pD95621F5.dip.t-dialin.net ([IPv6:::ffff:217.86.33.245]:32579
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225330AbUKIUAA>; Tue, 9 Nov 2004 20:00:00 +0000
Received: from fluff.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id iA9JxxXE025513;
	Tue, 9 Nov 2004 20:59:59 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id iA9Jxr7p025512;
	Tue, 9 Nov 2004 20:59:53 +0100
Date: Tue, 9 Nov 2004 20:59:53 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Manish Lachwani <mlachwani@prometheus.mvista.com>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] Small fix for the Sibyte Mac driver
Message-ID: <20041109195953.GA25337@linux-mips.org>
References: <20041108235148.GA20991@prometheus.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041108235148.GA20991@prometheus.mvista.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6290
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 08, 2004 at 03:51:48PM -0800, Manish Lachwani wrote:

> Attached is a small patch for the Sibyte MAC Driver. This helps
> print the device name correctly

> -	/* This is needed for PASS2 for Rx H/W checksum feature */
> -	sbmac_set_iphdr_offset(sc);
> -
>  	err = register_netdev(dev);
>  	if (err)
>  		goto out_uninit;
>  
> +	/* This is needed for PASS2 for Rx H/W checksum feature */
> +	sbmac_set_iphdr_offset(sc);
> +

Your patch introduces a race condition - the NIC needs to be fully setup
before register_netdev.  By the time register_netdev returns the driver
could possibly already be opened and traffic be flowing.  What's usually
done is using the PCI device's name as obtained through pci_name().
Which in this case fails, so maybe you should convert the driver to a
platform_device() and print platform_device->name instead.  The Titan GE
driver which I think you're familiar with already use platform_device ;-)

  Ralf
