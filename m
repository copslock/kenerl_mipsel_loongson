Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jul 2007 00:34:31 +0100 (BST)
Received: from zeniv.linux.org.uk ([195.92.253.2]:60331 "EHLO
	ZenIV.linux.org.uk") by ftp.linux-mips.org with ESMTP
	id S20022515AbXGVXe3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Jul 2007 00:34:29 +0100
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1ICkw7-0000z0-Sy; Mon, 23 Jul 2007 00:34:03 +0100
Date:	Mon, 23 Jul 2007 00:34:03 +0100
From:	Al Viro <viro@ftp.linux.org.uk>
To:	Matthew Wilcox <matthew@wil.cx>
Cc:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Christoph Hellwig <hch@infradead.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
	"James E.J. Bottomley" <James.Bottomley@SteelEye.com>,
	linux-scsi@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [patch 3/3] scsi: wd33c93 needs <asm/irq.h>
Message-ID: <20070722233403.GD21668@ftp.linux.org.uk>
References: <20070720164043.523003359@mail.of.borg> <20070720164324.097994947@mail.of.borg> <20070720173132.GB19424@linux-mips.org> <20070720173359.GA22423@infradead.org> <46A0F453.60005@ru.mvista.com> <20070720175050.GI14791@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070720175050.GI14791@parisc-linux.org>
User-Agent: Mutt/1.4.1i
Return-Path: <viro@ftp.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15854
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: viro@ftp.linux.org.uk
Precedence: bulk
X-list: linux-mips

On Fri, Jul 20, 2007 at 11:50:50AM -0600, Matthew Wilcox wrote:
> On Fri, Jul 20, 2007 at 09:43:47PM +0400, Sergei Shtylyov wrote:
> > Hello Christoph:
> > 
> > >>>+#include <asm/irq.h>
> > 
> > >>These days that should probably be <linux/irq.h>.
> > 
> > >Not at all, linux/irq.h is something entirely different.
> > 
> >    Actually, <linux/interrupt.h>
> 
> Not for enable/disable_irq.  For request_irq, yes.
> 
> This is something that should be fixed.

Now it is...  FWIW, I suspect that absolute majority of asm/irq.h
uses can be removed now.

Next steps in irq.h/interrupt.h cleanups:
	* scouring asm/irq.h like it had been done for sparc32;
the parts that are only used by relevant arch/ code should be
taken there and includes _in_ asm/irq.h trimmed to minimum
	* separating tasklet.h, with interrupt.h still including it.
Using it where needed.
	* asm/softirq.h (with stuff mostly taken there from asm/hardirq.h)
and linux/softirq.h; again interrupt.h still should include it.
	* mechanical adding include of linux/interrupt.h to files that use
request_irq/free_irq/enable_irq/disable_irq/irqreturn_t/IRQF_...
---> in the next merge window:
	* replace include of linux/interrupt.h in netdevice.h with
that of linux/softirq.h.
	* trim uses of linux/interrupt.h that are not needed anymore.
