Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Oct 2004 08:47:34 +0100 (BST)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:700 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225073AbUJUHr2>;
	Thu, 21 Oct 2004 08:47:28 +0100
Received: from waterleaf.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i9L7lOMp024669;
	Thu, 21 Oct 2004 09:47:24 +0200 (MEST)
Date: Thu, 21 Oct 2004 09:47:23 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: thomas_blattmann@canada.com
cc: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: crt1.o missing
In-Reply-To: <20041020173517.2756.h013.c009.wm@mail.canada.com.criticalpath.net>
Message-ID: <Pine.GSO.4.61.0410210946170.614@waterleaf.sonytel.be>
References: <20041020173517.2756.h013.c009.wm@mail.canada.com.criticalpath.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6157
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Wed, 20 Oct 2004 thomas_blattmann@canada.com wrote:
> > That's the host-libc6. You need a target-libc6.
> > 
> > tpkg-install-libc can do that for you. You need to
> > install dpkg-cross and
> > toolchain-source first.  More information about this
> > can be found in
> > /usr/share/doc/toolchain-source/ (toolchain-source is
> > the Debian-recommended
> > way to build cross-compilers).
> > 
> > But since you're compiler is installed in /usr/local/
> > and dpkg-cross will
> > install libc6 in /usr, you'll have to add some
> symbolic
> > links from (possibly
> > some parts under) /usr/local/mipsel-linux/ to
> > /usr/lib/mipsel-linux/.
> 
> I tired 'tpkg-install-libc mipsel' and mipsel-linux. It
> failed with the error message
> 
> Building libc6-mipsel-cross_2.3.2.ds1-18_all.deb
> Unpacking libc6-mipsel-cross
> dpkg: dependency problems prevent configuration of
> libc6-mipsel-cross:
>  libc6-mipsel-cross depends on
> libdb1-compat-mipsel-cross; however:
>   Package libdb1-compat-mipsel-cross is not installed.
> dpkg: error processing libc6-mipsel-cross (--install):
>  dependency problems - leaving unconfigured
> Errors were encountered while processing:
>  libc6-mipsel-cross
> dpkg -i failed.
> 
> 
> ...and I can't find this package
> libdb1-compat-mipsel-cross.

Which toolchain-source are you using? Probably the one in Debian stable? Please
try testing.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
