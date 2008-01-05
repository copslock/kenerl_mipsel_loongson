Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Jan 2008 11:58:14 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:25247 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20029442AbYAEL6M (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 5 Jan 2008 11:58:12 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m05Bw9Z0010320;
	Sat, 5 Jan 2008 12:58:09 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m05Bw97x010319;
	Sat, 5 Jan 2008 12:58:09 +0100
Date:	Sat, 5 Jan 2008 12:58:09 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix IP32 breakage
Message-ID: <20080105115809.GA9805@linux-mips.org>
References: <20080105111311.2DE1CC2EF8@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080105111311.2DE1CC2EF8@solo.franken.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17923
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Jan 05, 2008 at 12:13:11PM +0100, Thomas Bogendoerfer wrote:

> - suppress master aborts during config read
> - set io_map_base
> - only fixup end of iomem resource to avoid failing request_resource
>   in serial driver
> - killed useless setting of crime_int bit, which caused wrong interrupts
> - use physcial address for serial port platform device and let 8250
>   driver do the ioremap
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Thanks, applied.

  Ralf
