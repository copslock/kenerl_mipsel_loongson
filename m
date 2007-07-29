Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Jul 2007 15:44:44 +0100 (BST)
Received: from verein.lst.de ([213.95.11.210]:9105 "EHLO mail.lst.de")
	by ftp.linux-mips.org with ESMTP id S20022869AbXG2Oom (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 29 Jul 2007 15:44:42 +0100
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id l6TEiaA5028856
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 29 Jul 2007 16:44:36 +0200
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id l6TEiaEN028854;
	Sun, 29 Jul 2007 16:44:36 +0200
Date:	Sun, 29 Jul 2007 16:44:36 +0200
From:	Christoph Hellwig <hch@lst.de>
To:	"H. Peter Anvin" <hpa@zytor.com>
Cc:	maximilian attems <max@stro.at>, ralf@linux-mips.org,
	linux-mips@linux-mips.org, klibc@zytor.com
Subject: Re: [klibc] klibc kernelheaders build failure on mips/mipsel
Message-ID: <20070729144436.GA28703@lst.de>
References: <20070729095217.GE7448@stro.at> <46AC997B.2030706@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46AC997B.2030706@zytor.com>
User-Agent: Mutt/1.3.28i
X-Scanned-By: MIMEDefang 2.39
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15923
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips

On Sun, Jul 29, 2007 at 06:43:23AM -0700, H. Peter Anvin wrote:
> >  i'm not sure if you want to export both headers in the make
> >  kernelheaders target or if it is the fault of klibc to assume
> >  that those are available?
> >
> 
> If I remember correctly (sorry, I'm on the road at the moment), those 
> files should be exportable.  They wouldn't be all that hard to replicate 
> in klibc, though.

Both headers contain cpp macros for assembly code to work with the
mariads of mips ABIs.  I don't think the kernel should export those
headers.  And yes, they're both quite trivial.
