Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Feb 2003 19:37:50 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:6396 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225192AbTBQTht>;
	Mon, 17 Feb 2003 19:37:49 +0000
Received: from localhost (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id LAA03324;
	Mon, 17 Feb 2003 11:37:19 -0800
Subject: Re: CVS Update@-mips.org: linux
From: Pete Popov <ppopov@mvista.com>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <20030217144652.C31781@linux-mips.org>
References: <20030216062530Z8224847-1272+556@linux-mips.org>
	 <20030217144652.C31781@linux-mips.org>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1045510730.6765.19.camel@adsl.pacbell.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 17 Feb 2003 11:38:50 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1452
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Mon, 2003-02-17 at 05:46, Ralf Baechle wrote:
> On Sun, Feb 16, 2003 at 06:25:24AM +0000, ppopov@linux-mips.org wrote:
> 
> > Modified files:
> > 	drivers/mtd/maps: Tag: linux_2_4 Config.in Makefile 
> > Added files:
> > 	drivers/mtd/maps: Tag: linux_2_4 db1x00-flash.c 
> > 
> > Log message:
> > 	Added Db1x00 mtd driver support. The driver supports all supported
> > 	flash densities, but only the default 64Mb has been tested at this
> > 	time.
> 
> #include <stdrant.h> you forgot 2.5 :-)

Sorry. Dan _is_ working on 2.5. I'll start testing the builds on 2.4 and
2.5 before committing the patches.

Pete
