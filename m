Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Nov 2007 14:43:55 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:40878 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28578696AbXK3Onx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 30 Nov 2007 14:43:53 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lAUEhXlv027677;
	Fri, 30 Nov 2007 14:43:34 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lAUEhWiQ027676;
	Fri, 30 Nov 2007 14:43:32 GMT
Date:	Fri, 30 Nov 2007 14:43:32 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	linux-mips@linux-mips.org, manoj.ekbote@broadcom.com,
	mark.e.mason@broadcom.com
Subject: Re: BigSur: io_map_base not set for PCI bus 0000:00
Message-ID: <20071130144332.GA27363@linux-mips.org>
References: <20071125142603.GQ20922@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071125142603.GQ20922@deprecation.cyrius.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17648
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Nov 25, 2007 at 03:26:03PM +0100, Martin Michlmayr wrote:

> When I put a SATA/PATA PCI card into the first PCI slot of my BigSur,
> I get the following with current git:
> 
> io_map_base of root PCI bus 0000:00 unset.  Trying to continue but you better
> fix this issue or report it to linux-mips@linux-mips.org or your vendor.
> Kernel panic - not syncing: To avoid data corruption io_map_base MUST be set with multiple PCI domains.

You ran into a paranoia check somewhere in the iomap code.  I'll try to
sort it out.

  Ralf
