Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 May 2006 03:54:39 +0200 (CEST)
Received: from [220.76.242.187] ([220.76.242.187]:4497 "EHLO
	localhost.localdomain") by ftp.linux-mips.org with ESMTP
	id S8133510AbWEaBy3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 31 May 2006 03:54:29 +0200
Received: from mrv ([192.168.11.157])
	by localhost.localdomain (8.12.8/8.12.8) with SMTP id k4V1uNEE005785;
	Wed, 31 May 2006 10:56:26 +0900
Message-ID: <001001c68455$29746ba0$9d0ba8c0@mrv>
From:	"Roman Mashak" <mrv@corecom.co.kr>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Cc:	<linux-mips@linux-mips.org>
References: <000101c6838e$437abdf0$9d0ba8c0@mrv> <20060530140616.GA18432@linux-mips.org>
Subject: Re: compiling BCM5700 driver
Date:	Wed, 31 May 2006 10:54:31 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="ISO-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
FL-Build: Fidolook 2002 (SL) 6.0.2800.86 - 14/6/2003 22:16:25
Return-Path: <mrv@corecom.co.kr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11604
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mrv@corecom.co.kr
Precedence: bulk
X-list: linux-mips

Hello, Ralf!
You wrote to "Roman Mashak" <mrv@corecom.co.kr> on Tue, 30 May 2006 15:06:16 
+0100:

 ??>> I try to compile BCM5700 driver of gigabit ethernet card for MIPS
 ??>> target. I used both toolchains (from PMC-sierra and self-made
 ??>> following http://www.kegel.com/crosstool recommendations). Get same
 ??>> errors: In file included from mm.h:151,                from
 ??>> b57um.c:19: tigon3.h:2225: unnamed fields of type other than struct or
 ??>> union are not allowed

 RB> Broadcom's old and infamous Tigon 3 driver.  Dump it, use tg3, be
 RB> happy.
I ran across problems with Trigon3 driver working in bridge mode. Upon 
replacement it with bcm5700 - all problems have gone.
Anyway, I managed to compile driver and now I'm testing it.

I'm more concerned with Titan GE driver on "Sequoia" board (by PMC-sierra). 
What's the status of this driver in 2.4.26? If I understand correct - it's 
maintained now only in 2.6.x? Upon compilation of 2.4.26 for Sequoia" board 
and installation on to target, we observed a lot of CRC errors on gigabit 
ethernet (we used SmartBit for testing). Is the driver in this version 
broken?

With best regards, Roman Mashak.  E-mail: mrv@corecom.co.kr 
