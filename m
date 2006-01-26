Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jan 2006 17:35:13 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:33041 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133683AbWAZRez (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 26 Jan 2006 17:34:55 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k0QHcwdT008005;
	Thu, 26 Jan 2006 17:38:58 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k0QHcrZh008003;
	Thu, 26 Jan 2006 17:38:53 GMT
Date:	Thu, 26 Jan 2006 17:38:53 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Christoph Hellwig <hch@lst.de>
Cc:	Franck <vagabon.xyz@gmail.com>,
	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Optimize swab operations
Message-ID: <20060126173853.GG3411@linux-mips.org>
References: <cda58cb80601260308v3eecf0d0w@mail.gmail.com> <20060126112638.GC3411@linux-mips.org> <20060126123857.GA28043@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060126123857.GA28043@lst.de>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10191
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jan 26, 2006 at 01:38:57PM +0100, Christoph Hellwig wrote:

> > > This patch uses 'wsbh' instruction to optimize swab operations. This
> > > instruction is part of the MIPS Release 2 instructions set.
> > 
> > Will apply.  Small nit - you must include <linux/config.h> in every file
> > that is refering to a CONFIG_* symbols, I'll take care of that.
> 
> That's not required anymore.  the build system now implicitly includes it
> for every file.

Wonderful.  Was waiting for the day when this becomes the official religion.
No more time wasted to make configcheck ...

  Ralf
