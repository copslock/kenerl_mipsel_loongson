Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jul 2007 18:37:13 +0100 (BST)
Received: from pentafluge.infradead.org ([213.146.154.40]:20117 "EHLO
	pentafluge.infradead.org") by ftp.linux-mips.org with ESMTP
	id S20023019AbXGTRhJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 20 Jul 2007 18:37:09 +0100
Received: from hch by pentafluge.infradead.org with local (Exim 4.63 #1 (Red Hat Linux))
	id 1IBwMZ-0005qf-4T; Fri, 20 Jul 2007 18:33:59 +0100
Date:	Fri, 20 Jul 2007 18:33:59 +0100
From:	Christoph Hellwig <hch@infradead.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Geert Uytterhoeven <geert@linux-m68k.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
	"James E.J. Bottomley" <James.Bottomley@SteelEye.com>,
	linux-scsi@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [patch 3/3] scsi: wd33c93 needs <asm/irq.h>
Message-ID: <20070720173359.GA22423@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
	"James E.J. Bottomley" <James.Bottomley@SteelEye.com>,
	linux-scsi@vger.kernel.org, linux-mips@linux-mips.org
References: <20070720164043.523003359@mail.of.borg> <20070720164324.097994947@mail.of.borg> <20070720173132.GB19424@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070720173132.GB19424@linux-mips.org>
User-Agent: Mutt/1.4.2.3i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Return-Path: <SRS0+246e8e8c99add9226fa3+1426+infradead.org+hch@pentafluge.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15837
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@infradead.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 20, 2007 at 06:31:32PM +0100, Ralf Baechle wrote:
> > +#include <asm/irq.h>
> 
> These days that should probably be <linux/irq.h>.

Not at all, linux/irq.h is something entirely different.
