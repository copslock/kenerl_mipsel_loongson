Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3ODZwwJ021829
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 24 Apr 2002 06:35:58 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3ODZwjd021828
	for linux-mips-outgoing; Wed, 24 Apr 2002 06:35:58 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3ODZrwJ021825
	for <linux-mips@oss.sgi.com>; Wed, 24 Apr 2002 06:35:53 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id GAA14093;
	Wed, 24 Apr 2002 06:36:10 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id GAA11195;
	Wed, 24 Apr 2002 06:36:09 -0700 (PDT)
Received: from copsun17.mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g3ODZHA07656;
	Wed, 24 Apr 2002 15:35:17 +0200 (MEST)
From: Hartvig Ekner <hartvige@mips.com>
Received: (from hartvige@localhost)
	by copsun17.mips.com (8.9.1/8.9.0) id PAA02613;
	Wed, 24 Apr 2002 15:35:16 +0200 (MET DST)
Message-Id: <200204241335.PAA02613@copsun17.mips.com>
Subject: Re: Updates for RedHat 7.1/mips
To: hjl@lucon.org (H . J . Lu)
Date: Wed, 24 Apr 2002 15:35:16 +0200 (MET DST)
Cc: linux-mips@oss.sgi.com
In-Reply-To: <20020423155925.A8846@lucon.org> from "H . J . Lu" at Apr 23, 2002 03:59:25 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

All the problems I reported are fixed (only tested LE so far). Thanks.

Currently recompiling glibc natively for the installation images.
We'll post a message here when our new installation images are ready.

/Hartvig

H . J . Lu writes:
> 
> On Mon, Apr 22, 2002 at 08:38:49PM +0200, Hartvig Ekner wrote:
> > Hi,
> > 
> > H . J . Lu writes:
> > > 
> > > On Mon, Apr 22, 2002 at 06:55:14PM +0200, Hartvig Ekner wrote:
> > > > Hi H.J,
> > > > 
> > > > No, I did not compile myself, but used your binary (except for cracklib,
> > > > where I used our natively compiled package instead). But I did replace
> > > > ALL new updated packages at once during the upgrade.
> > > > 
> > > > However, I have also tried to install (-U) rpm*rpm and the popt rpm on a
> > > > working system based on your original packages, and voila: the same error
> > > > appears. So it does appear to be linked to the rpm RPM package.
> > > > 
> > > > The grep you asked for returns:
> > > 
> > > Thanks. I will fix those among other bugs I have been working on.
> > 
> > Great, thanks. Can you let me know as soon as the RPM problem has been fixed,
> > so that I can continue the update of the installation images? BTW, are the
> > other bugs you're working on something to wait for in this regard or not?
> > 
> 
> I updated glibc, python, gcc, gdb, rpm, openssl, binutils and toolchain at
> 
> ftp://oss.sgi.com/pub/linux/mips/redhat/7.1/
> 
> Let know know if there are any problems.
> 
> 
> H.J.
