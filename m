Received:  by oss.sgi.com id <S305158AbQBSX74>;
	Sat, 19 Feb 2000 15:59:56 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:52277 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305156AbQBSX7d>; Sat, 19 Feb 2000 15:59:33 -0800
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id QAA09836; Sat, 19 Feb 2000 16:02:29 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id PAA39830; Sat, 19 Feb 2000 15:59:31 -0800 (PST)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA82972
	for linux-list;
	Sat, 19 Feb 2000 15:44:35 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA58751
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 19 Feb 2000 15:44:32 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA00751
	for <linux@cthulhu.engr.sgi.com>; Sat, 19 Feb 2000 15:44:36 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-10.uni-koblenz.de (cacc-10.uni-koblenz.de [141.26.131.10])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id AAA01473;
	Sun, 20 Feb 2000 00:44:18 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407899AbQBSXOp>;
	Sun, 20 Feb 2000 00:14:45 +0100
Date:   Sun, 20 Feb 2000 00:14:45 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Marc Esipovich <marc@mucom.co.il>
Cc:     Ralf Baechle <ralf@oss.sgi.com>, brett <brett@madhouse.org>,
        Bruce Leggett <bleggett@sofamordanek.com>,
        linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: Linux on O2?
Message-ID: <20000220001445.B23993@uni-koblenz.de>
References: <20000218035335.F5234@uni-koblenz.de> <Pine.LNX.4.20.0002190629430.7658-100000@mucom.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <Pine.LNX.4.20.0002190629430.7658-100000@mucom.co.il>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Sat, Feb 19, 2000 at 06:30:22AM -0200, Marc Esipovich wrote:

> > > Im still wainting to hear anything about the indigo i hear alot of talk
> > > about the indigo2 but nothing about the original blue boxes
> > 
> > The problem is that the origin docs are gone by now and SGI can't
> > just go and ship the IRIX source to hackers ...
> 
> Wow, what do you mean gone by now?  are you saying there's no chance in
> hell to obtain the documentation?  it can't be gone.

Remember that SGI is a company that designs a large fraction of a system.
So the designers of some piece of hardware and it's direct users, the
kernel programmers have close to each other.  For a lot of chips
documentation never is written or at least never the same way so it would
be the case for chips that would be marketed as such.  It's obvious that
this isn't good at all for Free Software where the access to high
quality documentation is crucial.

So now imagine what has happened to all the knowledge about a machine
during the decade after it was developed?  The product's development
finishes, it get's marketed, the OS for gets some final bugfixes and
even later it gets phased out.  Silence.  Meanwhile the brains behind
the machine leave the company, tapes and paper go to some dark room
where nobody still remembers them and the machine gets forgotten.

Slow death of a computer ...

  Ralf
