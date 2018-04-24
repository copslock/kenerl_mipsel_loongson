Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Apr 2018 20:53:02 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:37723 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994665AbeDXSw4choPR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 Apr 2018 20:52:56 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 636E120719; Tue, 24 Apr 2018 20:52:49 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 343AD20384;
        Tue, 24 Apr 2018 20:52:39 +0200 (CEST)
Date:   Tue, 24 Apr 2018 20:52:39 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>,
        razvan.stefanescu@nxp.com, po.liu@nxp.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH net-next 5/8] net: mscc: Add initial Ocelot switch support
Message-ID: <20180424185239.GG19011@piout.net>
References: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
 <20180323201117.8416-6-alexandre.belloni@bootlin.com>
 <1df0a932-f7c1-f1b5-9a35-3c16d0c551e5@gmail.com>
 <20180330124537.GC14180@piout.net>
 <20180330135422.GA28244@lunn.ch>
 <20180330141634.GD14180@piout.net>
 <20180330145008.GE28244@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180330145008.GE28244@lunn.ch>
User-Agent: Mutt/1.9.5 (2018-04-13)
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63736
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

I realise now that I didn't reply to this comment:

On 30/03/2018 16:50:08+0200, Andrew Lunn wrote:
> > The fact is that ocelot doesn't have separate controls. The port is
> > either forwarding or not. If it is not forwarding, then there is nothing
> > to tell the HW to do.
> 
> Think about the following sequence:
> 
> ip link set lan0 up
> 
> After this command, i expect to see packets on lan0 arrive at the
> host, tcpdump to work, etc. This probably means the port is in
> 'forwarding' mode, or for B53, STP is disabled.
> 

On Ocelot, forwarding packets to the host (i.e. forwarding frames
received on the port to the cpu port) is separate from bridging ports
together. So after that command, the host can receive packets on lan0.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
