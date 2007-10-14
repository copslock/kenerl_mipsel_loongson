Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Oct 2007 09:11:42 +0100 (BST)
Received: from host99-201-dynamic.16-79-r.retail.telecomitalia.it ([79.16.201.99]:4040
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S20026744AbXJNILd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 14 Oct 2007 09:11:33 +0100
Received: from [192.168.2.51]
	by eppesuigoccas.homedns.org with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1IgyZL-0004aH-EW
	for linux-mips@linux-mips.org; Sun, 14 Oct 2007 10:11:29 +0200
Subject: Compile problems with latest GIT kernel version
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To:	linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Date:	Sun, 14 Oct 2007 10:12:41 +0200
Message-Id: <1192349561.17182.11.camel@scarafaggio>
Mime-Version: 1.0
X-Mailer: Evolution 2.10.3 
Content-Transfer-Encoding: 8BIT
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17015
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

Hi *,
I am investigating a new problem (already reported in this list by
Martin Michlmayr) about the serial device on the SGI O2. While
recompiling the latest kernel I get this error:

make[1]: Entering directory `/usr/local/src/kernel/linux-2.6.23'
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  Checking missing-syscalls for N32
  CALL    scripts/checksyscalls.sh
  Checking missing-syscalls for O32
  CALL    scripts/checksyscalls.sh
  CALL    scripts/checksyscalls.sh
  CHK     include/linux/compile.h
  CC      arch/mips/kernel/time.o
arch/mips/kernel/time.c: In function ‘mips_clockevent_init’:
arch/mips/kernel/time.c:399: error: ‘MIPS_CPU_IRQ_BASE’ undeclared (first use in this function)
arch/mips/kernel/time.c:399: error: (Each undeclared identifier is reported only once
arch/mips/kernel/time.c:399: error: for each function it appears in.)
make[2]: *** [arch/mips/kernel/time.o] Error 1
make[1]: *** [arch/mips/kernel] Error 2
make[1]: Leaving directory `/usr/local/src/kernel/linux-2.6.23'
make: *** [debian/stamp-build-kernel] Error 2

But I don't know what to do. Is this a #define missing for ip32?

Bye,
Giuseppe
