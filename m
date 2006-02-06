Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Feb 2006 11:41:41 +0000 (GMT)
Received: from ns.miraclelinux.com ([219.118.163.66]:12151 "EHLO
	mail01.miraclelinux.com") by ftp.linux-mips.org with ESMTP
	id S3458475AbWBFLlc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 6 Feb 2006 11:41:32 +0000
Received: from mail01 (localhost.localdomain [127.0.0.1])
	by mail01.miraclelinux.com (Postfix) with ESMTP
	id E1D4631C144; Mon,  6 Feb 2006 20:47:02 +0900 (JST)
Received: from localhost.localdomain (sshgate.miraclelinux.com [])
	by mail01.miraclelinux.com ([10.1.0.10]);
	Mon, 06 Feb 2006 11:47:02 +0000
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 1FA2642022F; Mon,  6 Feb 2006 20:47:03 +0900 (JST)
Date:	Mon, 6 Feb 2006 20:47:02 +0900
To:	Roman Zippel <zippel@linux-m68k.org>
Cc:	linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, dev-etrax@axis.com,
	David Howells <dhowells@redhat.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Linus Torvalds <torvalds@osdl.org>, linux-ia64@vger.kernel.org,
	Hirokazu Takata <takata@linux-m32r.org>,
	linux-m68k@vger.kernel.org, linux-mips@linux-mips.org,
	parisc-linux@parisc-linux.org, linuxsh-dev@lists.sourceforge.net,
	linuxsh-shmedia-dev@lists.sourceforge.net,
	sparclinux@vger.kernel.org, ultralinux@vger.kernel.org,
	Miles Bader <uclinux-v850@lsi.nec.co.jp>,
	Andi Kleen <ak@suse.de>, Chris Zankel <chris@zankel.net>
Subject: Re: [patch 15/44] generic ext2_{set,clear,test,find_first_zero,find_next_zero}_bit()
Message-ID: <20060206114702.GA11836@miraclelinux.com>
References: <20060201090224.536581000@localhost.localdomain> <20060201090326.139510000@localhost.localdomain> <Pine.LNX.4.61.0602011214270.12293@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0602011214270.12293@scrub.home>
User-Agent: Mutt/1.5.9i
From:	mita@miraclelinux.com (Akinobu Mita)
Return-Path: <mita@miraclelinux.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10343
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mita@miraclelinux.com
Precedence: bulk
X-list: linux-mips

On Wed, Feb 01, 2006 at 12:27:38PM +0100, Roman Zippel wrote:
> > +static __inline__ int generic_test_le_bit(unsigned long nr,
> > +				  __const__ unsigned long *addr)
> > +{
> > +	__const__ unsigned char	*tmp = (__const__ unsigned char *) addr;
> > +	return (tmp[nr >> 3] >> (nr & 7)) & 1;
> > +}
> 
> The underscores are not needed.
> 

Thanks, I converted to 'inline' and 'const'.
