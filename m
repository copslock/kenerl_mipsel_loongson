Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Dec 2003 13:35:19 +0000 (GMT)
Received: from p508B6A83.dip.t-dialin.net ([IPv6:::ffff:80.139.106.131]:2470
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225498AbTLTNfT>; Sat, 20 Dec 2003 13:35:19 +0000
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id hBKDZHoK006953
	for <linux-mips@linux-mips.org>; Sat, 20 Dec 2003 14:35:18 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id hBKDZHCq006952
	for linux-mips@linux-mips.org; Sat, 20 Dec 2003 14:35:17 +0100
Date: Sat, 20 Dec 2003 14:35:16 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: linux-mips@linux-mips.org
Subject: FYI, misc minors
Message-ID: <20031220133516.GB5392@linux-mips.org>
References: <20031220131855Z8225494-16706+1521@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031220131855Z8225494-16706+1521@linux-mips.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3808
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Dec 20, 2003 at 01:18:51PM +0000, ralf@linux-mips.org wrote:

> Modified files:
> 	drivers/char   : Tag: linux_2_4 au1000_gpio.c ite_gpio.c lcd.c 
> 	include/linux  : Tag: linux_2_4 miscdevice.h 
> 
> Log message:
> 	Time for one of those surprises you all love me for sooo much :-)
> 	
> 	Switch au1000_gpio.c, ite_gpio.c and lcd.c to dynamic minors.

I've removed all MIPS private allocations of misc minor devices.  I'm not
happy with this change but without this there's no change to ever build
a driver for the affected systems from a stock kernel.org tree.  This
change means the minor device numbers of the three affected device
drivers will change - something that will be very easy to deal with by
users and distributions.

  Ralf
