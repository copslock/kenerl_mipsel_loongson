Received:  by oss.sgi.com id <S553814AbQJND4S>;
	Fri, 13 Oct 2000 20:56:18 -0700
Received: from u-108.karlsruhe.ipdial.viaginterkom.de ([62.180.18.108]:31241
        "EHLO u-108.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553797AbQJND4C>; Fri, 13 Oct 2000 20:56:02 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S868877AbQJNDzu>;
        Sat, 14 Oct 2000 05:55:50 +0200
Date:   Sat, 14 Oct 2000 05:55:50 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jun Sun <jsun@mvista.com>
Cc:     linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: stable binutils, gcc, glibc ...
Message-ID: <20001014055550.B3816@bacchus.dhis.org>
References: <39E7EB73.9206D0DB@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <39E7EB73.9206D0DB@mvista.com>; from jsun@mvista.com on Fri, Oct 13, 2000 at 10:13:23PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Oct 13, 2000 at 10:13:23PM -0700, Jun Sun wrote:

> Sorry to bring this topic again, but I cannot seem to sort out all the
> pieces of info together to get a consistent picture.  Below is what I
> gathered through the recent emails on the lists.  Please take a look and
> correct any mistakes.  Particularly I like to know which version is
> considered STABLE today.  Perhaps there is also issue what version works
> with what.
> 
> Also, let me know if I miss something.
> 
> In the end I like to put it on a web page and track the future toolchain
> developments - for lazy hackers. :-)
> 
> Jun 
> 
> 1. binutils
> -----------
> 
> a) latest binutil cvs tree (v2.10) + debian patch
> 
> http://sourceware.cygnus.com/binutils/
> ftp://ftp.rfc822.org/pub/local/debian-mips/patches/rel32-binutils.diff
> 
> b) Andreas Jaeger recommanded Ulf's patch against the CVS tree.  He
> recommanded 
> 
> ftp://oss.sgi.com/pub/linux/mips/src/binutils/binutils-000420.diff.gz.  
> 
> But I only found the following file.
> 
> ftp://oss.sgi.com/pub/linux/mips/binutils/binutils-000424.diff.gz

The binutils paragraph is old new.  All of the required patches are now
in binutils except one which I sent to Ulf yesterday.

> c) What about those patches at the same ftp sites (v2.8.x)?
> 
> ftp://oss.sgi.com/pub/linux/mips/binutils/

Still recommended because we can't yet be sure that binutils-cvs are
kosher yet.  For example it's suspect that I can't build Emacs.  Might
be something else but in case of doubt binutils are the suspect ...

> 2. gcc
> -------
> 
> a) the cvs tree on oss.sgi.com (v2.7.2?) Any patch needed for TODAY's
> tree?  Ralf seems to suggest his patch posted on 09/08 is still needed
> (constructor, Keith gcse, etc).
>  
> b) Ralf's patch against egcs 1.1.2
> 
> ftp://oss.sgi.com/pub/linux/mips/src/egcs/egcs-1.1.2.diff.gz

Only intended for mips64 kernels..  Almost guaranteed to be unusable for
anything else.

> c) Ralf's patch against egcs 1.0.3a.  (Where is the base tar ball?)

On your favorite GNU site.

> ftp://oss.sgi.com/pub/linux/mips/egcs/egcs-1.0.3a-2.diff.gz
> 
> d) Andreas said the current development version 2.96 worked - with the
> later binutils and gcc.

Plus above mentioned constructor patch.

Seems to work reasonably well.


> 3.glibc
> -------
> 
> a) the cvs tree on oss.sgi.com (v2.0.6).  Any patch needed?

No.  However I'm not always doing the best job at keeping it uptodate.

> Florian pointed out the following patch.  I am not 100% sure if it is
> aginst the current sgi CVS tree.  Any confirmation?
> 
> ftp://ftp.rfc822.org/pub/local/debian-mips/patches/rel32-glibc.diff

Against the glibc cvs tree at Cygnus.

> b) Andreas is trying to get glibc 2.2 working.  Definitely bleeding edge
> stuff.
> 
> http://www.suse.de/%7Eaj/glibc-mips.html
> 
> c) Maciej reported he got binutils v2.10 working for glibc 2.2.  No
> details or any distribution.
> 
> d) glibc v2.0.7 from linux-vr project by Jay
> 
> ftp://ftp.place.org/pub/nop/linuxce/
> ftp://ftp.place.org/pub/nop/linuxce/rpms/glibc-2.0.7-20.src.rpm

2.0.7 has resulted in so many bug reports that I consider to plain dump any
related reports in the future.

  Ralf
