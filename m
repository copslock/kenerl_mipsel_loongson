Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Feb 2006 10:35:48 +0000 (GMT)
Received: from ns.miraclelinux.com ([219.118.163.66]:10607 "EHLO
	mail01.miraclelinux.com") by ftp.linux-mips.org with ESMTP
	id S3457885AbWBHKfj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 8 Feb 2006 10:35:39 +0000
Received: from mail01 (localhost.localdomain [127.0.0.1])
	by mail01.miraclelinux.com (Postfix) with ESMTP
	id 4396731C2E8; Wed,  8 Feb 2006 19:41:21 +0900 (JST)
Received: from localhost.localdomain (sshgate.miraclelinux.com [])
	by mail01.miraclelinux.com ([10.1.0.10]);
	Wed, 08 Feb 2006 10:41:21 +0000
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 722FD42022F; Wed,  8 Feb 2006 19:41:21 +0900 (JST)
Date:	Wed, 8 Feb 2006 19:41:21 +0900
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
Message-ID: <20060208104121.GB27490@miraclelinux.com>
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
X-archive-position: 10367
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mita@miraclelinux.com
Precedence: bulk
X-list: linux-mips

On Wed, Feb 01, 2006 at 12:27:38PM +0100, Roman Zippel wrote:

> For the inline version I would prefer this version:
> 
> {
> 	const unsigned char *tmp = (const unsigned char *)addr;
> 	return (tmp[nr >> 3] & (unsigned char)(1 << (nr & 7))) != 0;
> }
> 
> Although this would be a good alternative as well:
> 
> {
> 	return (addr[nr >> 5] & (1 << ((nr ^ 24) & 31))) != 0;
> }

Thanks, maybe I could use BITOP_LE_SWIZZLE similar to other *_le_bit().

#define BITOP_LE_SWIZZLE       ((BITS_PER_LONG-1) & ~0x7)
 :
#define generic_test_le_bit(nr, addr) test_bit((nr) ^ BITOP_LE_SWIZZLE, (addr))
 :
#endif /* __BIG_ENDIAN */
