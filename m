Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jan 2006 17:26:51 +0000 (GMT)
Received: from are.twiddle.net ([64.81.246.98]:3221 "EHLO are.twiddle.net")
	by ftp.linux-mips.org with ESMTP id S8133656AbWAZR0c (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 26 Jan 2006 17:26:32 +0000
Received: from are.twiddle.net (localhost.localdomain [127.0.0.1])
	by are.twiddle.net (8.12.11/8.12.11) with ESMTP id k0QHUckg010735;
	Thu, 26 Jan 2006 09:30:38 -0800
Received: (from rth@localhost)
	by are.twiddle.net (8.12.11/8.12.11/Submit) id k0QHUEL5010734;
	Thu, 26 Jan 2006 09:30:14 -0800
X-Authentication-Warning: are.twiddle.net: rth set sender to rth@twiddle.net using -f
Date:	Thu, 26 Jan 2006 09:30:14 -0800
From:	Richard Henderson <rth@twiddle.net>
To:	Edgar Toernig <froese@gmx.de>
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
Message-ID: <20060126173014.GC5592@twiddle.net>
Mail-Followup-To: Edgar Toernig <froese@gmx.de>,
	Akinobu Mita <mita@miraclelinux.com>, linux-kernel@vger.kernel.org,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Ian Molton <spyro@f2s.com>, dev-etrax@axis.com,
	David Howells <dhowells@redhat.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Linus Torvalds <torvalds@osdl.org>, linux-ia64@vger.kernel.org,
	Hirokazu Takata <takata@linux-m32r.org>, linux-m68k@vger.kernel.org,
	Greg Ungerer <gerg@uclinux.org>, linux-mips@linux-mips.org,
	parisc-linux@parisc-linux.org, linuxppc-dev@ozlabs.org,
	linux390@de.ibm.com, linuxsh-dev@lists.sourceforge.net,
	linuxsh-shmedia-dev@lists.sourceforge.net,
	sparclinux@vger.kernel.org, ultralinux@vger.kernel.org,
	Miles Bader <uclinux-v850@lsi.nec.co.jp>, Andi Kleen <ak@suse.de>,
	Chris Zankel <chris@zankel.net>
References: <20060125112625.GA18584@miraclelinux.com> <20060125113206.GD18584@miraclelinux.com> <20060125200250.GA26443@flint.arm.linux.org.uk> <20060126000618.GA5592@twiddle.net> <20060126053412.0da7f505.froese@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060126053412.0da7f505.froese@gmx.de>
User-Agent: Mutt/1.4.1i
Return-Path: <rth@twiddle.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10190
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rth@twiddle.net
Precedence: bulk
X-list: linux-mips

On Thu, Jan 26, 2006 at 05:34:12AM +0100, Edgar Toernig wrote:
> Why shift at all?

Becuase that *is* a valid architecture tuning knob.  Most risc
machines can't AND with arbitrary constants like that, and loading
the constant might bulk things up more than just using the shift.


r~
