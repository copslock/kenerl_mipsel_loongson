Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Dec 2007 18:31:26 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:46229 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20026990AbXLHSbY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 8 Dec 2007 18:31:24 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lB8IVM5G029453;
	Sat, 8 Dec 2007 18:31:22 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lB8G5xED016287;
	Sat, 8 Dec 2007 16:05:59 GMT
Date:	Sat, 8 Dec 2007 16:05:59 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] SNI_RM: EISA support for A20R/RM200
Message-ID: <20071208160559.GB3361@linux-mips.org>
References: <20071130214749.7E597C2EAB@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071130214749.7E597C2EAB@solo.franken.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17732
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Nov 30, 2007 at 10:47:49PM +0100, Thomas Bogendoerfer wrote:

> This patch adds EISA support for non PCI RMs (RM200 and RM400-xxx). The
> major part is the splitting of the EISA and onboard ISA of the RM200,
> which makes the EISA bus on the RM200 look like on other RMs.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Queued for 2.6.25.

Thanks,

  Ralf
