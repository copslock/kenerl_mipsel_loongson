Received:  by oss.sgi.com id <S305158AbQCMIoU>;
	Mon, 13 Mar 2000 00:44:20 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:20515 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305156AbQCMIoC>; Mon, 13 Mar 2000 00:44:02 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id AAA05367; Mon, 13 Mar 2000 00:47:23 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id AAA47871
	for linux-list;
	Mon, 13 Mar 2000 00:29:57 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id AAA14959
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 13 Mar 2000 00:29:53 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id AAA04390
	for <linux@cthulhu.engr.sgi.com>; Mon, 13 Mar 2000 00:29:53 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (newman [206.31.31.8])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id AAA13762;
	Mon, 13 Mar 2000 00:29:51 -0800 (PST)
Received: from satanas (satanas [192.168.236.12])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id AAA12558;
	Mon, 13 Mar 2000 00:29:49 -0800 (PST)
Message-ID: <002701bf8cc6$c2ef0200$0ceca8c0@satanas.mips.com>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Harald Koerfgen" <Harald.Koerfgen@home.ivm.de>
Cc:     <linux-mips@vger.rutgers.edu>, <linux-mips@fnet.fr>,
        "Linux SGI" <linux@cthulhu.engr.sgi.com>
Subject: Re: FP emulation patch available
Date:   Mon, 13 Mar 2000 09:33:02 +0100
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

As Ralf just reminded me by email, the Algorithmics/MIPS
kernel FPU emulator is *not* SMP-safe.  It borrows an existing
(if seldom used) exception handler, and has only a single
set of emulated FPU registers.  I sort-of knew this, but
had not worried about it, since to the best of my knowledge
no one is building (or has built) SMP MIPS machines 
out of FPU-less processors.  Nevertheless, a compile-time
test, to blow up on any attempt at an SMP build of the 
emulator should always have been there, and is going in 
right away.

Does anyone out there actually need/want an SMP
version of the emulator?   It's not completely trivial,
but it would not be all that difficult to do...

            Regards,

            Kevin K.
__

Kevin D. Kissell
MIPS Technologies European Architecture Lab
kevink@mips.com
Tel. +33.4.78.38.70.67
FAX. +33.4.78.38.70.68
