Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Nov 2007 16:57:09 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:12212 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20025766AbXKZQ5H (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 26 Nov 2007 16:57:07 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lAQGuMv4024582;
	Mon, 26 Nov 2007 16:56:22 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lAQGuL0o024581;
	Mon, 26 Nov 2007 16:56:21 GMT
Date:	Mon, 26 Nov 2007 16:56:21 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] IP22: Fix modules for 64bit kernels by using a CKSEG2
	MAP_BASE
Message-ID: <20071126165621.GA24575@linux-mips.org>
References: <20071123195152.B86B0C2E30@solo.franken.de> <20071125100224.GA17974@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071125100224.GA17974@alpha.franken.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17592
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Nov 25, 2007 at 11:03:12AM +0100, Thomas Bogendoerfer wrote:

> please drop this bogus patch, it causes vmalloc allocations fails. The bug
> it tries to fix isn't even there.

Ok.

  Ralf
