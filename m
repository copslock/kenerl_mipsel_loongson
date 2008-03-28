Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Mar 2008 18:12:22 +0100 (CET)
Received: from relay01.mx.bawue.net ([193.7.176.67]:13993 "EHLO
	relay01.mx.bawue.net") by lappi.linux-mips.net with ESMTP
	id S528957AbYC1RMS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 28 Mar 2008 18:12:18 +0100
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by relay01.mx.bawue.net (Postfix) with ESMTP id 33E7E48916;
	Fri, 28 Mar 2008 18:11:47 +0100 (CET)
Received: from ths by lagash with local (Exim 4.69)
	(envelope-from <ths@networkno.de>)
	id 1JfI7G-0004uD-8Y; Fri, 28 Mar 2008 17:11:46 +0000
Date:	Fri, 28 Mar 2008 17:11:46 +0000
From:	Thiemo Seufer <ths@networkno.de>
To:	Larry Stefani <lstefani@yahoo.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: SB1250 locking up in init on current 2.6.16 kernel
Message-ID: <20080328171146.GA23320@networkno.de>
References: <20080328134317.GA21099@networkno.de> <54971.71316.qm@web38813.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54971.71316.qm@web38813.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18699
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Larry Stefani wrote:
> Hi Thiemo,
> 
> I applied your patch (from
> http://www.linux-mips.org/archives/linux-mips/2008-03/msg00001.html)
> on 2.6.16.60, and also patched arch/mips/mm/c-sb1.c to
> remove:
> 
>           local_flush_data_cache_page = (void *)
> sb1_nop;
> 
> in order to compile after your changes to cache.c and
> cacheflush.h.  However, this did not work on my board,
> and I experienced the same lockup as before.

Stick with the original 2.6.16.60 code but try to remove the

   if (cpu_has_dc_aliases) {

conditional in ide.h _without_ using my patch. This is what made
it boot for me.

> >>Keep in mind that this is a crude workaround on top
> of other cache code hacks for the SB-1.
> 
> What other "cache code hacks for SB-1"?  Are there
> additional changes required to 2.6.16.60 to make SB1
> work properly?  Did you post those hacks somewhere?

No, what I meant to say is that the old sb-1 cache code isn't quite
the most trustibe code, it had some holes which were papered over
by doing more cache flushes than necessary.


Thiemo
