Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jul 2005 09:42:56 +0100 (BST)
Received: from go4.ext.ti.com ([IPv6:::ffff:192.91.75.132]:9962 "EHLO
	go4.ext.ti.com") by linux-mips.org with ESMTP id <S8225771AbVG0Iml> convert rfc822-to-8bit;
	Wed, 27 Jul 2005 09:42:41 +0100
Received: from dlep31.itg.ti.com ([157.170.139.161])
	by go4.ext.ti.com (8.13.1/8.13.1) with ESMTP id j6R8j9PF025001
	for <linux-mips@linux-mips.org>; Wed, 27 Jul 2005 03:45:09 -0500 (CDT)
Received: from dlep90.itg.ti.com (localhost [127.0.0.1])
	by dlep31.itg.ti.com (8.12.11/8.12.11) with ESMTP id j6R8j9Xg008402
	for <linux-mips@linux-mips.org>; Wed, 27 Jul 2005 03:45:09 -0500 (CDT)
Received: from dbde01.ent.ti.com (localhost [127.0.0.1])
	by dlep90.itg.ti.com (8.12.11/8.12.11) with ESMTP id j6R8j5i6012666
	for <linux-mips@linux-mips.org>; Wed, 27 Jul 2005 03:45:08 -0500 (CDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: xtime drift issue
Date:	Wed, 27 Jul 2005 14:15:05 +0530
Message-ID: <CBD77117272E1249BFDC21E33D555FDC0601A7@dbde01.ent.ti.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: xtime drift issue
Thread-Index: AcWSh3xGMMv1tp93Q+KoMn/o8LU7nw==
From:	"Nori, Soma Sekhar" <nsekhar@ti.com>
To:	<linux-mips@linux-mips.org>
Return-Path: <nsekhar@ti.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8645
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nsekhar@ti.com
Precedence: bulk
X-list: linux-mips


Hi All,

I am running linux 2.6.10 (kernel.org) on my MIPS 4kec board.

On bootup, I use "hwclock -s" to sync the system time to the RTC.
Thereafter, the RTC keeps pace, but "date" starts losing time pretty
rapidly (~13 seconds per minute).

There is no interrupt from my RTC and hence updating xtime in RTC
ISR is not possible.

Is it normal for date to lose time at such a rapid pace?
If yes, what is the prefered way to keep pace (without using NTP)?

Thanks,
Sekhar Nori.
