Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5OBxinC026692
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 24 Jun 2002 04:59:44 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5OBxiEM026691
	for linux-mips-outgoing; Mon, 24 Jun 2002 04:59:44 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (ftp.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5OBxcnC026682;
	Mon, 24 Jun 2002 04:59:38 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id FAA11415;
	Mon, 24 Jun 2002 05:02:49 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id FAA01432;
	Mon, 24 Jun 2002 05:02:49 -0700 (PDT)
Message-ID: <00ee01c21b77$18522510$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   "Carsten Langgaard" <carstenl@mips.com>
Cc: "Ralf Baechle" <ralf@oss.sgi.com>, <linux-mips@oss.sgi.com>
References: <Pine.GSO.3.96.1020624133501.22509K-100000@delta.ds2.pg.gda.pl>
Subject: Re: sys_syscall patch.
Date: Mon, 24 Jun 2002 14:02:49 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
> On Mon, 24 Jun 2002, Carsten Langgaard wrote:
> 
> > > What programs btw are using syscall()?  To be honest I don't recall one ...
> > 
> > /sbin/rpc.lockd.
> > It use syscall() to indirectly call the 'sys_nfsservctl' syscall, why it
> > doesn't do the syscall directly is beyond me.

I can only speculate that at the time it was written, there was not
a universally respected library binding to get to the direct syscall.

>  Hmm, shouldn't syscall() be a library wrapper?  I think we should kill
> sys_syscall(). 

While I agree that rpc.lockd should directly invoke the desired
system call if possible, having an indirect system call mechanism
is something that has proved useful to me in the past on other
Unices, and I would rather see it fixed than discarded.

            Kevin K.
