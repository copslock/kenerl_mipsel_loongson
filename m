Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jul 2007 18:35:23 +0100 (BST)
Received: from palinux.external.hp.com ([192.25.206.14]:56731 "EHLO
	mail.parisc-linux.org") by ftp.linux-mips.org with ESMTP
	id S20023017AbXGTRfV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 20 Jul 2007 18:35:21 +0100
Received: by mail.parisc-linux.org (Postfix, from userid 26919)
	id C35E149400A; Fri, 20 Jul 2007 11:34:48 -0600 (MDT)
Date:	Fri, 20 Jul 2007 11:34:48 -0600
From:	Matthew Wilcox <matthew@wil.cx>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Geert Uytterhoeven <geert@linux-m68k.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
	"James E.J. Bottomley" <James.Bottomley@SteelEye.com>,
	linux-scsi@vger.kernel.org, linux-mips@linux-mips.org,
	Russell King <rmk@arm.linux.org.uk>
Subject: Re: [patch 3/3] scsi: wd33c93 needs <asm/irq.h>
Message-ID: <20070720173448.GH14791@parisc-linux.org>
References: <20070720164043.523003359@mail.of.borg> <20070720164324.097994947@mail.of.borg> <20070720173132.GB19424@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070720173132.GB19424@linux-mips.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <willy@parisc-linux.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15836
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matthew@wil.cx
Precedence: bulk
X-list: linux-mips

On Fri, Jul 20, 2007 at 06:31:32PM +0100, Ralf Baechle wrote:
> On Fri, Jul 20, 2007 at 06:40:46PM +0200, Geert Uytterhoeven wrote:
> > +#include <asm/irq.h>
> 
> These days that should probably be <linux/irq.h>.

Go and read the comments at the top of linux/irq.h.
And then report to Russell for your whipping.

-- 
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
