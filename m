Received:  by oss.sgi.com id <S553862AbRA3Jtp>;
	Tue, 30 Jan 2001 01:49:45 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:45469 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553857AbRA3Jt0>;
	Tue, 30 Jan 2001 01:49:26 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id KAA00887;
	Tue, 30 Jan 2001 10:46:37 +0100 (MET)
Date:   Tue, 30 Jan 2001 10:46:36 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Mike McDonald <mikemac@mikemac.com>
cc:     linux-mips@oss.sgi.com
Subject: Re: Cross compiling RPMs 
In-Reply-To: <200101300012.QAA17611@saturn.mikemac.com>
Message-ID: <Pine.GSO.3.96.1010130104226.678A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, 29 Jan 2001, Mike McDonald wrote:

> >Date:   Mon, 29 Jan 2001 16:57:08 +0100 (MET)
> >From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
> >To: Ralf Baechle <ralf@oss.sgi.com>
> >Subject: Re: Cross compiling RPMs
> 
> >   If you have a decent native
> >system, why to bother with cross-compiling? 
> 
>   Because that's a huge IF! Most of the systems I deal with aren't
> "decent" enough to support native compilation of the system. (The
> systems of interest to me are embedded and handheld units.)

 Of course, but Ralf was mentioning some R10k system with 1.5GB of RAM... 
Much enough to buffer all binaries executed during a build as well as all
glibc and X11 sources together with intermediate object and library files
at once. 8-}

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
