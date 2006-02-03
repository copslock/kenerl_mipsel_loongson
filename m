Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Feb 2006 10:13:01 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:32262 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S8133366AbWBCKMn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 3 Feb 2006 10:12:43 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id CF4F5F5CE7;
	Fri,  3 Feb 2006 11:17:57 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 01091-07; Fri,  3 Feb 2006 11:17:57 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 84BA9F5A90;
	Fri,  3 Feb 2006 11:17:57 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id k13AHqiZ027570;
	Fri, 3 Feb 2006 11:17:52 +0100
Date:	Fri, 3 Feb 2006 10:17:58 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] TX49 MFC0 bug workaround
In-Reply-To: <20060203.111012.130238823.nemoto@toshiba-tops.co.jp>
Message-ID: <Pine.LNX.4.64N.0602031014080.3882@blysk.ds.pg.gda.pl>
References: <20060202165656.GC17352@linux-mips.org> <20060203.020428.59032357.anemo@mba.ocn.ne.jp>
 <20060202172434.GE17352@linux-mips.org> <20060203.111012.130238823.nemoto@toshiba-tops.co.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.87.1/1272/Thu Feb  2 23:27:32 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10325
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 3 Feb 2006, Atsushi Nemoto wrote:

> It should be OK for all CPU while STI/CLI/KMODE macro always clear
> bit[4:1] of status register.  Could you confirm, Maciej ?

 Well, as long as RESTORE_SOME in <asm/stackframe.h> correctly restores 
the IEc, KUc, IEp and KUp bits in the status register this change should 
be OK for R3k-class processors.

  Maciej
