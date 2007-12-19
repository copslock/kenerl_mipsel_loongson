Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Dec 2007 17:34:37 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:24448 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20026895AbXLSRef (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 19 Dec 2007 17:34:35 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lBJHSdEb009747;
	Wed, 19 Dec 2007 18:29:04 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lBJHRo4U009745;
	Wed, 19 Dec 2007 18:27:50 +0100
Date:	Wed, 19 Dec 2007 18:27:50 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	Jeff Garzik <jgarzik@pobox.com>, netdev@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [UPDATED PATCH] SGISEEQ: use cached memory access to make
	driver work on IP28
Message-ID: <20071219172750.GA9717@linux-mips.org>
References: <20071202103312.75E51C2EB5@solo.franken.de> <47671FEE.90103@pobox.com> <20071218103006.GA18598@alpha.franken.de> <476867F5.3070006@pobox.com> <20071219124235.GA7550@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071219124235.GA7550@alpha.franken.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17861
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 19, 2007 at 01:42:36PM +0100, Thomas Bogendoerfer wrote:

> - Use inline functions for dma_sync_* instead of macros 
> - added Kconfig change to make selection for similair SGI boxes easier
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
