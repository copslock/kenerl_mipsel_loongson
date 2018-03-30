Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Mar 2018 16:50:26 +0200 (CEST)
Received: from vps0.lunn.ch ([185.16.172.187]:53201 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991855AbeC3OuTjaJyg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 30 Mar 2018 16:50:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=FTpGNAYh/8VA0UjQXcvEPnKVtZDoDGUlB6Wehn210a8=;
        b=A1XMbAWFADtuAgAHYCbicj26/X35tSYd5YwWhFfcj2nU9jkNO281QO1N327A4vKxrgeUvC/kDiYy1Q7hFLJKs9R/PZ2KNHS1WZ06zDvFD08a+ij88uEBaDP7dwGp/JOG7W7BYucb81hlmI4YkrQ4mk7Ec6oxVy0Hskod7dhEiuM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1f1vM0-0007o1-LI; Fri, 30 Mar 2018 16:50:08 +0200
Date:   Fri, 30 Mar 2018 16:50:08 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>,
        razvan.stefanescu@nxp.com, po.liu@nxp.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH net-next 5/8] net: mscc: Add initial Ocelot switch support
Message-ID: <20180330145008.GE28244@lunn.ch>
References: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
 <20180323201117.8416-6-alexandre.belloni@bootlin.com>
 <1df0a932-f7c1-f1b5-9a35-3c16d0c551e5@gmail.com>
 <20180330124537.GC14180@piout.net>
 <20180330135422.GA28244@lunn.ch>
 <20180330141634.GD14180@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180330141634.GD14180@piout.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63368
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

On Fri, Mar 30, 2018 at 04:16:34PM +0200, Alexandre Belloni wrote:
> On 30/03/2018 at 15:54:22 +0200, Andrew Lunn wrote:
> > > > All of this sounds like it should be moved into the br_join/leave, this
> > > > does not appear to be the right place to do that.
> > > > 
> > > 
> > > No, I've triple checked because this is a comment that both Andrew and
> > > you had. Once a port is added to the PGID MASK, it will start forwarding
> > > frames so we really want that to happen only when the port is in
> > > BR_STATE_FORWARDING state. Else, we may forward frames between the
> > > addition of the port to the bridge and setting the port to the
> > > BR_STATE_BLOCKING state.
> > 
> > Hi Alexandre
> > 
> > Interesting observation. I took a look at some of the other join
> > implementations. mv88e6xxx does the join immediately. mt7539 does it
> > immediately, if the port is enabled. lan9303 does it immediately.
> > qca8k does it immediately. b53 does it immediately.
> > 
> 
> I had a look at b53, my impression was that b53_br_join() adds the port
> to the bridge but b53_br_set_stp_state() actually enables forwarding. So
> as long as the default on the port is PORT_CTRL_DIS_STATE, the port will
> not be forwarding frames. And this is the case because b53_enable_port()
> does put 0 in B53_PORT_CTRL.

https://elixir.bootlin.com/linux/latest/source/drivers/net/dsa/b53/b53_regs.h#L71

It seems like, 0 means no STP at all. Which to me would mean, forward
all packets. But i could be wrong. Florian?

> The fact is that ocelot doesn't have separate controls. The port is
> either forwarding or not. If it is not forwarding, then there is nothing
> to tell the HW to do.

Think about the following sequence:

ip link set lan0 up

After this command, i expect to see packets on lan0 arrive at the
host, tcpdump to work, etc. This probably means the port is in
'forwarding' mode, or for B53, STP is disabled.

ip link add name br0 type bridge
ip link set dev br0 up
ip link set dev lan0 master br0

When the port is added to the bridge, there is a window of time
between the join and the STP change to blocking/learning, when the
port is in forwarding mode. You avoid this window. But the other
drivers don't appear to.

So i would like to fix this of every driver. I'm not sure how yet...

   Andrew
