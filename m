Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Mar 2018 16:16:57 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:50613 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991855AbeC3OQunKJ29 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 30 Mar 2018 16:16:50 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 272A920644; Fri, 30 Mar 2018 16:16:45 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id F295220384;
        Fri, 30 Mar 2018 16:16:34 +0200 (CEST)
Date:   Fri, 30 Mar 2018 16:16:34 +0200
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
Message-ID: <20180330141634.GD14180@piout.net>
References: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
 <20180323201117.8416-6-alexandre.belloni@bootlin.com>
 <1df0a932-f7c1-f1b5-9a35-3c16d0c551e5@gmail.com>
 <20180330124537.GC14180@piout.net>
 <20180330135422.GA28244@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180330135422.GA28244@lunn.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63367
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

On 30/03/2018 at 15:54:22 +0200, Andrew Lunn wrote:
> > > All of this sounds like it should be moved into the br_join/leave, this
> > > does not appear to be the right place to do that.
> > > 
> > 
> > No, I've triple checked because this is a comment that both Andrew and
> > you had. Once a port is added to the PGID MASK, it will start forwarding
> > frames so we really want that to happen only when the port is in
> > BR_STATE_FORWARDING state. Else, we may forward frames between the
> > addition of the port to the bridge and setting the port to the
> > BR_STATE_BLOCKING state.
> 
> Hi Alexandre
> 
> Interesting observation. I took a look at some of the other join
> implementations. mv88e6xxx does the join immediately. mt7539 does it
> immediately, if the port is enabled. lan9303 does it immediately.
> qca8k does it immediately. b53 does it immediately.
> 

I had a look at b53, my impression was that b53_br_join() adds the port
to the bridge but b53_br_set_stp_state() actually enables forwarding. So
as long as the default on the port is PORT_CTRL_DIS_STATE, the port will
not be forwarding frames. And this is the case because b53_enable_port()
does put 0 in B53_PORT_CTRL.

The fact is that ocelot doesn't have separate controls. The port is
either forwarding or not. If it is not forwarding, then there is nothing
to tell the HW to do.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
