Received:  by oss.sgi.com id <S42271AbQG1CRW>;
	Thu, 27 Jul 2000 19:17:22 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:37686 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42222AbQG1CRS>;
	Thu, 27 Jul 2000 19:17:18 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id TAA10773
	for <linux-mips@oss.sgi.com>; Thu, 27 Jul 2000 19:09:47 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id TAA49864 for <linux-mips@oss.sgi.com>; Thu, 27 Jul 2000 19:15:32 -0700 (PDT)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id TAA82025
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 27 Jul 2000 19:13:59 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from hermes.mvista.com (gateway-490.mvista.com [63.192.220.206]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id TAA08105
	for <linux@cthulhu.engr.sgi.com>; Thu, 27 Jul 2000 19:13:59 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.9.3/8.9.3) with ESMTP id TAA30244;
	Thu, 27 Jul 2000 19:12:47 -0700
Message-ID: <3980EC1C.AEF173D2@mvista.com>
Date:   Thu, 27 Jul 2000 19:12:44 -0700
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.12-20b i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     Ralf Baechle <ralf@oss.sgi.com>
CC:     Keith M Wesolowski <wesolows@chem.unr.edu>, linux-mips@fnet.fr,
        linux@cthulhu.engr.sgi.com
Subject: Re: strace on Linux/MIPS?
References: <3980C024.8DCCA084@mvista.com> <20000727161212.B12897@chem.unr.edu> <3980C9F0.96B48253@mvista.com> <20000728021137.B1328@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Ralf Baechle wrote:
> 
> > > Ralf fixed some things in ptrace a few days
> > > ago.
> >
> > Great!  Can you pinpoint the related files?  I took a snapshot of CVS on
> > 6/27 and hacked heavily to get it work on my NEC board.  It would be
> > very difficult for me to move to the new kernel.  It would be better if
> > I can just reverse-merge with the related changes.
> 
> arch/mips/kernel/scall_o32.S
> arch/mips/tools/offset.c
> arch/mips64/kernel/scall_64.S
> arch/mips64/kernel/scall_o32.S
> arch/mips64/tools/offset.c
> 
>   Ralf

I just updated offset.c and scall_o32.S.  After a trial change ("nice"
-> "priority") in offset.c, strace seems to work fine now.

However, I did notice an error message for mmap(...).

mmap(ptrace: umoven: Input/output error
ptrace: umoven: Input/output error
)                                  = 717291520

Keith, if you want the patch for strace 4.2, I can send it to you.  

Jun
