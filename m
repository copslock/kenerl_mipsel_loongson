Received:  by oss.sgi.com id <S42266AbQG1AOk>;
	Thu, 27 Jul 2000 17:14:40 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:59244 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42222AbQG1AOX>; Thu, 27 Jul 2000 17:14:23 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id RAA01709
	for <linux-mips@oss.sgi.com>; Thu, 27 Jul 2000 17:20:15 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id RAA15363 for <linux-mips@oss.sgi.com>; Thu, 27 Jul 2000 17:13:51 -0700 (PDT)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA52799
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 27 Jul 2000 17:12:19 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from u-151.karlsruhe.ipdial.viaginterkom.de (u-151.karlsruhe.ipdial.viaginterkom.de [62.180.19.151]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA03025
	for <linux@cthulhu.engr.sgi.com>; Thu, 27 Jul 2000 17:12:15 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S868870AbQG1ALh>;
        Fri, 28 Jul 2000 02:11:37 +0200
Date:   Fri, 28 Jul 2000 02:11:37 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jun Sun <jsun@mvista.com>
Cc:     Keith M Wesolowski <wesolows@chem.unr.edu>, linux-mips@fnet.fr,
        linux@cthulhu.engr.sgi.com
Subject: Re: strace on Linux/MIPS?
Message-ID: <20000728021137.B1328@bacchus.dhis.org>
References: <3980C024.8DCCA084@mvista.com> <20000727161212.B12897@chem.unr.edu> <3980C9F0.96B48253@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3980C9F0.96B48253@mvista.com>; from jsun@mvista.com on Thu, Jul 27, 2000 at 04:46:56PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Jul 27, 2000 at 04:46:56PM -0700, Jun Sun wrote:

> > > Has anybody been successful in trying to get strace running on
> > > Linux/MIPS?  I managed to get 4.2, with a little from CVS tree, compiled
> > > and run.  However, it does not quite right.  It only prints the first
> > > system. See below.  Verified that this is the same behavior on both
> > > 2.3.99-pre3 and 2.4.0-test2.
> > 
> > Your kernel is too old.
> 
> Wow, a couple days is "too old".  I guest that is Linux speed.

Software is like fish, it starts to smell soon :-)

> > Ralf fixed some things in ptrace a few days
> > ago. 
> 
> Great!  Can you pinpoint the related files?  I took a snapshot of CVS on
> 6/27 and hacked heavily to get it work on my NEC board.  It would be
> very difficult for me to move to the new kernel.  It would be better if
> I can just reverse-merge with the related changes.

arch/mips/kernel/scall_o32.S
arch/mips/tools/offset.c
arch/mips64/kernel/scall_64.S
arch/mips64/kernel/scall_o32.S
arch/mips64/tools/offset.c

  Ralf
