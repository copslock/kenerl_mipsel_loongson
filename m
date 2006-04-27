Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Apr 2006 06:25:44 +0100 (BST)
Received: from mail.soc-soft.com ([202.56.254.199]:52486 "EHLO
	igateway.soc-soft.com") by ftp.linux-mips.org with ESMTP
	id S8127208AbWD0FZe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 27 Apr 2006 06:25:34 +0100
Received: from keys.soc-soft.com ([192.168.4.44]) by igateway.soc-soft.com with InterScan VirusWall; Thu, 27 Apr 2006 10:55:26 +0530
Received: from soc-mail.soc-soft.com ([192.168.4.25])
  by keys.soc-soft.com (PGP Universal service);
  Thu, 27 Apr 2006 10:50:37 +0530
X-PGP-Universal: processed;
	by keys.soc-soft.com on Thu, 27 Apr 2006 10:50:37 +0530
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Compiling glibc for mips64
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Date:	Thu, 27 Apr 2006 10:55:24 +0530
Message-ID: <4BF47D56A0DD2346A1B8D622C5C5902C01666AD1@soc-mail.soc-soft.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Compiling glibc for mips64
Thread-Index: AcZpuvwHW+ndiiiZTsqIZh+YegHgAw==
From:	<Vadivelan@soc-soft.com>
To:	<linux-mips@linux-mips.org>
Return-Path: <Vadivelan@soc-soft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11219
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Vadivelan@soc-soft.com
Precedence: bulk
X-list: linux-mips


Hi,
	I'm compiling glibc 2.4 for mips64. Here's the configuration I'm
using.

../glibc-2.4/configure
--with-headers=/opt/optMVL4.0.1_64bit/montavista/pro/devkit/lsp/broadcom
-bcm91250-mips64_fp_be/linux-2.6.10_mvl401/include/ --build=i386-linux
--host=mips64-linux --enable-add-ons --prefix=/myglibc/
--cache-file=config.cache --disable-profile --with-tls
--enable-check-abi --enable-oldest-abi=o32

Tool chain: mips64_fp_be-gcc

I'm getting the following errors when I do 'make'.

******************************************************


../ports/sysdeps/unix/sysv/linux/mips/sigaction.c: In function
`__libc_sigaction':
../ports/sysdeps/unix/sysv/linux/mips/sigaction.c:95: warning: cast from
pointer to integer of different size
../ports/sysdeps/unix/sysv/linux/mips/sigaction.c:95: warning:
initialization makes integer from pointer without a cast
../ports/sysdeps/unix/sysv/linux/mips/sigaction.c:95: warning: cast from
pointer to integer of different size
../ports/sysdeps/unix/sysv/linux/mips/sigaction.c:95: warning:
initialization makes integer from pointer without a cast
../ports/sysdeps/unix/sysv/linux/mips/sigaction.c:134: warning: cast
from pointer to integer of different size
../ports/sysdeps/unix/sysv/linux/mips/sigaction.c:134: warning:
initialization makes integer from pointer without a cast
../ports/sysdeps/unix/sysv/linux/mips/sigaction.c:134: warning: cast
from pointer to integer of different size
../ports/sysdeps/unix/sysv/linux/mips/sigaction.c:134: warning:
initialization makes integer from pointer without a cast
../ports/sysdeps/unix/sysv/linux/mips/sigaction.c:134: error:
`__NR_sigaction' undeclared (first use in this function)
../ports/sysdeps/unix/sysv/linux/mips/sigaction.c:134: error: (Each
undeclared identifier is reported only once
../ports/sysdeps/unix/sysv/linux/mips/sigaction.c:134: error: for each
function it appears in.)
../ports/sysdeps/unix/sysv/linux/mips/sigaction.c:146: error: `restore'
undeclared (first use in this function)
../ports/sysdeps/unix/sysv/linux/mips/sigaction.c: At top level:
../ports/sysdeps/unix/sysv/linux/mips/sigaction.c:46: warning:
'restore_rt' declared `static' but never defined
make[2]: ***
[/usr/src/redhat/SOURCES/glibc/glibc-2.4_build/signal/sigaction.o] Error
1
make[2]: Leaving directory
`/usr/src/redhat/SOURCES/glibc/glibc-2.4/signal'
make[1]: *** [signal/subdir_lib] Error 2
make[1]: Leaving directory `/usr/src/redhat/SOURCES/glibc/glibc-2.4'
make: *** [all] Error 2

******************************************************

During configuration if I give --host=mips-linux, it compiles but with
-mabi=32 option and during installation it creates only lib directory.

How do I make it to create lib, lib32 and lib64 directory's.

Thanking u.

Regards,
Vadi.








The information contained in this e-mail message and in any annexure is
confidential to the  recipient and may contain privileged information. If you are not
the intended recipient, please notify the sender and delete the message along with
any annexure. You should not disclose, copy or otherwise use the information contained
in the message or any annexure. Any views expressed in this e-mail are those of the
individual sender except where the sender specifically states them to be the views of
SoCrates Software India Pvt Ltd., Bangalore.
