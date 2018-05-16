Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 May 2018 13:26:36 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:54376 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992907AbeEPL02fdgoK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 16 May 2018 13:26:28 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6C68A206FB; Wed, 16 May 2018 13:26:21 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4075C20012;
        Wed, 16 May 2018 13:26:21 +0200 (CEST)
Date:   Wed, 16 May 2018 13:26:22 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     James Hogan <jhogan@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>,
        razvan.stefanescu@nxp.com, po.liu@nxp.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH net-next v3 0/7] Microsemi Ocelot Ethernet switch support
Message-ID: <20180516112622.GA3254@piout.net>
References: <20180514200500.2953-1-alexandre.belloni@bootlin.com>
 <20180514205844.GG1057@lunn.ch>
 <20180514214734.GB29541@jamesdev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514214734.GB29541@jamesdev>
User-Agent: Mutt/1.9.5 (2018-04-13)
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63973
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@bootlin.com
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

On 14/05/2018 22:47:35+0100, James Hogan wrote:
> On Mon, May 14, 2018 at 10:58:44PM +0200, Andrew Lunn wrote:
> > Hi Alexandre
> > > 
> > > The ocelot dts changes are here for reference and should probably go
> > > through the MIPS tree once the bindings are accepted.
> > 
> > For your next version, you probably want to drop those patches, so
> > that David can apply the network patches to net-next.
> 
> Since it sounds like the net patches are ready now, I'll apply the MIPS
> DTS ones for 4.18.
> 

They are in now, tell me if you want me to resend.

Anyway, I'll probably send another patch to enable the driver in
board-ocelot.config


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
