Received:  by oss.sgi.com id <S305172AbPLHLWk>;
	Wed, 8 Dec 1999 03:22:40 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:22793 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305167AbPLHLWS>; Wed, 8 Dec 1999 03:22:18 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id DAA09705; Wed, 8 Dec 1999 03:31:22 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id DAA70772
	for linux-list;
	Wed, 8 Dec 1999 03:21:49 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from hollywood.engr.sgi.com (hollywood.engr.sgi.com [150.166.61.38])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id DAA10830
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 8 Dec 1999 03:21:46 -0800 (PST)
	mail_from (owner-linux@hollywood.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by hollywood.engr.sgi.com (940816.SGI.8.6.9/960327.SGI.AUTOCF) via ESMTP id DAA25251; Wed, 8 Dec 1999 03:21:44 -0800
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA05326;
	Wed, 8 Dec 1999 03:21:44 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from lappi (animaniacs.conectiva.com.br [200.250.58.146]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id DAA07947; Wed, 8 Dec 1999 03:21:27 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received:  by lappi.waldorf-gmbh.de id <S407621AbPLHLVM>;
	Wed, 8 Dec 1999 09:21:12 -0200
Date:   Wed, 8 Dec 1999 09:21:12 -0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Alistair Lambie <alambie@rock.csd.sgi.com>
Cc:     fisher@sgi.com, kevink@mips.com, linux@hollywood.engr.sgi.com,
        William Fisher <fisher@hollywood.engr.sgi.com>
Subject: Re: Question for David Miller or anyone else about R6000 code
Message-ID: <19991208092112.F10331@uni-koblenz.de>
References: <199912080313.TAA24823@hollywood.engr.sgi.com> <384DDEF9.E3BE1F10@csd.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <384DDEF9.E3BE1F10@csd.sgi.com>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Wed, Dec 08, 1999 at 05:30:49PM +1300, Alistair Lambie wrote:

> Don't forget CDC used the R6000 and ramped it to 90MHz.  They also got
> it going in an SMP configuration with 4 processors from what I can
> remember.  I guess it is possible that someone could actually want to
> burn some cycles on this, although they had better have a cheap source
> of power and good airconditioning :-)

At one time some Linux/m68k hacker was seriously looking into porting
Linux to a 3-CPU 256mb CDC which at that time was used as
ftp.uni-erlangen.de.

As usual the largest problem was technical documentation for the machine
and the CPU; the R6k is covered very badly by the freely available
documentation.

  Ralf
