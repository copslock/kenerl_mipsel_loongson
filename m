Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Nov 2007 01:08:29 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.185]:59170 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20026354AbXKGBIU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 7 Nov 2007 01:08:20 +0000
Received: by nf-out-0910.google.com with SMTP id c10so1587258nfd
        for <linux-mips@linux-mips.org>; Tue, 06 Nov 2007 17:08:10 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=ZVCRxtXdNr+V7f6KX0EWYVeTFvdcI+uNHgJ97agLaYI=;
        b=imeiVQB+kv9ButeMN4c5NTsmBntJgrc3D4P/qZshzaiDn4Q84nbnS1qCsu/D9str6oRBJwa/XnBf7gsTwsBcYjX14367kU0KDQDVQ4NFMT992toIpkOb83qHqdGSsLN35rC2bCOpCo76GCx082vNrKeZctTAvEVM84sbd0B3eO8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Xx5WIg/FthiedxlsjXcOcfNbFdFgXr44/tqpo0GzFk17w/MAbUZSoM+XxjSzOFt5IIbVo5xEOG2f0icJQLb2I4/aNYge7Jh3Ol9LpJk9t/3SJsPS0yn7uPXIpcmKGP708u6h/lJT96uMThoRAdyzqH8/BrOV7586+Ro7fD16oz0=
Received: by 10.78.176.20 with SMTP id y20mr5480679hue.1194397690264;
        Tue, 06 Nov 2007 17:08:10 -0800 (PST)
Received: by 10.78.29.10 with HTTP; Tue, 6 Nov 2007 17:08:10 -0800 (PST)
Message-ID: <3b279e3f0711061708r12913a29o62e4bf99a2ee3664@mail.gmail.com>
Date:	Wed, 7 Nov 2007 01:08:10 +0000
From:	"Reeve Yang" <reeve.yang@gmail.com>
To:	linux-mips@linux-mips.org
Subject: cross-tool for mips target
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <reeve.yang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17427
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: reeve.yang@gmail.com
Precedence: bulk
X-list: linux-mips

Hi there,

I'm trying to build cross tool chain for mips32 target from my pc
(i686) based on crosstoll-0.43. By running "sh demo-mips.sh" (I chose
eval `cat mips.dat gcc-3.4.5-glibc-2.3.5.dat` sh all.sh --notest), I
got following error from log file. Has anyone ever had similiar
experience and how did you fix it? Thanks!

- Reeve

## ----------- ##
## Core tests. ##
## ----------- ##

configure:1706: checking build system type
configure:1724: result: i686-pc-linux-gnu
configure:1732: checking host system type
configure:1746: result: mips642-unknown-linux-gnu
configure:1998: checking sysdep dirs
configure:2214: result: sysdeps/generic/elf sysdeps/generic
configure:2233: checking for a BSD-compatible install
configure:2288: result: /usr/bin/install -c
configure:2303: checking whether ln -s works
configure:2307: result: yes
configure:2323: checking for mips32-linux-gnu-gcc
configure:2349: result: gcc
configure:2631: checking for C compiler version
configure:2634: gcc --version </dev/null >&5
gcc (GCC) 3.3.5 (Debian 1:3.3.5-13)
Copyright (C) 2003 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

configure:2637: $? = 0
configure:2639: gcc -v </dev/null >&5
Reading specs from /usr/lib/gcc-lib/i486-linux/3.3.5/specs
Configured with: ../src/configure -v
--enable-languages=c,c++,java,f77,pascal,objc,ada,treelang --prefix=/
usr --mandir=/usr/share/man --infodir=/usr/share/info
--with-gxx-include-dir=/usr/include/c++/3.3 --enable
-shared --enable-__cxa_atexit --with-system-zlib --enable-nls
--without-included-gettext --enable-clocale=
gnu --enable-debug --enable-java-gc=boehm --enable-java-awt=xlib
--enable-objc-gc i486-linux
Thread model: posix
gcc version 3.3.5 (Debian 1:3.3.5-13)
configure:2642: $? = 0
configure:2644: gcc -V </dev/null >&5
gcc: `-V' option must have argument
configure:2647: $? = 1
configure:2651: checking for suffix of object files
configure:2672: gcc -c   -mabi=n32 conftest.c >&5
cc1: error: invalid option `abi=n32'
configure:2675: $? = 1
configure: failed program was:
| /* confdefs.h.  */
|
| #define PACKAGE_NAME "GNU C Library"
| #define PACKAGE_TARNAME "c-library"
| #define PACKAGE_VERSION "(see version.h)"
| #define PACKAGE_STRING "GNU C Library (see version.h)"
| #define PACKAGE_BUGREPORT "glibc"
| /* end confdefs.h.  */
|
| int
| main ()
| {
|
|   ;
|   return 0;
| }
configure:2689: error: cannot compute suffix of object files: cannot compile
See `config.log' for more details.
