Received:  by oss.sgi.com id <S42277AbQHIXI7>;
	Wed, 9 Aug 2000 16:08:59 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:3435 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42259AbQHIXId>; Wed, 9 Aug 2000 16:08:33 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id QAA01436
	for <linux-mips@oss.sgi.com>; Wed, 9 Aug 2000 16:13:58 -0700 (PDT)
	mail_from (jsimmons@acsu.buffalo.edu)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA04515
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 9 Aug 2000 16:07:38 -0700 (PDT)
	mail_from (jsimmons@acsu.buffalo.edu)
Received: from mailrelay.acsu.buffalo.edu (mailrelay.acsu.buffalo.edu [128.205.7.101]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id QAA04543
	for <linux@cthulhu.engr.sgi.com>; Wed, 9 Aug 2000 16:07:19 -0700 (PDT)
	mail_from (jsimmons@acsu.buffalo.edu)
Received: (qmail 1772 invoked from network); 9 Aug 2000 23:07:16 -0000
Received: from ubppp233-118.dialin.buffalo.edu (128.205.233.118)
  by mailrelay with SMTP; 9 Aug 2000 23:07:16 -0000
Date:   Wed, 9 Aug 2000 19:17:02 -0400 (EDT)
From:   James Simmons <jsimmons@acsu.buffalo.edu>
X-Sender: jsimmons@maxwell.futurevision.com
To:     i15@ornl.gov
cc:     linux-fbdev@vuser.vu.union.edu, linux@cthulhu.engr.sgi.com
Subject: Re: [linux-fbdev] SGI VW 540, fbdev and pot pourii of faults and
 evidence..:-)
In-Reply-To: <Pine.LNX.4.21.0008051851230.943-100000@janus.lsd.ornl.gov>
Message-ID: <Pine.LNX.4.10.10008091913570.1534-100000@maxwell.futurevision.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


> I would also like to ask, if SGI is likely to make the hardware specs OSS
> (for cobalt etc.), so that those with the skill (this is not my forte, but
> I will try...), can stabilise this otherwise competent port.

Nope. SGI no longer supports Visual Workstations with linux. I don't even
know if they support Visual Workstatiosn period. It would be nice if they
did release the specs anyways :-)

> 1. After boot , no matter what video mode one is in, the text console is
> zippy. After using X (or changing modes using fbset) the text scrolling is
> *painfully* slow. There is no apparent difference in the kernel mechanism
> when switching, so is it just the boot state that works?

Which X server?  Sounds like the X server is doing the naughty.

> 	Empirical observations (i.e. writing known patterns to the
> /dev/fb0 device) indicate that SGI reverse RGB for 888 format, compared to
> RGB565. That is red offset=0, green=8,blue=16 rather than red=24 etc.. I
> have reversed the assignment in the "var" structure (in sgivwfb_set_var )
> and in setcolreg the offsets are used, but to no effect. What else needs
> changing?

Have a patch for this? Can you post it?

----------------------------------------------------------------------------
Innovation, innovate, and the concept of doing what everyone else did 20
years ago are registered trademarks of Microsoft Corporation. Other
buzzwords, euphemisms, and blatant lies are trademarks of their respective
owners.

James Simmons  [jsimmons@linux-fbdev.org]               ____/| 
fbdev/console/gfx developer                             \ o.O| 
http://www.linux-fbdev.org                               =(_)= 
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net
