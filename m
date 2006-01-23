Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jan 2006 12:05:57 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:23812 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S8133465AbWAWMFj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Jan 2006 12:05:39 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 7ED60F5963;
	Mon, 23 Jan 2006 13:09:49 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 05161-04; Mon, 23 Jan 2006 13:09:49 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 3728AE1C6D;
	Mon, 23 Jan 2006 13:09:49 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id k0NC9gfm005017;
	Mon, 23 Jan 2006 13:09:42 +0100
Date:	Mon, 23 Jan 2006 12:09:50 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	tbm@cyrius.com, yuasa@hh.iij4u.or.jp, linux-mips@linux-mips.org
Subject: Re: DECstation fails to compile with iomap patch applied
In-Reply-To: <20060123.152640.11963149.nemoto@toshiba-tops.co.jp>
Message-ID: <Pine.LNX.4.64N.0601231204110.27141@blysk.ds.pg.gda.pl>
References: <20060122134553.GA27266@deprecation.cyrius.com>
 <20060123.152640.11963149.nemoto@toshiba-tops.co.jp>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="328795856-2071255785-1138018190=:27141"
X-Virus-Scanned: ClamAV 0.87.1/1247/Sat Jan 21 11:24:51 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10050
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--328795856-2071255785-1138018190=:27141
Content-Type: TEXT/PLAIN; charset=iso-8859-7
Content-Transfer-Encoding: 8BIT

On Mon, 23 Jan 2006, Atsushi Nemoto wrote:

> tbm>   CC      arch/mips/lib/iomap.o
> tbm> arch/mips/lib/iomap.c: In function ¡pci_iomap¢:
> tbm> arch/mips/lib/iomap.c:66: error: ¡_CACHE_CACHABLE_COW¢ undeclared (first use in this function)
> 
> Yes, R3000 does not define _CACHE_CACHABLE_COW.  I suppose the line would be
> 
> 	return __ioremap_mode(start, len, PAGE_CACHABLE_DEFAULT);
> 
> or
> 
> 	return ioremap(start, len);
> 
> I doubt we can really use cacheable page for IORESOURCE_CACHEABLE
> resource...

 I think "iomap.o" should simply be obj-$(CONFIG_PCI) until (unless) there 
is a use for it for other I/O buses.

  Maciej
--328795856-2071255785-1138018190=:27141--
