Received:  by oss.sgi.com id <S42209AbQF2TON>;
	Thu, 29 Jun 2000 12:14:13 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:12092 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42202AbQF2TOJ>;
	Thu, 29 Jun 2000 12:14:09 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id MAA02316
	for <linux-mips@oss.sgi.com>; Thu, 29 Jun 2000 12:09:20 -0700 (PDT)
	mail_from (ulfc@calypso.engr.sgi.com)
Received: from calypso.engr.sgi.com (calypso.engr.sgi.com [163.154.5.113])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA57565;
	Thu, 29 Jun 2000 12:13:46 -0700 (PDT)
	mail_from (ulfc@calypso.engr.sgi.com)
Received: by calypso.engr.sgi.com (Postfix, from userid 37984)
	id 86BE0A7875; Thu, 29 Jun 2000 12:12:41 -0700 (PDT)
From:   Ulf Carlsson <ulfc@calypso.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14683.40873.494836.164828@calypso.engr.sgi.com>
Date:   Thu, 29 Jun 2000 12:12:41 -0700 (PDT)
To:     "J. Scott Kasten" <jsk@tetracon-eng.net>
Cc:     linux-mips@oss.sgi.com
Subject: Re: MIPS symbol versioning patches
In-Reply-To: <Pine.SGI.4.10.10006291446000.17956-100000@thor.tetracon-eng.net>
References: <14671.21669.3126.181895@calypso.engr.sgi.com>
	<Pine.SGI.4.10.10006291446000.17956-100000@thor.tetracon-eng.net>
X-Mailer: VM 6.75 under Emacs 20.5.1
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

 > > I have synced the binutils CVS with symbol versioning patches.  The
 > > current CVS tree at http://sourceware.cygnus.com/binutils should work
 > > now.  I have only tested compile and tests from glibc 2.1.90 so things
 > > will probably break badly.  I will be away from my office the next
 > > five days, and I will unfortunately not have any machine to work on.
 > > 
 > > I have verified with glibc CVS from today, glibc 2.96 CVS from today
 > > and binutils CVS from today.
 > > 
 > > Ulf
 > > 
 > 
 > I take this to mean that we may soon have a working glibc 2.1.xx for MIPS?
 > 

Yes, it's just a matter of recompiling everything against it.  Keith
Wesolowski is doing this.  We have found some minor problems with
glibc that we haven't been able to resolve yet.  There is some bug in
the dynamic linker, it tries to resolve symbols that aren't there in
some packages.

There is also a problem with compiling gcc 2.96 natively, but I
actually think that's a problem in gcc 2.96.  It shouldn't try to
generate jump instructions like it does that in PIC code.  I think the
bootstrapping of gcc 2.96 currently is broken, but that's not a MIPS
issue.

Note that glibc 2.1 never will run on MIPS, glibc 2.1.90 is the
development version for the forthcoming glibc 2.2.

Ulf
