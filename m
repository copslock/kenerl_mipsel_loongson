Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id CAA28680
	for <pstadt@stud.fh-heilbronn.de>; Thu, 5 Aug 1999 02:28:06 +0200
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id RAA15050; Wed, 4 Aug 1999 17:21:43 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA50952
	for linux-list;
	Wed, 4 Aug 1999 17:13:02 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA00472
	for <linux@engr.sgi.com>;
	Wed, 4 Aug 1999 17:11:36 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA07269
	for <linux@engr.sgi.com>; Wed, 4 Aug 1999 17:09:24 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-13.uni-koblenz.de [141.26.131.13])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id CAA13224
	for <linux@engr.sgi.com>; Thu, 5 Aug 1999 02:09:21 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id CAA22432;
	Thu, 5 Aug 1999 02:02:16 +0200
Date: Thu, 5 Aug 1999 02:02:16 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Mark Mitchell <mark@codesourcery.com>
Cc: binutils@sourceware.cygnus.com, linux@cthulhu.engr.sgi.com,
        linux-mips@fnet.fr, linux-mips@vger.rutgers.edu
Subject: Re: R_MIPS_26 testcase
Message-ID: <19990805020216.A22390@uni-koblenz.de>
References: <19990804134926T.mitchell@codesourcery.com> <19990804230046.B15625@uni-koblenz.de> <19990804234523.A21269@uni-koblenz.de> <19990804152625A.mitchell@codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <19990804152625A.mitchell@codesourcery.com>; from Mark Mitchell on Wed, Aug 04, 1999 at 03:26:25PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Aug 04, 1999 at 03:26:25PM -0700, Mark Mitchell wrote:

> >>>>> "Ralf" == Ralf Baechle <ralf@uni-koblenz.de> writes:
> 
>     Ralf> This seems to fix test case #6.
> 
>     >> else if (r_type == R_MIPS16_26 || r_type == R_MIPS16_26)
>     Ralf>                       ^^^^^^^^^^^ ^^^^^^^^^^^
> 
> !#@!
>  
> I'm going to take a nap now.  When I wake up, I promise to be a saner
> person.

Just to make your waking sweeter, latest cvs-binutils plus the R_MIPS_26
patch from my other email plus your elflink.h patch build a working
Linux kernel!

  Ralf
