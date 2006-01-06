Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jan 2006 14:49:53 +0000 (GMT)
Received: from nevyn.them.org ([66.93.172.17]:16515 "EHLO nevyn.them.org")
	by ftp.linux-mips.org with ESMTP id S8133576AbWAFOtg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 6 Jan 2006 14:49:36 +0000
Received: from drow by nevyn.them.org with local (Exim 4.54)
	id 1Euswy-0001mv-K9; Fri, 06 Jan 2006 09:52:16 -0500
Date:	Fri, 6 Jan 2006 09:52:16 -0500
From:	Daniel Jacobowitz <dan@debian.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Alex Gonzalez <langabe@gmail.com>, linux-mips@linux-mips.org
Subject: Re: Jump/branch to external symbol
Message-ID: <20060106145216.GA6849@nevyn.them.org>
References: <c58a7a270601060241u765acb76s61bb30d443c420f1@mail.gmail.com> <Pine.LNX.4.64N.0601061147540.25759@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0601061147540.25759@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.8i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9787
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Fri, Jan 06, 2006 at 11:51:56AM +0000, Maciej W. Rozycki wrote:
> On Fri, 6 Jan 2006, Alex Gonzalez wrote:
> 
> > I am happy with the patch for binutils-2.15, and I would need a
> > solution for binutils-2.13.
> > 
> > Can anybody offer any help?
> 
>  Well, the most obvious solution is upgrading to the current release, 
> which is 2.16.1 now.  Otherwise you are probably on your own -- 2.15 is 
> already somewhat old and 2.13 is ancient.

Or better yet to trunk and you won't need any patches for this.

-- 
Daniel Jacobowitz
CodeSourcery
