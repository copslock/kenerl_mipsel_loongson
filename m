Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA66978 for <linux-archive@neteng.engr.sgi.com>; Thu, 18 Jun 1998 16:07:30 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA72789
	for linux-list;
	Thu, 18 Jun 1998 16:06:58 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA65263
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 18 Jun 1998 16:06:55 -0700 (PDT)
	mail_from (stuart@gnqs.org)
Received: from post.mail.demon.net (post-11.mail.demon.net [194.217.242.40]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via SMTP id QAA01025
	for <linux@cthulhu.engr.sgi.com>; Thu, 18 Jun 1998 16:06:52 -0700 (PDT)
	mail_from (stuart@gnqs.org)
Received: from (askone.demon.co.uk) [194.222.7.179] 
	by post.mail.demon.net with esmtp (Exim 1.82 #2)
	id 0ymnla-0006h4-00; Thu, 18 Jun 1998 23:06:50 +0000
Received: from myrddraal.octopus.com (myrddraal.octopus-technologies.com [172.16.1.2])
	by askone.demon.co.uk (8.8.5/8.8.5) with SMTP id XAA14542;
	Thu, 18 Jun 1998 23:05:37 GMT
From: "Stuart Herbert, GNQS Maintainer" <stuart@gnqs.org>
To: <ralf@uni-koblenz.de>
Cc: "Linux/SGI List" <linux@cthulhu.engr.sgi.com>
Subject: RE: Linux/SGI and processor sets
Date: Fri, 19 Jun 1998 00:05:37 +0100
Message-ID: <000301bd9b0d$9af576a0$020110ac@myrddraal.octopus.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
In-Reply-To: <19980618035423.A517@uni-koblenz.de>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.2106.4
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi Ralf,

> We only support the uninteresting sysmp(2) operations MP_PGSIZE,
> MP_NPROCS and MP_NAPROCS as part of the IRIX binary compatibility.

My patch covers MP_NPROCS, MP_NAPROCS, MP_EMPOWER, MP_RESTRICT,
MP_MUSTRUN, MP_RUNANYWHERE, MP_PSET (with MPPS_CREATE, MPPS_DELETE,
MPPS_ADD, MPPS_REMOVE, and my own extension MPPS_ASSIGN).

I'm sure it isn't binary compatible, but it should be
operation-compatible with sysmp(2) on IRIX, with two exceptions :

  a)  You can remove processors from the 'all' processor set
  b)  I've added MPPS_ASSIGN to the MP_PSET command to provide an API
to
      associate a process with a process ID, because I couldn't find
the
      official SG way to do this with the documentation I had.

As I say, I'm no kernel hacker, so the patch probably has race
conditions or inefficiencies which I've simply never thought of.  My
crude implementation of sysmp(2) is also achieved using a user-space
wrapper.

> We don't yet support SMP - nobody has so far provided a SMP machine
to
> me plus the hardware documentation.  However I think you might also
> consult about sysmp(2) and pset(1) with the people from
> linux-smp@vger.rutgers.edu, the stuff is definately of interest to
the
> users of Alpha, i386 and Sparc systems on which SMP is supported.

Alan's said it can go into 2.3 ... I'm digging around to find out if
anyone more competent at kernel hacking has had a go at this first,
and the Linux/SGI list seemed the most obvious place to start ;-)

> Linux/MIPS is so far not yet a very widespread OS, but if you
nevertheless
> wish to port your code to Linux/MIPS, then I as one of the core
> developers would like to offer you my support.  I'd also
> like to point out that Linux/MIPS as far as technically possible is
> binary compatible beyond the machines of just one manufacturer.
>
>   Ralf

Thank you very much.

I guess the thing to do would be if you looked at the (admittedly old)
pset patch I already have:


ftp://ftp.shef.ac.uk/pub/uni/projects/nqs/linux-smp/pset-kit-0.3.tar.g
z

Against an early 2.0 kernel, it works out-of-the-box on a
uni-processor machine if you compile the kernel to be SMP.  On a true
SMP box, it doesn't work because it doesn't use the right CPU array -
I'm told this is a trivial fix.

I don't know what your baseline kernel release is; I'd be happy to put
the time in to produce a patch against your preferred kernel sources
if it would help.

Best regards,
Stu
--
Stuart Herbert                               s.herbert@sheffield.ac.uk
Generic NQS Maintainer                      http://www.shef.ac.uk/~nqs
--
