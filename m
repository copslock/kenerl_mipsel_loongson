Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 May 2003 00:00:51 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:43759 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225206AbTENXAt>;
	Thu, 15 May 2003 00:00:49 +0100
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id QAA28982;
	Wed, 14 May 2003 16:00:40 -0700
Subject: RE: Power On Self Test and testing memory
From: Pete Popov <ppopov@mvista.com>
To: Lyle Bainbridge <lyle@zevion.com>
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
In-Reply-To: <000001c31a6c$0e504e80$0a01a8c0@RADIUM>
References: <000001c31a6c$0e504e80$0a01a8c0@RADIUM>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1052953242.788.230.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 14 May 2003 16:00:43 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2388
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Wed, 2003-05-14 at 15:56, Lyle Bainbridge wrote:
> Hi,
> 
> I used the same strategy, but had similar issues.
> So I just skip the first couple of 1000 bytes.
> I'd like to find out why too.
> 
> Also, memory wraps.  If I have 32MB of RAM @ 0x80000000,
> then run the memory test in non-existent memory from
> 0x82000000 to 0x83ffffff it appears to reference 0x80000000
> to 0x81ffffff.  Can this be made to fail?

Write something other than 5555 5555 and you'll catch the "problem". If
you write the address of the memory location or in the inverse of the
address, you'll catch the wrap around.

Pete

> Lyle
> 
> 
> > -----Original Message-----
> > From: linux-mips-bounce@linux-mips.org 
> > [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Jeff Baitis
> > Sent: Wednesday, May 14, 2003 5:27 PM
> > To: linux-mips@linux-mips.org
> > Subject: Power On Self Test and testing memory
> > 
> > 
> > Hi all:
> > 
> > I implemented memory tests in my bootloader code for the 
> > AU1500. I'm trying to figure out why Linux boots when loaded 
> > into cached KSEG0 (0x 80c0 0000), but my memory test FAILS 
> > for this same region.
> > 
> > (pretty backwards huh? get linux booting, then write memory tests!)
> > 
> > 
> > I start by writing 0x5555 5555 to all of uncached memory, 
> > reading it back, and I write 0xAAAA AAAA to all of uncached 
> > memory and read it back.
> > 
> > This works great.
> > 
> > Next, I try to write 0x5555 5555 to cached KSEG0 memory, and 
> > it fails at addr 0x8000FE50. But Linux boots!
> > 
> > I'm not issuing SYNC commands when writing to cached memory; 
> > could this be the problem?
> > 
> > We've exhaustively verified the memory burst parameters, etc. 
> > They look good.
> > 
> > Thank you in advance for your ideas!
> > 
> > Regards,
> > Jeff
> > 
> > -- 
> >          Jeffrey Baitis - Associate Software Engineer
> > 
> >                     Evolution Robotics, Inc.
> >                      130 West Union Street
> >                        Pasadena CA 91103
> > 
> >  tel: 626.535.2776  |  fax: 626.535.2777  |  baitisj@evolution.com 
> > 
> 
> 
> 
