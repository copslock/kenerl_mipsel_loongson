Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Feb 2003 13:47:04 +0000 (GMT)
Received: from p508B51DC.dip.t-dialin.net ([IPv6:::ffff:80.139.81.220]:12776
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225192AbTBQNrE>; Mon, 17 Feb 2003 13:47:04 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h1HDkqZ32291
	for linux-mips@linux-mips.org; Mon, 17 Feb 2003 14:46:52 +0100
Date: Mon, 17 Feb 2003 14:46:52 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
Message-ID: <20030217144652.C31781@linux-mips.org>
References: <20030216062530Z8224847-1272+556@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030216062530Z8224847-1272+556@linux-mips.org>; from ppopov@linux-mips.org on Sun, Feb 16, 2003 at 06:25:24AM +0000
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1447
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Feb 16, 2003 at 06:25:24AM +0000, ppopov@linux-mips.org wrote:

> Modified files:
> 	drivers/mtd/maps: Tag: linux_2_4 Config.in Makefile 
> Added files:
> 	drivers/mtd/maps: Tag: linux_2_4 db1x00-flash.c 
> 
> Log message:
> 	Added Db1x00 mtd driver support. The driver supports all supported
> 	flash densities, but only the default 64Mb has been tested at this
> 	time.

#include <stdrant.h> you forgot 2.5 :-)

  Ralf
