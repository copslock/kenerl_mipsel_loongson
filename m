Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Oct 2004 01:35:28 +0100 (BST)
Received: from h015.c009.snv.cp.net ([IPv6:::ffff:209.228.34.128]:55782 "HELO
	c009.snv.cp.net") by linux-mips.org with SMTP id <S8225228AbUJUAfX>;
	Thu, 21 Oct 2004 01:35:23 +0100
Received: (cpmta 11596 invoked from network); 20 Oct 2004 17:35:17 -0700
Received: from 209.228.34.126 (HELO mail.canada.com.criticalpath.net)
  by smtp.canada.com (209.228.34.128) with SMTP; 20 Oct 2004 17:35:17 -0700
X-Sent: 21 Oct 2004 00:35:17 GMT
Received: from [69.193.111.169] by mail.canada.com with HTTP;
    Wed, 20 Oct 2004 17:35:16 -0700 (PDT)
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
To: geert@linux-m68k.org
Cc: linux-mips@linux-mips.org
From: thomas_blattmann@canada.com
Subject: Re: crt1.o missing
X-Sent-From: thomas_blattmann@canada.com
Date: Wed, 20 Oct 2004 17:35:16 -0700 (PDT)
X-Mailer: Web Mail 5.6.4-0
Message-Id: <20041020173517.2756.h013.c009.wm@mail.canada.com.criticalpath.net>
Return-Path: <thomas_blattmann@canada.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6149
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas_blattmann@canada.com
Precedence: bulk
X-list: linux-mips


> That's the host-libc6. You need a target-libc6.
> 
> tpkg-install-libc can do that for you. You need to
> install dpkg-cross and
> toolchain-source first.  More information about this
> can be found in
> /usr/share/doc/toolchain-source/ (toolchain-source is
> the Debian-recommended
> way to build cross-compilers).
> 
> But since you're compiler is installed in /usr/local/
> and dpkg-cross will
> install libc6 in /usr, you'll have to add some
symbolic
> links from (possibly
> some parts under) /usr/local/mipsel-linux/ to
> /usr/lib/mipsel-linux/.
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond
ia32
> -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I
call
> myself a hacker. But
> when I'm talking to journalists I just say
"programmer"
> or something like that.
> 							    -- Linus 

I tired 'tpkg-install-libc mipsel' and mipsel-linux. It
failed with the error message

Building libc6-mipsel-cross_2.3.2.ds1-18_all.deb
Unpacking libc6-mipsel-cross
dpkg: dependency problems prevent configuration of
libc6-mipsel-cross:
 libc6-mipsel-cross depends on
libdb1-compat-mipsel-cross; however:
  Package libdb1-compat-mipsel-cross is not installed.
dpkg: error processing libc6-mipsel-cross (--install):
 dependency problems - leaving unconfigured
Errors were encountered while processing:
 libc6-mipsel-cross
dpkg -i failed.


...and I can't find this package
libdb1-compat-mipsel-cross.

I also tried dpgk-make mipsel - got the two
directories, debuild and debi worked well with
binutils-gcc-mipsel-2.15 - debuild failes however in
gcc-mipsel-3.0.4 withdh_testdir
dh_testroot
dh_installdocs
dh_installman
dh_installinfo
dh_undocumented
dh_installchangelogs 
dh_link
dh_strip
strip: Unable to recognise the format of the input file
_m16subsf3.o
dh_strip: command returned error code
make: *** [binary-arch] Error 1
debuild: fatal error at line 456:
dpkg-buildpackage failed!

All I need is to compile hello world to get it run on a
mips ;) Any ideas ?

thx

Thomas
