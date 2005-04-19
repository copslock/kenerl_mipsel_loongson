Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Apr 2005 16:23:33 +0100 (BST)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:1711 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8226155AbVDSPXQ>;
	Tue, 19 Apr 2005 16:23:16 +0100
Received: from drow by nevyn.them.org with local (Exim 4.50 #1 (Debian))
	id 1DNuZE-0007u8-De; Tue, 19 Apr 2005 11:23:12 -0400
Date:	Tue, 19 Apr 2005 11:23:12 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	Thiemo Seufer <ths@networkno.de>
Cc:	Greg Weeks <greg.weeks@timesys.com>, linux-mips@linux-mips.org
Subject: Re: sysv ipc msg functions
Message-ID: <20050419152312.GA30205@nevyn.them.org>
References: <426518D0.5080506@timesys.com> <20050419143543.GB3300@hattusa.textio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050419143543.GB3300@hattusa.textio>
User-Agent: Mutt/1.5.8i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7765
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 19, 2005 at 04:35:43PM +0200, Thiemo Seufer wrote:
> Greg Weeks wrote:
> > I needed this glibc patch to get the sysv ipc msgctl functions to work 
> > correctly. This looks a bit hackish to me, so I wanted to run it past 
> > everybody here before filing it with glibc.
> 
> The Debian glibc has a similiar patch, see
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=200215&archive=yes
> for a discussion.

Last thing I see there was:

  Okay, I suggest you send this patch to Uli for libc and I'll prepare a
  patch for the kernel, will post here later.

Anything ever come of that?

-- 
Daniel Jacobowitz
CodeSourcery, LLC
