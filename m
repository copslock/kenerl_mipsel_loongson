Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Apr 2003 19:34:02 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:49401 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225268AbTDOSeB>;
	Tue, 15 Apr 2003 19:34:01 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h3FIXu811090;
	Tue, 15 Apr 2003 11:33:56 -0700
Date: Tue, 15 Apr 2003 11:33:56 -0700
From: Jun Sun <jsun@mvista.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux/MIPS Development <linux-mips@linux-mips.org>, jsun@mvista.com
Subject: Re: rtc_[gs]et_time()
Message-ID: <20030415113356.P1642@mvista.com>
References: <Pine.GSO.4.21.0304151021320.26578-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0304151021320.26578-100000@vervain.sonytel.be>; from geert@linux-m68k.org on Tue, Apr 15, 2003 at 11:02:35AM +0200
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2065
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, Apr 15, 2003 at 11:02:35AM +0200, Geert Uytterhoeven wrote:
> 	Hi,
> 
> Is there any specific reason why the function pointers rtc_[gs]et_time() use
> seconds instead of struct rtc_time? Most RTCs store the date and time in a
> format similar to struct rtc_time, so they have to convert from seconds to
> struct rtc_time again. I found only 2 exceptions, namely the vr4181 RTC and the
> Lasat ds1630 RTC (BTW, I found no RTC driver for vr41xx, since
> vr41xx_rtc_get_time() is nowhere defined).
>

This interface is designed to 1) satisfy rtc need by system timer (see
arch/mips/kernel/time.c) and 2) provide abstract for vastly different 
RTC hardwares.  Using "second" is a nature choice to interface with xtime

There are quite a few different RTCs.  And I am sure there are others coming.
vr4181_rtc_get_time() is another example (which you missed :0)

Extending this interface to support user rtc driver (/dev/rtc) is desirable.
Since rtc driver is not called frequently, converting twice is not much a concern.

BTW, I think the wrapping function done in PPC for genrtc should just work
for MIPS. :)

Once genrtc is done for MIPS, we should remove mips_rtc driver.

Jun
