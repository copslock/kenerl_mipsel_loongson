Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 May 2007 10:54:55 +0100 (BST)
Received: from hellhawk.shadowen.org ([80.68.90.175]:47117 "EHLO
	hellhawk.shadowen.org") by ftp.linux-mips.org with ESMTP
	id S20022921AbXE3Jyx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 30 May 2007 10:54:53 +0100
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1HtL8z-0004eb-V7; Wed, 30 May 2007 11:11:06 +0100
Message-ID: <465D49F3.7010005@shadowen.org>
Date:	Wed, 30 May 2007 10:54:59 +0100
From:	Andy Whitcroft <apw@shadowen.org>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To:	Andrew Morton <akpm@linux-foundation.org>
CC:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zs: Move to the serial subsystem
References: <Pine.LNX.4.64N.0705291258390.14456@blysk.ds.pg.gda.pl> <20070530011224.bf36d2df.akpm@linux-foundation.org>
In-Reply-To: <20070530011224.bf36d2df.akpm@linux-foundation.org>
X-Enigmail-Version: 0.94.2.0
OpenPGP: url=http://www.shadowen.org/~apw/public-key
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <apw@shadowen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15190
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: apw@shadowen.org
Precedence: bulk
X-list: linux-mips

Andrew Morton wrote:
> On Tue, 29 May 2007 14:03:54 +0100 (BST) "Maciej W. Rozycki" <macro@linux-mips.org> wrote:

> Hey, you have volatiles and checkpatch.pl didn't complain.  Andy, a
> reference to Documentation/volatile-considered-harmful.txt would suit.
> 
> (That's
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.22-rc2/2.6.22-rc2-mm1/broken-out/volatile-considered-harmful-take-3.patch)

Added ...

Use of volatile is usually wrong: see
Documentation/volatile-considered-harmful.txt
PATCH: XXX.eml:374:
FILE: linux-2.6.22-rc2/drivers/serial/zs.c:131:
+       volatile void __iomem *control = zport->port.membase +

[...]

I will batch up any changes to checkpatch.pl and send you them as a blob
when they get "interesting" if that suits.

-apw
