Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jan 2006 00:02:47 +0000 (GMT)
Received: from are.twiddle.net ([64.81.246.98]:53652 "EHLO are.twiddle.net")
	by ftp.linux-mips.org with ESMTP id S8133496AbWAZAC3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 26 Jan 2006 00:02:29 +0000
Received: from are.twiddle.net (localhost.localdomain [127.0.0.1])
	by are.twiddle.net (8.12.11/8.12.11) with ESMTP id k0Q06eqJ005619;
	Wed, 25 Jan 2006 16:06:40 -0800
Received: (from rth@localhost)
	by are.twiddle.net (8.12.11/8.12.11/Submit) id k0Q06IZx005614;
	Wed, 25 Jan 2006 16:06:18 -0800
X-Authentication-Warning: are.twiddle.net: rth set sender to rth@twiddle.net using -f
Date:	Wed, 25 Jan 2006 16:06:18 -0800
From:	Richard Henderson <rth@twiddle.net>
To:	Akinobu Mita <mita@miraclelinux.com>, linux-kernel@vger.kernel.org,
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
Message-ID: <20060126000618.GA5592@twiddle.net>
Mail-Followup-To: Akinobu Mita <mita@miraclelinux.com>,
	linux-kernel@vger.kernel.org,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Ian Molton <spyro@f2s.com>, dev-etrax@axis.com,
	David Howells <dhowells@redhat.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Linus Torvalds <torvalds@osdl.org>, linux-ia64@vger.kernel.org,
	Hirokazu Takata <takata@linux-m32r.org>,
	linux-m68k@lists.linux-m68k.org, Greg Ungerer <gerg@uclinux.org>,
	linux-mips@linux-mips.org, parisc-linux@parisc-linux.org,
	linuxppc-dev@ozlabs.org, linux390@de.ibm.com,
	linuxsh-dev@lists.sourceforge.net,
	linuxsh-shmedia-dev@lists.sourceforge.net,
	sparclinux@vger.kernel.org, ultralinux@vger.kernel.org,
	Miles Bader <uclinux-v850@lsi.nec.co.jp>, Andi Kleen <ak@suse.de>,
	Chris Zankel <chris@zankel.net>
References: <20060125112625.GA18584@miraclelinux.com> <20060125113206.GD18584@miraclelinux.com> <20060125200250.GA26443@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060125200250.GA26443@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Return-Path: <rth@twiddle.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10158
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rth@twiddle.net
Precedence: bulk
X-list: linux-mips

On Wed, Jan 25, 2006 at 08:02:50PM +0000, Russell King wrote:
> > +	s = 16; if (word << 16 != 0) s = 0; b += s; word >>= s;
> > +	s =  8; if (word << 24 != 0) s = 0; b += s; word >>= s;
> > +	s =  4; if (word << 28 != 0) s = 0; b += s; word >>= s;
...
> Basically, shifts which depend on a variable are more expensive than
> constant-based shifts.

Actually, they're all constant shifts.  Just written stupidly.


r~
