Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Feb 2005 16:50:39 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:272 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225411AbVBYQuX>; Fri, 25 Feb 2005 16:50:23 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id B6F68E1C84
	for <linux-mips@linux-mips.org>; Fri, 25 Feb 2005 17:50:17 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 28818-09 for <linux-mips@linux-mips.org>;
 Fri, 25 Feb 2005 17:50:17 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 78F25E1C6B
	for <linux-mips@linux-mips.org>; Fri, 25 Feb 2005 17:50:17 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id j1PGoLEH027711
	for <linux-mips@linux-mips.org>; Fri, 25 Feb 2005 17:50:21 +0100
Date:	Fri, 25 Feb 2005 16:50:29 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
In-Reply-To: <20050225133831Z8225462-1340+3675@linux-mips.org>
Message-ID: <Pine.LNX.4.61L.0502251649040.9216@blysk.ds.pg.gda.pl>
References: <20050225133831Z8225462-1340+3675@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.80/700/Fri Feb  4 00:33:15 2005
	clamav-milter version 0.80j
	on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7342
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 25 Feb 2005 ths@linux-mips.org wrote:

> Modified files:
> 	drivers/i2c/busses: i2c-sibyte.c 
> 
> Log message:
> 	Fix 64bit builds.

 Well, these should actually be converted to ioremap()...

  Maciej
