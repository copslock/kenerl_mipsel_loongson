Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Aug 2005 22:11:24 +0100 (BST)
Received: from smtp005.bizmail.sc5.yahoo.com ([IPv6:::ffff:66.163.175.82]:29543
	"HELO smtp005.bizmail.sc5.yahoo.com") by linux-mips.org with SMTP
	id <S8225792AbVHEVLH>; Fri, 5 Aug 2005 22:11:07 +0100
Received: (qmail 400 invoked from network); 5 Aug 2005 21:14:40 -0000
Received: from unknown (HELO ?192.168.1.106?) (ppopov@embeddedalley.com@71.128.175.242 with plain)
  by smtp005.bizmail.sc5.yahoo.com with SMTP; 5 Aug 2005 21:14:40 -0000
Subject: Re: AMD Au1100 problems (USB & Ethernet)
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	Sylvain Munaut <tnt@246tNt.com>
Cc:	Michael Kelly <mike@cogcomp.com>,
	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
In-Reply-To: <42F3D4B7.6040905@246tNt.com>
References: <42F3C05E.7060002@246tNt.com>
	 <1123271252.19992.189.camel@localhost.localdomain>
	 <6.2.0.14.2.20050805155414.044a0f00@mail.cogcomp.com>
	 <1123272640.19992.199.camel@localhost.localdomain>
	 <42F3D4B7.6040905@246tNt.com>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date:	Fri, 05 Aug 2005 14:14:34 -0700
Message-Id: <1123276474.23193.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8701
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips


> The PHY is on the CPU module itself, it's a BCM5221.

I see.

> >>If you could determine the actual errors (such as CRC, collision, etc) then we
> >>can try to determine where the errors are coming from.  It may very well be
> >>HW, but it is a bit too early to make such a broad statement without more
> >>information.
> > 
> > 
> > Well, could be just a cable issue, hub, etc, but I'll put that in the HW
> > bucket as well :)
> 
> The RX errors are reported as "rx miss" (RX_MISSED_FRAME set) which is
> described as "Internal FIFO overrun". Maybe those are just OK and it's
> just that it can't wistand full 100Mbps (the module is connected on a
> 10/100/1000 switch and the server is gigabit).

No, I don't think that's normal.

> The TX errors are time-out, how can I find more details about that ?

If possible, eliminate the gig switch by replacing it with a small
10/100 switch. If the problems go away, then that's a big clue.

Take a look at what the bcm phy is auto-negotiating and make sure it
matches what the switch thinks it has negotiated. Although, the tx
timeouts should have nothing to do with mismatched auto negotiation...
but I see there are a bunch of "carrier" errors.

You of course tried a different cable, just in case?

Pete
