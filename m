Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 May 2003 23:34:06 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:2552 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225217AbTENWeE>;
	Wed, 14 May 2003 23:34:04 +0100
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id PAA27828;
	Wed, 14 May 2003 15:33:59 -0700
Subject: Re: Power On Self Test and testing memory
From: Pete Popov <ppopov@mvista.com>
To: baitisj@evolution.com
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
In-Reply-To: <20030514152643.A5897@luca.pas.lab>
References: <20030514152643.A5897@luca.pas.lab>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1052951641.788.225.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 14 May 2003 15:34:01 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2386
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Wed, 2003-05-14 at 15:26, Jeff Baitis wrote:
> Hi all:
> 
> I implemented memory tests in my bootloader code for the AU1500. I'm trying
> to figure out why Linux boots when loaded into cached KSEG0 (0x 80c0 0000),
> but my memory test FAILS for this same region.
> 
> (pretty backwards huh? get linux booting, then write memory tests!)
> 
> 
> I start by writing 0x5555 5555 to all of uncached memory, reading it back, and
> I write 0xAAAA AAAA to all of uncached memory and read it back.
> 
> This works great.
> 
> Next, I try to write 0x5555 5555 to cached KSEG0 memory, and it fails at addr
> 0x8000FE50. But Linux boots!

You're not overwriting any of the boot exception vectors, right?  What's
the failure exactly and how does the test work?

Pete

> I'm not issuing SYNC commands when writing to cached memory; could this be
> the problem?
> 
> We've exhaustively verified the memory burst parameters, etc. They look good.
> 
> Thank you in advance for your ideas!
> 
> Regards,
> Jeff
