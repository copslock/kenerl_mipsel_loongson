Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2009 10:21:51 +0100 (BST)
Received: from verein.lst.de ([213.95.11.210]:43929 "EHLO verein.lst.de"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S28573941AbZD1JVo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Apr 2009 10:21:44 +0100
Received: from verein.lst.de (localhost [127.0.0.1])
	by verein.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id n3S9LbIF002616
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 28 Apr 2009 11:21:37 +0200
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id n3S9LbXG002614;
	Tue, 28 Apr 2009 11:21:37 +0200
Date:	Tue, 28 Apr 2009 11:21:37 +0200
From:	Christoph Hellwig <hch@lst.de>
To:	Shane McDonald <mcdonald.shane@gmail.com>
Cc:	Geert Uytterhoeven <geert@linux-m68k.org>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [MIPS] Resolve compile issues with msp71xx configuration
Message-ID: <20090428092137.GB2408@lst.de>
References: <E1LyQQX-00047N-6E@localhost> <20090427130952.GA30817@linux-mips.org> <10f740e80904270622u730ba067g660257847dc526de@mail.gmail.com> <b2b2f2320904272321l4cf30181rcde6b1d42a5b5547@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2b2f2320904272321l4cf30181rcde6b1d42a5b5547@mail.gmail.com>
User-Agent: Mutt/1.3.28i
X-Scanned-By: MIMEDefang 2.39
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22506
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips

On Tue, Apr 28, 2009 at 12:21:09AM -0600, Shane McDonald wrote:
> 4. Remove the entire get_ramroot() code, both squashfs and cramfs, as
> Christoph has suggested.  I am hesitant to do this as it also affects code
> in the MTD subsystem (file maps/pmcmsp-ramroot.c), and it also loses some
> functionality on the PMC boards (putting the rootfs in RAM immediately
> following the kernel).  Perhaps there's a better way to handle this?

If the rootfs really is in ram only (and thus you discard any changes to
it) you can just use an initramfs which is a lot simpler than any of the
cramfs and squashfs hacks and supported by platform-independent code.
