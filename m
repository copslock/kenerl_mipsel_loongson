Received:  by oss.sgi.com id <S305162AbQCHRAc>;
	Wed, 8 Mar 2000 09:00:32 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:35615 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305154AbQCHRAS>; Wed, 8 Mar 2000 09:00:18 -0800
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id JAA04121; Wed, 8 Mar 2000 09:03:34 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id IAA93973; Wed, 8 Mar 2000 08:59:47 -0800 (PST)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA94665
	for linux-list;
	Wed, 8 Mar 2000 08:48:39 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA24710
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 8 Mar 2000 08:48:31 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from lappi (animaniacs.conectiva.com.br [200.250.58.146]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA03005
	for <linux@cthulhu.engr.sgi.com>; Wed, 8 Mar 2000 08:48:25 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received:  by lappi.waldorf-gmbh.de id <S407898AbQCHQZF>;
	Wed, 8 Mar 2000 13:25:05 -0300
Date:   Wed, 8 Mar 2000 13:25:05 -0300
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jay Carlson <nop@nop.com>
Cc:     Dominic Sweetman <dom@algor.co.uk>,
        "Bradley D. LaRonde" <brad@ltc.com>,
        "Andrew R. Baker" <andrewb@uab.edu>,
        Linux SGI <linux@cthulhu.engr.sgi.com>, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: FP emulation patch available
Message-ID: <20000308132505.D872@uni-koblenz.de>
References: <Pine.LNX.3.96.1000306220330.12659B-100000@lithium><097a01bf87eb$ebe4d4d0$b8119526@ltc.com> <200003071022.KAA00275@gladsmuir.algor.co.uk> <578601bf882d$d945f650$0a00000a@decoy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <578601bf882d$d945f650$0a00000a@decoy>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Tue, Mar 07, 2000 at 07:08:23AM -0500, Jay Carlson wrote:

> Whether Linux or NetBSD, as systems, were ever serious MIPS run-time
> systems---well, you wrote the book, so I'm inclined to get out of the
> argument.
> 
> >From my LinuxCE perspective, a full FP emu is fairly important for getting
> binary compatibility back with mainline Linux/MIPS---we've been in the
> softfp ghetto.  But most of what we do with FP is, uh, keep /bin/df happy
> when it tries to calculate the percentage of free disk space, and the like.
> And dropping softfp means we don't *have* to maintain a forked
> toolchain/libc.

Have you considered contribution of the softfp code to GNU libc or
packaging it as a glibc addon?  For small embedded systems it seems to
be the better tradeoff than the kernel emulator and for these systems
nobody cares very much about binary compatibility with something else.

  Ralf
