Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Nov 2004 18:05:14 +0000 (GMT)
Received: from verein.lst.de ([IPv6:::ffff:213.95.11.210]:45455 "EHLO
	mail.lst.de") by linux-mips.org with ESMTP id <S8224939AbUKOSFJ>;
	Mon, 15 Nov 2004 18:05:09 +0000
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-6.6) with ESMTP id iAFI57la024012
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 15 Nov 2004 19:05:07 +0100
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id iAFI57nE024010;
	Mon, 15 Nov 2004 19:05:07 +0100
Date: Mon, 15 Nov 2004 19:05:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kumba <kumba@gentoo.org>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH]: Rewrite of arch/mips/ramdisk/
Message-ID: <20041115180507.GA23952@lst.de>
References: <4196FE7C.9040309@gentoo.org> <20041114085202.GA30480@lst.de> <419794FB.6020104@gentoo.org> <4197B286.4060503@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4197B286.4060503@gentoo.org>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
X-Scanned-By: MIMEDefang 2.39
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6336
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips

> It looks like this option, which afaict, doesn't seem to have an entry 
> anywhere in Kconfig, specifies a list of files for inclusion in a cpio 
> archive that's bundled into the kernel.  My question then is, can a 
> lookback-mountable filesystem image be included in this list, and the 
> kernel, given /dev/ram0 as root, know to mount and use the loopback image?

You could include a loop-back mountable filesystem image.  But that's
not even nessecary.  The kernel will call /init of the files in the
initramfs, and you could just store everything you'd store in the
loopback filesystem directly in the initramfs image.
