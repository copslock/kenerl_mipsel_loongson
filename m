Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Dec 2007 18:31:49 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:46997 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20026985AbXLHSb0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 8 Dec 2007 18:31:26 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lB8IVM5I029453;
	Sat, 8 Dec 2007 18:31:23 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lB8G4od7015182;
	Sat, 8 Dec 2007 16:04:50 GMT
Date:	Sat, 8 Dec 2007 16:04:49 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-scsi@vger.kernel.org, linux-mips@linux-mips.org,
	James.Bottomley@HansenPartnership.com
Subject: Re: [UPDATED PATCH] SGIWD93: use cached memory access to make
	driver work on IP28
Message-ID: <20071208160449.GA3361@linux-mips.org>
References: <20071202103309.6A926C2EB4@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071202103309.6A926C2EB4@solo.franken.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17733
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Dec 02, 2007 at 11:33:09AM +0100, Thomas Bogendoerfer wrote:

> SGI IP28 machines would need special treatment (enable adding addtional
> wait states) when accessing memory uncached. To avoid this pain I
> changed the driver to use only cached access to memory.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Acked-by: Ralf Baechle <ralf@linux-mips.org>

The machine really is as insane as Thomas makes it sound.  Actually even
more so.

  Ralf
