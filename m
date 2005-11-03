Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Nov 2005 14:26:17 +0000 (GMT)
Received: from extgw-uk.mips.com ([62.254.210.129]:63238 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133850AbVKCO0A (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 3 Nov 2005 14:26:00 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id jA3EQj1a016765;
	Thu, 3 Nov 2005 14:26:45 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id jA3EQhEH016764;
	Thu, 3 Nov 2005 14:26:43 GMT
Date:	Thu, 3 Nov 2005 14:26:43 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] remove mips_rtc_lock
Message-ID: <20051103142642.GA16434@linux-mips.org>
References: <20051103.010240.41630907.anemo@mba.ocn.ne.jp> <20051103110552.GA3149@linux-mips.org> <20051103.231250.25477564.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051103.231250.25477564.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9418
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 03, 2005 at 11:12:50PM +0900, Atsushi Nemoto wrote:

> >>>>> On Thu, 3 Nov 2005 11:05:53 +0000, Ralf Baechle <ralf@linux-mips.org> said:
> 
> ralf> The difference between and get_rtc_time and rtc_get_time is less
> ralf> than obvious.  Same for set_rtc_time and rtc_set_time ...
> 
> Sure.  Also I suppose majority of RTC prefer struct rtc_time than
> unsigned long.  Is it time for redesign the mips RTC interface? ;-)

More than that, the whole MIPS time code while functional is such a
beauty it could make a grown man cry ...

  Ralf
