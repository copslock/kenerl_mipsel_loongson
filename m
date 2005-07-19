Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jul 2005 11:02:43 +0100 (BST)
Received: from go4.ext.ti.com ([IPv6:::ffff:192.91.75.132]:4817 "EHLO
	go4.ext.ti.com") by linux-mips.org with ESMTP id <S8226859AbVGSKCV> convert rfc822-to-8bit;
	Tue, 19 Jul 2005 11:02:21 +0100
Received: from dlep52.itg.ti.com ([157.170.170.57])
	by go4.ext.ti.com (8.13.1/8.13.1) with ESMTP id j6JA44mg023968
	for <linux-mips@linux-mips.org>; Tue, 19 Jul 2005 05:04:04 -0500 (CDT)
Received: from dlep90.itg.ti.com (localhost [127.0.0.1])
	by dlep52.itg.ti.com (8.12.11/8.12.11) with ESMTP id j6JA43dn011191
	for <linux-mips@linux-mips.org>; Tue, 19 Jul 2005 05:04:04 -0500 (CDT)
Received: from dbde01.ent.ti.com (localhost [127.0.0.1])
	by dlep90.itg.ti.com (8.12.11/8.12.11) with ESMTP id j6JA42cE028059
	for <linux-mips@linux-mips.org>; Tue, 19 Jul 2005 05:04:03 -0500 (CDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Updating RTC with date command
Date:	Tue, 19 Jul 2005 15:34:01 +0530
Message-ID: <CBD77117272E1249BFDC21E33D555FDC06018D@dbde01.ent.ti.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Updating RTC with date command
Thread-Index: AcWMSPfolCjiFsEMTcyVqhslHFL+aA==
From:	"Nori, Soma Sekhar" <nsekhar@ti.com>
To:	<linux-mips@linux-mips.org>
Return-Path: <nsekhar@ti.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8544
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nsekhar@ti.com
Precedence: bulk
X-list: linux-mips


Hi,

I am trying to add RTC (ds1338) support to 2.6.10 mips kernel
running on my 4kec board.

I have populated the rtc_{get|set}_time and rtc_set_mmss pointers 
and the date command shows the time correctly (as read from the RTC).

However, when I try to update the time using date -s <time string> 
the RTC does not get updated. (shows the old time when I boot-up again)

In arch\mips\kernel\time.c the timer_interrupt calls rtc_set_mmss,
but that call is made only when STA_UNSYNC is _not_ set in time_status
variable. do_settimeofday/sys_stime _set_ this flag so the timer 
interrupt does not call rtc_set_mmss. 	

In all, I could not figure out any other invocation of rtc_set_time or 
rtc_set_mmss which could be setting the time in my case.

Can somebody please help me understand how the RTC is supposed to be
updated after user changes the time using the date command?

Thanks,
Sekhar Nori
