Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jun 2003 16:44:40 +0100 (BST)
Received: from crack.them.org ([IPv6:::ffff:146.82.138.56]:57323 "EHLO
	crack.them.org") by linux-mips.org with ESMTP id <S8225211AbTFIPog>;
	Mon, 9 Jun 2003 16:44:36 +0100
Received: from dsl093-172-017.pit1.dsl.speakeasy.net
	([66.93.172.17] helo=nevyn.them.org ident=mail)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 19POpP-0000D8-00; Mon, 09 Jun 2003 10:44:59 -0500
Received: from drow by nevyn.them.org with local (Exim 3.36 #1 (Debian))
	id 19POob-0000TU-00; Mon, 09 Jun 2003 11:44:09 -0400
Date: Mon, 9 Jun 2003 11:44:08 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: David Kesselring <dkesselr@mmc.atmel.com>,
	linux-mips@linux-mips.org
Subject: Re: state of 64 bit support
Message-ID: <20030609154408.GA1781@nevyn.them.org>
References: <Pine.GSO.4.44.0306061234410.4045-100000@hydra.mmc.atmel.com> <Pine.GSO.3.96.1030609164009.2806n-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1030609164009.2806n-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2567
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Mon, Jun 09, 2003 at 05:28:18PM +0200, Maciej W. Rozycki wrote:
> On Fri, 6 Jun 2003, David Kesselring wrote:
> 
> > I've been trying to get a 64 bit compiler working for a 5kc/5kf core,
> > searching the net for info, and following this list for the last couple of
> > weeks. I have not been able to get some basic questions answered and I
> > hope that some of you can help me.
> 
>  With the above statement I assume you want to have a compiler suitable
> for a kernel build only (which is easier to get running) and you do not
> need to do 64-bit userland builds (which is tougher).  And that you want a
> cross-compiler.
> 
> > First what is the current status of mips 5k 64bit little-endian support
> > for gcc? Do I have to use 2.95/2.96? I don't think there is a linux binary
> > but if you know of one I'd love the link. I have been unsuccessful getting
> > this built.
> 
>  There are a few gcc 2.95.x i386/Linux LE binary RPM packages available at
> my site, but they have preliminary R4k workarounds applied which have
> disadvantageous side effects for later processors.  Your best bet is to
> get an RPM source package, disable R4k patches and rebuild. 
> 
> > On the web, there is a howto to build a mipsel gcc 3.2. Does 3.2 support
> > 64 bit mips? Has anyone gotten it to work?
> 
>  If going for version 3.x, you probably want to get 3.3.  I can't say if
> it supports MIPS64/Linux without patching -- probably yes.

More or less yes (kernel space).  Userspace went in to 3.4.

> 
> > Also linux. From my understanding, kernel 2.4.20 has the latest patches
> > for mips32 and mips64. Is that a valid codebase?
> 
>  Up till now most development was done based on 2.4.x, but Ralf has just
> finished updating 2.5.x, so you can select the version that suits you
> best.

... But you have to get it from the linux-mips.org CVS, not from
kernel.org!  Just clarifying.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
