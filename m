Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Mar 2007 01:12:05 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:64394 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021838AbXCMBME (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Mar 2007 01:12:04 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l2D1A4X0027635;
	Tue, 13 Mar 2007 01:10:05 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l2D19tLC027606;
	Tue, 13 Mar 2007 01:09:55 GMT
Date:	Tue, 13 Mar 2007 01:09:55 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Andrew Dyer <adyer@righthandtech.com>
Cc:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Marco Braga <marco.braga@gmail.com>,
	Domen Puncer <domen.puncer@telargo.com>,
	linux-mips@linux-mips.org
Subject: Re: Trouble with sound/mips/au1x00.c AC97 driver
Message-ID: <20070313010955.GA27567@linux-mips.org>
References: <20070307104930.GD25248@dusktilldawn.nl> <d459bb380703082322r18879381ma4c57149a8b7adfe@mail.gmail.com> <45F350E9.3020208@cooper-street.com> <d459bb380703120157wb3dde00p4c232e300e82fd3d@mail.gmail.com> <d459bb380703120259r53889966xd8af623ff01ef297@mail.gmail.com> <20070312103927.GC14658@moe.telargo.com> <d459bb380703120609i7d3a9e1dwf7f4fa431a9631e5@mail.gmail.com> <45F57328.8000606@ru.mvista.com> <20070313004315.GA26119@linux-mips.org> <45F5F7CA.3000503@righthandtech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45F5F7CA.3000503@righthandtech.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14444
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Mar 12, 2007 at 08:00:58PM -0500, Andrew Dyer wrote:

> I just looked it up.
> 
> Section 2.4.5 of the Alchemy Au1550 datasheet says that a SYNC is 
> guaranteed to commit the write buffer to memory.
> 
> Whoever is looking at this should also pay attention to the CCA bits in 
> the TLB mapping the registers (Section 2.3.6 of the manual) or the fixed 
> regions (depending on the VA used) to make sure that merging and 
> gathering are turned off.

MIPS does does no merging / gathering for uncached accesses.  KSEG1
addresses are uncached.

  Ralf
