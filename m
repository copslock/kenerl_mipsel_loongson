Received:  by oss.sgi.com id <S305176AbQEQUE3>;
	Wed, 17 May 2000 20:04:29 +0000
Received: from deliverator.sgi.com ([204.94.214.10]:48966 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305154AbQEQUEC>;
	Wed, 17 May 2000 20:04:02 +0000
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id MAA13089; Wed, 17 May 2000 12:59:11 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id NAA48323; Wed, 17 May 2000 13:03:31 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA84517
	for linux-list;
	Wed, 17 May 2000 12:53:44 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA62600
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 17 May 2000 12:53:41 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA08677
	for <linux@cthulhu.engr.sgi.com>; Wed, 17 May 2000 12:53:40 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-29.uni-koblenz.de (cacc-29.uni-koblenz.de [141.26.131.29])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id VAA12703;
	Wed, 17 May 2000 21:53:38 +0200 (MET DST)
Received:  by lappi.waldorf-gmbh.de id <S1403827AbQEQTxL>;
	Wed, 17 May 2000 21:53:11 +0200
Date:   Wed, 17 May 2000 21:53:11 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Soren S. Jorvang" <soren@wheel.dk>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: O2 ARCS
Message-ID: <20000517215310.F779@uni-koblenz.de>
References: <20000517051524.A21067@gnyf.wheel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20000517051524.A21067@gnyf.wheel.dk>; from soren@wheel.dk on Wed, May 17, 2000 at 05:15:24AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Wed, May 17, 2000 at 05:15:24AM +0200, Soren S. Jorvang wrote:

> I seem to remember some dire warnings about the O2 ARCS PROM
> needing special care and feeding to even do basic stuff. Am I
> on crack?
> 
> FWIW, as a system console it works just for me as the Indy, at
> least well enough to do PCI enumeration and play with NetBSD DDB.
> 
> Of course, there still isn't really any hardware documentation
> beyond sys/mace.h and friends..

The ARCS firmware isn't the big deal but the R10000 support for this
system or any other non-cachecoherent system.  Harald Koerfgen has
started poking at an O2 port and he's got first success.

  Ralf
