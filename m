Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Feb 2006 18:03:23 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:30214 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133589AbWBTSDN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Feb 2006 18:03:13 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 6827364D3D; Mon, 20 Feb 2006 18:10:03 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id AA2DB8DA8; Mon, 20 Feb 2006 18:09:53 +0000 (GMT)
Date:	Mon, 20 Feb 2006 18:09:53 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: Diff between Linus' and linux-mips git: trivial changes
Message-ID: <20060220180953.GC5254@deprecation.cyrius.com>
References: <20060219234318.GA16311@deprecation.cyrius.com> <20060219234757.GW10266@deprecation.cyrius.com> <Pine.LNX.4.64N.0602201329100.13723@blysk.ds.pg.gda.pl> <20060220142807.GM29098@deprecation.cyrius.com> <Pine.LNX.4.64N.0602201633260.13723@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0602201633260.13723@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10582
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Maciej W. Rozycki <macro@linux-mips.org> [2006-02-20 16:58]:
> I can't recall if I noticed it being removed and I have no idea who
> removed it and why.  I seem to have no access to the MTD CVS tree
> right now, so I can't check the history of the file.

I found it:

revision 1.10
date: 2004/07/15 00:34:49;  author: dwmw2;  state: Exp;  lines: +2 -7
MACH_DECSTATION not DECSTATION

Index: Kconfig
===================================================================
RCS file: /home/cvs/mtd/drivers/mtd/devices/Kconfig,v
retrieving revision 1.9
retrieving revision 1.10
diff -r1.9 -r1.10
2c2
< # $Id: Kconfig,v 1.9 2004/07/08 12:48:21 kalev Exp $
---
> # $Id: Kconfig,v 1.10 2004/07/15 00:34:49 dwmw2 Exp $
43c43
< 	depends on MTD && DECSTATION
---
> 	depends on MTD && MACH_DECSTATION
50,54d49
< 	  If you want to compile this driver as a module ( = code which can be
< 	  inserted in and removed from the running kernel whenever you want),
< 	  say M here and read <file:Documentation/modules.txt>.  The module will
< 	  be called ms02-nv.o.
< 

-- 
Martin Michlmayr
http://www.cyrius.com/
