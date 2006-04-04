Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Apr 2006 02:11:35 +0100 (BST)
Received: from mo00.po.2iij.net ([210.130.202.204]:32507 "EHLO
	mo00.po.2iij.net") by ftp.linux-mips.org with ESMTP
	id S8133791AbWDDBLV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 4 Apr 2006 02:11:21 +0100
Received: NPO MO00 id k341MNau027255; Tue, 4 Apr 2006 10:22:23 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (NPO-MR/mbox01) id k341MLbC014680
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NOT)
	for <linux-mips@linux-mips.org>; Tue, 4 Apr 2006 10:22:22 +0900 (JST)
Date:	Tue, 4 Apr 2006 10:22:21 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	linux-mips@linux-mips.org
Subject: build error about current git
Message-Id: <20060404102221.5280f199.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Envid: tripeaks.co.jp
Envelope-Id: tripeaks.co.jp
X-archive-position: 11016
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi,

I got the following error, when I built the kernel using current git.

Yoichi

$ make tb0287_defconfig
.
.
.
gcc: 0: No such file or directory
gcc: unrecognized option `-G'
gcc: unrecognized option `-EL'
cc1: error: invalid option `no-abicalls'

$ make
gcc: 0: No such file or directory
gcc: unrecognized option `-G'
gcc: unrecognized option `-EL'
cc1: error: invalid option `no-abicalls'
  CHK     include/linux/version.h
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/basic/split-include
  HOSTCC  scripts/basic/docproc
  HOSTCC  scripts/kconfig/conf.o
  HOSTCC  scripts/kconfig/kxgettext.o
  HOSTCC  scripts/kconfig/mconf.o
  HOSTCC  scripts/kconfig/zconf.tab.o
  HOSTLD  scripts/kconfig/conf
scripts/kconfig/conf -s arch/mips/Kconfig
#
# using defaults found in .config
#
gcc: 0: No such file or directory
gcc: unrecognized option `-G'
gcc: unrecognized option `-EL'
cc1: error: invalid option `no-abicalls'
  SPLIT   include/linux/autoconf.h -> include/config/*
  CC      arch/mips/kernel/asm-offsets.s
gcc: cannot specify -o with -c or -S and multiple compilations
make[1]: *** [arch/mips/kernel/asm-offsets.s] Error 1
make: *** [prepare0] Error 2

$ gcc -v
Reading specs from /usr/lib/gcc-lib/i486-linux/3.3.5/specs
Configured with: ../src/configure -v --enable-languages=c,c++,java,f77,pascal,objc,ada,treelang --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --with-gxx-include-dir=/usr/include/c++/3.3 --enable-shared --enable-__cxa_atexit --with-system-zlib --enable-nls --without-included-gettext --enable-clocale=gnu --enable-debug --enable-java-gc=boehm --enable-java-awt=xlib --enable-objc-gc i486-linux
Thread model: posix
gcc version 3.3.5 (Debian 1:3.3.5-13)
