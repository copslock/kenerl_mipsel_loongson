Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Feb 2006 11:24:28 +0000 (GMT)
Received: from scrub.xs4all.nl ([194.109.195.176]:61914 "EHLO scrub.xs4all.nl")
	by ftp.linux-mips.org with ESMTP id S8133658AbWBALYJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 1 Feb 2006 11:24:09 +0000
Received: from roman (helo=localhost)
	by scrub.xs4all.nl with local-esmtp (Exim 3.36 #1 (Debian))
	id 1F4G9C-0006bi-00; Wed, 01 Feb 2006 12:27:38 +0100
Date:	Wed, 1 Feb 2006 12:27:38 +0100 (CET)
From:	Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To:	Akinobu Mita <mita@miraclelinux.com>
cc:	linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
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
In-Reply-To: <20060201090326.139510000@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0602011214270.12293@scrub.home>
References: <20060201090224.536581000@localhost.localdomain>
 <20060201090326.139510000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <zippel@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10281
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zippel@linux-m68k.org
Precedence: bulk
X-list: linux-mips

Hi,

On Wed, 1 Feb 2006, Akinobu Mita wrote:

> +static __inline__ int generic_test_le_bit(unsigned long nr,
> +				  __const__ unsigned long *addr)
> +{
> +	__const__ unsigned char	*tmp = (__const__ unsigned char *) addr;
> +	return (tmp[nr >> 3] >> (nr & 7)) & 1;
> +}

The underscores are not needed.

For the inline version I would prefer this version:

{
	const unsigned char *tmp = (const unsigned char *)addr;
	return (tmp[nr >> 3] & (unsigned char)(1 << (nr & 7))) != 0;
}

Although this would be a good alternative as well:

{
	return (addr[nr >> 5] & (1 << ((nr ^ 24) & 31))) != 0;
}

bye, Roman
