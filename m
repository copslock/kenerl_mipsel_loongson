Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jun 2005 21:06:04 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:44295 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225848AbVFMUFu>; Mon, 13 Jun 2005 21:05:50 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 7A3E6F5991; Mon, 13 Jun 2005 22:05:43 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 00896-07; Mon, 13 Jun 2005 22:05:43 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 30E74F598B; Mon, 13 Jun 2005 22:05:43 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j5DK5m3u027731;
	Mon, 13 Jun 2005 22:05:48 +0200
Date:	Mon, 13 Jun 2005 21:05:59 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Daniel Jacobowitz <dan@debian.org>
Cc:	Jim Gifford <maillist@jg555.com>,
	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: Building o32 glibc on mips64
In-Reply-To: <20050613195602.GA3739@nevyn.them.org>
Message-ID: <Pine.LNX.4.61L.0506132100080.1725@blysk.ds.pg.gda.pl>
References: <42AB3366.8030206@jg555.com> <20050613195602.GA3739@nevyn.them.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/935/Mon Jun 13 18:27:50 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8079
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 13 Jun 2005, Daniel Jacobowitz wrote:

> I have not tried the 2.3.x series glibcs on MIPS64.  I recommend you
> use glibc HEAD for now instead, unless you're interested in tracking
> down this sort of problem.

 FYI, I've been able to build glibc 2.3.5 with GCC 4.0.0 for 
mips64el-linux (n64) with minimal patching.  I think what's only really 
required is that patch by Richard Sandiford that stays suspended in the 
glibc Bugzilla.

 For o32 glibc may have to be configured for "mips{,el}-linux" (as o32 
isn't MIPS64 at all), but that's a pure guess -- I haven't checked the 
scripts for that requirement.

 Do you think HEAD is stable enough for a non-glibc developer?  It's soon 
after a fork after all, so I'd expect more serious changes to be applied 
nowadays.

  Maciej
