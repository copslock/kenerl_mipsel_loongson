Received:  by oss.sgi.com id <S305172AbQAMAjZ>;
	Wed, 12 Jan 2000 16:39:25 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:13874 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305154AbQAMAjI>; Wed, 12 Jan 2000 16:39:08 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id QAA08496; Wed, 12 Jan 2000 16:42:46 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA86302
	for linux-list;
	Wed, 12 Jan 2000 16:30:00 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA63329
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 12 Jan 2000 16:29:58 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA07304
	for <linux@cthulhu.engr.sgi.com>; Wed, 12 Jan 2000 16:29:56 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-14.uni-koblenz.de (cacc-14.uni-koblenz.de [141.26.131.14])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id BAA14364;
	Thu, 13 Jan 2000 01:29:53 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407891AbQAMAUd>;
	Thu, 13 Jan 2000 01:20:33 +0100
Date:   Thu, 13 Jan 2000 01:20:33 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Harald Koerfgen <Harald.Koerfgen@home.ivm.de>,
        linux@cthulhu.engr.sgi.com
Subject: Re: kernel sources?
Message-ID: <20000113012033.A29273@uni-koblenz.de>
References: <XFMail.000111194757.Harald.Koerfgen@home.ivm.de> <Pine.LNX.4.05.10001120953200.29324-100000@callisto.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <Pine.LNX.4.05.10001120953200.29324-100000@callisto.of.borg>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Wed, Jan 12, 2000 at 09:57:41AM +0100, Geert Uytterhoeven wrote:

> Thanks! But unfortunately it doesn't fix all problems:
> 
> serial.c: In function `line_info':
> serial.c:3078: warning: long unsigned int format, unsigned int arg (arg 5)
> serial.c: In function `autoconfig':
> serial.c:3430: `ASYNC_IOC3' undeclared (first use this function)
> serial.c:3430: (Each undeclared identifier is reported only once
> serial.c:3430: for each function it appears in.)
> serial.c: In function `rs_init':
> serial.c:3999: `ASYNC_IOC3' undeclared (first use this function)
> serial.c:4015: warning: long unsigned int format, unsigned int arg (arg 4)
> 
> I think some #ifdef CONFIG_SGI_IP27/#endif is missing there.

Thanks for reporting!  What's actually missing is the definition of this
flag in include/linux/serial.h.

  Ralf
