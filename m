Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jun 2007 09:37:33 +0100 (BST)
Received: from verein.lst.de ([213.95.11.210]:38874 "EHLO mail.lst.de")
	by ftp.linux-mips.org with ESMTP id S20022584AbXF1Ih1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 28 Jun 2007 09:37:27 +0100
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id l5S8bQNK023466
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 28 Jun 2007 10:37:26 +0200
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id l5S8bPQo023464;
	Thu, 28 Jun 2007 10:37:25 +0200
Date:	Thu, 28 Jun 2007 10:37:25 +0200
From:	Christoph Hellwig <hch@lst.de>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	hch@lst.de, vagabon.xyz@gmail.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] generic clk API implementation for MIPS
Message-ID: <20070628083725.GA23394@lst.de>
References: <cda58cb80706260820y4db3eacnae4dff0101852d52@mail.gmail.com> <20070627.013312.25479645.anemo@mba.ocn.ne.jp> <20070627153932.GA6016@lst.de> <20070628.112223.96686654.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070628.112223.96686654.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.3.28i
X-Scanned-By: MIMEDefang 2.39
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15559
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips

On Thu, Jun 28, 2007 at 11:22:23AM +0900, Atsushi Nemoto wrote:
> On Wed, 27 Jun 2007 17:39:32 +0200, Christoph Hellwig <hch@lst.de> wrote:
> > > This MIPS implementation is derived (and stripped) from the SH
> > > implementation.
> > 
> > Why is this not in architecture-independent code?
> 
> Yes, this is architecture independent.  If we could have consensus on
> a generic (or least common) implementation, we can put it outside arch
> directory.
> 
> But I gave up for now ;) I will leave all implementation for platform
> code.

I really dislike duplicating thing over architectures.  If you copy code
from another architecture the first though should be 'could and should
this be generic ?'.  So please try to get this lifted to common code
instead of duplicating it.

> 
> ---
> Atsushi Nemoto
---end quoted text---
