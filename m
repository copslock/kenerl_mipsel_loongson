Received:  by oss.sgi.com id <S305155AbPKARP2>;
	Mon, 1 Nov 1999 09:15:28 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:8292 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305154AbPKARPN>;
	Mon, 1 Nov 1999 09:15:13 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id JAA06120
	for <linuxmips@oss.sgi.com>; Mon, 1 Nov 1999 09:15:28 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA69832
	for linux-list;
	Mon, 1 Nov 1999 08:41:53 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA19304
	for <linux@engr.sgi.com>;
	Mon, 1 Nov 1999 08:41:22 -0800 (PST)
	mail_from (xfinstrl@informatics.muni.cz)
Received: from aragorn.ics.muni.cz (aragorn.ics.muni.cz [147.251.4.33]) 
	by sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA7816840
	for <linux@engr.sgi.com>; Mon, 1 Nov 1999 08:41:02 -0800 (PST)
	mail_from (xfinstrl@informatics.muni.cz)
Received: from anxur.fi.muni.cz (0@anxur.fi.muni.cz [147.251.48.3])
	by aragorn.ics.muni.cz (8.8.5/8.8.5) with ESMTP id RAA14418;
	Mon, 1 Nov 1999 17:40:37 +0100 (MET)
Received: from gryf.fi.muni.cz (gryf.fi.muni.cz [147.251.48.137])
	by anxur.fi.muni.cz (8.8.5/8.8.5) with ESMTP id RAA27503;
	Mon, 1 Nov 1999 17:40:37 +0100 (MET)
Received: (from xfinstrl@localhost)
	by gryf.fi.muni.cz (8.8.7/8.8.7) id RAA07056;
	Mon, 1 Nov 1999 17:43:06 +0100
Message-ID: <19991101174305.A5167@gryf.fi.muni.cz>
Date:   Mon, 1 Nov 1999 17:43:05 +0100
From:   Ludek Finstrle <xfinstrl@informatics.muni.cz>
To:     Ralf Baechle <ralf@oss.sgi.com>,
        Ludek Finstrle <xfinstrl@informatics.muni.cz>
Cc:     sgi@linux.cz, linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: MIPS64
References: <19990822141504.A15701@uni-koblenz.de> <19990928163615.H25202@anxur.fi.muni.cz> <19990929160211.B21646@uni-koblenz.de> <19991005132552.K18469@gryf.fi.muni.cz> <19991006000724.B18573@uni-koblenz.de> <19991007142022.O18469@gryf.fi.muni.cz> <19991010041347.A413@uni-koblenz.de> <19991011010723.G981@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <19991011010723.G981@uni-koblenz.de>; from Ralf Baechle on Mon, Oct 11, 1999 at 01:07:24AM +0200
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

> > > Oh, where is online? I can't see it anywhere :o(
> > 
> > oss.sgi.com:/pub/pub/linux/mips/src/binutils-19990825.tar.bz2 are the
> > sources for the binutils which I'm using.  Fate doesn't like me, I
> > lost connection to oss when I tried to upload the egcs 1.1.2 patch
> > for MIPS64.  I'll put it into that directory tomorrow.
> 
> Ok, things are now online.  While I was at it I also have copied all
> the stuff from the old ftp.linux.sgi.com over to oss.sgi.com.  The
> crosscompiler source & patches are now in
> oss.sgi.com:/pub/linux/mips/src/mips64/.

Hello,

  we have some problems with code from cross-compiler for MIPS64.
We download sources from cygnus CVS and applied your patch. We had
some problems with compile egcs. We fix it but it generate bad
code => we fix it bad :o((

  Could you give us source from which you compiled your egcs cross-
compiler.

Thanks a lot

Luf
