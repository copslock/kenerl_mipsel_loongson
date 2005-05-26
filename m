Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 May 2005 20:06:14 +0100 (BST)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:11956 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225985AbVEZTF7>;
	Thu, 26 May 2005 20:05:59 +0100
Received: from drow by nevyn.them.org with local (Exim 4.50)
	id 1DbNg2-0004NS-K8; Thu, 26 May 2005 15:05:54 -0400
Date:	Thu, 26 May 2005 15:05:54 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	maxim@mox.ru, linux-mips@linux-mips.org
Subject: Re: glibc-2.3.4 mips64 compilation failure
Message-ID: <20050526190554.GA16765@nevyn.them.org>
References: <6097c4905052609326a4c1232@mail.gmail.com> <20050526170603.GA13272@nevyn.them.org> <Pine.LNX.4.61L.0505261815330.29423@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61L.0505261815330.29423@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.8i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7983
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Thu, May 26, 2005 at 06:26:10PM +0100, Maciej W. Rozycki wrote:
> On Thu, 26 May 2005, Daniel Jacobowitz wrote:
> 
> > > I am trying to build glibc-2.3.4 using binutils-2.15 and gcc-3.4.3
> > > from ftp://ftp.linux-mips.org/pub/linux/mips/crossdev/i386-linux/mips64-linux.
> > > Compilation fails with following messages:
> > 
> > Looks like your kernel headers are too old.
> 
>  Or too new, sigh...  See: 
> "http://sources.redhat.com/bugzilla/show_bug.cgi?id=758".  Unfortunately 
> it's not clear to me what "the 2.3 branch inclusion criteria" are and it's 
> a pity the MIPS port of glibc is unmaintained these days...

He did post the criteria.  You can find them in the list archives
though I don't have a URL handy.

I'm hoping to improve the maintenance in the near future.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
