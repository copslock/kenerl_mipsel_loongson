Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Aug 2007 16:26:23 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:64260 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20023257AbXHNP0P (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 14 Aug 2007 16:26:15 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id EFAD0E28B9;
	Tue, 14 Aug 2007 17:26:09 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9LtgJJjdaU2M; Tue, 14 Aug 2007 17:26:09 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 9FA06E1F30;
	Tue, 14 Aug 2007 17:26:09 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l7EFQJnm017983;
	Tue, 14 Aug 2007 17:26:19 +0200
Date:	Tue, 14 Aug 2007 16:26:13 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc:	vagabon.xyz@gmail.com, linux-mips@linux-mips.org
Subject: Re: [MIPS] Use generic NTP code for all MIPS platforms
In-Reply-To: <20070814.231255.74753150.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.64N.0708141621240.7206@blysk.ds.pg.gda.pl>
References: <46C07F36.1070308@gmail.com> <20070814.020229.29578157.anemo@mba.ocn.ne.jp>
 <46C0A83B.2090003@gmail.com> <20070814.231255.74753150.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.1/3957/Tue Aug 14 07:48:58 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16180
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 14 Aug 2007, Atsushi Nemoto wrote:

> Some difficulties are:
> 
> * timekeeping subsystem calls {read,update}_persistent_clock() with
>   irq-disabled.  But most RTC class routines might sleep.
> 
> * RTC class can have multiple RTCs on the system.
> 
> * There are already some conflicting features in RTC class ---
>   rtc_suspend and rtc_resume try to adjust the wall clock.
> 
> * IIRC Some people said "NTP sync can be done all in userland" ;-)

 NTP sync in the kernel disturbs the timer interrupt with some setups, 
affecting the dispersion and thus the quality of timekeeping horribly.

  Maciej
