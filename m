Received:  by oss.sgi.com id <S305172AbQCHUyC>;
	Wed, 8 Mar 2000 12:54:02 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:59965 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305161AbQCHUxp>; Wed, 8 Mar 2000 12:53:45 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id MAA01110; Wed, 8 Mar 2000 12:57:01 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA17706
	for linux-list;
	Wed, 8 Mar 2000 12:44:05 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA10214
	for <linux@engr.sgi.com>;
	Wed, 8 Mar 2000 12:44:02 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from lappi (animaniacs.conectiva.com.br [200.250.58.146]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA00653
	for <linux@engr.sgi.com>; Wed, 8 Mar 2000 12:43:46 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received:  by lappi.waldorf-gmbh.de id <S407898AbQCHUmv>;
	Wed, 8 Mar 2000 17:42:51 -0300
Date:   Wed, 8 Mar 2000 17:42:51 -0300
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Tim Wilkinson <tim@transvirtual.com>
Cc:     linux-mips@fnet.fr, linux-mips@vger.rutgers.edu,
        linux@cthulhu.engr.sgi.com
Subject: Re: Mips/Linux integration of latest GCC, Binutils & GLibc
Message-ID: <20000308174251.A6399@uni-koblenz.de>
References: <38C54F05.458A3EFE@transvirtual.com> <20000308140301.B1425@uni-koblenz.de> <38C6A5D4.F08DFCE4@transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <38C6A5D4.F08DFCE4@transvirtual.com>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Wed, Mar 08, 2000 at 07:11:16PM +0000, Tim Wilkinson wrote:

> So here's my basic problem.  GCC, Binutils and GLIBC don't really agree about
> PIC nature of code.  GCC seems to default to PIC unless you say -no-pic, but
> even then doesn't remove the -KPIC flag to the assembler.  GLIBC requires the
> PIC symbol to be defined otherwise it uses non-pic assembly code which won't
> compile with the -KPIC flag to the assembler (there are also a bunch of
> linux/glibc compatiblity issues we won't get into right now).
> 
> So my questions is - should GCC by default generate non-pic code or should it
> generate PIC code by default?  If it generate PIC by default it needs to
> define PIC and __PIC__ ... but this will cause problems when building a
> static version of GLIBC (even though it's really a PIC version).
> 
> I would want to do the following - gcc by default doesn't build PIC code,
> fix the -KPIC flag to be passed only when generating PIC code, and make a
> few minor changes to GLIBC to allow all this to happen.

You cannot mix pic and non-pic code on MIPS, so it must generate PIC code
by default and that is also pass PIC / __PIC__ / -KPIC by default.  That's
what the real compilers (not the abortion in egcs-cvs) do.

That is static vs shared and pic vs. non-pic code are orthogonal issues
except that you cannot generate shared libs from non-pic code.  They
always have been except that the way things are handled on other
architectures doesn't make recognizing this fact very important.

  Ralf
