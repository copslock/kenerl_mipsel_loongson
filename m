Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jan 2006 04:30:26 +0000 (GMT)
Received: from mail.gmx.net ([213.165.64.21]:41610 "HELO mail.gmx.net")
	by ftp.linux-mips.org with SMTP id S8133357AbWAZEaF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 26 Jan 2006 04:30:05 +0000
Received: (qmail invoked by alias); 26 Jan 2006 04:34:28 -0000
Received: from p50900265.dip0.t-ipconnect.de (EHLO dialup) [80.144.2.101]
  by mail.gmx.net (mp004) with SMTP; 26 Jan 2006 05:34:28 +0100
X-Authenticated: #271361
Date:	Thu, 26 Jan 2006 05:34:12 +0100
From:	Edgar Toernig <froese@gmx.de>
To:	Richard Henderson <rth@twiddle.net>
Cc:	Akinobu Mita <mita@miraclelinux.com>, linux-kernel@vger.kernel.org,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Ian Molton <spyro@f2s.com>, dev-etrax@axis.com,
	David Howells <dhowells@redhat.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Linus Torvalds <torvalds@osdl.org>, linux-ia64@vger.kernel.org,
	Hirokazu Takata <takata@linux-m32r.org>,
	linux-m68k@vger.kernel.org, Greg Ungerer <gerg@uclinux.org>,
	linux-mips@linux-mips.org, parisc-linux@parisc-linux.org,
	linuxppc-dev@ozlabs.org, linux390@de.ibm.com,
	linuxsh-dev@lists.sourceforge.net,
	linuxsh-shmedia-dev@lists.sourceforge.net,
	sparclinux@vger.kernel.org, ultralinux@vger.kernel.org,
	Miles Bader <uclinux-v850@lsi.nec.co.jp>,
	Andi Kleen <ak@suse.de>, Chris Zankel <chris@zankel.net>
Subject: Re: [PATCH 3/6] C-language equivalents of include/asm-*/bitops.h
Message-Id: <20060126053412.0da7f505.froese@gmx.de>
In-Reply-To: <20060126000618.GA5592@twiddle.net>
References: <20060125112625.GA18584@miraclelinux.com>
	<20060125113206.GD18584@miraclelinux.com>
	<20060125200250.GA26443@flint.arm.linux.org.uk>
	<20060126000618.GA5592@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Return-Path: <froese@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10164
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: froese@gmx.de
Precedence: bulk
X-list: linux-mips

Richard Henderson wrote:
>
> On Wed, Jan 25, 2006 at 08:02:50PM +0000, Russell King wrote:
> > > +	s = 16; if (word << 16 != 0) s = 0; b += s; word >>= s;
> > > +	s =  8; if (word << 24 != 0) s = 0; b += s; word >>= s;
> > > +	s =  4; if (word << 28 != 0) s = 0; b += s; word >>= s;
> ...
> > Basically, shifts which depend on a variable are more expensive than
> > constant-based shifts.
> 
> Actually, they're all constant shifts.  Just written stupidly.

Why shift at all?

int ffs(u32 word)
{
    int bit = 0;

    word &= -word; // only keep the lsb.

    if (word & 0xffff0000) bit |= 16;
    if (word & 0xff00ff00) bit |=  8;
    if (word & 0xf0f0f0f0) bit |=  4;
    if (word & 0xcccccccc) bit |=  2;
    if (word & 0xaaaaaaaa) bit |=  1;

    return bit;
}

Ciao, ET.
