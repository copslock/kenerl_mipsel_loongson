Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Oct 2005 08:47:55 +0100 (BST)
Received: from pentafluge.infradead.org ([213.146.154.40]:27363 "EHLO
	pentafluge.infradead.org") by ftp.linux-mips.org with ESMTP
	id S8133395AbVJTHrh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Oct 2005 08:47:37 +0100
Received: from g133107.upc-g.chello.nl ([80.57.133.107] helo=[172.31.3.43])
	by pentafluge.infradead.org with esmtpsa (Exim 4.54 #1 (Red Hat Linux))
	id 1ESV95-0004RE-Pw; Thu, 20 Oct 2005 08:47:29 +0100
Subject: Re: Patch: ATI Xilleon port 2/11 net/e100 Memory barriers and
	write flushing
From:	Arjan van de Ven <arjan@infradead.org>
To:	ddaney@avtrex.com
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
In-Reply-To: <17239.12568.110253.404667@dl2.hq2.avtrex.com>
References: <17239.12568.110253.404667@dl2.hq2.avtrex.com>
Content-Type: text/plain
Date:	Thu, 20 Oct 2005 09:47:25 +0200
Message-Id: <1129794446.2807.3.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Return-Path: <SRS0+f845bf7d0d0342f87d41+788+infradead.org+arjan@pentafluge.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9301
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arjan@infradead.org
Precedence: bulk
X-list: linux-mips

On Wed, 2005-10-19 at 22:54 -0700, David Daney wrote:
> This is the second part of my Xilleon port.
> 
> I am sending the full set of patches to linux-mips@linux-mips.org
> which is archived at: http://www.linux-mips.org/archives/
> 
> Only the patches that touch generic parts of the kernel are coming
> here.
> 
> The Xilleon (32bit MIPS SOC) has a write back buffer that seems to
> operate on the pci bus and does not get flushed before a read.  The
> result is that a memory barrier must be done before a read intended to
> flush PCI writes.

this is broken hardware; the real solution is to put that wmb() into the
readl() function, as opposed to patching half the kernel for this!

And the second problem seems to be an reodering, which is also not quite
allowed. That also needs fixing, probably in the writel/writeb() macros.
