Received:  by oss.sgi.com id <S305163AbQESO4Z>;
	Fri, 19 May 2000 14:56:25 +0000
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:12584 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305155AbQESO4M>; Fri, 19 May 2000 14:56:12 +0000
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id IAA08489; Fri, 19 May 2000 08:00:41 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id HAA66528; Fri, 19 May 2000 07:55:36 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA00909
	for linux-list;
	Fri, 19 May 2000 07:31:39 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA92318
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 19 May 2000 07:31:33 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA08133
	for <linux@cthulhu.engr.sgi.com>; Fri, 19 May 2000 07:31:32 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-21.uni-koblenz.de (cacc-21.uni-koblenz.de [141.26.131.21])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id QAA15900;
	Fri, 19 May 2000 16:31:25 +0200 (MET DST)
Received:  by lappi.waldorf-gmbh.de id <S1405598AbQESMhh>;
	Fri, 19 May 2000 14:37:37 +0200
Date:   Fri, 19 May 2000 14:37:37 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Guido Guenther <guido.guenther@uni-konstanz.de>,
        linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Subject: Re: SIGIO Handler
Message-ID: <20000519143737.C1244@uni-koblenz.de>
References: <20000518161135.A26055@bert.physik.uni-konstanz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20000518161135.A26055@bert.physik.uni-konstanz.de>; from agx@bert.physik.uni-konstanz.de on Thu, May 18, 2000 at 04:11:36PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Thu, May 18, 2000 at 04:11:36PM +0200, Guido Guenther wrote:

> I'm still trying to get the mouse to work under X. The problem seems not
> to be related to X itself but to a kernel/glibc problem. X uses a SIGIO
> handler to "get notified" about mouse events. I wrote my own small SIGIO
> handler(see attached program) which works fine on my intel box but not
> on an indy (glibc-2.0.6-3lm/linux-2.2.13-20000211). Could please someone
> else run the attached program on mips/mipsel and check if it works or
> give me a hint where to start to look for the problem.

Sigh...  Looking at this the first thing I noticed was that the ancient
strace that probably most of us are using prints wrong signal names and
in general seems to have problems.  Maybe I even just found the source of
a good fraction of the GDB problems.  Affects both mips and mips64.
Looking at those ptrace problems first ...

  Ralf
