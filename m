Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2007 16:22:13 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:6860 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022473AbXC1PWI (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 28 Mar 2007 16:22:08 +0100
Received: from localhost (p4133-ipad207funabasi.chiba.ocn.ne.jp [222.145.86.133])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 5D342C65A; Thu, 29 Mar 2007 00:20:48 +0900 (JST)
Date:	Thu, 29 Mar 2007 00:20:48 +0900 (JST)
Message-Id: <20070329.002048.126761099.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	linux-mips@linux-mips.org
Subject: Re: missimg system calls
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <cda58cb80703280401h7ef54d23i19766f453f085c5e@mail.gmail.com>
References: <20070328.011100.07456480.anemo@mba.ocn.ne.jp>
	<cda58cb80703280401h7ef54d23i19766f453f085c5e@mail.gmail.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14755
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 28 Mar 2007 13:01:30 +0200, "Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:
> +obj-$(CONFIG_MIPS32_N32)	+= missing_syscalls_n32.o
> +obj-$(CONFIG_MIPS32_O32)	+= missing_syscalls_o32.o
> +
> +CFLAGS_missing_syscalls_n32.o = -mabi=n32
> +CFLAGS_missing_syscalls_o32.o = -mabi=32
> +

We can not link n32/o32 objects into n64 kernel.

Hmm, lib- instead of obj- seems to work.  At least mips64-linux-ar
from binutils-2.17 does not complain.

diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 4924626..b82324e 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -67,4 +67,10 @@ obj-$(CONFIG_I8253)		+= i8253.o
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
+lib-$(CONFIG_MIPS32_N32)	+= missing_syscalls_n32.o
+lib-$(CONFIG_MIPS32_O32)	+= missing_syscalls_o32.o
+
+CFLAGS_missing_syscalls_n32.o = -mabi=n32
+CFLAGS_missing_syscalls_o32.o = -mabi=32
+
 CFLAGS_cpu-bugs64.o	= $(shell if $(CC) $(CFLAGS) -Wa,-mdaddi -c -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-DHAVE_AS_SET_DADDI"; fi)
diff --git a/arch/mips/kernel/missing_syscalls.h b/arch/mips/kernel/missing_syscalls.h
new file mode 100644
index 0000000..9c4f2e9
--- /dev/null
+++ b/arch/mips/kernel/missing_syscalls.h
@@ -0,0 +1 @@
+#include "../../../init/missing_syscalls.h"
diff --git a/arch/mips/kernel/missing_syscalls_n32.c b/arch/mips/kernel/missing_syscalls_n32.c
new file mode 100644
index 0000000..ce527c6
--- /dev/null
+++ b/arch/mips/kernel/missing_syscalls_n32.c
@@ -0,0 +1 @@
+#include "../../../init/missing_syscalls.c"
diff --git a/arch/mips/kernel/missing_syscalls_o32.c b/arch/mips/kernel/missing_syscalls_o32.c
new file mode 100644
index 0000000..ce527c6
--- /dev/null
+++ b/arch/mips/kernel/missing_syscalls_o32.c
@@ -0,0 +1 @@
+#include "../../../init/missing_syscalls.c"
