Received:  by oss.sgi.com id <S554059AbRBBPn0>;
	Fri, 2 Feb 2001 07:43:26 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:53445 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S554053AbRBBPnT>;
	Fri, 2 Feb 2001 07:43:19 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA10525;
	Fri, 2 Feb 2001 16:40:45 +0100 (MET)
Date:   Fri, 2 Feb 2001 16:40:45 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Carsten Langgaard <carstenl@mips.com>
cc:     linux-mips@oss.sgi.com
Subject: Re: Cross build applications
In-Reply-To: <3A7ACFB2.DAFC52E3@mips.com>
Message-ID: <Pine.GSO.3.96.1010202162911.28509M-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, 2 Feb 2001, Carsten Langgaard wrote:

> >  The file is supposed to come with glibc.  Do you have glibc for
> > mips-linux installed?
> 
> No, where can I get it.

 If you want glibc 2.2.1, you may get a source RPM package I made
available at 'ftp://ftp.ds2.pg.gda.pl/pub/macro/'.  I make mipsel-linux
builds only, so for cross-compilation you would get a mipsel-linux-glibc
package, modify the few defines at the top (and possibly the spec file
name) and build a mips-linux-glibc binary package.  Or build it in the
traditional way.  Note the few patches I include are not MIPS-specific, so
you do not really need them unless you want them. 

 If you want a glibc 2.0 package or a binary one, then I cannot help you. 
Check the usual resources -- oss.sgi.com and ftp.rfc822.org.  Others may
provide different pointers as well. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
