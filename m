Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2018 22:57:11 +0200 (CEST)
Received: from vps0.lunn.ch ([185.16.172.187]:36311 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992684AbeENU5Dz8CgZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 May 2018 22:57:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=UfpBcHB+XAQqVff+HUnff6CFndQrPgVFhzw2W0N1uXY=;
        b=Lugwso0ZuO/nnqnoN7D+KcHCNAgZURivzQTy0T4uRpT/iEZ5M2N57PAwlOImle/U3t74kOA2ISWau1Wk05/xRa0bmuUK5iR/OvFDIZAfzDCvq6uDMtVKYAXSDzQQa9ttjZcae5+0hMLP0hmbQnmegKPLBdbXEnIzgm4lKvlXl5g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fIKWb-0002En-F9; Mon, 14 May 2018 22:56:53 +0200
Date:   Mon, 14 May 2018 22:56:53 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>,
        razvan.stefanescu@nxp.com, po.liu@nxp.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH net-next v3 4/7] net: mscc: Add initial Ocelot switch
 support
Message-ID: <20180514205653.GF1057@lunn.ch>
References: <20180514200500.2953-1-alexandre.belloni@bootlin.com>
 <20180514200500.2953-5-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514200500.2953-5-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63951
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

On Mon, May 14, 2018 at 10:04:57PM +0200, Alexandre Belloni wrote:
> Add a driver for Microsemi Ocelot Ethernet switch support.
> 
> This makes two modules:
> mscc_ocelot_common handles all the common features that doesn't depend on
> how the switch is integrated in the SoC. Currently, it handles offloading
> bridging to the hardware. ocelot_io.c handles register accesses. This is
> unfortunately needed because the register layout is packed and then depends
> on the number of ports available on the switch. The register definition
> files are automatically generated.
> 
> ocelot_board handles the switch integration on the SoC and on the board.
> 
> Frame injection and extraction to/from the CPU port is currently done using
> register accesses which is quite slow. DMA is possible but the port is not
> able to absorb the whole switch bandwidth.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Hi Alexandre

There are a few Christmas trees which are not fully reversed. DaveM
might want them putting right.

But otherwise i think this is good enough to be merged.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
