Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Dec 2007 21:07:37 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:60325 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20033005AbXLDVHf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 4 Dec 2007 21:07:35 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lB4L5W2i000992;
	Tue, 4 Dec 2007 21:05:57 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lB4L5VNx000991;
	Tue, 4 Dec 2007 21:05:31 GMT
Date:	Tue, 4 Dec 2007 21:05:31 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Jeff Garzik <jgarzik@pobox.com>
Cc:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	netdev@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [UPDATED PATCH] SGISEEQ: use cached memory access to make
	driver work on IP28
Message-ID: <20071204210531.GB775@linux-mips.org>
References: <20071202103312.75E51C2EB5@solo.franken.de> <4755B536.8070003@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4755B536.8070003@pobox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17691
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Dec 04, 2007 at 03:14:46PM -0500, Jeff Garzik wrote:

>> Changes to last version:
>> - Use inline functions for dma_sync_* instead of macros (suggested by Ralf)
>> - added Kconfig change to make selection for similair SGI boxes easier
>
> Has Ralf ACK'd this updated version?

Acked-by: Ralf Baechle <ralf@linux-mips.org>

> This is for 2.6.25 (i.e. not a bug fix for 2.6.24-rc) I presume?

Yes.  IP28 support it scheduled to be merged for 2.6.25.

  Ralf
