Received:  by oss.sgi.com id <S42254AbQEVLtq>;
	Mon, 22 May 2000 04:49:46 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:61486 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42242AbQEVLtV>;
	Mon, 22 May 2000 04:49:21 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id EAA07815; Mon, 22 May 2000 04:44:29 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id EAA41435
	for linux-list;
	Mon, 22 May 2000 04:39:00 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA72081
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 22 May 2000 04:38:57 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id EAA00095
	for <linux@cthulhu.engr.sgi.com>; Mon, 22 May 2000 04:38:56 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-13.uni-koblenz.de (cacc-13.uni-koblenz.de [141.26.131.13])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id NAA18628;
	Mon, 22 May 2000 13:38:50 +0200 (MET DST)
Received:  by lappi.waldorf-gmbh.de id <S1403838AbQEVLbt>;
	Mon, 22 May 2000 13:31:49 +0200
Date:   Mon, 22 May 2000 13:31:49 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Hiroyuki Machida <machida@sm.sony.co.jp>
Cc:     agx@bert.physik.uni-konstanz.de, linux-mips@fnet.fr,
        linux@cthulhu.engr.sgi.com
Subject: Re: SIGIO Handler
Message-ID: <20000522133149.A4036@uni-koblenz.de>
References: <20000518161135.A26055@bert.physik.uni-konstanz.de> <20000522113213A.machida@sm.sony.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20000522113213A.machida@sm.sony.co.jp>; from machida@sm.sony.co.jp on Mon, May 22, 2000 at 11:32:13AM +0900
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Mon, May 22, 2000 at 11:32:13AM +0900, Hiroyuki Machida wrote:

> > I'm still trying to get the mouse to work under X. The problem seems not
> > to be related to X itself but to a kernel/glibc problem. X uses a SIGIO
> > handler to "get notified" about mouse events. I wrote my own small SIGIO
> > handler(see attached program) which works fine on my intel box but not
> > on an indy (glibc-2.0.6-3lm/linux-2.2.13-20000211). 
> 
> I had experienced same SIGIO problem. It that time, the definitions
> of glibc's FASYNC (in fnctbits.h) and kernel's FASYNC (in
> asm/fcnt..h) were not same. 
> 
> Check those values in your system, first.

I'll prepare a new glibc 2.0 release with the header file fixed.  Glibc 2.2's
<bits/fcntl.h> is ok.

  Ralf
