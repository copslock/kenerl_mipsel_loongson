Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jul 2005 12:32:11 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:17424 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226288AbVGGLbz>; Thu, 7 Jul 2005 12:31:55 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 08099E1C85
	for <linux-mips@linux-mips.org>; Thu,  7 Jul 2005 13:32:21 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 05969-04 for <linux-mips@linux-mips.org>;
 Thu,  7 Jul 2005 13:32:20 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id CB28BE1C84
	for <linux-mips@linux-mips.org>; Thu,  7 Jul 2005 13:32:20 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j67BWNGX031735
	for <linux-mips@linux-mips.org>; Thu, 7 Jul 2005 13:32:23 +0200
Date:	Thu, 7 Jul 2005 12:32:29 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
In-Reply-To: <20050707091937Z8226163-3678+1737@linux-mips.org>
Message-ID: <Pine.LNX.4.61L.0507071227170.3205@blysk.ds.pg.gda.pl>
References: <20050707091937Z8226163-3678+1737@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/970/Wed Jul  6 18:00:45 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8382
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 7 Jul 2005 ths@linux-mips.org wrote:

> Log message:
> 	Hack to make compiles for the other endianness easier.

 Why have you complicated it that much?  AFAIK:

cflags-$(CONFIG_CPU_BIG_ENDIAN)		+= -meb
cflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= -mel

would work just fine with all GCC versions supported (i.e. including 
2.95.x).  It's true "-EL" and "-EB" are broken, also with 4.0.0 (not sure 
if afterwards) -- it's related to an incorrect setup for the default specs 
for Linux, but it can be avoided using these alternative options as above.

  Maciej
