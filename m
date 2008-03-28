Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Mar 2008 14:43:53 +0100 (CET)
Received: from relay01.mx.bawue.net ([193.7.176.67]:15835 "EHLO
	relay01.mx.bawue.net") by lappi.linux-mips.net with ESMTP
	id S528721AbYC1Nnt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 28 Mar 2008 14:43:49 +0100
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by relay01.mx.bawue.net (Postfix) with ESMTP id 4119548918;
	Fri, 28 Mar 2008 14:43:18 +0100 (CET)
Received: from ths by lagash with local (Exim 4.69)
	(envelope-from <ths@networkno.de>)
	id 1JfErV-000643-D9; Fri, 28 Mar 2008 13:43:17 +0000
Date:	Fri, 28 Mar 2008 13:43:17 +0000
From:	Thiemo Seufer <ths@networkno.de>
To:	Larry Stefani <lstefani@yahoo.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: SB1250 locking up in init on current 2.6.16 kernel
Message-ID: <20080328134317.GA21099@networkno.de>
References: <20080324203311.GB15294@linux-mips.org> <926775.30590.qm@web38810.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <926775.30590.qm@web38810.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18693
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Larry Stefani wrote:
> Hi Ralf,
> 
> I used git bisect and narrowed the lockup to the
> "[MIPS] Retire flush_icache_page from mm use." patch
> (see git results below).  This is consistent with my
> earlier testing and what Thiemo reported March 3 on
> the linux.debian.kernel list.  I tried his patch (mark
> pages tainted by PIO IDE as dirty) on 2.6.16.60, but
> it didn't prevent the lockup.

ISTR I got 2.6.16.60 to work by always enabling the cache flush in
ide.h (it is currently only run to clean out aliases). Keep in mind
that this is a crude workaround on top of other cache code hacks for
the SB-1.


Thiemo
