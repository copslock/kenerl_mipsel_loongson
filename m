Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Aug 2004 18:14:59 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:30201 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225238AbUHEROz>;
	Thu, 5 Aug 2004 18:14:55 +0100
Received: from orion.mvista.com (localhost.localdomain [127.0.0.1])
	by orion.mvista.com (8.12.8/8.12.8) with ESMTP id i75HEqar028373;
	Thu, 5 Aug 2004 10:14:52 -0700
Received: (from jsun@localhost)
	by orion.mvista.com (8.12.8/8.12.8/Submit) id i75HEp2S028372;
	Thu, 5 Aug 2004 10:14:51 -0700
Date: Thu, 5 Aug 2004 10:14:51 -0700
From: Jun Sun <jsun@mvista.com>
To: Kumba <kumba@gentoo.org>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: anybody tried NPTL?
Message-ID: <20040805101451.A28337@mvista.com>
References: <20040804152936.D6269@mvista.com> <411188A8.9040607@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <411188A8.9040607@gentoo.org>; from kumba@gentoo.org on Wed, Aug 04, 2004 at 09:08:56PM -0400
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5601
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Wed, Aug 04, 2004 at 09:08:56PM -0400, Kumba wrote:
> Jun Sun wrote:
> 
> > I am looking into porting NPTL to MIPS.  Just curious if
> > anybody has tried this before.
> > 
> > I notice there was a discussion about the ABI extension
> > for TLS (thread local storage) support.  Before that support
> > becomes a reality it seems one can still use NPTL with 
> > the help of additional system calls.
> > 
> > A rough search of latest glibc source shows there is
> > zero MIPS code for nptl.  A couple of other arches
> > are missing as well (such as ARM)
> > 
> > Jun
> 
> All I've heard about this is that some kernel changes are (still?) 
> needed, then just the glibc support along w/ TLS (Maybe compiler support?).
> 

TLS support requires ABI change, which involves work in gcc and binutils.
At current stage I think only a few arches have added TLS support.
MIPS is definitely not one of them.  Does anybody know about the current
status, for MIPS and other arches?

I think the ABI change and TLS support might take a long time to 
be ready.  It appears meanwhile NPTL can run without TLS, but would
need a couple of additional system calls that get and set thread
local area.

> I believe I heard reports that the glibc people were looking to 
> deprecate linuxthreads within a another release or two (but don't know 
> specifics or anything), so it sounds like NPTL should be something to 
> get working.
> 

That surely puts some urgency on this matter. :)

Jun
