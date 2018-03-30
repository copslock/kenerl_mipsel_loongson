Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Mar 2018 15:54:46 +0200 (CEST)
Received: from vps0.lunn.ch ([185.16.172.187]:53126 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991855AbeC3NyjdJRw9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 30 Mar 2018 15:54:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=C9WlJNag0D/wjLxtNQAKyzZSl+qdKL/owk8s2wktyNw=;
        b=2Bs0AE+JF/Tq3r4o5Q+f7hUlhGKbHbfu19iIOjFGkF0RKRCuMQE3hISZx2wV0S+X6swlFoPc9HfvKYbX0eiFFJfdLydQArYCJ9rCEVGYu1fvP5YQsn7jWOC6c7ScmfuJFlMGXLPgYe/eyBwwK2BBrxIJJSFgL1+BCTXXjMz+9k0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1f1uU2-0007Pk-EI; Fri, 30 Mar 2018 15:54:22 +0200
Date:   Fri, 30 Mar 2018 15:54:22 +0200
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
Message-ID: <20180330135422.GA28244@lunn.ch>
References: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
 <20180323201117.8416-6-alexandre.belloni@bootlin.com>
 <1df0a932-f7c1-f1b5-9a35-3c16d0c551e5@gmail.com>
 <20180330124537.GC14180@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180330124537.GC14180@piout.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63366
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

> > All of this sounds like it should be moved into the br_join/leave, this
> > does not appear to be the right place to do that.
> > 
> 
> No, I've triple checked because this is a comment that both Andrew and
> you had. Once a port is added to the PGID MASK, it will start forwarding
> frames so we really want that to happen only when the port is in
> BR_STATE_FORWARDING state. Else, we may forward frames between the
> addition of the port to the bridge and setting the port to the
> BR_STATE_BLOCKING state.

Hi Alexandre

Interesting observation. I took a look at some of the other join
implementations. mv88e6xxx does the join immediately. mt7539 does it
immediately, if the port is enabled. lan9303 does it immediately.
qca8k does it immediately. b53 does it immediately.

Either they all get it wrong, or we make the assumption the bridge
sets the STP state first, then has the port join the bridge.

Looking at the code, br_add_if() it calls
netdev_master_upper_dev_link() and then later

        if (netif_running(dev) && netif_oper_up(dev) &&
            (br->dev->flags & IFF_UP))
                br_stp_enable_port(p);

So it does look like there is a window of time between the port
joining and the STP state being set.

I know in the past, we have run into the opposite problem. A port
leaves the bridge, while in blocked state. The port should then
becomes an individual port, so the STP state needs setting to
forwarding. I don't remember where we fix this.

I don't like that this new driver is different, but it also looks like
we have a real problem here. More digging needed.

   Andrew
