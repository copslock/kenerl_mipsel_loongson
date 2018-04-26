Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Apr 2018 22:46:29 +0200 (CEST)
Received: from vps0.lunn.ch ([185.16.172.187]:48048 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994626AbeDZUqWk4grO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 Apr 2018 22:46:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=SxWHWxo3spk/WDrRjcQJlcLYeVIO1qelovVHU1cObQo=;
        b=yroI/0gQTDh92JH0srlHl4SSYZkWgEEXUOEEeWRWfzciLDpXqhbHlkU1zIj7yQVx/a/2h6O9jHtUPKBorQGfrMjcupYCiNsMzENEYL23mJ7fVSwEmjCVEyK8eWbwTt5J+qkiPFr9/YMVDBA1iSBYno+GIeeEM2tNv/2XgErL7p4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fBnmF-000737-GP; Thu, 26 Apr 2018 22:46:03 +0200
Date:   Thu, 26 Apr 2018 22:46:03 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>,
        razvan.stefanescu@nxp.com, po.liu@nxp.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH net-next v2 2/7] net: mscc: Add MDIO driver
Message-ID: <20180426204603.GC23481@lunn.ch>
References: <20180426195931.5393-1-alexandre.belloni@bootlin.com>
 <20180426195931.5393-3-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426195931.5393-3-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63807
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

On Thu, Apr 26, 2018 at 09:59:26PM +0200, Alexandre Belloni wrote:
> Add a driver for the Microsemi MII Management controller (MIIM) found on
> Microsemi SoCs.
> On Ocelot, there are two controllers, one is connected to the internal
> PHYs, the other one can communicate with external PHYs.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
