Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Dec 2003 20:30:23 +0000 (GMT)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:22517 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225205AbTL1UaW>;
	Sun, 28 Dec 2003 20:30:22 +0000
Received: from waterleaf.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id hBSKUHQG029495;
	Sun, 28 Dec 2003 21:30:19 +0100 (MET)
Date: Sun, 28 Dec 2003 21:30:17 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: Linux-Mips <linux-mips@linux-mips.org>
Subject: Re: What toolchain for vr4181
In-Reply-To: <Pine.GSO.4.21.0310091320000.7430-100000@waterleaf.sonytel.be>
Message-ID: <Pine.GSO.4.21.0312282120390.2325-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3840
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Thu, 9 Oct 2003, Geert Uytterhoeven wrote:
> On Thu, 9 Oct 2003, Jan-Benedict Glaw wrote:
> > If companies have some kind of scripts or the like they use, I'd really
> > love to see them published. That'd really help all those guys out
> > there:)
> 
> Binutils (binutils-2.13.2.1.tar.bz2):
>     configure --target=mips-linux --prefix=/wherever/you/want
> 
> Gcc (gcc-core-3.2.2.tar.bz2):
>     configure --target=mips-linux --prefix=/wherever/you/want --enable-languages=c --enable-shared --with-gnu-as --with-gnu-ld --with-systemm-zlib --enable-long-long --enable-nls --without-included-gettext
> 
> I took the development libraries and includes from Debian:
>     libc6-dev_2.2.5-11.2_mips.deb
>     libc6_2.2.5-11.2_mips.deb
>     zlib1g-dev_1%3a1.1.4-1_mips.deb
>     zlib1g_1%3a1.1.4-1_mips.deb
> 
> I wrote very simple Perl clones of dpkg and dpkg-deb with just enough
> functionality to get `dpkg-cross -i' working on Solaris. I don't know whether I
> can share them, though.

It took me a while, but here they are, wrapped as a Christmas gift! :-)

You also have to take /usr/bin/dpkg-cross from a Debian system and probably
want to hardcode crossbase=/wherever/you/want, unless you're root.

BTW, I'd still really like to have some scripts so I can install (from binary
or from sources) Debian binaries in my home dir on a Red Hat or Solaris box.
Wishful thinking?

--- /dev/null	2003-12-21 17:51:51.000000000 +0100
+++ dpkg	2003-12-28 21:23:47.000000000 +0100
@@ -0,0 +1,29 @@
+#!/usr/bin/perl
+
+#
+# Very simple dpkg clone with just enough functionality to get `dpkg-cross -i'
+# working on Solaris
+#
+# © Copyright 2003 by Geert Uytterhoeven <geert@linux-m68k.org>
+#
+# This file is subject to the terms and conditions of the GNU General Public
+# License.
+#
+
+$progname = $0;
+$progname =~ s@^.*/@@g;
+
+
+$args = join(' ', @ARGV);
+print STDERR "$progname $args...\n";
+
+$arg = shift @ARGV or goto failed;
+if ($arg eq '-i') {
+  $archive = shift @ARGV or goto failed;
+  system("ar -p $archive data.tar.gz | (cd / && tar zxf - )");
+  exit(0);
+}
+
+failed:
+die "$progname $args: failed\n";
+
--- /dev/null	2003-12-21 17:51:51.000000000 +0100
+++ dpkg-deb	2003-12-28 21:23:25.000000000 +0100
@@ -0,0 +1,82 @@
+#!/usr/bin/perl
+
+#
+# Very simple dpkg-deb clone with just enough functionality to get
+# `dpkg-cross -i' working on Solaris
+#
+# © Copyright 2003 by Geert Uytterhoeven <geert@linux-m68k.org>
+#
+# This file is subject to the terms and conditions of the GNU General Public
+# License.
+#
+
+$progname = $0;
+$progname =~ s@^.*/@@g;
+
+
+$args = join(' ', @ARGV);
+
+$arg = shift @ARGV or goto failed;
+if ($arg eq '-f') {
+  # Get package name, version, or architecture
+  $archive = shift @ARGV or goto failed;
+  $field = shift @ARGV or goto failed;
+  ($package, $version, $architecture) = $archive =~ /(.*)_(.*)_(.*).deb/;
+  $package =~ s,.*/,,;
+  if ($field eq 'package') {
+    print "$package\n";
+    exit(0);
+  } elsif ($field eq 'version') {
+    print "$version\n";
+    exit(0);
+  } elsif ($field eq 'architecture') {
+    print "$architecture\n";
+    exit(0);
+  }
+} elsif ($arg eq '-e') {
+  # Extract the contents of control.tar.gz to a specified subdirectory
+  $archive = shift @ARGV or goto failed;
+  $dir = shift @ARGV or goto failed;
+  system("mkdir -p $dir && ar -p $archive control.tar.gz | (cd $dir && tar zxf - )");
+  exit(0);
+} elsif ($arg eq '--fsys-tarfile') {
+  # Extract the contents of data.tar.gz to stdout
+  $archive = shift @ARGV or goto failed;
+  system("ar -p $archive data.tar.gz | zcat");
+  exit(0);
+} elsif ($arg eq '-I') {
+  # Extract the control file to stdout
+  $archive = shift @ARGV or goto failed;
+  $name = shift @ARGV or goto failed;
+  system("ar -p $archive control.tar.gz | tar Ozxf - ./$name");
+  exit(0);
+} elsif ($arg eq '-b') {
+  $dir1 = shift @ARGV or goto failed;
+  $dir2 = shift @ARGV or goto failed;
+  # Extract package name and version from the control file
+  open(IN, "<$dir1/DEBIAN/control") or die;
+  $line = <IN>;
+  chomp($line);
+  ($package) = $line =~ /^Package: (.*)/;
+  $line = <IN>;
+  chomp($line);
+  ($version) = $line =~ /^Version: (.*)/;
+  close(IN);
+  $name = $package.'_'.$version.'_all.deb';
+  $name =~ s/:/%3a/g;
+  # Create control.tar.gz
+  system("cd $dir1/DEBIAN && tar zcf ../../control.tar.gz .");
+  system("cd $dir1 && rm -rf DEBIAN");
+  # Create data.tar.gz
+  system("cd $dir1 && tar zcf ../data.tar.gz .");
+  # Create debian-binary
+  system("echo '2.0' > $dir1/../debian-binary");
+  # Build a new Debian package
+  system("cd $dir1/.. && ar -r $name debian-binary control.tar.gz data.tar.gz");
+  system("mv $dir1/../$name $dir2/$name");
+  exit(0);
+}
+
+failed:
+die "$progname $args: failed\n";
+

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
