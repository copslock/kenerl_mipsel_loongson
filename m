Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Feb 2005 18:11:04 +0000 (GMT)
Received: from p3EE07C4A.dip.t-dialin.net ([IPv6:::ffff:62.224.124.74]:285
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225005AbVBISKp>; Wed, 9 Feb 2005 18:10:45 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j19IAinD005862;
	Wed, 9 Feb 2005 19:10:44 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id j19IAiW8005861;
	Wed, 9 Feb 2005 19:10:44 +0100
Date:	Wed, 9 Feb 2005 19:10:44 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: copy_from_user_page/copy_to_user_page fix
Message-ID: <20050209181044.GA5740@linux-mips.org>
References: <20050209.184947.30439119.nemoto@toshiba-tops.co.jp> <20050209125105.GA27875@linux-mips.org> <20050209.225256.92587183.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050209.225256.92587183.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7216
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 09, 2005 at 10:52:56PM +0900, Atsushi Nemoto wrote:

> ralf> I'm going to apply this because it's a correct fix; the
> ralf> temporary mapping strategy as we've discussed for the dup_mmap
> ralf> problem would be preferable.
> 
> Thank you.  I agree that the temporary mapping will be more efficient
> though I chose a simple fix.  I suppose a performance requirement for
> ptrace() would be less than the dup_mmap (fork()).

People have come up with creative abuses for ptrace which actually make
it a performance critical path.  Especially UML should be mentioned in
this cathegory.  And we're talkign about a few thousand cycles differences
per ptrace invocation.

  Ralf
