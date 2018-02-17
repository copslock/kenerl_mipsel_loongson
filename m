Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Feb 2018 23:14:56 +0100 (CET)
Received: from vps0.lunn.ch ([185.16.172.187]:35764 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994644AbeBQWOto0xvZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 17 Feb 2018 23:14:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=8c+PZ83XqFPhzuXQPr58ySkn/L21rgzs0wu3UXVG4Ug=;
        b=lf97fW3p/P+/tfvODyJrFSKn+jyZzpMGK6wOeck5JwKsvby+vjX0HMqadUCzmNn4rkblW+SWgqgpGd5ihd9/Eqba6JoRfcwpRt51XAdobGt69Fcsz42jurAyp2ohwX7DIWGNkf+en/xPK8+bqa+AOAmi/3sBlcGPnE9NnREuyHc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1enAke-00062D-8x; Sat, 17 Feb 2018 23:14:36 +0100
Date:   Sat, 17 Feb 2018 23:14:36 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Paul Burton <paul.burton@mips.com>
Cc:     netdev@vger.kernel.org, Hassan Naveed <hassan.naveed@mips.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        "David S . Miller" <davem@davemloft.net>, linux-mips@linux-mips.org
Subject: Re: [PATCH v5 01/14] net: pch_gbe: Mark Minnow PHY reset GPIO active
 low
Message-ID: <20180217221436.GA21315@lunn.ch>
References: <20180217201037.3006-1-paul.burton@mips.com>
 <20180217201037.3006-2-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180217201037.3006-2-paul.burton@mips.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62599
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andrew@lunn.ch
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

> @@ -2700,10 +2701,10 @@ static int pch_gbe_minnow_platform_init(struct pci_dev *pdev)
>  		return ret;
>  	}
>  
> -	gpio_set_value(gpio, 0);
> -	usleep_range(1250, 1500);
>  	gpio_set_value(gpio, 1);
>  	usleep_range(1250, 1500);
> +	gpio_set_value(gpio, 0);
> +	usleep_range(1250, 1500);

Hi Paul

It would be better to rewrite and use the gpiod_ API. The GPIO core
would then handle active low/active high.

      Andrew
