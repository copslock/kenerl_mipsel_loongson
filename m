Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Nov 2007 18:21:53 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:20627 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20025516AbXKLSVv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 12 Nov 2007 18:21:51 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lACIL6Tp007026;
	Mon, 12 Nov 2007 18:21:31 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lACIL5Rx007025;
	Mon, 12 Nov 2007 18:21:05 GMT
Date:	Mon, 12 Nov 2007 18:21:05 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] arch/mips/Makefile: Fix canonical system names
Message-ID: <20071112182105.GA7019@linux-mips.org>
References: <Pine.LNX.4.64N.0711121727000.30102@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0711121727000.30102@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17473
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 12, 2007 at 05:30:52PM +0000, Maciej W. Rozycki wrote:

>  The GNU `config.guess' uses "linux-gnu" as the canonical system name.  
> Fix the list of compiler prefixes checked to spell it correctly.
> 
> Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>

Applied, thanks.

  Ralf
