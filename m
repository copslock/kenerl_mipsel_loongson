Received:  by oss.sgi.com id <S305155AbQCGMXx>;
	Tue, 7 Mar 2000 04:23:53 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:52752 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305154AbQCGMX0>; Tue, 7 Mar 2000 04:23:26 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id EAA01215; Tue, 7 Mar 2000 04:26:40 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id EAA60442
	for linux-list;
	Tue, 7 Mar 2000 04:08:35 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA29808
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 7 Mar 2000 04:08:22 -0800 (PST)
	mail_from (nop@nop.com)
Received: from chmls05.mediaone.net (ne.mediaone.net [24.128.1.70]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id EAA00108
	for <linux@cthulhu.engr.sgi.com>; Tue, 7 Mar 2000 04:08:17 -0800 (PST)
	mail_from (nop@nop.com)
Received: from decoy (h00a0cc39f081.ne.mediaone.net [24.218.252.183])
	by chmls05.mediaone.net (8.8.7/8.8.7) with SMTP id HAA00566;
	Tue, 7 Mar 2000 07:08:01 -0500 (EST)
Message-ID: <578601bf882d$d945f650$0a00000a@decoy>
From:   "Jay Carlson" <nop@nop.com>
To:     "Dominic Sweetman" <dom@algor.co.uk>,
        "Bradley D. LaRonde" <brad@ltc.com>
Cc:     "Andrew R. Baker" <andrewb@uab.edu>,
        "Linux SGI" <linux@cthulhu.engr.sgi.com>, <linux-mips@fnet.fr>,
        <linux-mips@vger.rutgers.edu>
References: <Pine.LNX.3.96.1000306220330.12659B-100000@lithium><097a01bf87eb$ebe4d4d0$b8119526@ltc.com> <200003071022.KAA00275@gladsmuir.algor.co.uk>
Subject: Re: FP emulation patch available
Date:   Tue, 7 Mar 2000 07:08:23 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

> Bradley D. LaRonde (brad@ltc.com) writes (re the FPA emulator out of
> Algorithmics via Kevin Kissell):
>
> > I would jump right on this but I really need it for 2.3.47+.
>
> It's good to see our donation to the Linux project being taken up
> enthusiastically , but didn't SGI have some code like this?  I mean,
> you can't have a serious MIPS run-time system without an FP emulator,
> can you?

quoting from softftp.S from 2.3.19:

 * For now it's just a crude hack good enough to run certain fp programs
like
 * Mozilla.

It's just dealing with denorms, NaNs, etc as inputs.  AFAIK NetBSD was no
better until pretty recently.

Whether Linux or NetBSD, as systems, were ever serious MIPS run-time
systems---well, you wrote the book, so I'm inclined to get out of the
argument.

>From my LinuxCE perspective, a full FP emu is fairly important for getting
binary compatibility back with mainline Linux/MIPS---we've been in the
softfp ghetto.  But most of what we do with FP is, uh, keep /bin/df happy
when it tries to calculate the percentage of free disk space, and the like.
And dropping softfp means we don't *have* to maintain a forked
toolchain/libc.

(of course, getting rid of softfp makes mips16 more...interesting...)

Jay
