Received:  by oss.sgi.com id <S553738AbQK2NrB>;
	Wed, 29 Nov 2000 05:47:01 -0800
Received: from dragon.appliedmicro.ns.ca ([24.222.12.66]:7187 "EHLO
        appliedmicro.ns.ca") by oss.sgi.com with ESMTP id <S553695AbQK2Nqd>;
	Wed, 29 Nov 2000 05:46:33 -0800
Received: by dragon.appliedmicro.ns.ca id <7303>; Wed, 29 Nov 2000 09:41:45 -0400
To:     linux-mips@oss.sgi.com
Cc:     chris@debian.org
Subject: Re: cross-compile tools made easy ...
Message-Id: <00Nov29.094145ast.7303@dragon.appliedmicro.ns.ca>
References: <20001128214111.B9875@gateway.junsun.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001128214111.B9875@gateway.junsun.net>; from jsun@junsun.net on Wed, Nov 29, 2000 at 01:37:21AM -0400
From:   fifield@amirix.com (Jamie Fifield)
Date:   Wed, 29 Nov 2000 09:41:43 -0400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On that vein.  I've got a trvial patch against the binutils in Debian (woody)
for a cross binutils for big endian mips.

jamie:~$ dpkg -s binutils-mips
Package: binutils-mips
Status: install ok installed
Priority: extra
Section: devel
Installed-Size: 6364
Maintainer: Christopher C. Chimelis <chris@debian.org>
Source: binutils
Version: 2.10.1.0.2-1
Suggests: binutils (= 2.10.1.0.2-1)
Description: Binary utilities that support MIPS (Big Endian) targets.
 The programs in this package are used to manipulate binary and object
 files that may have been created on the MIPS (Big Endian) architecture.
 This package is primarily for MIPS developers and cross-compilers and is
 not needed by normal users or developers.


My version is compiled against glibc 2.1.3, so YMMV against 2.2.

Chris: Any chance I could persuade you to upload a binutils-mips to Woody? :)

Patch is below (and this patch does not build a mips target by default, you
still need to do ./debian/rules TARGET=mips binary-cross).


diff -uNr binutils-2.10.1.0.2/debian/control binutils-2.10.1.0.2-mips/debian/control
--- binutils-2.10.1.0.2/debian/control	Wed Nov 29 09:39:07 2000
+++ binutils-2.10.1.0.2-mips/debian/control	Tue Nov 28 09:21:58 2000
@@ -85,6 +85,17 @@
  This package is primarily for MIPS developers and cross-compilers and is 
  not needed by normal users or developers.
 
+Package: binutils-mips
+Section: devel
+Architecture: any
+Priority: extra
+Suggests: binutils (= ${Source-Version})
+Description: Binary utilities that support MIPS (Big Endian) targets.
+ The programs in this package are used to manipulate binary and object
+ files that may have been created on the MIPS (Big Endian) architecture.  
+ This package is primarily for MIPS developers and cross-compilers and is 
+ not needed by normal users or developers.
+
 Package: binutils-avr
 Section: devel
 Architecture: any
diff -uNr binutils-2.10.1.0.2/debian/rules binutils-2.10.1.0.2-mips/debian/rules
--- binutils-2.10.1.0.2/debian/rules	Wed Nov 29 09:39:07 2000
+++ binutils-2.10.1.0.2-mips/debian/rules	Tue Nov 28 09:23:15 2000
@@ -74,7 +74,7 @@
 # debian/control for each of these. For example, the cross binutils package
 # for powerpc is called binutils-powerpc.
 #
-ALL_TARGETS =     avr powerpc arm m68k mipsel
+ALL_TARGETS =     avr powerpc arm m68k mipsel mips
 
 # Targets NOT to build for. This is the set difference ALL_TARGETS - TARGETS
 #


On Wed, Nov 29, 2000 at 01:37:21AM -0400, Jun Sun wrote:
> 
> I found myself building cross-compile toolchains a lot recently.  So I 
> spent sometime and wrote a script to do the whole darn thing in one shot.  
> 
> If you want to build your own cross-compile tools, you can save some
> effort by just getting the tar balls and then typing "build".
> 
> It is not too much different from what is in Ralf's "Linux MIPS HOW-TO" 
> cross-compile section.  But the tarball offers some convenience by having 
> all the sources and patches put together and all configurations, options 
> lumped in one file.
> 
> You can find two tar balls at linux.junsun.net:
> 
> mips-xtool-1.1.tar.gz
> 	binutils 2.8.1 + egcs 1.1.2 + glibc 2.0.6
> 	(Thanks to Keith Wesolows for the glibc fix with egcs 1.1.2)
> 
> mips-xtool-0.1.tar.gz
> 	binutils 2.8.1 + egcs 1.0.3a + glibc 2.0.6
> 
> 
> I did some minimal tests with kernel and building a couple of packages,
> and would very much like to know if you have any problems (Yes, that is
> the purpose. :-0)
>  
> Enjoy!
> 
> Jun 

-- 
Jamie Fifield

Software Designer		Jamie.Fifield@amirix.com
AMIRIX Systems Inc.		http://www.amirix.com/
Embedded Debian Project		http://www.emdebian.org/
77 Chain Lake Drive		902-450-1700 x247 (Phone)
Halifax, N.S. B3S 1E1		902-450-1704 (FAX)
