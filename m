Received:  by oss.sgi.com id <S42243AbQIZVH5>;
	Tue, 26 Sep 2000 14:07:57 -0700
Received: from u-146.karlsruhe.ipdial.viaginterkom.de ([62.180.10.146]:265
        "EHLO u-146.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42229AbQIZVHn>; Tue, 26 Sep 2000 14:07:43 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S869595AbQIZVGu>;
        Tue, 26 Sep 2000 23:06:50 +0200
Date:   Tue, 26 Sep 2000 23:06:50 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Florian Lohoff <flo@rfc822.org>
Cc:     "Gleb O. Raiko" <raiko@niisi.msk.ru>, linux-mips@oss.sgi.com,
        linux-mips@fnet.fr, linux-origin@oss.sgi.com
Subject: Re: libc upgrade
Message-ID: <20000926230650.B10991@bacchus.dhis.org>
References: <20000922152604.A2627@bacchus.dhis.org> <20000925112413.B3247@paradigm.rfc822.org> <20000925132056.A7598@bacchus.dhis.org> <20000925161500.A4773@paradigm.rfc822.org> <20000925221414.A6190@bacchus.dhis.org> <20000926010416.B3761@paradigm.rfc822.org> <39D06065.FC00C7A0@niisi.msk.ru> <20000926123600.A413@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20000926123600.A413@paradigm.rfc822.org>; from flo@rfc822.org on Tue, Sep 26, 2000 at 12:36:00PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Sep 26, 2000 at 12:36:00PM +0200, Florian Lohoff wrote:

> > Well, another question. Ralf uploaded cross tools rpms year ago. Does
> > anybody have native rmps for big endian ? Also, does anybody have cross
> > tools for sparc glibc 2.1 (RH6.x sparc distribution) ? I can't compile
> > cross gcc on my Ultra, it seems like a bug in the sparc compiler, the
> > process fails in parsing an enum decl in a header.
> 
> I tried to compile cross gcc/binutils from CVS a couple of times
> for Linux/Sparc (Ultra) which didnt work as somewhere in the
> middle the beast meant to use the native "as" instead of
> mipsel-linux-as

gcc tries to run as on <prefix>/lib/gcc-lib/<target>/<version>/as, then
<prefix>/<target>/bin/as, then the native as from $PATH.  So check if you
were using the same target configuration name (mips-linux and
mips-unknown-linux-gnu are different!) for both gcc and binutils.

  Ralf
