Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Nov 2004 07:15:19 +0000 (GMT)
Received: from p508B767E.dip.t-dialin.net ([IPv6:::ffff:80.139.118.126]:53033
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225210AbUKVHPO>; Mon, 22 Nov 2004 07:15:14 +0000
Received: from fluff.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id iAM7DDl6026842;
	Mon, 22 Nov 2004 08:13:13 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id iAM7DDsa026841;
	Mon, 22 Nov 2004 08:13:13 +0100
Date: Mon, 22 Nov 2004 08:13:13 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] Improve o32 syscall handling
Message-ID: <20041122071313.GC25433@linux-mips.org>
References: <20041121164557.GQ20986@rembrandt.csv.ica.uni-stuttgart.de> <20041122061854.GA25433@linux-mips.org> <20041122070003.GA902@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041122070003.GA902@rembrandt.csv.ica.uni-stuttgart.de>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6397
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 22, 2004 at 08:00:04AM +0100, Thiemo Seufer wrote:

> > Why bother, the unaligned exception handler should take care of this.
> 
> It really does so for unaligned accesses from kernel space?

Yes.  In fact it's crucially important for this very case.  TCP for example
may result in missalignment.  And not everybody is using get_unaligned /
put_unaligned as they were intended.  Relying on the unaligned handler
is preferable where we expect pointers to be properly aligned almost
always.

The MIPS ABI mandates at least 8 byte stack alignment and funny things
happen if that assumption is violated.  So there is no motivation at all
to care about the performance of missalignment.  Aside of me defining this
to be verboten by punishment of signal 9 ;-)

> has 4 bytes and is loaded with lw. Using a macro which abstracts for
> 32/64bit compilation hides this needlessly, and can even lead to the
> erraneous impression the code would be useful for 64bit, too.

I'm more following the religion of using such abstractions everywhere
because code tends to be copied around mindlessly ...

  Ralf
