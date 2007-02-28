Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Feb 2007 23:17:36 +0000 (GMT)
Received: from smtp.osdl.org ([65.172.181.24]:43192 "EHLO smtp.osdl.org")
	by ftp.linux-mips.org with ESMTP id S20039061AbXB1XRb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 28 Feb 2007 23:17:31 +0000
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1SNB4hB032148
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 28 Feb 2007 15:11:04 -0800
Received: from freekitty (freekitty.pdx.osdl.net [10.8.0.54])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1SNB3C7029881;
	Wed, 28 Feb 2007 15:11:03 -0800
Date:	Wed, 28 Feb 2007 15:11:03 -0800
From:	Stephen Hemminger <shemminger@linux-foundation.org>
To:	"Dale Farnsworth" <dale@farnsworth.org>
Cc:	Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-mips@linux-mips.org,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 1/2] mv643xx_eth: move mac_addr inside of
 mv643xx_eth_platform_data
Message-ID: <20070228151103.0c5a320d@freekitty>
In-Reply-To: <20070228224031.GA8233@xyzzy.farnsworth.org>
References: <20070228224031.GA8233@xyzzy.farnsworth.org>
Organization: Linux Foundation
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Return-Path: <shemminger@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14291
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shemminger@linux-foundation.org
Precedence: bulk
X-list: linux-mips

On Wed, 28 Feb 2007 15:40:31 -0700
"Dale Farnsworth" <dale@farnsworth.org> wrote:

> The information contained within platform_data should be self-contained.
> Replace the pointer to a MAC address with the actual MAC address in
> struct mv643xx_eth_platform_data.
> 
> Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
> 
> Index: b/drivers/net/mv643xx_eth.c
> ===================================================================
> --- a/drivers/net/mv643xx_eth.c
> +++ b/drivers/net/mv643xx_eth.c
> @@ -1380,7 +1380,9 @@ static int mv643xx_eth_probe(struct plat
>  
>  	pd = pdev->dev.platform_data;
>  	if (pd) {
> -		if (pd->mac_addr)
> +		static u8 zero_mac_addr[6] = { 0 };
> +
> +		if (memcmp(pd->mac_addr, zero_mac_addr, 6) != 0)
>  			memcpy(dev->dev_addr, pd->mac_addr, 6);


is_zero_ether_addr() is faster/cleaner for this

-- 
Stephen Hemminger <shemminger@linux-foundation.org>
