Received:  by oss.sgi.com id <S554096AbRAZTj1>;
	Fri, 26 Jan 2001 11:39:27 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:16116 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553675AbRAZTi6>;
	Fri, 26 Jan 2001 11:38:58 -0800
Received: from mvista.com (IDENT:ppopov@zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f0QJZmI25472;
	Fri, 26 Jan 2001 11:35:48 -0800
Message-ID: <3A71D265.231904BB@mvista.com>
Date:   Fri, 26 Jan 2001 11:39:17 -0800
From:   Pete Popov <ppopov@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17 i586)
X-Accept-Language: bg, en
MIME-Version: 1.0
To:     Mike McDonald <mikemac@mikemac.com>
CC:     linux-mips@oss.sgi.com
Subject: Re: Cross compiling RPMs
References: <200101261927.LAA09872@saturn.mikemac.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Mike McDonald wrote:
> 
> >Date: Fri, 26 Jan 2001 10:37:03 -0800
> >From: Pete Popov <ppopov@mvista.com>
> >To: Mike McDonald <mikemac@mikemac.com>
> >Subject: Re: Cross compiling RPMs
> 
> >To start with, you'll need a cross tool chain setup properly with the
> >headers and libraries.  One option is
> >ftp.mvista.com:/pub/Area51/mips_fp_le. You can grab everything (the
> >entire root fs) or just the tools: binutils, gcc, kernel headers,
> >glibc.  Others might have similar toolchains they can point you at.
> >Another option is native builds, which I personally don't like.
> >
> >Pete
> 
>   I have a working tool chain that I use to cross compile a kernel
> with sources from. How do I convince rpm to use that chain?

Is that tool chain setup to compile userland apps? Can you cross compile
this:

hello.c:

int main()
{
    printf("hello world\n");
}

with a command such as "mips_fp_le-gcc -o hello hello.c" and get a
little endian mips binary that runs on your system?  

If so, then you need to modify the .spec file for the given rpm to pick
up the right tool chain, ... and you'll probably need to add macro files
that rpm picks up so  that you can do something like:

rpm -ba --target=xxxxx <spec file>

it works.

That's easier said than done.  I wouldn't know how to do it myself --
someone else has done it for me here.

Pete
