Received:  by oss.sgi.com id <S305167AbPLGLMc>;
	Tue, 7 Dec 1999 03:12:32 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:65333 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305164AbPLGLMP>;
	Tue, 7 Dec 1999 03:12:15 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id DAA04829; Tue, 7 Dec 1999 03:19:35 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id DAA98040
	for linux-list;
	Tue, 7 Dec 1999 03:11:27 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA14009
	for <linux@engr.sgi.com>;
	Tue, 7 Dec 1999 03:11:20 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from lappi (animaniacs.conectiva.com.br [200.250.58.146]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id DAA03953
	for <linux@engr.sgi.com>; Tue, 7 Dec 1999 03:11:17 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received:  by lappi.waldorf-gmbh.de id <S407621AbPLGLLB>;
	Tue, 7 Dec 1999 09:11:01 -0200
Date:   Tue, 7 Dec 1999 09:11:01 -0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Ryan Rafferty <rraffer1@osf1.gmu.edu>
Cc:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: Snapshot
Message-ID: <19991207091101.A759@uni-koblenz.de>
References: <19991206214429.T765@uni-koblenz.de> <Pine.OSF.3.96.991206221350.25177A-100000@osf1.gmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <Pine.OSF.3.96.991206221350.25177A-100000@osf1.gmu.edu>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Mon, Dec 06, 1999 at 10:14:12PM -0500, Ryan Rafferty wrote:

> Any highlights about important changes present in this snapshot?

Most important for you guys out there the upgrade to 2.3.21 and a number
of bug fixes.  Try it, break it.  Again ;-)  Aside of this this kernel
also has a good part of the 64-bit stuff.  Not all of it, I'm maintaining
the 32-bit kernel, the Indy 64-bit and the Origin kernel as separate
trees to prevent bugs from creeping from on tree in the other.

> On Mon, 6 Dec 1999, Ralf Baechle wrote:
> 
> > I've put a snapshot of current CVS kernel sources into
> > oss.sgi.com:/pub/linux/mips/src/kernel/linux-19991206.tar.gz.
