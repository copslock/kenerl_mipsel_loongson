Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jan 2006 14:54:47 +0000 (GMT)
Received: from lennier.cc.vt.edu ([198.82.162.213]:35231 "EHLO
	lennier.cc.vt.edu") by ftp.linux-mips.org with ESMTP
	id S8134400AbWASOyZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Jan 2006 14:54:25 +0000
Received: from steiner.cc.vt.edu (IDENT:mirapoint@evil-steiner.cc.vt.edu [10.1.1.14])
	by lennier.cc.vt.edu (8.12.11/8.12.11) with ESMTP id k0JEvpYu027477;
	Thu, 19 Jan 2006 09:57:51 -0500
Received: from [128.173.184.73] (gs4073.geos.vt.edu [128.173.184.73])
	by steiner.cc.vt.edu (MOS 3.6.4-CR)
	with ESMTP id EUR63008;
	Thu, 19 Jan 2006 09:57:45 -0500 (EST)
Message-ID: <43CFA8DC.9050904@gentoo.org>
Date:	Thu, 19 Jan 2006 09:57:32 -0500
From:	"Stephen P. Becker" <geoman@gentoo.org>
User-Agent: Mail/News 1.5 (X11/20060116)
MIME-Version: 1.0
To:	olegol@aport.ru
CC:	linux-mips@linux-mips.org
Subject: Re: GTK/GLIB port for mipsel
References: <43CF864F.1020202@gentoo.org> <Vy3HKuPmiEfd4pZ@aport2000.ru>
In-Reply-To: <Vy3HKuPmiEfd4pZ@aport2000.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <geoman@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9994
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geoman@gentoo.org
Precedence: bulk
X-list: linux-mips

> I'm trying to install glib 2.8.3 (I do not think it is 
> too much different from 2.8.5). I have little-endian mips 
> architecture (mipsel) and am installing the library on 
> the RedHat Linux with core 2.4 (both on a target and on a 
> host).

Well, my machines use 2.6 kernel and headers, however I don't think that 
is the problem and/or answer in this case.


> I'm using the following parameters with configure:
> ./configure --prefix=<path> --build=mipsel-linux --
> host=i686-linux --with-libiconv=gnu

That shouldn't be a problem as far as I can see.  For what it's worth, 
my glib was configured with:

./configure --prefix=/usr --host=mips64-unknown-linux-gnu 
--mandir=/usr/share/man --infodir=/usr/share/info --datadir=/usr/share 
--sysconfdir=/etc --localstatedir=/var/lib --with-threads=posix 
--disable-gtk-doc --build=mips64-unknown-linux-gnu


> Do you have you gtk/glib compiled from the sources on 
> your machine or just a binaries installed?

Compiled from sources (natively, not cross-compiled).  I do use Gentoo 
after all...


> Do you have a ./glib/gatomic.c file compiled?

Sure do:

cthulhu .libs # file gatomic.o
gatomic.o: ELF 32-bit MSB relocatable, MIPS, N32 MIPS-IV version 1 
(SYSV), not stripped


> I do not quite understand how that can be (I could not see there a 
> section for MIPS/MIPSEL). Also, do you have any of the 
> G_ATOMIC_<platform> macros defined in the config.h file?

I suspect that glib is broken for cross-compile in this way.  It is 
probably detecting that your host i686 install can use asm code for 
atomic operations, and thus enables it, which of course kills your 
build.  Natively, it looks like it does the RightThing(TM):

checking whether to use assembler code for atomic operations... none

-Steve
