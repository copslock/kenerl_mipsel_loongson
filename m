Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Mar 2008 13:12:40 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:32912 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28600179AbYCQNMi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 17 Mar 2008 13:12:38 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m2HDCSP6016610;
	Mon, 17 Mar 2008 13:12:28 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m2HDCMOP016588;
	Mon, 17 Mar 2008 13:12:22 GMT
Date:	Mon, 17 Mar 2008 13:12:22 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] BCM1480: Fix PCI/HT IO access
Message-ID: <20080317131105.GA15625@linux-mips.org>
References: <20080316171416.18556C226C@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080316171416.18556C226C@solo.franken.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18416
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Mar 16, 2008 at 06:14:16PM +0100, Thomas Bogendoerfer wrote:

> - removed check for enable HT-PCI bridges, because some CFE version
>   init only the needed one and scanning works even with disabled HT
>   links
> - implemented I/O access behind HT PCI busses
> - fixed pci_map for IO resource behind PCI bridge
> 
> Tested with E100 and Tulip driver.

Thanks, applied.

  Ralf
