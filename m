Received:  by oss.sgi.com id <S554107AbRAZUwq>;
	Fri, 26 Jan 2001 12:52:46 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:1530 "EHLO
        orion.mvista.com") by oss.sgi.com with ESMTP id <S554054AbRAZUwX>;
	Fri, 26 Jan 2001 12:52:23 -0800
Received: (from jsun@localhost)
	by orion.mvista.com (8.9.3/8.9.3) id MAA09442;
	Fri, 26 Jan 2001 12:51:31 -0800
Date:   Fri, 26 Jan 2001 12:51:31 -0800
From:   Jun Sun <jsun@mvista.com>
To:     Florian Lohoff <flo@rfc822.org>
Cc:     Pete Popov <ppopov@mvista.com>, linux-mips@oss.sgi.com
Subject: Re: Cross compiling RPMs
Message-ID: <20010126125131.G9325@mvista.com>
References: <200101261815.KAA08917@saturn.mikemac.com> <3A71C3CF.A179113@mvista.com> <20010126212341.A26384@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010126212341.A26384@paradigm.rfc822.org>; from flo@rfc822.org on Fri, Jan 26, 2001 at 09:23:41PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Jan 26, 2001 at 09:23:41PM +0100, Florian Lohoff wrote:
> On Fri, Jan 26, 2001 at 10:37:03AM -0800, Pete Popov wrote:
> > glibc.  Others might have similar toolchains they can point you at. 
> > Another option is native builds, which I personally don't like.
> 
> Cross compiling is definitly no option for debian as the dependencies
> etc are all made from "ldd binary" which has to fail for cross-compiling.
> I guess this also happens to rpm packages so cross-compiling to really
> get a correct distribution is definitly no option.
> 

There are other ways to figure out the dependency in a cross-compiling 
environment.  We have an internal tool that does just that and more (some
size/fs optimization stuff).  It is not used in the current release, though.

> The larger the packages are the harder it is to get them cross-compiled
> correctly as they run nifty little check programs from configure which
> cant work. I guess you had similar problems as all rpms are
> "noarch" which is definitly - ummm - interesting.
> 

The "noarch" means the installed target is arch-independent.  The
standard setup in mvista CDK is to let target boot from NFS root fs, 
where NFS host can be linux/i386, Linux/ppc and Sun/Sparc (perhaps
Win/i386 as well, I am not sure).  Those packages are meant to be 
installed to all those hosts, and therefore "noarch" :-0.

> I definitly go for native builds - Once you have a working stable 
> base you can set up debian autobuilders which will do nearly 
> everything for you except signing and uploading the package into
> the main repository.
>

Native compiling is easy.  Cross-compiling is cool. :-)

Well, not exactly.  When you are dealing with head-less, disk-less 
memory-scarce embedded devices with ad hoc run-time environments,
cross-compiling is your only choice.

Jun
