Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Mar 2008 16:28:29 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:19898 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20026495AbYCJQ20 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 10 Mar 2008 16:28:26 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m2AGSQxt001026;
	Mon, 10 Mar 2008 16:28:26 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m2AGSPk8001025;
	Mon, 10 Mar 2008 16:28:25 GMT
Date:	Mon, 10 Mar 2008 16:28:25 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] BCM1480: Init pci controller io_map_base
Message-ID: <20080310162825.GE31420@linux-mips.org>
References: <20080308185155.BA791E31BE@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080308185155.BA791E31BE@solo.franken.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18367
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Mar 08, 2008 at 07:51:55PM +0100, Thomas Bogendoerfer wrote:

> BCM1480: Init pci controller io_map_base

Thanks, applied.  But this patch only solves the problem for the BCM1480's
native PCI bus.  Support for PCI behind HT still needs to be fixed and I'm
not quite sure where the ports of such devices and busses are getting
mapped to.

  Ralf
