Received:  by oss.sgi.com id <S305167AbQBRXvY>;
	Fri, 18 Feb 2000 15:51:24 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:44615 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305163AbQBRXu6>;
	Fri, 18 Feb 2000 15:50:58 -0800
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id PAA05656; Fri, 18 Feb 2000 15:46:26 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id PAA44636; Fri, 18 Feb 2000 15:50:56 -0800 (PST)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA37322
	for linux-list;
	Fri, 18 Feb 2000 15:34:40 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from liveoak.engr.sgi.com (liveoak.engr.sgi.com [163.154.5.24])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA72706;
	Fri, 18 Feb 2000 15:33:03 -0800 (PST)
	mail_from (wje@liveoak.engr.sgi.com)
Received: (from wje@localhost)
	by liveoak.engr.sgi.com (8.9.3/8.8.7) id PAA19290;
	Fri, 18 Feb 2000 15:32:58 -0800
X-Authentication-Warning: liveoak.engr.sgi.com: wje set sender to wje@liveoak.engr.sgi.com using -f
From:   "William J. Earl" <wje@cthulhu.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14509.54953.882688.741736@liveoak.engr.sgi.com>
Date:   Fri, 18 Feb 2000 15:32:57 -0800 (PST)
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     brett <brett@madhouse.org>,
        Bruce Leggett <bleggett@sofamordanek.com>,
        linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: Linux on O2?
In-Reply-To: <20000218035335.F5234@uni-koblenz.de>
References: <BDDC26ED91ACD1118D4E00805F9FDAC3B027F2@broomfield01.sofamordanek.com>
	<Pine.LNX.3.96.1000217171401.908G-100000@caligula.madhouse.org>
	<20000218035335.F5234@uni-koblenz.de>
X-Mailer: VM 6.74 under Emacs 20.3.1
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Ralf Baechle writes:
 > On Thu, Feb 17, 2000 at 05:14:25PM -0800, brett wrote:
 > 
 > > Im still wainting to hear anything about the indigo i hear alot of talk
 > > about the indigo2 but nothing about the original blue boxes
 > 
 > The problem is that the origin docs are gone by now and SGI can't
 > just go and ship the IRIX source to hackers ...

      We might be able to help out with some Indigo R4000 information,
if someone is seriously interested, since the Indigo R4000 is close to
Indigo2 and Indy.  Indigo R3000 is probably hopeless (that development
project was something like 12 years ago, after all).  The graphics is
a tougher problem, since all but Newport and Starter (Indigo) graphics
have geometry engines with relatively complex interfaces.  

     Ralf is quite right about the IRIX source.  Since it is based
on source licensed from SCO, Sun, and others, we do not have the right
to hand it out without cost to others.  
