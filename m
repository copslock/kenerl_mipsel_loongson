Received:  by oss.sgi.com id <S305167AbQBSA4p>;
	Fri, 18 Feb 2000 16:56:45 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:63854 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305163AbQBSA4L>; Fri, 18 Feb 2000 16:56:11 -0800
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id QAA02199; Fri, 18 Feb 2000 16:59:07 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id QAA94119; Fri, 18 Feb 2000 16:56:10 -0800 (PST)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA15638
	for linux-list;
	Fri, 18 Feb 2000 16:42:02 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA24278;
	Fri, 18 Feb 2000 16:41:58 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA03574; Fri, 18 Feb 2000 16:42:01 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-2.uni-koblenz.de (cacc-2.uni-koblenz.de [141.26.131.2])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id BAA09782;
	Sat, 19 Feb 2000 01:41:25 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407895AbQBSADb>;
	Sat, 19 Feb 2000 01:03:31 +0100
Date:   Sat, 19 Feb 2000 01:03:31 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "William J. Earl" <wje@cthulhu.engr.sgi.com>
Cc:     Ralf Baechle <ralf@oss.sgi.com>, brett <brett@madhouse.org>,
        Bruce Leggett <bleggett@sofamordanek.com>,
        linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: Linux on O2?
Message-ID: <20000219010331.B19004@uni-koblenz.de>
References: <BDDC26ED91ACD1118D4E00805F9FDAC3B027F2@broomfield01.sofamordanek.com> <Pine.LNX.3.96.1000217171401.908G-100000@caligula.madhouse.org> <20000218035335.F5234@uni-koblenz.de> <14509.54953.882688.741736@liveoak.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <14509.54953.882688.741736@liveoak.engr.sgi.com>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Fri, Feb 18, 2000 at 03:32:57PM -0800, William J. Earl wrote:

> Ralf Baechle writes:
>  > On Thu, Feb 17, 2000 at 05:14:25PM -0800, brett wrote:
>  > 
>  > > Im still wainting to hear anything about the indigo i hear alot of talk
>  > > about the indigo2 but nothing about the original blue boxes
>  > 
>  > The problem is that the origin docs are gone by now and SGI can't
>  > just go and ship the IRIX source to hackers ...
> 
>       We might be able to help out with some Indigo R4000 information,
> if someone is seriously interested, since the Indigo R4000 is close to
> Indigo2 and Indy.  Indigo R3000 is probably hopeless (that development
> project was something like 12 years ago, after all).  The graphics is
> a tougher problem, since all but Newport and Starter (Indigo) graphics
> have geometry engines with relatively complex interfaces.  
> 
>      Ralf is quite right about the IRIX source.  Since it is based
> on source licensed from SCO, Sun, and others, we do not have the right
> to hand it out without cost to others.  

How about if myself and possibly others who currently are under NDA for SGI
would support such projects by describing things via email where
neither docs nor uncontaminated source is available and possibly some
source where it's (C)-clean and managment aproved.  Could something like
that be made working?  It's a shame that still nobody so far has had an
actual chance to start working on an O2 port or something like that.

  Ralf
