Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Feb 2006 10:43:39 +0000 (GMT)
Received: from cantor.suse.de ([195.135.220.2]:59810 "EHLO mx1.suse.de")
	by ftp.linux-mips.org with ESMTP id S8133648AbWBAKnV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 1 Feb 2006 10:43:21 +0000
Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 030B5E7D1;
	Wed,  1 Feb 2006 11:48:22 +0100 (CET)
From:	Andi Kleen <ak@suse.de>
To:	Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [patch 14/44] generic hweight{64,32,16,8}()
Date:	Wed, 1 Feb 2006 11:24:27 +0100
User-Agent: KMail/1.8.2
Cc:	Akinobu Mita <mita@miraclelinux.com>, linux-kernel@vger.kernel.org,
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
References: <20060201090224.536581000@localhost.localdomain> <200602011006.09596.ak@suse.de> <43E07EB2.4020409@tls.msk.ru>
In-Reply-To: <43E07EB2.4020409@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602011124.29423.ak@suse.de>
Return-Path: <ak@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10280
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ak@suse.de
Precedence: bulk
X-list: linux-mips

On Wednesday 01 February 2006 10:26, Michael Tokarev wrote:
> Andi Kleen wrote:
> > On Wednesday 01 February 2006 10:02, Akinobu Mita wrote:
> > 
> >>+static inline unsigned int hweight32(unsigned int w)
> []
> > How large are these functions on x86? Maybe it would be better to not inline them,
> > but put it into some C file out of line.
> 
> hweight8	47 bytes
> hweight16	76 bytes
> hweight32	97 bytes
> hweight64	56 bytes (NOT inlining hweight32)
> hweight64	197 bytes (inlining hweight32)
> 
> Those are when compiled as separate non-inlined functions,
> with pushl %ebp and ret.

This would argue for moving them out of line.

-Andi
