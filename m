Received:  by oss.sgi.com id <S553767AbQJNK6a>;
	Sat, 14 Oct 2000 03:58:30 -0700
Received: from noose.gt.owl.de ([62.52.19.4]:59408 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553679AbQJNK6X>;
	Sat, 14 Oct 2000 03:58:23 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id E18517F8; Sat, 14 Oct 2000 12:58:20 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 74D89900C; Sat, 14 Oct 2000 12:55:32 +0200 (CEST)
Date:   Sat, 14 Oct 2000 12:55:32 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     Jun Sun <jsun@mvista.com>
Cc:     linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: stable binutils, gcc, glibc ...
Message-ID: <20001014125532.A1536@paradigm.rfc822.org>
References: <39E7EB73.9206D0DB@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <39E7EB73.9206D0DB@mvista.com>; from jsun@mvista.com on Fri, Oct 13, 2000 at 10:13:23PM -0700
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Oct 13, 2000 at 10:13:23PM -0700, Jun Sun wrote:
> Jun 
> 
> 1. binutils
> -----------
> 
> a) latest binutil cvs tree (v2.10) + debian patch
> 
> http://sourceware.cygnus.com/binutils/
> ftp://ftp.rfc822.org/pub/local/debian-mips/patches/rel32-binutils.diff

Its not a debian patch - I just put it up when i got it out of Ralfs
Nose :)

> b) Andreas Jaeger recommanded Ulf's patch against the CVS tree.  He
> recommanded 

Just use cvs 

> 2. gcc
> -------
> 
> a) the cvs tree on oss.sgi.com (v2.7.2?) Any patch needed for TODAY's
> tree?  Ralf seems to suggest his patch posted on 09/08 is still needed
> (constructor, Keith gcse, etc).

I am using current cvs - Which seems to do quiet well ...

> 3.glibc
> -------
> 
> a) the cvs tree on oss.sgi.com (v2.0.6).  Any patch needed?

*urgs* 2.0.6 - I am currently building everything against 2.0.6 but
i rather now then later stop using it - But currently i am not using 2.2
because with the newest patch set by Ralf (glibc + binutils) i get
a bus error while using rpcgen with the freshly build 2.2 glibc in
the build process ...

> Florian pointed out the following patch.  I am not 100% sure if it is
> aginst the current sgi CVS tree.  Any confirmation?
> 
> ftp://ftp.rfc822.org/pub/local/debian-mips/patches/rel32-glibc.diff

This is the corresponding patch to the binutils things - Doesnt solve
my problem though.

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5201-669912
      "Write only memory - Oops. Time for my medication again ..."
