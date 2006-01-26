Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jan 2006 16:26:35 +0000 (GMT)
Received: from relais.videotron.ca ([24.201.245.36]:55168 "EHLO
	relais.videotron.ca") by ftp.linux-mips.org with ESMTP
	id S8133571AbWAZQ0Q (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 26 Jan 2006 16:26:16 +0000
Received: from xanadu.home ([24.202.136.67]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0ITP00AITKJ7Q4H0@VL-MH-MR002.ip.videotron.ca> for
 linux-mips@linux-mips.org; Thu, 26 Jan 2006 11:30:44 -0500 (EST)
Date:	Thu, 26 Jan 2006 11:30:43 -0500 (EST)
From:	Nicolas Pitre <nico@cam.org>
Subject: Re: [parisc-linux] Re: [PATCH 3/6] C-language equivalents of
 include/asm-*/bitops.h
In-reply-to: <20060126161849.GA13632@colo.lackof.org>
X-X-Sender: nico@localhost.localdomain
To:	Grant Grundler <grundler@parisc-linux.org>
Cc:	Akinobu Mita <mita@miraclelinux.com>,
	lkml <linux-kernel@vger.kernel.org>,
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
Message-id: <Pine.LNX.4.64.0601261128280.16649@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20060125112625.GA18584@miraclelinux.com>
 <20060125113206.GD18584@miraclelinux.com>
 <20060125200250.GA26443@flint.arm.linux.org.uk>
 <20060126000618.GA5592@twiddle.net>
 <20060126085540.GA15377@flint.arm.linux.org.uk>
 <20060126161849.GA13632@colo.lackof.org>
Return-Path: <nico@cam.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10182
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nico@cam.org
Precedence: bulk
X-list: linux-mips

On Thu, 26 Jan 2006, Grant Grundler wrote:

> On Thu, Jan 26, 2006 at 08:55:41AM +0000, Russell King wrote:
> > Unfortunately that's not correct.  You do not appear to have checked
> > the compiler output like I did - this code does _not_ generate
> > constant shifts.
> 
> Russell,
> By "written stupidly", I thought Richard meant they could have
> used constants instead of "s".  e.g.:
> 	if (word << 16 == 0) { b += 16; word >>= 16); }
> 	if (word << 24 == 0) { b +=  8; word >>=  8); }
> 	if (word << 28 == 0) { b +=  4; word >>=  4); }
> 
> But I prefer what Edgar Toernig suggested.

It is just as bad on ARM since it requires large constants that cannot 
be expressed with immediate litteral values.  The constant shift 
approach is really the best on ARM.


Nicolas
