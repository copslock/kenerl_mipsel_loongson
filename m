Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2006 16:42:15 +0100 (BST)
Received: from web31513.mail.mud.yahoo.com ([68.142.198.142]:63344 "HELO
	web31513.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133788AbWFPPmF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 16 Jun 2006 16:42:05 +0100
Received: (qmail 74839 invoked by uid 60001); 16 Jun 2006 15:41:54 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=zIeB18by4sz1jMl/VMTheOXdD6x9OzrJmtqrDRWpiNy92Dk1t6hJFr6Xnw3GSQwoh+rSTiW52cRH66+urGmMsrjCUSiV5cwPh7WzggibOVfsdEGWhSyOY1Gk3eEj+lM9z42yzd86d1BPE4vf+Wicly9JLMwHMv1torqHaZOI94k=  ;
Message-ID: <20060616154154.74837.qmail@web31513.mail.mud.yahoo.com>
Received: from [208.187.37.98] by web31513.mail.mud.yahoo.com via HTTP; Fri, 16 Jun 2006 08:41:54 PDT
Date:	Fri, 16 Jun 2006 08:41:54 -0700 (PDT)
From:	Jonathan Day <imipak@yahoo.com>
Subject: Re: gcc-4.1.0 cross-compile for MIPS
To:	kernel coder <lhrkernelcoder@gmail.com>, linux-mips@linux-mips.org
In-Reply-To: <f69849430606160522i12050d00n9a4a39810f13b8a0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <imipak@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11746
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: imipak@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi,

Two quick questions in return! :) First, did you use
the patches on the Linux From Scratch website, which
fixes problems with GCC in a MIPS environment?
(Although not using the MIPSEL environment myself, I'm
on a big-endiam system, I learned very quickly that
those patches really are essential.)

The second question is why 4.1.0? 4.1.1 fixes some
nasties, from what I understand, making that the
better of the 4.1.x branch. On the flip-side, 4.0.3 is
the last-known version of GCC that will compile G95
correctly, strongly hinting at remaining issues in
4.1.x that have the potential for generating incorrect
code. (I've not been able to build 4.2.x from SVN for
a while, although it adds some features I would love
to use.)

Jonathan Day

--- kernel coder <lhrkernelcoder@gmail.com> wrote:

> hi,
>    I'm trying to cross compile gcc-4.1.0 for mipsel
> platform.Following
> is the sequence of commands which i'm using.My host
> system is i686.
> 
> ../gcc-4.1.0/configure --target=mipsel
> --without-headres
> --prefix=/home/shahzad/install/ --with-newlib
> --enable-languages=c
> 
> make
> 
> But following error is generated
> 
> /home/shahzad/mips_gcc/./gcc/xgcc
> -B/home/shahzad/mips_gcc/./gcc/
> -B/home/shahzad/install//mipsel/bin/
> -B/home/shahzad/install//mipsel/lib/ -isystem
> /home/shahzad/install//mipsel/include -isystem
> /home/shahzad/install//mipsel/sys-include
> -DHAVE_CONFIG_H -I.
> -I../../../gcc-4.1.0/libssp -I. -Wall -O2 -g -O2 -MT
> ssp.lo -MD -MP
> -MF .deps/ssp.Tpo -c ../../../gcc-4.1.0/libssp/ssp.c
> -o ssp.o
> ../../../gcc-4.1.0/libssp/ssp.c:46:20: error:
> fcntl.h: No such file or directory
> ../../../gcc-4.1.0/libssp/ssp.c: In function
> '__guard_setup':
> ../../../gcc-4.1.0/libssp/ssp.c:70: warning:
> implicit declaration of
> function 'open'
> ../../../gcc-4.1.0/libssp/ssp.c:70: error:
> 'O_RDONLY' undeclared
> (first use in this function)
> ../../../gcc-4.1.0/libssp/ssp.c:70: error: (Each
> undeclared identifier
> is reported only once
> ../../../gcc-4.1.0/libssp/ssp.c:70: error: for each
> function it appears in.)
> ../../../gcc-4.1.0/libssp/ssp.c:73: error: 'ssize_t'
> undeclared (first
> use in this function)
> ../../../gcc-4.1.0/libssp/ssp.c:73: error: expected
> ';' before 'size'
> .........................................
> ........................................
> 
> I'm using fedora 5 as development platform and
> version of gcc
> installed on system is 4.1.0
> 
> thanks,
> shahzad
> 
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
