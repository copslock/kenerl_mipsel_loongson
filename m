Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2009 16:09:54 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:49691 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S20025530AbZD1PJv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Apr 2009 16:09:51 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n3SF9joD008715;
	Tue, 28 Apr 2009 17:09:46 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n3SF9hm2008328;
	Tue, 28 Apr 2009 17:09:43 +0200
Date:	Tue, 28 Apr 2009 17:09:42 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Shane McDonald <mcdonald.shane@gmail.com>
Cc:	Christoph Hellwig <hch@lst.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-mips@linux-mips.org
Subject: Re: [MIPS] Resolve compile issues with msp71xx configuration
Message-ID: <20090428150942.GA28519@linux-mips.org>
References: <E1LyQQX-00047N-6E@localhost> <20090427130952.GA30817@linux-mips.org> <10f740e80904270622u730ba067g660257847dc526de@mail.gmail.com> <20090428092005.GA2408@lst.de> <b2b2f2320904280748q3a45ecf6r46dcb536877663c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2b2f2320904280748q3a45ecf6r46dcb536877663c@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22515
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 28, 2009 at 08:48:52AM -0600, Shane McDonald wrote:

> > If the rootfs really is in ram only (and thus you discard any changes to
> > it) you can just use an initramfs which is a lot simpler than any of the
> > cramfs and squashfs hacks and supported by platform-independent code.
> The rootfs is ram only with a union mount of a jffs2 filesystem to retain
> changes.  The target system is a resource-constrained router board, and we
> were trying to keep everything as small as possible.  If I remember
> correctly, this code originally came over from an internal 2.4 port on an
> even more resource-constrained platform; perhaps there are better options in
> today's world.
> 
> I will look into a better solution to this problem.  In the meantime, I'm
> hesitant to remove the existing code -- I think I prefer to leave it
> uncompilable until that solution is found.

You may want to chainsaw it into a shape were it's usable in some way -
for example with NFS root until you have a chance to sort this out.

  Ralf
