Received:  by oss.sgi.com id <S42288AbQHVD4P>;
	Mon, 21 Aug 2000 20:56:15 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:2845 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42207AbQHVDzy>;
	Mon, 21 Aug 2000 20:55:54 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id UAA26755
	for <linux-mips@oss.sgi.com>; Mon, 21 Aug 2000 20:48:11 -0700 (PDT)
	mail_from (adi@mr-happy.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id UAA44868
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 21 Aug 2000 20:55:31 -0700 (PDT)
	mail_from (adi@mr-happy.com)
Received: from brainguy.tc.mtu.edu (brainguy.tc.mtu.edu [141.219.5.85]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id UAA09725
	for <linux@cthulhu.engr.sgi.com>; Mon, 21 Aug 2000 20:55:29 -0700 (PDT)
	mail_from (adi@mr-happy.com)
Received: from crow.mr-happy.com (crow.mr-happy.com [172.19.3.81])
	by brainguy.tc.mtu.edu (Postfix) with ESMTP
	id D811C1A196; Mon, 21 Aug 2000 23:55:22 -0400 (EDT)
Received: by crow.mr-happy.com (Postfix, from userid 22448)
	id CEF418D58; Mon, 21 Aug 2000 23:55:20 -0400 (EDT)
Date:   Mon, 21 Aug 2000 22:55:20 -0500
From:   Andy Isaacson <adi@mr-happy.com>
To:     James Simmons <jsimmons@acsu.buffalo.edu>, i15@ornl.gov
Cc:     linux-fbdev@vuser.vu.union.edu, linux@cthulhu.engr.sgi.com
Subject: Re: [linux-fbdev] SGI VW 540, fbdev and pot pourii of faults and evidence..:-)
Message-ID: <20000821225520.A25330@mr-happy.com>
References: <Pine.LNX.4.10.10008091913570.1534-100000@maxwell.futurevision.com> <Pine.SGI.4.10.10008091908170.26870-100000@tigger.ccs.ornl.gov> <Pine.LNX.4.21.0008051851230.943-100000@janus.lsd.ornl.gov> <Pine.LNX.4.10.10008091913570.1534-100000@maxwell.futurevision.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.10.10008091913570.1534-100000@maxwell.futurevision.com>; from jsimmons@acsu.buffalo.edu on Wed, Aug 09, 2000 at 07:17:02PM -0400
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.mr-happy.com/~adi/pgp.txt
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Aug 09, 2000 at 07:17:02PM -0400, James Simmons wrote:
> > I would also like to ask, if SGI is likely to make the hardware specs OSS
> > (for cobalt etc.), so that those with the skill (this is not my forte, but
> > I will try...), can stabilise this otherwise competent port.
> 
> Nope. SGI no longer supports Visual Workstations with linux. I don't even
> know if they support Visual Workstatiosn period. It would be nice if they
> did release the specs anyways :-)

SGI never did support the Visual Workstation 540 and 320 in Linux.
There did exist some code, but it was never a formal SGI product.

On Wed, Aug 09, 2000 at 07:28:07PM -0400, philloc@tigger.ccs.ornl.gov wrote:
> 	Anyone from SGI care to comment on why SGI has not released the
> specs to reasonable attention, since they are unable to help port? 

I don't speak for SGI, but in the past I think they said that the
specs basically do not exist in a releasable form.  Basically, the
hardware developers and software developers worked in the same hallway
and the development was of the form "hey Joe, how do I program the
zapbot to do foobaz?"

OK, maybe that's not quite accurate, but the result is that there are
no plans to release specs.

-andy
-- 
Andy Isaacson <adi@mr-happy.com> http://web.mr-happy.com/~adi/
I want to buy your broken laptop! http://web.mr-happy.com/~adi/laptop.html
