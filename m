Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jan 2006 22:51:02 +0000 (GMT)
Received: from colo.lackof.org ([198.49.126.79]:32406 "EHLO colo.lackof.org")
	by ftp.linux-mips.org with ESMTP id S8133722AbWAZWun (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 26 Jan 2006 22:50:43 +0000
Received: from localhost (localhost [127.0.0.1])
	by colo.lackof.org (Postfix) with ESMTP id 31C373600FD;
	Thu, 26 Jan 2006 16:04:45 -0700 (MST)
Received: from colo.lackof.org ([127.0.0.1])
	by localhost (colo.lackof.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 12169-03; Thu, 26 Jan 2006 16:04:43 -0700 (MST)
Received: by colo.lackof.org (Postfix, from userid 27253)
	id 8D4A9360021; Thu, 26 Jan 2006 16:04:43 -0700 (MST)
Date:	Thu, 26 Jan 2006 16:04:43 -0700
From:	Grant Grundler <grundler@parisc-linux.org>
To:	Grant Grundler <grundler@parisc-linux.org>,
	Akinobu Mita <mita@miraclelinux.com>,
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
	Miles Bader <uclinux-v850@lsi.nec.co.jp>,
	Andi Kleen <ak@suse.de>, Chris Zankel <chris@zankel.net>
Subject: Re: [parisc-linux] Re: [PATCH 3/6] C-language equivalents of include/asm-*/bitops.h
Message-ID: <20060126230443.GC13632@colo.lackof.org>
References: <20060125112625.GA18584@miraclelinux.com> <20060125113206.GD18584@miraclelinux.com> <20060125200250.GA26443@flint.arm.linux.org.uk> <20060126000618.GA5592@twiddle.net> <20060126085540.GA15377@flint.arm.linux.org.uk> <20060126161849.GA13632@colo.lackof.org> <20060126164020.GA27222@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060126164020.GA27222@flint.arm.linux.org.uk>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lackof.org
Return-Path: <grundler@lackof.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10196
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grundler@parisc-linux.org
Precedence: bulk
X-list: linux-mips

On Thu, Jan 26, 2006 at 04:40:21PM +0000, Russell King wrote:
> Ok, I can see I'm going to lose this, but what the hell.

Well, we agree. As Richard Henderson just pointed out, parisc
is among those that can't load large immediate values either.

> Let's compare the implementations, which are:
...
> int arm_ffs(unsigned long word)
> {
>      int k = 31;
>      if (word & 0x0000ffff) { k -= 16; word <<= 16; }
>      if (word & 0x00ff0000) { k -= 8;  word <<= 8;  }
>      if (word & 0x0f000000) { k -= 4;  word <<= 4;  }
>      if (word & 0x30000000) { k -= 2;  word <<= 2;  }
>      if (word & 0x40000000) { k -= 1; }
>      return k;
> }

Of those suggested, arm_ffs() is closest to what parisc
currently has in assembly (see include/asm-parisc/bitops.h:__ffs()).
But given how unobvious the parisc instruction nullification works,
the rough equivalent in "C" (untested!) would look something like:

	unsigned int k = 31;
	if (word & 0x0000ffff) { k -= 16;} else { word >>= 16; }
	if (word & 0x000000ff) { k -=  8;} else { word >>= 8; }
	if (word & 0x0000000f) { k -=  4;} else { word >>= 4; }
	if (word & 0x00000003) { k -=  2;} else { word >>= 2; }
	if (word & 0x00000001) { k -=  1;}
	return k;

I doubt that's better for arm but am curious how it compares.
You have time to try it?
If not, no worries.


> 19 instructions.  2 registers.  0 register based shifts.  More reasonable
> for inlining.

Yeah, about the same for parisc.

> Clearly the smallest of the lot with the smallest register pressure,
> being the best candidate out of the lot, whether we inline it or not.

Agreed. But I expect parisc will have to continue using it's asm
sequence and ignore the generic version. AFAIK, the compiler isn't that
good with instruction nullification and I have other issues I'd
rather work on.

cheers,
grant
