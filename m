Received:  by oss.sgi.com id <S305166AbPLFKF2>;
	Mon, 6 Dec 1999 02:05:28 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:36357 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305158AbPLFKFF>;
	Mon, 6 Dec 1999 02:05:05 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id CAA21317; Mon, 6 Dec 1999 02:08:05 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id BAA69184
	for linux-list;
	Mon, 6 Dec 1999 01:48:26 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id BAA69850
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 6 Dec 1999 01:48:21 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id BAA00981
	for <linux@cthulhu.engr.sgi.com>; Mon, 6 Dec 1999 01:48:20 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (newman [206.31.31.8])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id BAA03614
	for <linux@cthulhu.engr.sgi.com>; Mon, 6 Dec 1999 01:48:18 -0800 (PST)
Received: from satanas (fr-host2 [192.168.236.12])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id BAA26302
	for <linux@cthulhu.engr.sgi.com>; Mon, 6 Dec 1999 01:48:16 -0800 (PST)
Message-ID: <004c01bf3fd0$68336790$0ceca8c0@satanas.mips.com>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Linux SGI" <linux@cthulhu.engr.sgi.com>
Subject: Question for David Miller or anyone else about R6000 code
Date:   Mon, 6 Dec 1999 10:58:10 +0100
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

I tried sending this to David Miller at his SGI email
address, just in case it would work.  Of course, it
didn't.  David, if you are reading this mailing list,
I'd appreciate your comments.  And anyone else
having knowledge should feel free to respond as
well!

David:

I don't know that you are still at SGI - indeed, with
all the changes in recent months, I would be a bit
surprised if you were - but this is the last email
address I have for you.

I'm working on cleaning up and enhancing the
MIPS/Linux code to support the new families
of CPUs coming out of MIPS Technologies Inc.
In doing so, I've come across and fixed a number
of bugs, most of which I've also passed back to
Ralf Baechle for integration with the moving
target at linux.sgi.com.   But I came across 
something this morning that, while not a problem
for us, puzzles me.   In arch/mips/mm/r6000.c,
which has your name on it, there is a compiler
directive to use MIPS III instructions, and the
resulting code does indeed end up containing
64-bit (daddiu, etc.) instructions.   I've never
actually programmed an R6000, but all of the
information I have on that processor indicates
that it is a MIPS II, 32-bit design, and that those
instructions should therefore cause exceptions.

Am I mistaken, or is that directive a bug?

            Regards,

            Kevin K.
__

Kevin D. Kissell
MIPS Technologies European Architecture Lab
kevink@mips.com
Tel. +33.4.78.38.70.67
FAX. +33.4.78.38.70.68
