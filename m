Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jan 2004 20:59:07 +0000 (GMT)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:8888 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225365AbUAMU7G>;
	Tue, 13 Jan 2004 20:59:06 +0000
Received: from drow by nevyn.them.org with local (Exim 4.30 #1 (Debian))
	id 1AgVco-0004VO-5X; Tue, 13 Jan 2004 15:58:58 -0500
Date: Tue, 13 Jan 2004 15:58:58 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Nathan Field <ndf@ghs.com>
Cc: linux-mips@linux-mips.org
Subject: Re: ptrace induced instruction cache bug?
Message-ID: <20040113205858.GA17260@nevyn.them.org>
References: <20040113150108.GA7144@nevyn.them.org> <Pine.LNX.4.44.0401131029410.1969-100000@zcar.ghs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0401131029410.1969-100000@zcar.ghs.com>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@crack.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3926
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 13, 2004 at 10:35:04AM -0800, Nathan Field wrote:
> > It sounds reasonable.  I've encountered this problem in the past also,
> > but never with the Pro 2.1 / MIPS release which is what you're using.  
> > I don't see anything obviously wrong with your test code, either.
> 	So... is there a fix for this?

Usually a missing cache flush, as you surmised :)  But I don't know of
any that were missing in that version.

> > Yes, you will need a newer toolchain.  Honestly, I'm baffled as to why a
> > Pro 2.1 toolchain was available from our web site at all, unless you got
> > it via an old product subscription... it should have been Pro 3.0, which
> > uses GCC 3.2 and a more recent binutils.  But I don't have any control
> > over these things :)
> 	I downloaded it about 5 days ago from:
> http://www.mvista.com/previewkit/index.html
> 
> Could I get a preview kit of your 3.0 release for a Malta 4Kc board?

Let me inquire as to why we're distributing old ones.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
