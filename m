Received:  by oss.sgi.com id <S554132AbRA0Hmb>;
	Fri, 26 Jan 2001 23:42:31 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:52477 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553804AbRA0HmM>;
	Fri, 26 Jan 2001 23:42:12 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id IAA29822;
	Sat, 27 Jan 2001 08:42:35 +0100 (MET)
Date:   Sat, 27 Jan 2001 08:42:34 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Florian Lohoff <flo@rfc822.org>
cc:     Pete Popov <ppopov@mvista.com>, linux-mips@oss.sgi.com
Subject: Re: Cross compiling RPMs
In-Reply-To: <20010126212341.A26384@paradigm.rfc822.org>
Message-ID: <Pine.GSO.3.96.1010127083433.29150D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, 26 Jan 2001, Florian Lohoff wrote:

> Cross compiling is definitly no option for debian as the dependencies
> etc are all made from "ldd binary" which has to fail for cross-compiling.
> I guess this also happens to rpm packages so cross-compiling to really
> get a correct distribution is definitly no option.

 See how my RPM got modified to make use of readelf and objdump if
available to circumvent this problem.  I'm actually going to contribute
these changes to RPM one day (I've just got bored trying to figure the
right e-mail address last time) -- using ldd for this purpose is
definitely broken as it pulls in indirect dependencies (see e.g. dnet vs
non-dnet versions of libX11). 

 All my cross-compiled packages have correct dependencies. 8-}

> I definitly go for native builds - Once you have a working stable 
> base you can set up debian autobuilders which will do nearly 
> everything for you except signing and uploading the package into
> the main repository.

 Yep, native builds are more likely to get correct as that's what most
developers out there check (there are actually developers who never heard
of something like a cross-compilation, sigh...).  But not everyone can
afford a week to build glibc or X11... 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
