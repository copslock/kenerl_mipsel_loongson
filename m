Received:  by oss.sgi.com id <S305166AbPLFUYH>;
	Mon, 6 Dec 1999 12:24:07 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:19555 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305158AbPLFUXr>; Mon, 6 Dec 1999 12:23:47 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id MAA01488; Mon, 6 Dec 1999 12:32:38 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA85964
	for linux-list;
	Mon, 6 Dec 1999 12:23:52 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA84072
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 6 Dec 1999 12:23:49 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA09650
	for <linux@cthulhu.engr.sgi.com>; Mon, 6 Dec 1999 12:23:48 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (newman [206.31.31.8])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id MAA14189;
	Mon, 6 Dec 1999 12:23:47 -0800 (PST)
Received: from satanas (fr-host2 [192.168.236.12])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id MAA11604;
	Mon, 6 Dec 1999 12:23:45 -0800 (PST)
Message-ID: <012901bf4029$2e465020$0ceca8c0@satanas.mips.com>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Ralf Baechle" <ralf@oss.sgi.com>
Cc:     "Linux SGI" <linux@cthulhu.engr.sgi.com>
Subject: Re: Kernel Semaphores
Date:   Mon, 6 Dec 1999 21:33:38 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3110.5
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

>> To make it work on 32-bit CPUs, I looked at using
>> the x386 model, but that one uses interrupt disables
>> and is intrinsically SMP-unsafe.
>
>semaphore-helper.h uses spin_lock_irqsave which is smp-safe.  The way
>we do things for 64-bit MIPS is just more performant.


spin_lock_irqsave() in 2.2.12 for MIPS is just a save_and_cli().
The MIPS spin_lock macros all collapse the lock into nothingness.
