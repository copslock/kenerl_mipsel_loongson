Received:  by oss.sgi.com id <S553796AbQJ0Xfq>;
	Fri, 27 Oct 2000 16:35:46 -0700
Received: from gateway-490.mvista.com ([63.192.220.206]:20719 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553756AbQJ0Xfm>;
	Fri, 27 Oct 2000 16:35:42 -0700
Received: from mvista.com (IDENT:ppopov@zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id e9RNY1303021;
	Fri, 27 Oct 2000 16:34:01 -0700
Message-ID: <39FA101C.4903F088@mvista.com>
Date:   Fri, 27 Oct 2000 16:30:36 -0700
From:   Pete Popov <ppopov@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.12-20b i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     Ralf Baechle <ralf@oss.sgi.com>
CC:     Jun Sun <jsun@mvista.com>,
        "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: userland packages
References: <39F8CE01.3782BBF5@mvista.com> <20001027043432.F6628@bacchus.dhis.org> <39F9B7EF.D6469D07@mvista.com> <20001028012745.B2813@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Ralf Baechle wrote:
> 
> On Fri, Oct 27, 2000 at 10:14:23AM -0700, Jun Sun wrote:
> 
> > He is not telling the truth. :-)  See his very own MIPS-HOWTO,
> > cross-compile section :
> >
> > http://www.linux.sgi.com/mips-howto.html
> 
> So you probably never tried to crosscompile something with extensive
> autoconf scripts like Gnome.  It's a major pain to get that done right.
> Running the compiler is the trivial part of build some package ...

Our cross development environment make it easy to rebuild all packages
we support, but the big endian tool chain and libs aren't ready yet.  I
think I'll just wait :-)  I've got plenty of things broken as it is,
without the userland packages.

> > Also, you can take a look of the rpm spec files for the toolchains I put
> > on ftp.mvista.com/pub/Area51/mips_le/.  So far all my usrland stuff are
> > cross-compiled - I don't have the luxury of a desktop MIPS with 1.6GB
> > RAM.
> 
> I bet your heating makes less noise ...


Pete
