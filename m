Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jan 2006 16:05:11 +0000 (GMT)
Received: from colo.lackof.org ([198.49.126.79]:6543 "EHLO colo.lackof.org")
	by ftp.linux-mips.org with ESMTP id S8133559AbWAZQEx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 26 Jan 2006 16:04:53 +0000
Received: from localhost (localhost [127.0.0.1])
	by colo.lackof.org (Postfix) with ESMTP id 6F6AC360021;
	Thu, 26 Jan 2006 09:18:51 -0700 (MST)
Received: from colo.lackof.org ([127.0.0.1])
	by localhost (colo.lackof.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 13278-06; Thu, 26 Jan 2006 09:18:50 -0700 (MST)
Received: by colo.lackof.org (Postfix, from userid 27253)
	id 051B5360002; Thu, 26 Jan 2006 09:18:50 -0700 (MST)
Date:	Thu, 26 Jan 2006 09:18:49 -0700
From:	Grant Grundler <grundler@parisc-linux.org>
To:	Akinobu Mita <mita@miraclelinux.com>, linux-kernel@vger.kernel.org,
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
Message-ID: <20060126161849.GA13632@colo.lackof.org>
References: <20060125112625.GA18584@miraclelinux.com> <20060125113206.GD18584@miraclelinux.com> <20060125200250.GA26443@flint.arm.linux.org.uk> <20060126000618.GA5592@twiddle.net> <20060126085540.GA15377@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060126085540.GA15377@flint.arm.linux.org.uk>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lackof.org
Return-Path: <grundler@lackof.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10180
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grundler@parisc-linux.org
Precedence: bulk
X-list: linux-mips

On Thu, Jan 26, 2006 at 08:55:41AM +0000, Russell King wrote:
> Unfortunately that's not correct.  You do not appear to have checked
> the compiler output like I did - this code does _not_ generate
> constant shifts.

Russell,
By "written stupidly", I thought Richard meant they could have
used constants instead of "s".  e.g.:
	if (word << 16 == 0) { b += 16; word >>= 16); }
	if (word << 24 == 0) { b +=  8; word >>=  8); }
	if (word << 28 == 0) { b +=  4; word >>=  4); }

But I prefer what Edgar Toernig suggested.

grant
