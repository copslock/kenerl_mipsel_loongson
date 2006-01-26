Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jan 2006 12:34:53 +0000 (GMT)
Received: from verein.lst.de ([213.95.11.210]:20353 "EHLO mail.lst.de")
	by ftp.linux-mips.org with ESMTP id S8133524AbWAZMed (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 26 Jan 2006 12:34:33 +0000
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id k0QCd0RT028372
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 26 Jan 2006 13:39:00 +0100
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id k0QCcvqX028370;
	Thu, 26 Jan 2006 13:38:57 +0100
Date:	Thu, 26 Jan 2006 13:38:57 +0100
From:	Christoph Hellwig <hch@lst.de>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Franck <vagabon.xyz@gmail.com>,
	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Optimize swab operations
Message-ID: <20060126123857.GA28043@lst.de>
References: <cda58cb80601260308v3eecf0d0w@mail.gmail.com> <20060126112638.GC3411@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060126112638.GC3411@linux-mips.org>
User-Agent: Mutt/1.3.28i
X-Scanned-By: MIMEDefang 2.39
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10175
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips

On Thu, Jan 26, 2006 at 11:26:38AM +0000, Ralf Baechle wrote:
> On Thu, Jan 26, 2006 at 12:08:25PM +0100, Franck wrote:
> 
> > This patch uses 'wsbh' instruction to optimize swab operations. This
> > instruction is part of the MIPS Release 2 instructions set.
> 
> Will apply.  Small nit - you must include <linux/config.h> in every file
> that is refering to a CONFIG_* symbols, I'll take care of that.

That's not required anymore.  the build system now implicitly includes it
for every file.
