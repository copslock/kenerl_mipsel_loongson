Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id OAA16630
	for <pstadt@stud.fh-heilbronn.de>; Thu, 29 Jul 1999 14:50:25 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id FAA17732; Thu, 29 Jul 1999 05:45:27 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id FAA89131
	for linux-list;
	Thu, 29 Jul 1999 05:37:48 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id FAA68759
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 29 Jul 1999 05:37:46 -0700 (PDT)
	mail_from (mkomiya@crossnet.co.jp)
Received: from crossnet.co.jp ([210.232.77.94]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id FAA08374
	for <linux@cthulhu.engr.sgi.com>; Thu, 29 Jul 1999 05:37:31 -0700 (PDT)
	mail_from (mkomiya@crossnet.co.jp)
Received: from crossnet.co.jp (nimbus [192.168.77.96])
	by crossnet.co.jp (8.8.7/3.6Wbeta6) with ESMTP id MAA11267
	for <linux@cthulhu.engr.sgi.com>; Thu, 29 Jul 1999 12:36:21 +0900
Message-ID: <37A04B51.E1B39DC1@crossnet.co.jp>
Date: Thu, 29 Jul 1999 21:38:41 +0900
From: Masami Komiya <mkomiya@crossnet.co.jp>
X-Mailer: Mozilla 4.5 [ja] (Win98; I)
X-Accept-Language: ja
MIME-Version: 1.0
To: Linux/Mips <linux@cthulhu.engr.sgi.com>
Subject: set_rtc_mmss() of arch/mips/kenrel/time.c
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk
Content-Transfer-Encoding: 7bit

I'm reading kernel source for mips architecture. But can not 
realize the meaning of the following part of set_rtc_mmss() function
in arch/mips/kenrel/time.c

static int set_rtc_mmss(unsigned long nowtime)
{

			:

	/*
	 * since we're only adjusting minutes and seconds,
	 * don't interfere with hour overflow. This avoids
	 * messing with unknown time zones but requires your
	 * RTC not to be off by more than 15 minutes
	 */
	real_seconds = nowtime % 60;
	real_minutes = nowtime / 60;
	if (((abs(real_minutes - cmos_minutes) + 15)/30) & 1)
		real_minutes += 30;		/* correct for half hour time zone */
	real_minutes %= 60;

			:

Please anyone explain me.

Thank you.

Masami Komiya
