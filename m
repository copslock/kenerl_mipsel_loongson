Received:  by oss.sgi.com id <S305175AbQDUThC>;
	Fri, 21 Apr 2000 12:37:02 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:48191 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305172AbQDUTg4>;
	Fri, 21 Apr 2000 12:36:56 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id MAA23565; Fri, 21 Apr 2000 12:32:11 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA93726
	for linux-list;
	Fri, 21 Apr 2000 12:28:50 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA66268
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 21 Apr 2000 12:28:48 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA00194
	for <linux@cthulhu.engr.sgi.com>; Fri, 21 Apr 2000 12:28:46 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id D218081A; Fri, 21 Apr 2000 21:28:47 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 822B38FC4; Fri, 21 Apr 2000 21:22:34 +0200 (CEST)
Date:   Fri, 21 Apr 2000 21:22:34 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     Andreas Jaeger <aj@oss.sgi.com>, linux@cthulhu.engr.sgi.com,
        linux-mips@fnet.fr, linux-mips@vger.rutgers.edu,
        Ulf Carlsson <ulfc@oss.sgi.com>
Subject: Re: GLIBC 2.2 should work on MIPS-Linux
Message-ID: <20000421212234.B5928@paradigm.rfc822.org>
References: <ho8zy7mkeq.fsf@awesome.engr.sgi.com> <hozoqnl5d7.fsf@awesome.engr.sgi.com> <20000421115121.A1498@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20000421115121.A1498@uni-koblenz.de>; from Ralf Baechle on Fri, Apr 21, 2000 at 11:51:21AM -0700
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Fri, Apr 21, 2000 at 11:51:21AM -0700, Ralf Baechle wrote:
> To keep you people up to date on this - I've got free shopping for
> the kernel FPU support software, that's is there are four solutions
> available:
> 
>  - two different ones from IRIX which I'm allowed to recycle for Linux
>  - the Algorithmics code which already has been integrated into Linux
>    by MIPS.
>  - Write something new that is based on include/math-emu/.
> 
> It used to be a relativly hard thing but it's no longer :-)

Pick the good out of all ? :) Honestly - We should keep an eye on 
memory footprint as the embedded people will be very interested in this.

How much work would the IRIX ones be and what is the difference between
the two ? Are they probably available as they are right now to just
publish them and someone with a lot time may produce a superset for Linux ?

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-subject-2-change
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
