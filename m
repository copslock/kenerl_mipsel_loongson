Received:  by oss.sgi.com id <S42205AbQF3BWb>;
	Thu, 29 Jun 2000 18:22:31 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:23092 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42202AbQF3BWM>; Thu, 29 Jun 2000 18:22:12 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id SAA01368; Thu, 29 Jun 2000 18:27:41 -0700 (PDT)
	mail_from (ulfc@calypso.engr.sgi.com)
Received: from calypso.engr.sgi.com (calypso.engr.sgi.com [163.154.5.113])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA81213;
	Thu, 29 Jun 2000 18:21:44 -0700 (PDT)
	mail_from (ulfc@calypso.engr.sgi.com)
Received: by calypso.engr.sgi.com (Postfix, from userid 37984)
	id 67274A7875; Thu, 29 Jun 2000 18:20:43 -0700 (PDT)
From:   Ulf Carlsson <ulfc@calypso.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14683.62955.352556.455553@calypso.engr.sgi.com>
Date:   Thu, 29 Jun 2000 18:20:43 -0700 (PDT)
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     "J. Scott Kasten" <jsk@tetracon-eng.net>, linux-mips@oss.sgi.com
Subject: Re: MIPS symbol versioning patches
In-Reply-To: <20000630023352.E15960@bacchus.dhis.org>
References: <14671.21669.3126.181895@calypso.engr.sgi.com>
	<Pine.SGI.4.10.10006291446000.17956-100000@thor.tetracon-eng.net>
	<14683.40873.494836.164828@calypso.engr.sgi.com>
	<20000630023352.E15960@bacchus.dhis.org>
X-Mailer: VM 6.75 under Emacs 20.5.1
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

 > > Yes, it's just a matter of recompiling everything against it.  Keith
 > > Wesolowski is doing this.  We have found some minor problems with
 > > glibc that we haven't been able to resolve yet.  There is some bug in
 > > the dynamic linker, it tries to resolve symbols that aren't there in
 > > some packages.
 > > 
 > > There is also a problem with compiling gcc 2.96 natively, but I
 > > actually think that's a problem in gcc 2.96.  It shouldn't try to
 > > generate jump instructions like it does that in PIC code.
 > 
 > What jump instructions?  jal goes ok, the assembler knows how expand
 > them correctly for PIC code.

It uses j to perform branches that are out of range.  I think gcc
expects the assembler to translate it into a GOT16/LO16 thing if it's
out of range.

Ulf
