Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Nov 2007 12:16:10 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:2961 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20029255AbXK2MQI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 29 Nov 2007 12:16:08 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lATCFv1u010565;
	Thu, 29 Nov 2007 12:15:58 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lATCFvK7010564;
	Thu, 29 Nov 2007 12:15:57 GMT
Date:	Thu, 29 Nov 2007 12:15:57 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] IP28 support
Message-ID: <20071129121557.GA10522@linux-mips.org>
References: <20071126224004.D885AC2B26@solo.franken.de> <20071128143459.GA22943@linux-mips.org> <20071129095844.GA9106@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071129095844.GA9106@alpha.franken.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17640
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 29, 2007 at 10:58:44AM +0100, Thomas Bogendoerfer wrote:

> I've changed that in the updated IP28 patch. I don't see a way to
> support ISA busmaster devices, because they will generate a physical
> address between 0 and 0x1000000, which will only hit the 512 KB
> mirrored RAM. Anything which uses ISA slave DMA is able to address
> the full 32bit address space.

Those 512kB could be used as a fairly claustrophobic ZONE_DMA.  Not
pretty though.

  Ralf
