Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Sep 2005 16:17:18 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:6407 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225263AbVIGPRB>; Wed, 7 Sep 2005 16:17:01 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 767B6E1C95; Wed,  7 Sep 2005 17:23:56 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 24614-07; Wed,  7 Sep 2005 17:23:56 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id DED49E1C8E; Wed,  7 Sep 2005 17:23:55 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j87FNuwP010594;
	Wed, 7 Sep 2005 17:23:56 +0200
Date:	Wed, 7 Sep 2005 16:24:05 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: unkillable process due to setup_frame() failure
In-Reply-To: <20050907.234413.108737010.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.61L.0509071619120.4591@blysk.ds.pg.gda.pl>
References: <20050906184118.GC3102@linux-mips.org>
 <Pine.LNX.4.61L.0509071011560.4591@blysk.ds.pg.gda.pl> <20050907134717.GA3493@linux-mips.org>
 <20050907.234413.108737010.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/1068/Wed Sep  7 12:03:01 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8892
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 7 Sep 2005, Atsushi Nemoto wrote:

> So my "which is preferred" question was inappropriate.  I had to ask
> "#1 or #2 or both or other ?"

 We should be consistent with other platforms -- having a look at e.g. the 
i386 (as it used to be the reference) and the alpha (as close-enough to 
MIPS) should reveal the answer.  IIRC, a SIGSEGV that has a handler 
installed, but which cannot be callled due to a bad stack pointer is 
forced to SIG_DFL, but you may want to double-check it.

  Maciej
