Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA86464 for <linux-archive@neteng.engr.sgi.com>; Tue, 21 Jul 1998 11:28:06 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA84453
	for linux-list;
	Tue, 21 Jul 1998 11:27:18 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA85029
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 21 Jul 1998 11:27:17 -0700 (PDT)
	mail_from (ralf@mailhost.uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA06212
	for <linux@cthulhu.engr.sgi.com>; Tue, 21 Jul 1998 11:27:15 -0700 (PDT)
	mail_from (ralf@mailhost.uni-koblenz.de)
Received: from zaphod (ralf@zaphod.uni-koblenz.de [141.26.4.13])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with SMTP id UAA00449;
	Tue, 21 Jul 1998 20:27:01 +0200 (MEST)
Received: by zaphod (SMI-8.6/KO-2.0)
	id UAA25174; Tue, 21 Jul 1998 20:26:58 +0200
Message-ID: <19980721202658.37672@uni-koblenz.de>
Date: Tue, 21 Jul 1998 20:26:58 +0200
From: ralf@uni-koblenz.de
To: eak@detroit.sgi.com
Cc: Mike Shaver <shaver@netscape.com>,
        SGI/Linux mailing list <linux@cthulhu.engr.sgi.com>
Subject: Re: Xwindows status?
References: <Pine.LNX.3.95.980721093249.5677D-100000@thebrain> <35B4D431.F77FB01B@detroit.sgi.com> <35B4D6A8.811A9941@netscape.com> <35B4DA52.A17C32A7@detroit.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
In-Reply-To: <35B4DA52.A17C32A7@detroit.sgi.com>; from Eric Kimminau on Tue, Jul 21, 1998 at 02:13:38PM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Jul 21, 1998 at 02:13:38PM -0400, Eric Kimminau wrote:

> and
> [root@linux RPMS]# rpm -Uvh --force pythonlib-1.22-1.noarch.rpm 
> package pythonlib-1.22-1 is for a different architecture
> error: pythonlib-1.22-1.noarch.rpm cannot be installed
> 
> and
> 
> [root@linux RPMS]# rpm -Uvh --force tksysv-1.0-3.noarch.rpm 
> package tksysv-1.0-3 is for a different architecture
> error: tksysv-1.0-3.noarch.rpm cannot be installed
> 
> although I believe this last one might be intentional, is there a reason
> to include it if it is unuseable?

--force won't force the installation, you have to use --ignorearch if
you want to force installation of a package of the other architecture.
This is a known glitch in HH; Alex is investigating the source of the
problem.

  Ralf
