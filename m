Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jul 2007 12:34:38 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:57352 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20022563AbXG3Leg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 30 Jul 2007 12:34:36 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 54247E1C77;
	Mon, 30 Jul 2007 13:34:32 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3WFFMmmrs6hb; Mon, 30 Jul 2007 13:34:32 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 07658E1C63;
	Mon, 30 Jul 2007 13:34:32 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l6UBYclQ012907;
	Mon, 30 Jul 2007 13:34:38 +0200
Date:	Mon, 30 Jul 2007 12:34:35 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] remove unused GROUP_TOSHIBA_NAMES
In-Reply-To: <20070730111308.GC11436@linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0707301227580.12082@blysk.ds.pg.gda.pl>
References: <20070729211718.4a2b52e2.yoichi_yuasa@tripeaks.co.jp>
 <20070730111308.GC11436@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.1/3819/Mon Jul 30 07:36:40 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15939
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 30 Jul 2007, Ralf Baechle wrote:

> > Remove unused GROUP_TOSHIBA_NAMES.
> 
> The whole machtype / machgroup stuff should probably be ripped out; I
> think DECstation is the only to use it.  Ages ago it was intended for
> something which platform_devices are doing a much better job at
> anyway.

 Well, the DECstation uses it for stuff like IRQ routing and system 
address map discovery, so some kind of enumeration will always be 
required.  Essentially the firmware gives you a system ID you have to 
infer the rest from.  Thus while not necessarily in <asm/bootinfo.h> such 
a list of system variations will have to live somewhere.

  Maciej
