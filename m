Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Feb 2006 03:43:49 +0000 (GMT)
Received: from colo.lackof.org ([198.49.126.79]:45487 "EHLO colo.lackof.org")
	by ftp.linux-mips.org with ESMTP id S8133480AbWBCDna (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 3 Feb 2006 03:43:30 +0000
Received: from localhost (localhost [127.0.0.1])
	by colo.lackof.org (Postfix) with ESMTP id D25D6360018;
	Thu,  2 Feb 2006 20:58:23 -0700 (MST)
Received: from colo.lackof.org ([127.0.0.1])
	by localhost (colo.lackof.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 10848-07; Thu, 2 Feb 2006 20:58:22 -0700 (MST)
Received: by colo.lackof.org (Postfix, from userid 27253)
	id 3882C360014; Thu,  2 Feb 2006 20:58:22 -0700 (MST)
Date:	Thu, 2 Feb 2006 20:58:22 -0700
From:	Grant Grundler <grundler@parisc-linux.org>
To:	Akinobu Mita <mita@miraclelinux.com>
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	linux-ia64@vger.kernel.org, Ian Molton <spyro@f2s.com>,
	David Howells <dhowells@redhat.com>, linuxppc-dev@ozlabs.org,
	Greg Ungerer <gerg@uclinux.org>, sparclinux@vger.kernel.org,
	Miles Bader <uclinux-v850@lsi.nec.co.jp>,
	Linus Torvalds <torvalds@osdl.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Hirokazu Takata <takata@linux-m32r.org>,
	linuxsh-dev@lists.sourceforge.net, linux-m68k@lists.linux-m68k.org,
	Chris Zankel <chris@zankel.net>, dev-etrax@axis.com,
	ultralinux@vger.kernel.org, Andi Kleen <ak@suse.de>,
	linuxsh-shmedia-dev@lists.sourceforge.net, linux390@de.ibm.com,
	Russell King <rmk@arm.linux.org.uk>,
	parisc-linux@parisc-linux.org
Subject: Re: [parisc-linux] [patch 12/44] generic sched_find_first_bit()
Message-ID: <20060203035822.GA12539@colo.lackof.org>
References: <20060201090224.536581000@localhost.localdomain> <20060201090325.497639000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060201090325.497639000@localhost.localdomain>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lackof.org
Return-Path: <grundler@lackof.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10322
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grundler@parisc-linux.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 01, 2006 at 06:02:36PM +0900, Akinobu Mita wrote:
> This patch introduces the C-language equivalent of the function:
> int sched_find_first_bit(const unsigned long *b);

Akinobu, would you prefer this is a slightly cleaner way?
(Not compile tested)

static inline int sched_find_first_bit(const unsigned long *b)
{
	if (unlikely(b[0]))
		return __ffs(b[0]);
	if (unlikely(b[1]))
		return __ffs(b[1]) + BITS_PER_LONG;
#if BITS_PER_LONG == 32
	if (unlikely(b[2]))
		return __ffs(b[2]) + 64;
	if (b[3])
		return __ffs(b[3]) + 96;
#endif
	return __ffs(b[128/BITS_PER_LONG]) + 128;
}

If BITS_PER_LONG isn't defined, the link step will fail and point
at a some unknown .o as the offender. But it's the responsibility
of the header file to make sure it's including the BITS_PER_LONG
definition, not the code that calls sched_find_first_bit().

hth,
grant
