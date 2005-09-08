Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Sep 2005 22:05:42 +0100 (BST)
Received: from web31502.mail.mud.yahoo.com ([IPv6:::ffff:68.142.198.131]:58811
	"HELO web31502.mail.mud.yahoo.com") by linux-mips.org with SMTP
	id <S8225329AbVIHVFV>; Thu, 8 Sep 2005 22:05:21 +0100
Received: (qmail 86770 invoked by uid 60001); 8 Sep 2005 21:11:27 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=zt1rjVqh9MZpv+iz+iBrfRHlONHP9H9BZhA/KNkpMMpfCMPeWGanZ/hwuLMWGn2ojkNf8Z8F+54sEVG9cbQhaQGZweDtsNQN1NSTqM5A839hV5c9XDVfv+jyMrmtjVPoqERU1FZN41sX5bRyL3Kq2C2nuCSrYGXVVM36G+sOirE=  ;
Message-ID: <20050908211127.86768.qmail@web31502.mail.mud.yahoo.com>
Received: from [208.187.37.98] by web31502.mail.mud.yahoo.com via HTTP; Thu, 08 Sep 2005 14:11:26 PDT
Date:	Thu, 8 Sep 2005 14:11:26 -0700 (PDT)
From:	Jonathan Day <imipak@yahoo.com>
Subject: Re: Question regarding compiling a toolchain for a Broadcom SB1
To:	Daniel Kegel <dank@kegel.com>, gcc@gcc.gnu.org
Cc:	linux-mips@linux-mips.org, crossgcc <crossgcc@sources.redhat.com>
In-Reply-To: <43207601.7020000@kegel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <imipak@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8906
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: imipak@yahoo.com
Precedence: bulk
X-list: linux-mips

Here's the web link to all of the patches needed by
the Linux From Scratch group.

http://documents.jg555.com/cross-lfs/mips64-64/materials/patches.html

I'm doing a build from the binutils, gcc and glibc
from CVS, for an initial run. Results so far:

Binutils patches cleanly, using the patch on file. It
seems to build fine, when patched, but until all
stages are complete, there's no easy way to verify
that.

GCC won't take the Posix patch and some of the other
patches need massaging, but there doesn't seem to be
any major problems. HOWEVER, this does say that you'd
best stick with the intended version (GCC 4.0.1) for
your build scripts.

Glibc will take the 64-bit fixes but all other patches
are rejected. It failed on the forced unwinding test,
when configuring. According to the LFS docs, NPTL is
broken for MIPS64, but I don't know if that is still
the case. I decided to backtrack to the glibc that
works, according to the LFS, and have classed the
status of Glibc for MIPS64 as uncertain.


--- Daniel Kegel <dank@kegel.com> wrote:

> Jonathan Day <imipak at yahoo dot com> wrote:
> > Crosstool, for example, only supports 32-bit MIPS
> -
> > and even then the build matrix is a pretty sh
ade
> of
> > red for the most part.
> 
> [ The build matrix:
> http://kegel.com/crosstool/current/buildlogs/ ]
> 
> There are quite a few combinations that build for
> 32-bit mips with crosstool, e.g.
>   mips-gcc-3.2.3-glibc-2.2.5
>   mips-gcc-3.2.3-glibc-2.3.2
>   mips-gcc-3.3.6-glibc-2.2.5
>   mips-gcc-3.3.6-glibc-2.3.5
>   mips-gcc-3.4.4-glibc-2.3.2-hdrs-2.6.11.2
>   mips-gcc-3.4.4-glibc-2.3.5-hdrs-2.6.11.2
>   mips-gcc-4.1-20050702-glibc-2.3.2-hdrs-2.6.11.2
>   mips-gcc-4.1-20050709-glibc-2.3.2-hdrs-2.6.11.2
> so the situation isn't that dire.
> 
> For the record, I would be more than happy to add
> mips64 support to crosstool.
>
http://www.linux-mips.org/archives/linux-mips/2005-07/msg00189.html
>
http://documents.jg555.com/cross-lfs/mips64-64/cross-tools/glibc.html
>
http://documents.jg555.com/cross-lfs/mips64-64/cross-tools/gcc-final.html
> mentions some patches that might be needed.
> I haven't had time to chase them down and add them
> to crosstool,
> but if anybody else felt like it, I'd gladly accept
> the patches.
> I'm sure a lot of mips64 users would be very happy.
> - Dan
> 
> 
> 



	
		
______________________________________________________
Click here to donate to the Hurricane Katrina relief effort.
http://store.yahoo.com/redcross-donate3/
