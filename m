Received:  by oss.sgi.com id <S42256AbQG0XuV>;
	Thu, 27 Jul 2000 16:50:21 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:39967 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42222AbQG0XuH>;
	Thu, 27 Jul 2000 16:50:07 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id QAA28726
	for <linux-mips@oss.sgi.com>; Thu, 27 Jul 2000 16:42:42 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id QAA06538 for <linux-mips@oss.sgi.com>; Thu, 27 Jul 2000 16:49:41 -0700 (PDT)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA45191
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 27 Jul 2000 16:48:09 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from hermes.mvista.com (gateway-490.mvista.com [63.192.220.206]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA04688
	for <linux@cthulhu.engr.sgi.com>; Thu, 27 Jul 2000 16:48:09 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.9.3/8.9.3) with ESMTP id QAA24193;
	Thu, 27 Jul 2000 16:46:58 -0700
Message-ID: <3980C9F0.96B48253@mvista.com>
Date:   Thu, 27 Jul 2000 16:46:56 -0700
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.12-20b i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     Keith M Wesolowski <wesolows@chem.unr.edu>
CC:     linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Subject: Re: strace on Linux/MIPS?
References: <3980C024.8DCCA084@mvista.com> <20000727161212.B12897@chem.unr.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Keith M Wesolowski wrote:
> 
> On Thu, Jul 27, 2000 at 04:05:08PM -0700, Jun Sun wrote:
> 
> > Has anybody been successful in trying to get strace running on
> > Linux/MIPS?  I managed to get 4.2, with a little from CVS tree, compiled
> > and run.  However, it does not quite right.  It only prints the first
> > system. See below.  Verified that this is the same behavior on both
> > 2.3.99-pre3 and 2.4.0-test2.
> 
> Your kernel is too old.

Wow, a couple days is "too old".  I guest that is Linux speed.

> Ralf fixed some things in ptrace a few days
> ago. 

Great!  Can you pinpoint the related files?  I took a snapshot of CVS on
6/27 and hacked heavily to get it work on my NEC board.  It would be
very difficult for me to move to the new kernel.  It would be better if
I can just reverse-merge with the related changes.

Jun
