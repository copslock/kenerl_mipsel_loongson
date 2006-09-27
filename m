Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Sep 2006 22:07:34 +0100 (BST)
Received: from farad.aurel32.net ([82.232.2.251]:50099 "EHLO farad.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S20039024AbWI0VHa (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 27 Sep 2006 22:07:30 +0100
Received: from bode.aurel32.net ([2001:618:400:fc13:211:9ff:feed:c498])
	by farad.aurel32.net with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1GSgcn-0005ce-4G; Wed, 27 Sep 2006 23:07:25 +0200
Received: from aurel32 by bode.aurel32.net with local (Exim 4.63)
	(envelope-from <aurelien@aurel32.net>)
	id 1GSgcn-0007dd-FJ; Wed, 27 Sep 2006 23:07:25 +0200
Date:	Wed, 27 Sep 2006 23:07:25 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	linux-kernel@vger.kernel.org
Cc:	linux-mips@linux-mips.org
Subject: [PATCH] QEMU - Add support for little endian mips
Message-ID: <20060927210723.GA28334@bode.aurel32.net>
Mail-Followup-To: Aurelien Jarno <aurelien@aurel32.net>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
X-Mailer: Mutt 1.5.13 (2006-08-11)
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12700
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

This very small patch adds support for little endian on the virtual QEMU
mips platform. The status of this platform is the same as the big endian
one, ie it is possible to boot a system with init=/bin/sh.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
i

diff -Nurd linux-2.6.18.orig/arch/mips/Kconfig linux-2.6.18/arch/mips/Kconfig
--- linux-2.6.18.orig/arch/mips/Kconfig	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18/arch/mips/Kconfig	2006-09-27 23:00:12.124563754 +0200
@@ -557,6 +557,7 @@
 	select SYS_HAS_CPU_MIPS32_R1
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_BIG_ENDIAN
+	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select ARCH_SPARSEMEM_ENABLE
 	help
 	  Qemu is a software emulator which among other architectures also

-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
