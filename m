Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Mar 2005 03:22:12 +0000 (GMT)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:8360 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225972AbVCVDV4>;
	Tue, 22 Mar 2005 03:21:56 +0000
Received: from drow by nevyn.them.org with local (Exim 4.50 #1 (Debian))
	id 1DDZxu-0006Iy-38; Mon, 21 Mar 2005 22:21:58 -0500
Date:	Mon, 21 Mar 2005 22:21:58 -0500
From:	Daniel Jacobowitz <dan@debian.org>
To:	David Daney <ddaney@avtrex.com>
Cc:	Kumba <kumba@gentoo.org>, linux-mips@linux-mips.org
Subject: Re: NPTL support for the kernel
Message-ID: <20050322032158.GA24188@nevyn.them.org>
References: <20050316141151.GA23225@nevyn.them.org> <20050321203445.GA7082@nevyn.them.org> <423F7305.2030908@gentoo.org> <423F77DF.2060808@avtrex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <423F77DF.2060808@avtrex.com>
User-Agent: Mutt/1.5.6+20040907i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7497
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Mon, Mar 21, 2005 at 05:41:51PM -0800, David Daney wrote:
> Kumba wrote:
> >Daniel Jacobowitz wrote:
> >
> >>
> >>Ping?
> >>
> >
> >Doesn't this need the glibc side of things to be effective?, or is it 
> >testable  w/o that component?

It is testable independently.  Also, I posted the glibc bits last week.

> I think the main point is that it should not break existing code.

Of course.  It doesn't.  The only thing it could possibly break would
be four-argument clone (it's supposed to be five argument, and the
missing argument conventionally goes in the middle... oops).  But
I strongly believe nothing is yet using the four-argument form so I
synced MIPS with the rest of the world.

> We need NPTL support in all three of GCC, Linux kernel and glibc before 
> it can be tested.  If it doesn't break existing code, I think it should 
> go in the kernel so that we have something on which to test gcc and glibc.

GCC support was committed two weeks ago, BTW.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
