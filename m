Received:  by oss.sgi.com id <S305162AbQEOVhn>;
	Mon, 15 May 2000 21:37:43 +0000
Received: from deliverator.sgi.com ([204.94.214.10]:56403 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305154AbQEOVhW>;
	Mon, 15 May 2000 21:37:22 +0000
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id OAA02530; Mon, 15 May 2000 14:32:31 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA45488
	for linux-list;
	Mon, 15 May 2000 14:33:11 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA17609
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 15 May 2000 14:33:08 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA00597
	for <linux@cthulhu.engr.sgi.com>; Mon, 15 May 2000 14:33:07 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-4.uni-koblenz.de (cacc-4.uni-koblenz.de [141.26.131.4])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id XAA18735;
	Mon, 15 May 2000 23:33:08 +0200 (MET DST)
Received:  by lappi.waldorf-gmbh.de id <S1403827AbQEOVct>;
	Mon, 15 May 2000 23:32:49 +0200
Date:   Mon, 15 May 2000 23:32:49 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Peter Popov <ppopov@redcreek.com>
Cc:     "linux@engr.sgi.com" <linux@cthulhu.engr.sgi.com>
Subject: Re: general mips question
Message-ID: <20000515233249.F1682@uni-koblenz.de>
References: <3920677D.221EC442@redcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3920677D.221EC442@redcreek.com>; from ppopov@redcreek.com on Mon, May 15, 2000 at 02:09:17PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Mon, May 15, 2000 at 02:09:17PM -0700, Peter Popov wrote:

> Is it possible to "walk" the stack on a mips system after a crash to
> figure out all the functions which were called upto and including the
> function where the crash occurred?  For example, I can do that on an
> i960 system because of the help I get from the cpu in creating a stack
> and saving some registers for every function call.  If A called B which
> called C which called D, I can walk the stack on an i960 system and
> figure out how I got to D. But I can't quite figure out how to do that
> in software on a mips system.  All I can get is the return address of
> the current function -- eg if the system crashed in D, all I can get is
> the return address which is somewhere in function C.  Any ideas?

Well, you couldn't figure out simply because it's not possible to unwind
MIPS stackframes without the help of debug information or doing stunts
like analysing the code of the returning function.  A reasonable heuristic
should be to search the stack for words that have valid text addresses
in them.

  Ralf
