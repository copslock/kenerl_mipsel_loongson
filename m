Received:  by oss.sgi.com id <S42282AbQEXXIR>;
	Wed, 24 May 2000 16:08:17 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:28223 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42238AbQEXXH7>; Wed, 24 May 2000 16:07:59 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id RAA00818; Wed, 24 May 2000 17:12:38 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA62504
	for linux-list;
	Wed, 24 May 2000 16:59:16 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA35630
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 24 May 2000 16:59:14 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA07315
	for <linux@cthulhu.engr.sgi.com>; Wed, 24 May 2000 16:59:13 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-8.uni-koblenz.de (cacc-8.uni-koblenz.de [141.26.131.8])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id BAA27699;
	Thu, 25 May 2000 01:59:15 +0200 (MET DST)
Received:  by lappi.waldorf-gmbh.de id <S1405595AbQEXX6n>;
	Thu, 25 May 2000 01:58:43 +0200
Date:   Thu, 25 May 2000 01:58:43 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
Cc:     Klaus Naumann <spock@mgnet.de>, Linux MIPS <linux-mips@fnet.fr>,
        SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: CVS Update@oss.sgi.com: linux
Message-ID: <20000525015843.A7991@uni-koblenz.de>
References: <20000524012413.A5507@spock> <XFMail.000524185009.Harald.Koerfgen@home.ivm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <XFMail.000524185009.Harald.Koerfgen@home.ivm.de>; from Harald.Koerfgen@home.ivm.de on Wed, May 24, 2000 at 06:50:09PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Wed, May 24, 2000 at 06:50:09PM +0200, Harald Koerfgen wrote:

> Ok, trying to fix that I added a fastdep rule to arch/mips/tools/Makefile only to
> find myself in a catch 22 situation. offset.c includes asm/ptrace.h which, in
> turn, includes asm/offset.h, i.e. you have to have offset.h to create offset.h :-o
> 
> Without heavily messing around with several header files, which may have an
> impact on non-MIPS platforms as well, I see no easy solution for that. Adding an
> empty offset.h, on the other hand, and leaving the .cvsignore in place should at
> least partially do what I want. Any objections?
> 
> And now for something completly different. Why the hell did I mess around with
> that?
> 
> Well, if something in the kernel is changed which affects offset.h then
> generating a diff against a fresh CVS copy will contain those differences. That
> annoyed me because, personally, I find this disturbing when reviewing those diffs.
> Nobody really needs that anyway, at least that's what I thought, because offset.h
> is generated automatically.
> 
> The suggestion I made above would not solve that but at least avoids that those
> changes creep into the CVS.

A good solution is important now that we have SMP.  Toggling CONFIG_SMP
affects offset.h and not for all variations of make invocations we
actually have the guarantee that offset.h is being rebuilt before using
it.

  Ralf
