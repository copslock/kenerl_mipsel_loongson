Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jun 2007 16:39:44 +0100 (BST)
Received: from verein.lst.de ([213.95.11.210]:49643 "EHLO mail.lst.de")
	by ftp.linux-mips.org with ESMTP id S20022386AbXF0Pjk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 27 Jun 2007 16:39:40 +0100
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id l5RFdXNK006080
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 27 Jun 2007 17:39:33 +0200
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id l5RFdW1j006078;
	Wed, 27 Jun 2007 17:39:32 +0200
Date:	Wed, 27 Jun 2007 17:39:32 +0200
From:	Christoph Hellwig <hch@lst.de>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	vagabon.xyz@gmail.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] generic clk API implementation for MIPS
Message-ID: <20070627153932.GA6016@lst.de>
References: <cda58cb80706260237r60a0b6b3obeba7daac7cf114a@mail.gmail.com> <20070626.233332.74753130.anemo@mba.ocn.ne.jp> <cda58cb80706260820y4db3eacnae4dff0101852d52@mail.gmail.com> <20070627.013312.25479645.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070627.013312.25479645.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.3.28i
X-Scanned-By: MIMEDefang 2.39
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15556
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips

On Wed, Jun 27, 2007 at 01:33:12AM +0900, Atsushi Nemoto wrote:
> This MIPS implementation is derived (and stripped) from the SH
> implementation.

Why is this not in architecture-independent code?
