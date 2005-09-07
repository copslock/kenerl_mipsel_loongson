Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Sep 2005 17:28:10 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:46344 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225275AbVIGQ1w>; Wed, 7 Sep 2005 17:27:52 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 27058E1C99; Wed,  7 Sep 2005 18:34:47 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 06872-04; Wed,  7 Sep 2005 18:34:47 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id CD163E1C95; Wed,  7 Sep 2005 18:34:46 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j87GYlE2013441;
	Wed, 7 Sep 2005 18:34:48 +0200
Date:	Wed, 7 Sep 2005 17:34:57 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: unkillable process due to setup_frame() failure
In-Reply-To: <20050907161157.GA11379@linux-mips.org>
Message-ID: <Pine.LNX.4.61L.0509071731320.4591@blysk.ds.pg.gda.pl>
References: <20050906184118.GC3102@linux-mips.org>
 <Pine.LNX.4.61L.0509071011560.4591@blysk.ds.pg.gda.pl> <20050907134717.GA3493@linux-mips.org>
 <20050907.234413.108737010.anemo@mba.ocn.ne.jp>
 <Pine.LNX.4.61L.0509071619120.4591@blysk.ds.pg.gda.pl>
 <20050907161157.GA11379@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/1068/Wed Sep  7 12:03:01 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8895
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 7 Sep 2005, Ralf Baechle wrote:

> That's what's already happening.  We call force_sigsegv which is like
> force_sig unless it's trying to deliver a SIGSEGV in which case it'll
> reset the handler to SIG_DFL, return to userspace where it hits the
> break instruction and starts all over to process the SIGTRAP.

 Except that SIG_DFL for SIGSEGV is killing the process (with a core 
dump).  Therefore user space shouldn't ever be reached again in this 
context.

  Maciej
