Received:  by oss.sgi.com id <S305162AbQEOVOd>;
	Mon, 15 May 2000 21:14:33 +0000
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:56873 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305154AbQEOVOM>; Mon, 15 May 2000 21:14:12 +0000
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id OAA07259; Mon, 15 May 2000 14:18:42 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id OAA81021; Mon, 15 May 2000 14:13:41 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA19842
	for linux-list;
	Mon, 15 May 2000 14:07:56 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA70773
	for <linux@engr.sgi.com>;
	Mon, 15 May 2000 14:07:55 -0700 (PDT)
	mail_from (ppopov@redcreek.com)
Received: from exchange.redcreek.com (mail.redcreek.com [209.125.38.15]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA06262
	for <linux@engr.sgi.com>; Mon, 15 May 2000 14:07:50 -0700 (PDT)
	mail_from (ppopov@redcreek.com)
Received: from redcreek.com (host120.redcreek.com [209.218.26.120]) by exchange.redcreek.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2650.21)
	id KCP8VDLF; Mon, 15 May 2000 14:07:34 -0700
Message-ID: <3920677D.221EC442@redcreek.com>
Date:   Mon, 15 May 2000 14:09:17 -0700
From:   Peter Popov <ppopov@redcreek.com>
Organization: RedCreek Communications
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.12-20 i686)
X-Accept-Language: bg, en
MIME-Version: 1.0
To:     "linux@engr.sgi.com" <linux@cthulhu.engr.sgi.com>
Subject: general mips question
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


Is it possible to "walk" the stack on a mips system after a crash to
figure out all the functions which were called upto and including the
function where the crash occurred?  For example, I can do that on an
i960 system because of the help I get from the cpu in creating a stack
and saving some registers for every function call.  If A called B which
called C which called D, I can walk the stack on an i960 system and
figure out how I got to D. But I can't quite figure out how to do that
in software on a mips system.  All I can get is the return address of
the current function -- eg if the system crashed in D, all I can get is
the return address which is somewhere in function C.  Any ideas?

Thanks,

Pete
