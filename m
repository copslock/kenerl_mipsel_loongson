Received:  by oss.sgi.com id <S305158AbQCMXgA>;
	Mon, 13 Mar 2000 15:36:00 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:49791 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305156AbQCMXfs>; Mon, 13 Mar 2000 15:35:48 -0800
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id PAA09819; Mon, 13 Mar 2000 15:39:09 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id PAA68297; Mon, 13 Mar 2000 15:35:47 -0800 (PST)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA36003
	for linux-list;
	Mon, 13 Mar 2000 15:19:22 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA98779
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 13 Mar 2000 15:19:07 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA09056
	for <linux@cthulhu.engr.sgi.com>; Mon, 13 Mar 2000 15:19:07 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (newman [206.31.31.8])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id PAA29449;
	Mon, 13 Mar 2000 15:18:59 -0800 (PST)
Received: from Ulysses (par-c45-004-vty236.as.wcom.net [195.232.68.236])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id PAA24576;
	Mon, 13 Mar 2000 15:18:49 -0800 (PST)
Message-ID: <005a01bf8d42$c656d2c0$ec44e8c3@Ulysses>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Harald Koerfgen" <Harald.Koerfgen@home.ivm.de>
Cc:     "Linux SGI" <linux@cthulhu.engr.sgi.com>,
        "Linux/MIPS fnet" <linux-mips@fnet.fr>,
        <linux-mips@vger.rutgers.edu>
Subject: Re: FP emulation patch available
Date:   Tue, 14 Mar 2000 00:20:36 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3110.1
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Herald Koerfgen writes:
>Personally, I don't have any idea why the emulator works perfectly on an
R3000
>but not on an R3912.

Nor I, but in the absence of data, I'm happy to speculate.  ;-)
...
>Oh I see, I should have made myself more clear. I have a root filesystem on
a
>CF card based on declinuxroot (a cut down RedHat 5.1) and my Mobilon boots
all
>the way through to the login prompt if I delete the fsck from the
initscripts.
>
>Booting into single user mode I can easily verify that tools like df or
e2fsck
>are bombing out with floating point exeptions. My "tests" with the emulator
>have been so far: Does df survive? What does fsck do? and things like that.
>Well, with the emulator all these tools make the Mobilon crash. Hard. So
hard
>that even the reset button doesn't work.


There are two ways in which the FPU emulator is close enough
to the hardware to be this sensitive to implementation.  One
is the way the emulator provokes an address error exception to
execute a delay slot instruction following a simulated branch, but
I don't think df or fsck do any branch-on-floating-conditions.  The
other is, of course, that it counts on getting sensible and recoverable
coprocessor unusable exceptions.  If the R3912 does something
funky to the processor state on a CP1 unusable fault - an event
that it doesn't have to deal with in its principal mission
as a Windows CE platform - the results would be much
what you are seeing.

There are people at Toshiba who read this mailing
list, so we can hope that they too are on the case and
can maybe lend a clue...

            Regards,

            Kevin K.
