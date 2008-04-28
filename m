Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Apr 2008 20:23:50 +0100 (BST)
Received: from host194-211-dynamic.20-79-r.retail.telecomitalia.it ([79.20.211.194]:38043
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S20191241AbYD1TXs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 28 Apr 2008 20:23:48 +0100
Received: from localhost ([127.0.0.1] helo=sgi)
	by eppesuigoccas.homedns.org with smtp (Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1JqYwk-000890-R7
	for linux-mips@linux-mips.org; Mon, 28 Apr 2008 21:23:34 +0200
Date:	Mon, 28 Apr 2008 21:23:27 +0200
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To:	linux-mips@linux-mips.org
Subject: undefined reference to `copy_siginfo_from_user32'
Message-Id: <20080428212327.47c703b6.giuseppe@eppesuigoccas.homedns.org>
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; mips-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19042
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

Hi list,
since a few days, whenever I try to recompile the latest kernel (from git) it always print this error message:

[...]
  AS      arch/mips/lib/strlen_user.o
  AS      arch/mips/lib/strncpy_user.o
  AS      arch/mips/lib/strnlen_user.o
  CC      arch/mips/lib/uncached.o
  AR      arch/mips/lib/lib.a
  LD      vmlinux.o
  MODPOST vmlinux.o
WARNING: modpost: Found 11 section mismatch(es).
To see full details build your kernel with:
'make CONFIG_DEBUG_SECTION_MISMATCH=y'
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
kernel/built-in.o: In function `$L261':
ptrace.c:(.text+0x13550): undefined reference to `copy_siginfo_from_user32'
ptrace.c:(.text+0x13550): relocation truncated to fit: R_MIPS_26 against `copy_siginfo_from_user32'
make[1]: *** [.tmp_vmlinux1] Error 1
make[1]: Leaving directory `/usr/local/src/kernel/2.6.25'
make: *** [debian/stamp-build-kernel] Error 2

Any idea about a possible cause/solution?

Thank you very mcuh,
Giuseppe
