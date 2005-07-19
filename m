Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jul 2005 15:29:38 +0100 (BST)
Received: from localhost.localdomain ([IPv6:::ffff:127.0.0.1]:38365 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8226872AbVGSO3W>; Tue, 19 Jul 2005 15:29:22 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j6JEVBVI006296;
	Tue, 19 Jul 2005 10:31:11 -0400
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j6JEVAj5006295;
	Tue, 19 Jul 2005 10:31:10 -0400
Date:	Tue, 19 Jul 2005 10:31:10 -0400
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Nori, Soma Sekhar" <nsekhar@ti.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Updating RTC with date command
Message-ID: <20050719143110.GD3108@linux-mips.org>
References: <CBD77117272E1249BFDC21E33D555FDC06018D@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CBD77117272E1249BFDC21E33D555FDC06018D@dbde01.ent.ti.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8548
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jul 19, 2005 at 03:34:01PM +0530, Nori, Soma Sekhar wrote:

> I am trying to add RTC (ds1338) support to 2.6.10 mips kernel
> running on my 4kec board.
> 
> I have populated the rtc_{get|set}_time and rtc_set_mmss pointers 
> and the date command shows the time correctly (as read from the RTC).
> 
> However, when I try to update the time using date -s <time string> 
> the RTC does not get updated. (shows the old time when I boot-up again)
> 
> In arch\mips\kernel\time.c the timer_interrupt calls rtc_set_mmss,
> but that call is made only when STA_UNSYNC is _not_ set in time_status
> variable. do_settimeofday/sys_stime _set_ this flag so the timer 
> interrupt does not call rtc_set_mmss. 	
> 
> In all, I could not figure out any other invocation of rtc_set_time or 
> rtc_set_mmss which could be setting the time in my case.
> 
> Can somebody please help me understand how the RTC is supposed to be
> updated after user changes the time using the date command?

Not at all.  Try man hwclock.

  Ralf
