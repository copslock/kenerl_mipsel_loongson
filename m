Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Mar 2004 14:52:02 +0000 (GMT)
Received: from p508B7CF6.dip.t-dialin.net ([IPv6:::ffff:80.139.124.246]:63505
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224950AbUCJOv7>; Wed, 10 Mar 2004 14:51:59 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i2AEpvex009016;
	Wed, 10 Mar 2004 15:51:57 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i2AEpvlQ009015;
	Wed, 10 Mar 2004 15:51:57 +0100
Date: Wed, 10 Mar 2004 15:51:57 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@linux-mips.org
Subject: Re: "eth%d" - net dev name in 2.6?
Message-ID: <20040310145156.GA26629@linux-mips.org>
References: <20040310023308.GU31326@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040310023308.GU31326@mvista.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4522
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Mar 09, 2004 at 06:33:08PM -0800, Jun Sun wrote:

> With swarm running on 2.6 I just saw the net dev names are
> not set correctly.  See below.
> 
> eth%d: SiByte Ethernet at 0x10064000, address: 00-02-4C-FE-0C-B2                
> eth%d: enabling TCP rcv checksum                                                
> 
> It appears alloc_netdev() assigns this initial name and nobody
> later resets it to a more meaningful name.  
> 
> Any body has a clue here?  I don't think it is driver's job though ...

It's always the driver :-)

It's referencing net_device->name before register_netdev.

There's plenty of other small candy in that driver, for example in
sbmac_cleanup_module():

                dev = dev_sbmac[idx];
                if (!dev) {
                        struct sbmac_softc *sc = dev->priv;
                        unregister_netdev(dev);
                        sbmac_uninitctx(sc);
                        free_netdev(dev);
                }

Better make sure the pointer is NULL before we dereference it.  We don't
want to miss a crash, do we ;-)

  Ralf
