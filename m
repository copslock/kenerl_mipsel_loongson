Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jun 2008 08:53:30 +0100 (BST)
Received: from hall.aurel32.net ([91.121.138.14]:59865 "EHLO hall.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S20039914AbYFXHxX (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 24 Jun 2008 08:53:23 +0100
Received: from lrouen-151-71-128-142.w193-253.abo.wanadoo.fr ([193.253.246.142] helo=volta.aurel32.net)
	by hall.aurel32.net with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <aurelien@aurel32.net>)
	id 1KB3Kx-0004Yb-0Q; Tue, 24 Jun 2008 09:53:14 +0200
Received: from aurel32 by volta.aurel32.net with local (Exim 4.69)
	(envelope-from <aurelien@aurel32.net>)
	id 1KAgec-0003zP-Le; Mon, 23 Jun 2008 09:39:58 +0200
Date:	Mon, 23 Jun 2008 09:39:58 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Michael Buesch <mb@bu3sch.de>, Adrian Bunk <bunk@kernel.org>,
	linux-mips@linux-mips.org, Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: pending mips build fixes
Message-ID: <20080623073958.GA14282@volta.aurel32.net>
References: <20080612134539.GA20487@cs181133002.pp.htv.fi> <20080612135835.GB20015@linux-mips.org> <200806121631.57857.mb@bu3sch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <200806121631.57857.mb@bu3sch.de>
X-Mailer: Mutt 1.5.18 (2008-05-17)
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19606
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

On Thu, Jun 12, 2008 at 04:31:57PM +0200, Michael Buesch wrote:
> On Thursday 12 June 2008 15:58:35 Ralf Baechle wrote:
> > On Thu, Jun 12, 2008 at 04:45:40PM +0300, Adrian Bunk wrote:
> > > From: Adrian Bunk <bunk@kernel.org>
> > > Date: Thu, 12 Jun 2008 16:45:40 +0300
> > > To: ralf@linux-mips.org
> > > Cc: linux-mips@linux-mips.org, Michael Buesch <mb@bu3sch.de>,
> > > 	Aurelien Jarno <aurelien@aurel32.net>,
> > > 	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> > > Subject: pending mips build fixes
> > > Content-Type: text/plain; charset=utf-8
> > > 
> > > Hi Ralf,
> > > 
> > > I hope I'm not too annoying on this, but I like it when as many 
> > > defconfigs as possible compile.
> > > 
> > > Please review and push the following patches for 2.6.26:
> > > 
> > >   BCM47xx: Add platform specific PCI code
> > >   http://marc.info/?l=linux-kernel&amp;m=120876451216558&amp;w=2
> 
> > Can't comment at the BCM47xx patch yet.
> 
> The 47xx patch is OK. It was a merge error by me. I simply forgot
> to push these two functions upstream.
> 

Any news on that?


-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
