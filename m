Received:  by oss.sgi.com id <S305180AbQDUVtM>;
	Fri, 21 Apr 2000 14:49:12 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:38443 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305179AbQDUVtG>; Fri, 21 Apr 2000 14:49:06 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id OAA09518; Fri, 21 Apr 2000 14:53:09 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id OAA26796; Fri, 21 Apr 2000 14:48:35 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA06359
	for linux-list;
	Fri, 21 Apr 2000 14:38:29 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from lappi (dhcp-163-154-5-221.engr.sgi.com [163.154.5.221])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA32065
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 21 Apr 2000 14:38:28 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received:  by lappi.waldorf-gmbh.de id <S1405412AbQDUVey>;
	Fri, 21 Apr 2000 14:34:54 -0700
Date:   Fri, 21 Apr 2000 14:34:54 -0700
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Florian Lohoff <flo@rfc822.org>
Cc:     Andreas Jaeger <aj@oss.sgi.com>, linux@cthulhu.engr.sgi.com,
        linux-mips@fnet.fr, linux-mips@vger.rutgers.edu,
        Ulf Carlsson <ulfc@oss.sgi.com>
Subject: Re: GLIBC 2.2 should work on MIPS-Linux
Message-ID: <20000421143454.E1498@uni-koblenz.de>
References: <ho8zy7mkeq.fsf@awesome.engr.sgi.com> <hozoqnl5d7.fsf@awesome.engr.sgi.com> <20000421115121.A1498@uni-koblenz.de> <20000421212234.B5928@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20000421212234.B5928@paradigm.rfc822.org>; from flo@rfc822.org on Fri, Apr 21, 2000 at 09:22:34PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Fri, Apr 21, 2000 at 09:22:34PM +0200, Florian Lohoff wrote:

> Pick the good out of all ? :) Honestly - We should keep an eye on 
> memory footprint as the embedded people will be very interested in this.
> 
> How much work would the IRIX ones be and what is the difference between
> the two ? Are they probably available as they are right now to just
> publish them and someone with a lot time may produce a superset for Linux ?

There are two FP emulators in IRIX.  The first one is fairly old, was already
used in RISC/os and is written in assembler.  I'm not sure if it can
properly deal with MIPS IV.  It's successor is written in C and is what's
currently being used in IRIX, is pretty clean and maintainable code.  It
was clearly written with a heavily optimizing compiler such as SGI's in
mind and I assume that it won't perform well without major restructuring 
when compiled with GCC.  On the other side it's as far as I know the only
package that gets all the cornercases right.

  Ralf
