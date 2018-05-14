Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2018 22:51:29 +0200 (CEST)
Received: from vps0.lunn.ch ([185.16.172.187]:36286 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992737AbeENUvPY4hTZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 May 2018 22:51:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=93yA/042XRyqz0mYnSITNTCmvT+GycCxwUSpmHrGQtA=;
        b=rW2srmFpz8mp8fDpTDq9jAr1BvSooQ8CCLIvS1i9d1ENR9IJzVuh3/3ic0FieMgph6fDZpTjWax3Ft0BrNVhOEDj+G3G/6okk7EOKk53ZoEAQduqjmJ2Entr0c6+I1B79T5vAGR4u/TPbdCC/rZVMEzFy0L+LfAS0uIwNhR7APs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fIKQz-000295-HK; Mon, 14 May 2018 22:51:05 +0200
Date:   Mon, 14 May 2018 22:51:05 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>,
        razvan.stefanescu@nxp.com, po.liu@nxp.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH net-next v3 7/7] MAINTAINERS: Add entry for Microsemi
 Ethernet switches
Message-ID: <20180514205105.GE1057@lunn.ch>
References: <20180514200500.2953-1-alexandre.belloni@bootlin.com>
 <20180514200500.2953-8-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514200500.2953-8-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63946
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

On Mon, May 14, 2018 at 10:05:00PM +0200, Alexandre Belloni wrote:
> Add myself as a maintainer for the Microsemi Ethernet switches.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0a1410d5a621..b632deb3f503 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9280,6 +9280,12 @@ F:	include/linux/cciss*.h
>  F:	include/uapi/linux/cciss*.h
>  F:	Documentation/scsi/smartpqi.txt
>  
> +MICROSEMI ETHERNET SWITCH DRIVER
> +M:	Alexandre Belloni <alexandre.belloni@bootlin.com>
> +L:	netdev@vger.kernel.org
> +S:	Supported
> +F:	drivers/net/ethernet/mscc/
> +
>  MICROSOFT SURFACE PRO 3 BUTTON DRIVER
>  M:	Chen Yu <yu.c.chen@intel.com>
>  L:	platform-driver-x86@vger.kernel.org
> -- 
> 2.17.0
> 
