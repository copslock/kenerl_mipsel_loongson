Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Feb 2006 09:21:33 +0000 (GMT)
Received: from hobbit.corpit.ru ([81.13.94.6]:45920 "EHLO hobbit.corpit.ru")
	by ftp.linux-mips.org with ESMTP id S8133742AbWBAJVM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 1 Feb 2006 09:21:12 +0000
Received: from localhost (localhost [127.0.0.1])
	by hobbit.corpit.ru (Postfix) with ESMTP id 39BB82A7F1;
	Wed,  1 Feb 2006 12:26:07 +0300 (MSK)
	(envelope-from mjt@tls.msk.ru)
Received: from [192.168.1.1] (paltus.tls.msk.ru [192.168.1.1])
	by hobbit.corpit.ru (Postfix) with ESMTP;
	Wed,  1 Feb 2006 12:26:07 +0300 (MSK)
	(envelope-from mjt@tls.msk.ru)
Message-ID: <43E07EB2.4020409@tls.msk.ru>
Date:	Wed, 01 Feb 2006 12:26:10 +0300
From:	Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Andi Kleen <ak@suse.de>
CC:	Akinobu Mita <mita@miraclelinux.com>, linux-kernel@vger.kernel.org,
	Richard Henderson <rth@twiddle.net>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Russell King <rmk@arm.linux.org.uk>,
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
	Chris Zankel <chris@zankel.net>
Subject: Re: [patch 14/44] generic hweight{64,32,16,8}()
References: <20060201090224.536581000@localhost.localdomain> <20060201090325.905071000@localhost.localdomain> <200602011006.09596.ak@suse.de>
In-Reply-To: <200602011006.09596.ak@suse.de>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <mjt@tls.msk.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10279
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mjt@tls.msk.ru
Precedence: bulk
X-list: linux-mips

Andi Kleen wrote:
> On Wednesday 01 February 2006 10:02, Akinobu Mita wrote:
> 
>>+static inline unsigned int hweight32(unsigned int w)
[]
> How large are these functions on x86? Maybe it would be better to not inline them,
> but put it into some C file out of line.

hweight8	47 bytes
hweight16	76 bytes
hweight32	97 bytes
hweight64	56 bytes (NOT inlining hweight32)
hweight64	197 bytes (inlining hweight32)

Those are when compiled as separate non-inlined functions,
with pushl %ebp and ret.

/mjt
