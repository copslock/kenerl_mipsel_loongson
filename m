Received:  by oss.sgi.com id <S305155AbQAGXje>;
	Fri, 7 Jan 2000 15:39:34 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:32026 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305154AbQAGXjM>;
	Fri, 7 Jan 2000 15:39:12 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id PAA19311; Fri, 7 Jan 2000 15:35:46 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA93404
	for linux-list;
	Fri, 7 Jan 2000 15:32:23 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA91306;
	Fri, 7 Jan 2000 15:32:16 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA02469; Fri, 7 Jan 2000 15:32:03 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-9.uni-koblenz.de (cacc-9.uni-koblenz.de [141.26.131.9])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id AAA24432;
	Sat, 8 Jan 2000 00:31:56 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407891AbQAGX3L>;
	Sat, 8 Jan 2000 00:29:11 +0100
Date:   Sat, 8 Jan 2000 00:29:11 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
Cc:     "William J. Earl" <wje@cthulhu.engr.sgi.com>,
        linux@cthulhu.engr.sgi.com, Florian Lohoff <flo@rfc822.org>,
        "Kevin D. Kissell" <kevink@mips.com>
Subject: Re: Decstation 5000/150 2.3.21 Boot successs
Message-ID: <20000108002911.B20825@uni-koblenz.de>
References: <14452.58782.750095.352886@liveoak.engr.sgi.com> <XFMail.000107200905.Harald.Koerfgen@home.ivm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <XFMail.000107200905.Harald.Koerfgen@home.ivm.de>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Fri, Jan 07, 2000 at 08:09:05PM +0100, Harald Koerfgen wrote:

> On 06-Jan-00 William J. Earl wrote:
> >      Note that the SVR4 MIPS ABI assumes FR=0 (R3000-compatible), as
> > do SGI IRIX "-32" ("O32") binaries (and, I believe, default gcc
> > binaries).  SGI IRIX "-n32" and "-n64" binaries assumes FR=1
> > (R4000-compatible), and also have a somewhat different register calling
> > convention (which affects where arguments to system calls reside).
> 
> Wouldn't it make sense then if we made FR=0 the default for Linux/MIPS?

Obviously; you can clear that flag painless somewhere in
arch/mips/kernel/traps.c only for those CPUs that actually have it.

  Ralf
