Received:  by oss.sgi.com id <S553823AbQJ0RNW>;
	Fri, 27 Oct 2000 10:13:22 -0700
Received: from gateway-490.mvista.com ([63.192.220.206]:22004 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553820AbQJ0RNH>;
	Fri, 27 Oct 2000 10:13:07 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id e9RHBL310703;
	Fri, 27 Oct 2000 10:11:25 -0700
Message-ID: <39F9B7EF.D6469D07@mvista.com>
Date:   Fri, 27 Oct 2000 10:14:23 -0700
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     Ralf Baechle <ralf@oss.sgi.com>
CC:     Pete Popov <ppopov@mvista.com>,
        "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: userland packages
References: <39F8CE01.3782BBF5@mvista.com> <20001027043432.F6628@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Ralf Baechle wrote:
> 
> On Thu, Oct 26, 2000 at 05:36:17PM -0700, Pete Popov wrote:
> 
> > Is there a guide on how to rebuild userland packages from source code?
> > I've installed the cross compiler and can compile a kernel, but when I
> > try to build a simple userland app, the compiler can't find libraries,
> > include files, etc.
> 
> You have to copy all the includes and libraries to
> /usr/mips-linux/{include,lib}/, then fixup linker scripts that disguise
> themselfes as .so files like libc.so and you can start.
> 
> Getting everything to crosscompile is a hard job, I really recomend
> native builds.
> 

Pete,

He is not telling the truth. :-)  See his very own MIPS-HOWTO,
cross-compile section :

http://www.linux.sgi.com/mips-howto.html

Also, you can take a look of the rpm spec files for the toolchains I put
on ftp.mvista.com/pub/Area51/mips_le/.  So far all my usrland stuff are
cross-compiled - I don't have the luxury of a desktop MIPS with 1.6GB
RAM.

Jun
