Received:  by oss.sgi.com id <S553809AbQJMWOQ>;
	Fri, 13 Oct 2000 15:14:16 -0700
Received: from gateway-490.mvista.com ([63.192.220.206]:54261 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553806AbQJMWOC>;
	Fri, 13 Oct 2000 15:14:02 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id e9DMCGx18916;
	Fri, 13 Oct 2000 15:12:16 -0700
Message-ID: <39E7EB73.9206D0DB@mvista.com>
Date:   Fri, 13 Oct 2000 22:13:23 -0700
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: stable binutils, gcc, glibc ...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Sorry to bring this topic again, but I cannot seem to sort out all the
pieces of info together to get a consistent picture.  Below is what I
gathered through the recent emails on the lists.  Please take a look and
correct any mistakes.  Particularly I like to know which version is
considered STABLE today.  Perhaps there is also issue what version works
with what.

Also, let me know if I miss something.

In the end I like to put it on a web page and track the future toolchain
developments - for lazy hackers. :-)

Jun 

1. binutils
-----------

a) latest binutil cvs tree (v2.10) + debian patch

http://sourceware.cygnus.com/binutils/
ftp://ftp.rfc822.org/pub/local/debian-mips/patches/rel32-binutils.diff

b) Andreas Jaeger recommanded Ulf's patch against the CVS tree.  He
recommanded 

ftp://oss.sgi.com/pub/linux/mips/src/binutils/binutils-000420.diff.gz.  

But I only found the following file.

ftp://oss.sgi.com/pub/linux/mips/binutils/binutils-000424.diff.gz

c) What about those patches at the same ftp sites (v2.8.x)?

ftp://oss.sgi.com/pub/linux/mips/binutils/


2. gcc
-------

a) the cvs tree on oss.sgi.com (v2.7.2?) Any patch needed for TODAY's
tree?  Ralf seems to suggest his patch posted on 09/08 is still needed
(constructor, Keith gcse, etc).
 
b) Ralf's patch against egcs 1.1.2

ftp://oss.sgi.com/pub/linux/mips/src/egcs/egcs-1.1.2.diff.gz

c) Ralf's patch against egcs 1.0.3a.  (Where is the base tar ball?)

ftp://oss.sgi.com/pub/linux/mips/egcs/egcs-1.0.3a-2.diff.gz

d) Andreas said the current development version 2.96 worked - with the
later binutils and gcc.


3.glibc
-------

a) the cvs tree on oss.sgi.com (v2.0.6).  Any patch needed?

Florian pointed out the following patch.  I am not 100% sure if it is
aginst the current sgi CVS tree.  Any confirmation?

ftp://ftp.rfc822.org/pub/local/debian-mips/patches/rel32-glibc.diff

b) Andreas is trying to get glibc 2.2 working.  Definitely bleeding edge
stuff.

http://www.suse.de/%7Eaj/glibc-mips.html

c) Maciej reported he got binutils v2.10 working for glibc 2.2.  No
details or any distribution.

d) glibc v2.0.7 from linux-vr project by Jay

ftp://ftp.place.org/pub/nop/linuxce/
ftp://ftp.place.org/pub/nop/linuxce/rpms/glibc-2.0.7-20.src.rpm
