Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Nov 2004 08:52:19 +0000 (GMT)
Received: from verein.lst.de ([IPv6:::ffff:213.95.11.210]:53426 "EHLO
	mail.lst.de") by linux-mips.org with ESMTP id <S8225011AbUKNIwF>;
	Sun, 14 Nov 2004 08:52:05 +0000
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-6.6) with ESMTP id iAE8q2la030500
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 14 Nov 2004 09:52:02 +0100
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id iAE8q2pa030498;
	Sun, 14 Nov 2004 09:52:02 +0100
Date: Sun, 14 Nov 2004 09:52:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kumba <kumba@gentoo.org>
Cc: linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH]: Rewrite of arch/mips/ramdisk/
Message-ID: <20041114085202.GA30480@lst.de>
References: <4196FE7C.9040309@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4196FE7C.9040309@gentoo.org>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
X-Scanned-By: MIMEDefang 2.39
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6323
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips

On Sun, Nov 14, 2004 at 01:43:08AM -0500, Kumba wrote:
> Attached is a patch for 2.6 that rewrites how embedded mips ramdisks are 
> merged into the kernel.  It basically replicates the method used by 2.6's 
> initramfs (for linking in config.gz and such into the kernel, see the files 
> in usr/ in the source tree).

So why do you keep it instead of using initramfs as you should - which
is the portable method useable on all ports.
