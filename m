Received:  by oss.sgi.com id <S42233AbQGaQi4>;
	Mon, 31 Jul 2000 09:38:56 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:59949 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42302AbQGaQim>; Mon, 31 Jul 2000 09:38:42 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id JAA07161
	for <linux-mips@oss.sgi.com>; Mon, 31 Jul 2000 09:44:34 -0700 (PDT)
	mail_from (ulfc@calypso.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id JAA77204 for <linux-mips@oss.sgi.com>; Mon, 31 Jul 2000 09:38:11 -0700 (PDT)
Received: from calypso.engr.sgi.com (calypso.engr.sgi.com [163.154.5.113])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA29719;
	Mon, 31 Jul 2000 09:36:39 -0700 (PDT)
	mail_from (ulfc@calypso.engr.sgi.com)
Received: by calypso.engr.sgi.com (Postfix, from userid 37984)
	id B99C8A7875; Mon, 31 Jul 2000 09:34:44 -0700 (PDT)
To:     Dan Aizenstros <dan@vcubed.com>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Binutils-2.10
References: <39859107.195824A0@vcubed.com>
From:   Ulf Carlsson <ulfc@calypso.engr.sgi.com>
Date:   31 Jul 2000 09:34:44 -0700
In-Reply-To: Dan Aizenstros's message of "Mon, 31 Jul 2000 10:45:27 -0400"
Message-ID: <6ov1z0afecb.fsf@calypso.engr.sgi.com>
X-Mailer: Gnus v5.7/Emacs 20.5
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi Dan,

binutils-2.10 is known to work [or at least compile], but the patches
you use are broken in some way.  You could try to generate new files
as you suggested.  To generate new files you have to give the
--enable-maintainer-mode option to configure, and you need special
versions of some build tools.  The files will be generated when you
run make.

Here is the README-maintainer-mode that pretty much explains it:

                Notes on enabling maintainer mode

Note that if you configure with --enable-maintainer-mode, you will
need special versions of automake, autoconf, libtool and gettext. You
will find the sources for these in ftp://sourceware.cygnus.com/pub/binutils.

Ulf

> Hello,
> 
> I have tried to compile binutils-2.10 with the patches from
> http://www.ds2.pg.gda.pl/~macro/ but it fails because
> BFD_RELOC_MIPS_HIGHER and BFD_RELOC_MIPS_HIGHEST are not
> defined.  I believe that they should be defined in bfd-in2.h
> but they are not there.  At the top of the file it says that
> it is a generated file so how do I generate it?  I am also
> wondering if changes to this file are missing from the patch
> file.
> 
> Dan Aizenstros
> Software Engineer
> V3 Semiconductor Corp.
