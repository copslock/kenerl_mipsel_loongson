Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Sep 2005 10:07:39 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:4879 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225239AbVIGJHU>; Wed, 7 Sep 2005 10:07:20 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id D6062F5982; Wed,  7 Sep 2005 11:14:14 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 21160-07; Wed,  7 Sep 2005 11:14:14 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 5A0D3F5980; Wed,  7 Sep 2005 11:14:14 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j879ECgU028397;
	Wed, 7 Sep 2005 11:14:12 +0200
Date:	Wed, 7 Sep 2005 10:14:16 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: unkillable process due to setup_frame() failure
In-Reply-To: <20050906184118.GC3102@linux-mips.org>
Message-ID: <Pine.LNX.4.61L.0509071011560.4591@blysk.ds.pg.gda.pl>
References: <20050907.014234.108739386.anemo@mba.ocn.ne.jp>
 <20050906184118.GC3102@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/1067/Wed Sep  7 02:53:51 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8884
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 6 Sep 2005, Ralf Baechle wrote:

> > So, the process can not be kill by SIGKILL.  In 2.6.12, 'sigkill
> > priority fix' was applied to __dequeue_signal(), but it does not help
> > while the SIGTRAP is queued to tsk->pending but SIGKILL (by kill
> > command) is queued to tsk->signal->shared_pending.
> 
> The behaviour of not advancing the EPC beyond the faulting instruction is
> part of the problem - but I believe that was the usual behaviour for
> MIPS UNIXoid operating systems.

 Well, SIGKILL should always work and frankly I can't see a reason to 
return back to user space in the affected context in the first place.  
What's left in EPC shouldn't matter.

  Maciej
