Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Apr 2003 10:02:30 +0100 (BST)
Received: from mail2.sonytel.be ([IPv6:::ffff:195.0.45.172]:60577 "EHLO
	mail.sonytel.be") by linux-mips.org with ESMTP id <S8225202AbTDOJC3>;
	Tue, 15 Apr 2003 10:02:29 +0100
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.26])
	by mail.sonytel.be (8.9.0p/8.8.6) with ESMTP id LAA09144
	for <linux-mips@linux-mips.org>; Tue, 15 Apr 2003 11:02:23 +0200 (MET DST)
Date: Tue, 15 Apr 2003 11:02:35 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: rtc_[gs]et_time()
Message-ID: <Pine.GSO.4.21.0304151021320.26578-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2047
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

	Hi,

Is there any specific reason why the function pointers rtc_[gs]et_time() use
seconds instead of struct rtc_time? Most RTCs store the date and time in a
format similar to struct rtc_time, so they have to convert from seconds to
struct rtc_time again. I found only 2 exceptions, namely the vr4181 RTC and the
Lasat ds1630 RTC (BTW, I found no RTC driver for vr41xx, since
vr41xx_rtc_get_time() is nowhere defined).

This makes it more complex to make drivers/char/genrtc.c work on MIPS, since 
usually the date and time have to be converted twice: once from struct rtc_time
to seconds in <asm/rtc.h>, and once from seconds to struct rtc_time in each RTC
driver.

Is it OK to make rtc_[gs]et_time() always use struct rtc_time?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
