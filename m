Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jan 2004 00:40:23 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:55791 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225255AbUAOAkW>;
	Thu, 15 Jan 2004 00:40:22 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id i0F0eBT16181;
	Wed, 14 Jan 2004 16:40:11 -0800
Date: Wed, 14 Jan 2004 16:40:11 -0800
From: Jun Sun <jsun@mvista.com>
To: Nathan Field <ndf@ghs.com>
Cc: Daniel Jacobowitz <dan@debian.org>, linux-mips@linux-mips.org,
	jsun@mvista.com
Subject: Re: ptrace induced instruction cache bug?
Message-ID: <20040114164011.F13471@mvista.com>
References: <20040114160729.D13471@mvista.com> <Pine.LNX.4.44.0401141619110.1969-100000@zcar.ghs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0401141619110.1969-100000@zcar.ghs.com>; from ndf@ghs.com on Wed, Jan 14, 2004 at 04:22:01PM -0800
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3961
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Wed, Jan 14, 2004 at 04:22:01PM -0800, Nathan Field wrote:
> > There are too many things related to cache are wrong in 2.4.17.  For
> > example,
> > 
> > . flush_page_indexed() is not right for multi-way cache
> > . when you map user pages into kernel, you are sufferring potential cache
> >   aliasing problem (BTW, we still suffer from this right now to a less degree)
> > . flush_page_to_ram() has a broken semantic, because it is not clear whether
> >   the area mapped into user virt spaces should be flushed or not
> > ...
> > 
> > In short, it is not worth your time to fix old bugs.  Last time I
> > checked malta was working fine around 2.4.21.  It shouldn't be too hard
> > to get it working again in the latest 2.4 branch.
> 	Is this the 2.4.21 from ftp.kernel.org, or do I need to get 
> specific patches to get it to work? I looked at the cvs tree but it's 
> currently a 2.6 release. Should I just check out the linux_2_4_branch 
> version from linux-mips.org?
> 

Yes.  "linux_2_4" branch to be exact.

Jun
