Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jan 2006 22:25:27 +0000 (GMT)
Received: from ozlabs.org ([203.10.76.45]:954 "EHLO ozlabs.org")
	by ftp.linux-mips.org with ESMTP id S8133463AbWAYWZJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 25 Jan 2006 22:25:09 +0000
Received: by ozlabs.org (Postfix, from userid 1003)
	id 2239A68ABD; Thu, 26 Jan 2006 09:29:32 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17367.64370.844350.972910@cargo.ozlabs.ibm.com>
Date:	Thu, 26 Jan 2006 09:28:02 +1100
From:	Paul Mackerras <paulus@samba.org>
To:	mita@miraclelinux.com (Akinobu Mita)
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	linux-ia64@vger.kernel.org, Ian Molton <spyro@f2s.com>,
	David Howells <dhowells@redhat.com>, linuxppc-dev@ozlabs.org,
	Greg Ungerer <gerg@uclinux.org>, sparclinux@vger.kernel.org,
	Miles Bader <uclinux-v850@lsi.nec.co.jp>,
	Linus Torvalds <torvalds@osdl.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Hirokazu Takata <takata@linux-m32r.org>,
	linuxsh-shmedia-dev@lists.sourceforge.net,
	linux-m68k@lists.linux-m68k.org,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Richard Henderson <rth@twiddle.net>,
	Chris Zankel <chris@zankel.net>, dev-etrax@axis.com,
	ultralinux@vger.kernel.org, Andi Kleen <ak@suse.de>,
	linuxsh-dev@lists.sourceforge.net, linux390@de.ibm.com,
	Russell King <rmk@arm.linux.org.uk>,
	parisc-linux@parisc-linux.org
Subject: Re: [PATCH 5/6] fix warning on test_ti_thread_flag()
In-Reply-To: <20060125113446.GF18584@miraclelinux.com>
References: <20060125112625.GA18584@miraclelinux.com>
	<20060125113446.GF18584@miraclelinux.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Return-Path: <paulus@ozlabs.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10154
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paulus@samba.org
Precedence: bulk
X-list: linux-mips

Akinobu Mita writes:

> If the arechitecture is
> - BITS_PER_LONG == 64
> - struct thread_info.flag 32 is bits
> - second argument of test_bit() was void *
> 
> Then compiler print error message on test_ti_thread_flags()
> in include/linux/thread_info.h

And correctly so.  The correct fix is to make thread_info.flag an
unsigned long.  This patch is NAKed.

Paul.
