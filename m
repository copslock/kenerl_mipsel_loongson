Received:  by oss.sgi.com id <S305169AbQEPUZN>;
	Tue, 16 May 2000 20:25:13 +0000
Received: from deliverator.sgi.com ([204.94.214.10]:28207 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305154AbQEPUYz>;
	Tue, 16 May 2000 20:24:55 +0000
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id NAA22967; Tue, 16 May 2000 13:20:05 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA83418
	for linux-list;
	Tue, 16 May 2000 13:17:50 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA06832
	for <linux@engr.sgi.com>;
	Tue, 16 May 2000 13:17:49 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA09095
	for <linux@engr.sgi.com>; Tue, 16 May 2000 13:17:48 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-18.uni-koblenz.de (cacc-18.uni-koblenz.de [141.26.131.18])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id WAA07758;
	Tue, 16 May 2000 22:17:43 +0200 (MET DST)
Received:  by lappi.waldorf-gmbh.de id <S1403827AbQEPUQ6>;
	Tue, 16 May 2000 22:16:58 +0200
Date:   Tue, 16 May 2000 22:16:58 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jun Sun <jsun@mvista.com>
Cc:     Ralf Baechle <ralf@oss.sgi.com>, linux@cthulhu.engr.sgi.com,
        linux-mips@fnet.fr, linux-mips@vger.rutgers.edu
Subject: Re: dumb question - where is the latest linux/mips kernel source?
Message-ID: <20000516221658.E6174@uni-koblenz.de>
References: <39209F64.83638479@mvista.com> <20000516132314.B4561@uni-koblenz.de> <39218130.444EB4A3@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <39218130.444EB4A3@mvista.com>; from jsun@mvista.com on Tue, May 16, 2000 at 10:11:12AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Tue, May 16, 2000 at 10:11:12AM -0700, Jun Sun wrote:

> Is the intention to merge MIPS work back to the standard Linux tree?  If
> yes, do we have an idea when?  If no, I assume the MIPS branch has to
> keep getting forward merges from the standard tree.  That will be a
> pain.

Most of the changes have already been merged with Linus.  The situation is
now sufficiently confusing that I'll wait for pre9-3 or even the next
`real' patch before continuing to merge with Linus.  In any case our
diffs should be now down to less than 10% of what they used to be and I'll
continue to shrink them further.  The perspective of 2.4 compiling out of
the box for MIPS is pretty close to reallity, including even MIPS64, SMP
and Origin.

In any case we'll keep merging into our separate tree.  That's where all
the development happens and where we send the good bits to Linus from
time to time.

  Ralf
