Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2018 22:59:02 +0200 (CEST)
Received: from vps0.lunn.ch ([185.16.172.187]:36321 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992737AbeENU64SFpRZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 May 2018 22:58:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=1AbkXRg46txqfj2y8nlJbDfLPEOqI23iohFRZ/CVago=;
        b=Ptc1KaKtRXX7sNf9tKQp01OMJMkIUV89BGppSKWW4cw/qvhaBYrAZj4EVkRu+P/cQ8okGymz3vxwmtQa59W1yl5JabpWgvSMy523dl3NwmknCoZCvBFwtHKdr2n7/EatQaco5c4yr89yY6fxmmIJA1xZlivVdJEMrXgAfq3wrS8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fIKYO-0002Gj-Ej; Mon, 14 May 2018 22:58:44 +0200
Date:   Mon, 14 May 2018 22:58:44 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>,
        razvan.stefanescu@nxp.com, po.liu@nxp.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, James Hogan <jhogan@kernel.org>
Subject: Re: [PATCH net-next v3 0/7] Microsemi Ocelot Ethernet switch support
Message-ID: <20180514205844.GG1057@lunn.ch>
References: <20180514200500.2953-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514200500.2953-1-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63952
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

Hi Alexandre
> 
> The ocelot dts changes are here for reference and should probably go
> through the MIPS tree once the bindings are accepted.

For your next version, you probably want to drop those patches, so
that David can apply the network patches to net-next.

     Andrew
