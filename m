Received:  by oss.sgi.com id <S305168AbQEPUZN>;
	Tue, 16 May 2000 20:25:13 +0000
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:38417 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305167AbQEPUY7>; Tue, 16 May 2000 20:24:59 +0000
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id NAA09085; Tue, 16 May 2000 13:29:30 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA03254
	for linux-list;
	Tue, 16 May 2000 13:11:31 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA73527
	for <linux@engr.sgi.com>;
	Tue, 16 May 2000 13:11:29 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA05367
	for <linux@engr.sgi.com>; Tue, 16 May 2000 13:11:28 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-18.uni-koblenz.de (cacc-18.uni-koblenz.de [141.26.131.18])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id WAA07131;
	Tue, 16 May 2000 22:11:17 +0200 (MET DST)
Received:  by lappi.waldorf-gmbh.de id <S1403827AbQEPUKa>;
	Tue, 16 May 2000 22:10:30 +0200
Date:   Tue, 16 May 2000 22:10:30 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jun Sun <jsun@mvista.com>
Cc:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: HELP : ptrace returns puzzling results
Message-ID: <20000516221030.D6174@uni-koblenz.de>
References: <392045FC.827CACB5@mvista.com> <20000516133620.C4561@uni-koblenz.de> <39218A14.919D119A@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <39218A14.919D119A@mvista.com>; from jsun@mvista.com on Tue, May 16, 2000 at 10:49:08AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Tue, May 16, 2000 at 10:49:08AM -0700, Jun Sun wrote:

> However, step or next or setting another breakpoint do not work.  It
> appears that gdbserver calls ptrace with PTRACE_SINGLESTEP option, which
> is not implemented in the kernel I am using (it is v2.3.99-pre3).  Is
> this implemented in the latest version?  If not, is it difficult to add
> one?  Or can we get around without it?

PTRACE_SINGLESTEP is meant to be implemented using hardware single stepping.
That's something which most MIPS CPUs don't support.  It can be simulated in
userspace, so there is no point in putting it into the kernel ergo we won't
implement it.

There's actually a good number of CPUs which don't have hardware breakpoints
so you should check what gdbserver does for those other architectures.
The generic solution is to write a breakpoint into the logically next
instruction(s).  Usually that's at epc + 4 but there are branch instructions
to make live more entertaining ...

  Ralf
