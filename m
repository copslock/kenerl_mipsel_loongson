Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Oct 2004 09:22:19 +0100 (BST)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:49907 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8224932AbUJSIWN>;
	Tue, 19 Oct 2004 09:22:13 +0100
Received: from waterleaf.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i9J8M5Mp010322;
	Tue, 19 Oct 2004 10:22:05 +0200 (MEST)
Date: Tue, 19 Oct 2004 10:22:04 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: thomas_blattmann@canada.com
cc: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: crt1.o missing
In-Reply-To: <20041018165504.6798.h002.c009.wm@mail.canada.com.criticalpath.net>
Message-ID: <Pine.GSO.4.61.0410191016430.13789@waterleaf.sonytel.be>
References: <20041018165504.6798.h002.c009.wm@mail.canada.com.criticalpath.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6097
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Mon, 18 Oct 2004 thomas_blattmann@canada.com wrote:
> > On Fri, Oct 15, 2004 at 05:48:31PM -0700,
> > thomas_blattmann@canada.com wrote:
> > 
> > > I'm trying to crosscompile a hello-world program but
> > it
> > > fails:
> >
> /usr/local/lib/gcc-lib/mipsel-linux/2.96-mips3264-000710/../../../../mipsel-linux/bin/ld: cannot open crt1.o:
> > > No such file or directory
> > > collect2: ld returned 1 exit status
> > > 
> > > There are several postings in the archives but non
> of
> > > them helped me on so far. I will probably have to
> get
> > > the libc for mipsel-linux - but where can I get it
> and
> > > what to do with it ??
> > 
> > You need to install libc; the crt1.o file would end up
> > being in
> > /usr/local/mipsel-linux/lib/crt1.o then.
> > 
> >   Ralf
> 
> Hi,
> what libc do I have to install and where can I get it.
> I have libc6 installed:
> 
> inspiron:~# apt-get install libc6
> Reading Package Lists... Done
> Building Dependency Tree... Done
> libc6 is already the newest version.
> 0 upgraded, 0 newly installed, 0 to remove and 1 not
> upgraded.
> 
> inspiron:~# apt-get install libc6-dev
> Reading Package Lists... Done
> Building Dependency Tree... Done
> libc6-dev is already the newest version.
> 0 upgraded, 0 newly installed, 0 to remove and 1 not
> upgraded.
> 
> inspiron:~# uname -a
> Linux inspiron 2.4.26 #7 Thu Sep 9 17:11:08 CEST 2004
> i686 GNU/Linux

That's the host-libc6. You need a target-libc6.

tpkg-install-libc can do that for you. You need to install dpkg-cross and
toolchain-source first.  More information about this can be found in
/usr/share/doc/toolchain-source/ (toolchain-source is the Debian-recommended
way to build cross-compilers).

But since you're compiler is installed in /usr/local/ and dpkg-cross will
install libc6 in /usr, you'll have to add some symbolic links from (possibly
some parts under) /usr/local/mipsel-linux/ to /usr/lib/mipsel-linux/.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
