Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Dec 2014 19:14:48 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:49917 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27008844AbaLOSOrC5K5z (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 15 Dec 2014 19:14:47 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sBFIEj9q029672;
        Mon, 15 Dec 2014 19:14:45 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sBFIEidg029671;
        Mon, 15 Dec 2014 19:14:44 +0100
Date:   Mon, 15 Dec 2014 19:14:44 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>, linux-mips@linux-mips.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ioc3: fix incorrect use of htons/ntohs
Message-ID: <20141215181444.GD26674@linux-mips.org>
References: <1417344054-4374-1-git-send-email-LinoSanfilippo@gmx.de>
 <1417406976.7215.126.camel@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1417406976.7215.126.camel@decadent.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44697
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Mon, Dec 01, 2014 at 04:09:36AM +0000, Ben Hutchings wrote:

> >  	/* Same as tx - compute csum of pseudo header  */
> >  	csum = hwsum +
> > -	       (ih->tot_len - (ih->ihl << 2)) +
> > -	       htons((uint16_t)ih->protocol) +
> > +	       (ih->tot_len - (ih->ihl << 2)) + ih->protocol +
> >  	       (ih->saddr >> 16) + (ih->saddr & 0xffff) +
> >  	       (ih->daddr >> 16) + (ih->daddr & 0xffff);
> >
> 
> The pseudo-header is specified as:
> 
>                      +--------+--------+--------+--------+
>                      |           Source Address          |
>                      +--------+--------+--------+--------+
>                      |         Destination Address       |
>                      +--------+--------+--------+--------+
>                      |  zero  |  PTCL  |    TCP Length   |
>                      +--------+--------+--------+--------+
> 
> The current code zero-extends the protocol number to produce the 5th
> 16-bit word of the pseudo-header, then uses htons() to put it in
> big-endian order, consistent with the other fields.  (Yes, it's doing
> addition on big-endian words; this works even on little-endian machines
> due to the way the checksum is specified.)
> 
> The driver should not be doing this at all, though.  It should set
> skb->csum = hwsum; skb->ip_summed = CHECKSUM_COMPLETE; and let the
> network stack adjust the hardware checksum.

Really?  The IOC3 isn't the exactly the smartest NIC around; it does add up
everything and the kitchen sink, that is ethernet headers, IP headers and
on RX the frame's trailing CRC.  All that needs to be subtracted in software
which is what this does.  I think others NICs are all smarted and don't
need this particular piece of magic.

I agree with your other comment wrt. to htons().

  Ralf
