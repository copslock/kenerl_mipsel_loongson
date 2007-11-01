Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Nov 2007 15:50:30 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:43150 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20025505AbXKAPu2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 1 Nov 2007 15:50:28 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lA1Fo6hK020230;
	Thu, 1 Nov 2007 15:50:06 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lA1Fo6NC020229;
	Thu, 1 Nov 2007 15:50:06 GMT
Date:	Thu, 1 Nov 2007 15:50:06 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] SNI: register a02r clockevent; don't use PIT timer
Message-ID: <20071101155006.GA20176@linux-mips.org>
References: <20071101103642.GA28146@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071101103642.GA28146@alpha.franken.de>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17360
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 01, 2007 at 11:36:42AM +0100, Thomas Bogendoerfer wrote:

> Register A20R clockevent
> Remove PIT timer setup because it doesn't work 
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Applied.

  Ralf
