Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jul 2007 18:50:54 +0100 (BST)
Received: from palinux.external.hp.com ([192.25.206.14]:18117 "EHLO
	mail.parisc-linux.org") by ftp.linux-mips.org with ESMTP
	id S20023043AbXGTRuw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 20 Jul 2007 18:50:52 +0100
Received: by mail.parisc-linux.org (Postfix, from userid 26919)
	id ED7B649400A; Fri, 20 Jul 2007 11:50:50 -0600 (MDT)
Date:	Fri, 20 Jul 2007 11:50:50 -0600
From:	Matthew Wilcox <matthew@wil.cx>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Christoph Hellwig <hch@infradead.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
	"James E.J. Bottomley" <James.Bottomley@SteelEye.com>,
	linux-scsi@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [patch 3/3] scsi: wd33c93 needs <asm/irq.h>
Message-ID: <20070720175050.GI14791@parisc-linux.org>
References: <20070720164043.523003359@mail.of.borg> <20070720164324.097994947@mail.of.borg> <20070720173132.GB19424@linux-mips.org> <20070720173359.GA22423@infradead.org> <46A0F453.60005@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46A0F453.60005@ru.mvista.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <willy@parisc-linux.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15840
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matthew@wil.cx
Precedence: bulk
X-list: linux-mips

On Fri, Jul 20, 2007 at 09:43:47PM +0400, Sergei Shtylyov wrote:
> Hello Christoph:
> 
> >>>+#include <asm/irq.h>
> 
> >>These days that should probably be <linux/irq.h>.
> 
> >Not at all, linux/irq.h is something entirely different.
> 
>    Actually, <linux/interrupt.h>

Not for enable/disable_irq.  For request_irq, yes.

This is something that should be fixed.

-- 
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
