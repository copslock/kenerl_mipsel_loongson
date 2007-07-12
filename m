Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jul 2007 18:58:30 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:7632 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022656AbXGLR61 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Jul 2007 18:58:27 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l6CHhMB3022591;
	Thu, 12 Jul 2007 18:43:22 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l6CHhKCf022590;
	Thu, 12 Jul 2007 18:43:20 +0100
Date:	Thu, 12 Jul 2007 18:43:20 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Andrew Morton <akpm@linux-foundation.org>,
	Mark Mason <mason@broadcom.com>,
	Andy Whitcroft <apw@shadowen.org>,
	Randy Dunlap <rdunlap@xenotime.net>,
	Joel Schopp <jschopp@austin.ibm.com>,
	linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sb1250-duart.c: SB1250 DUART serial support
Message-ID: <20070712174320.GA22332@linux-mips.org>
References: <Pine.LNX.4.64N.0707121745010.3029@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0707121745010.3029@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15751
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jul 12, 2007 at 06:39:00PM +0100, Maciej W. Rozycki wrote:

>  This is a driver for the SB1250 DUART, a dual serial port implementation 
> included in the Broadcom family of SOCs descending from the SiByte SB1250 
> MIPS64 chip multiprocessor.  It is a new implementation replacing the 
> old-fashioned driver currently present in the linux-mips.org tree.  It 
> supports all the usual features one would expect from a(n asynchronous) 
> serial driver, including modem line control (as far as hardware supports 
> it -- there is edge detection logic missing from the DCD and RI lines and 
> the driver does not implement polling of these lines at the moment), the 
> serial console, BREAK transmission and reception, including the magic 
> SysRq.  The receive FIFO threshold is not maintained though.
> 
> Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>

I'm all in favor of this patch sine the old drivers/char/ serial driver
has been slowly decaying while the kernel around it is changing.  It would
also make the kernel.org kernel finally usable for the Sibyte machines, so
it's an improvment even if it doesn't have half a decade of testing under
the belt, thus ACK.

  Ralf
