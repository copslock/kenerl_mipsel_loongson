Received:  by oss.sgi.com id <S42292AbQEXRGp>;
	Wed, 24 May 2000 10:06:45 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:32842 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42277AbQEXRGZ>;
	Wed, 24 May 2000 10:06:25 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id KAA21797; Wed, 24 May 2000 10:01:33 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id KAA49020; Wed, 24 May 2000 10:04:39 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA24354
	for linux-list;
	Wed, 24 May 2000 09:50:46 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA94838
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 24 May 2000 09:50:43 -0700 (PDT)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from mail.ivm.net (mail.ivm.net [62.204.1.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA03402
	for <linux@cthulhu.engr.sgi.com>; Wed, 24 May 2000 09:50:41 -0700 (PDT)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from franz.no.dom (port9.duesseldorf.ivm.de [195.247.65.9])
	by mail.ivm.net (8.8.8/8.8.8) with ESMTP id SAA03154;
	Wed, 24 May 2000 18:50:28 +0200
X-To:   linux@cthulhu.engr.sgi.com
Message-ID: <XFMail.000524185009.Harald.Koerfgen@home.ivm.de>
X-Mailer: XFMail 1.4.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20000524012413.A5507@spock>
Date:   Wed, 24 May 2000 18:50:09 +0200 (CEST)
Reply-To: Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
Organization: none
From:   Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
To:     Klaus Naumann <spock@mgnet.de>
Subject: RE: CVS Update@oss.sgi.com: linux
Cc:     Linux MIPS <linux-mips@fnet.fr>,
        SGI Linux <linux@cthulhu.engr.sgi.com>
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


On 23-May-00 Klaus Naumann wrote:
[offset.h problems with my recent CVS changes snipped]

> Well, unfortunately this doesn't fix the problem.
> At least not for me. I get the same error I 
> stated a mail ago - offset.h is generated after 
> the use in main.c .

Ok, trying to fix that I added a fastdep rule to arch/mips/tools/Makefile only to
find myself in a catch 22 situation. offset.c includes asm/ptrace.h which, in
turn, includes asm/offset.h, i.e. you have to have offset.h to create offset.h :-o

Without heavily messing around with several header files, which may have an
impact on non-MIPS platforms as well, I see no easy solution for that. Adding an
empty offset.h, on the other hand, and leaving the .cvsignore in place should at
least partially do what I want. Any objections?

And now for something completly different. Why the hell did I mess around with
that?

Well, if something in the kernel is changed which affects offset.h then
generating a diff against a fresh CVS copy will contain those differences. That
annoyed me because, personally, I find this disturbing when reviewing those diffs.
Nobody really needs that anyway, at least that's what I thought, because offset.h
is generated automatically.

The suggestion I made above would not solve that but at least avoids that those
changes creep into the CVS.

-- 
Regards,
Harald
