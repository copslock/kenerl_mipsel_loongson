Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Feb 2006 01:56:52 +0000 (GMT)
Received: from ns.miraclelinux.com ([219.118.163.66]:41381 "EHLO
	mail01.miraclelinux.com") by ftp.linux-mips.org with ESMTP
	id S3458530AbWBGB4n (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 7 Feb 2006 01:56:43 +0000
Received: from mail01 (localhost.localdomain [127.0.0.1])
	by mail01.miraclelinux.com (Postfix) with ESMTP
	id EA7BB31C2E8; Tue,  7 Feb 2006 11:02:17 +0900 (JST)
Received: from localhost.localdomain (sshgate.miraclelinux.com [])
	by mail01.miraclelinux.com ([10.1.0.10]);
	Tue, 07 Feb 2006 02:02:16 +0000
Received: by localhost.localdomain (Postfix, from userid 1000)
	id C6BF142022F; Tue,  7 Feb 2006 11:02:16 +0900 (JST)
Date:	Tue, 7 Feb 2006 11:02:16 +0900
To:	David Howells <dhowells@redhat.com>
Cc:	linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, dev-etrax@axis.com,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	linux-ia64@vger.kernel.org,
	Hirokazu Takata <takata@linux-m32r.org>,
	Greg Ungerer <gerg@uclinux.org>, linux-mips@linux-mips.org,
	parisc-linux@parisc-linux.org, linuxsh-dev@lists.sourceforge.net,
	linuxsh-shmedia-dev@lists.sourceforge.net,
	sparclinux@vger.kernel.org, ultralinux@vger.kernel.org,
	Miles Bader <uclinux-v850@lsi.nec.co.jp>,
	Chris Zankel <chris@zankel.net>
Subject: Re: [patch 11/44] generic find_{next,first}{,_zero}_bit()
Message-ID: <20060207020216.GA9323@miraclelinux.com>
References: <20060201090324.373982000@localhost.localdomain> <20060201090224.536581000@localhost.localdomain> <12367.1139221560@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12367.1139221560@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.5.9i
From:	mita@miraclelinux.com (Akinobu Mita)
Return-Path: <mita@miraclelinux.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10353
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mita@miraclelinux.com
Precedence: bulk
X-list: linux-mips

On Mon, Feb 06, 2006 at 10:26:00AM +0000, David Howells wrote:
> Akinobu Mita <mita@miraclelinux.com> wrote:
> 
> > This patch introduces the C-language equivalents of the functions below:
> > 
> > unsigned logn find_next_bit(const unsigned long *addr, unsigned long size,
> >                             unsigned long offset);
> > unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
> >                                  unsigned long offset);
> > unsigned long find_first_zero_bit(const unsigned long *addr,
> >                                   unsigned long size);
> > unsigned long find_first_bit(const unsigned long *addr, unsigned long size);
> 
> These big functions should perhaps be out of line.

Yes. I'll make them and below out of line.

- hweight*()
- ext2_find_*_zero_bit()
- minix_find_first_zero_bit()
