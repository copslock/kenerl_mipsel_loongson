Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jul 2005 09:58:43 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:47121 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226317AbVGFI60>; Wed, 6 Jul 2005 09:58:26 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id EAFADE1C98; Wed,  6 Jul 2005 10:58:44 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 07919-10; Wed,  6 Jul 2005 10:58:44 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id A9210E1C69; Wed,  6 Jul 2005 10:58:44 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j668wjVf029011;
	Wed, 6 Jul 2005 10:58:46 +0200
Date:	Wed, 6 Jul 2005 09:58:50 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	ralf@linux-mips.org, djohnson+linuxmips@sw.starentnetworks.com,
	linux-mips@linux-mips.org
Subject: Re: preempt_schedule_irq missing from mfinfo[]?
In-Reply-To: <20050706.122912.71087098.nemoto@toshiba-tops.co.jp>
Message-ID: <Pine.LNX.4.61L.0507060952500.9536@blysk.ds.pg.gda.pl>
References: <17093.19241.353160.946039@cortez.sw.starentnetworks.com>
 <20050703.005921.25910131.anemo@mba.ocn.ne.jp> <20050705200308.GE18772@linux-mips.org>
 <20050706.122912.71087098.nemoto@toshiba-tops.co.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/968/Wed Jul  6 04:48:09 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8365
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 6 Jul 2005, Atsushi Nemoto wrote:

> Yes, but many sleeping/scheduling (such as schedule_timeout(),
> __down(), etc.)  are compiled without -fno-omit-frame-pointer, so
> you can not find the caller of such functions anyway.

 Of course you can -- __builtin_return_address().  It should be enough for 
`ps' to fetch useful data from "System.map", shouldn't it?

  Maciej
