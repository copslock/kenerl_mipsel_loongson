Received:  by oss.sgi.com id <S305162AbQEPSIg>;
	Tue, 16 May 2000 18:08:36 +0000
Received: from deliverator.sgi.com ([204.94.214.10]:19718 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305154AbQEPSIU>;
	Tue, 16 May 2000 18:08:20 +0000
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id LAA03367; Tue, 16 May 2000 11:03:29 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA51588
	for linux-list;
	Tue, 16 May 2000 11:02:58 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from virgil.engr.sgi.com (virgil.engr.sgi.com [163.154.5.20])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA22752
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 16 May 2000 11:02:58 -0700 (PDT)
	mail_from (bigham@cthulhu.engr.sgi.com)
Received: from engr.sgi.com (localhost [127.0.0.1]) by virgil.engr.sgi.com (980427.SGI.8.8.8/960327.SGI.AUTOCF) via ESMTP id LAA68442 for <linux@engr.sgi.com>; Tue, 16 May 2000 11:02:57 -0700 (PDT)
Message-ID: <39218D50.F09EBACD@engr.sgi.com>
Date:   Tue, 16 May 2000 11:02:56 -0700
From:   Nancy Bigham <bigham@cthulhu.engr.sgi.com>
Organization: Linux
X-Mailer: Mozilla 4.7C-SGI [en] (X11; I; IRIX 6.5 IP22)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux@cthulhu.engr.sgi.com
Subject: [Fwd: BOUNCE linux@relay.engr.sgi.com:    Non-member submission from 
 [Jun Sun <jsun@mvista.com>]]
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing



-------- Original Message --------
Subject: BOUNCE linux@relay.engr.sgi.com:    Non-member submission from
[Jun Sun <jsun@mvista.com>]
Date: Tue, 16 May 2000 10:49:56 -0700 (PDT)
From: owner-linux@cthulhu
To: owner-linux@cthulhu

>From owner-linux  Tue May 16 10:49:55 2000
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA52215
	for <linux@engr.sgi.com>;
	Tue, 16 May 2000 10:49:54 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from hermes.mvista.com (gateway.mvista.com [63.192.220.206]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA06183
	for <linux@engr.sgi.com>; Tue, 16 May 2000 10:49:52 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.9.3/8.9.3) with ESMTP id KAA22202;
	Tue, 16 May 2000 10:49:43 -0700
Sender: jsun@hermes.mvista.com
Message-ID: <39218A14.919D119A@mvista.com>
Date: Tue, 16 May 2000 10:49:08 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.12-20b i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: linux@engr.sgi.com, linux-mips@fnet.fr, linux-mips@vger.rutgers.edu
Subject: Re: HELP : ptrace returns puzzling results
References: <392045FC.827CACB5@mvista.com>
<20000516133620.C4561@uni-koblenz.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Ralf Baechle wrote:
> 
> On Mon, May 15, 2000 at 11:46:20AM -0700, Jun Sun wrote:
> 
> > I am writing a gdbserver for linux/mips.  The server can now talk with
> > the gdb client, and can run to completion if you press 'c'.
> 
> > reg #29 ($29,sp) = 2147483120 (0x7ffffdf0)
> 
> The value of sp looks sane, it a value near the absolute top of the stack
> at 0x80000000.
> 
> > reg #37 ($64,pc) = 263607008 (0x0fb652e0)
> 
> Also looks sane at first look, this value is in the typical address range
> where the dynamic linker gets mapped.
> 
> Many of the registers in the dump you gave have a value of zero and that is
> worrying me much more.  All the caller saved registers are zero, that
> smells.
> 

I looked at the problem again.  The registers are actually correct. 
Most registers are zero becase that is the program start up time (in
exec()). I now can set a breakpoint and run until that breakpoint.

However, step or next or setting another breakpoint do not work.  It
appears that gdbserver calls ptrace with PTRACE_SINGLESTEP option, which
is not implemented in the kernel I am using (it is v2.3.99-pre3).  Is
this implemented in the latest version?  If not, is it difficult to add
one?  Or can we get around without it?

Jun
