Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Nov 2004 17:55:22 +0000 (GMT)
Received: from pD9562417.dip.t-dialin.net ([IPv6:::ffff:217.86.36.23]:31016
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224930AbUKORzR>; Mon, 15 Nov 2004 17:55:17 +0000
Received: from fluff.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id iAFHtFed007924;
	Mon, 15 Nov 2004 18:55:15 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id iAFHtEYO007923;
	Mon, 15 Nov 2004 18:55:14 +0100
Date: Mon, 15 Nov 2004 18:55:14 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Kumba <kumba@gentoo.org>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH]: Rewrite of arch/mips/ramdisk/
Message-ID: <20041115175514.GA6069@linux-mips.org>
References: <4196FE7C.9040309@gentoo.org> <20041114085202.GA30480@lst.de> <419794FB.6020104@gentoo.org> <4197B286.4060503@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4197B286.4060503@gentoo.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6335
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Nov 14, 2004 at 02:31:18PM -0500, Kumba wrote:

> Ahh, I see.  Ralf pointed me at CONFIG_INITRAMFS_SOURCE in 2.6.10.  My 
> patch was based on 2.6.9, and I didn't exactly think this specific bit of 
> the kernel would change between 2.6.9 and 2.6.10.  Go figure.
> 
> It looks like this option, which afaict, doesn't seem to have an entry 
> anywhere in Kconfig, specifies a list of files for inclusion in a cpio 
> archive that's bundled into the kernel.  My question then is, can a 
> lookback-mountable filesystem image be included in this list, and the 
> kernel, given /dev/ram0 as root, know to mount and use the loopback image?

I guess you and many others don't realize the speed of the Linux evolution
these days.  Between 2.6.10-rc1 and 2.6.10-rc2 there's about 9MB of
patches.  Even if much of the code is not changing - the halftime for
patches has reduced quite a bit ...

  Ralf
