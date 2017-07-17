Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Jul 2017 15:30:18 +0200 (CEST)
Received: from vmicros1.altlinux.org ([194.107.17.57]:48402 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994827AbdGQNaJkO3a1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Jul 2017 15:30:09 +0200
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 80EE772E20A;
        Mon, 17 Jul 2017 16:30:03 +0300 (MSK)
Received: from glebfm.cloud.tilaa.com (glebfm.cloud.tilaa.com [84.22.98.219])
        by imap.altlinux.org (Postfix) with ESMTPSA id F2F144A4B06;
        Mon, 17 Jul 2017 16:30:01 +0300 (MSK)
Date:   Mon, 17 Jul 2017 16:29:46 +0300
From:   Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Aleksa Sarai <asarai@suse.de>,
        David Laight <David.Laight@ACULAB.COM>,
        James Hogan <james.hogan@imgtec.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Valentin Rothberg <vrothberg@suse.com>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>, Jiri Slaby <jslaby@suse.com>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] [PING] Fix TIOCGPTPEER ioctl definition
Message-ID: <20170717132946.GK21910@glebfm.cloud.tilaa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Return-Path: <glebfm@altlinux.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59121
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: glebfm@altlinux.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

This ioctl does nothing to justify an _IOC_READ or _IOC_WRITE flag
because it doesn't copy anything from/to userspace to access the
argument.

Fixes: 54ebbfb16034 ("tty: add TIOCGPTPEER ioctl")
Signed-off-by: Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
Acked-by: Aleksa Sarai <asarai@suse.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/include/uapi/asm/ioctls.h   | 2 +-
 arch/mips/include/uapi/asm/ioctls.h    | 2 +-
 arch/parisc/include/uapi/asm/ioctls.h  | 2 +-
 arch/powerpc/include/uapi/asm/ioctls.h | 2 +-
 arch/sh/include/uapi/asm/ioctls.h      | 2 +-
 arch/sparc/include/uapi/asm/ioctls.h   | 2 +-
 arch/xtensa/include/uapi/asm/ioctls.h  | 2 +-
 include/uapi/asm-generic/ioctls.h      | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/ioctls.h b/arch/alpha/include/uapi/asm/ioctls.h
index ff67b8373bf7..1cd7dc7d4870 100644
--- a/arch/alpha/include/uapi/asm/ioctls.h
+++ b/arch/alpha/include/uapi/asm/ioctls.h
@@ -100,7 +100,7 @@
 #define TIOCGPKT	_IOR('T', 0x38, int) /* Get packet mode state */
 #define TIOCGPTLCK	_IOR('T', 0x39, int) /* Get Pty lock state */
 #define TIOCGEXCL	_IOR('T', 0x40, int) /* Get exclusive mode state */
-#define TIOCGPTPEER	_IOR('T', 0x41, int) /* Safely open the slave */
+#define TIOCGPTPEER	_IO('T', 0x41) /* Safely open the slave */
 
 #define TIOCSERCONFIG	0x5453
 #define TIOCSERGWILD	0x5454
diff --git a/arch/mips/include/uapi/asm/ioctls.h b/arch/mips/include/uapi/asm/ioctls.h
index 68e19b689a00..1609cb0907ac 100644
--- a/arch/mips/include/uapi/asm/ioctls.h
+++ b/arch/mips/include/uapi/asm/ioctls.h
@@ -91,7 +91,7 @@
 #define TIOCGPKT	_IOR('T', 0x38, int) /* Get packet mode state */
 #define TIOCGPTLCK	_IOR('T', 0x39, int) /* Get Pty lock state */
 #define TIOCGEXCL	_IOR('T', 0x40, int) /* Get exclusive mode state */
-#define TIOCGPTPEER	_IOR('T', 0x41, int) /* Safely open the slave */
+#define TIOCGPTPEER	_IO('T', 0x41) /* Safely open the slave */
 
 /* I hope the range from 0x5480 on is free ... */
 #define TIOCSCTTY	0x5480		/* become controlling tty */
diff --git a/arch/parisc/include/uapi/asm/ioctls.h b/arch/parisc/include/uapi/asm/ioctls.h
index 674c68a5bbd0..d0e3321403be 100644
--- a/arch/parisc/include/uapi/asm/ioctls.h
+++ b/arch/parisc/include/uapi/asm/ioctls.h
@@ -60,7 +60,7 @@
 #define TIOCGPKT	_IOR('T', 0x38, int) /* Get packet mode state */
 #define TIOCGPTLCK	_IOR('T', 0x39, int) /* Get Pty lock state */
 #define TIOCGEXCL	_IOR('T', 0x40, int) /* Get exclusive mode state */
-#define TIOCGPTPEER	_IOR('T', 0x41, int) /* Safely open the slave */
+#define TIOCGPTPEER	_IO('T', 0x41) /* Safely open the slave */
 
 #define FIONCLEX	0x5450  /* these numbers need to be adjusted. */
 #define FIOCLEX		0x5451
diff --git a/arch/powerpc/include/uapi/asm/ioctls.h b/arch/powerpc/include/uapi/asm/ioctls.h
index bfd609a3e928..e3b10469f787 100644
--- a/arch/powerpc/include/uapi/asm/ioctls.h
+++ b/arch/powerpc/include/uapi/asm/ioctls.h
@@ -100,7 +100,7 @@
 #define TIOCGPKT	_IOR('T', 0x38, int) /* Get packet mode state */
 #define TIOCGPTLCK	_IOR('T', 0x39, int) /* Get Pty lock state */
 #define TIOCGEXCL	_IOR('T', 0x40, int) /* Get exclusive mode state */
-#define TIOCGPTPEER	_IOR('T', 0x41, int) /* Safely open the slave */
+#define TIOCGPTPEER	_IO('T', 0x41) /* Safely open the slave */
 
 #define TIOCSERCONFIG	0x5453
 #define TIOCSERGWILD	0x5454
diff --git a/arch/sh/include/uapi/asm/ioctls.h b/arch/sh/include/uapi/asm/ioctls.h
index eec7901e9e65..787bac9f67da 100644
--- a/arch/sh/include/uapi/asm/ioctls.h
+++ b/arch/sh/include/uapi/asm/ioctls.h
@@ -93,7 +93,7 @@
 #define TIOCGPKT	_IOR('T', 0x38, int) /* Get packet mode state */
 #define TIOCGPTLCK	_IOR('T', 0x39, int) /* Get Pty lock state */
 #define TIOCGEXCL	_IOR('T', 0x40, int) /* Get exclusive mode state */
-#define TIOCGPTPEER	_IOR('T', 0x41, int) /* Safely open the slave */
+#define TIOCGPTPEER	_IO('T', 0x41) /* Safely open the slave */
 
 #define TIOCSERCONFIG	_IO('T', 83) /* 0x5453 */
 #define TIOCSERGWILD	_IOR('T', 84,  int) /* 0x5454 */
diff --git a/arch/sparc/include/uapi/asm/ioctls.h b/arch/sparc/include/uapi/asm/ioctls.h
index 6d27398632ea..f5df72b93bb2 100644
--- a/arch/sparc/include/uapi/asm/ioctls.h
+++ b/arch/sparc/include/uapi/asm/ioctls.h
@@ -88,7 +88,7 @@
 #define TIOCGPTN	_IOR('t', 134, unsigned int) /* Get Pty Number */
 #define TIOCSPTLCK	_IOW('t', 135, int) /* Lock/unlock PTY */
 #define TIOCSIG		_IOW('t', 136, int) /* Generate signal on Pty slave */
-#define TIOCGPTPEER	_IOR('t', 137, int) /* Safely open the slave */
+#define TIOCGPTPEER	_IO('t', 137) /* Safely open the slave */
 
 /* Little f */
 #define FIOCLEX		_IO('f', 1)
diff --git a/arch/xtensa/include/uapi/asm/ioctls.h b/arch/xtensa/include/uapi/asm/ioctls.h
index 98b004e24e85..47d82c09be7b 100644
--- a/arch/xtensa/include/uapi/asm/ioctls.h
+++ b/arch/xtensa/include/uapi/asm/ioctls.h
@@ -105,7 +105,7 @@
 #define TIOCGPKT	_IOR('T', 0x38, int) /* Get packet mode state */
 #define TIOCGPTLCK	_IOR('T', 0x39, int) /* Get Pty lock state */
 #define TIOCGEXCL	_IOR('T', 0x40, int) /* Get exclusive mode state */
-#define TIOCGPTPEER	_IOR('T', 0x41, int) /* Safely open the slave */
+#define TIOCGPTPEER	_IO('T', 0x41) /* Safely open the slave */
 
 #define TIOCSERCONFIG	_IO('T', 83)
 #define TIOCSERGWILD	_IOR('T', 84,  int)
diff --git a/include/uapi/asm-generic/ioctls.h b/include/uapi/asm-generic/ioctls.h
index 06d5f7ddf84e..14baf9f23a14 100644
--- a/include/uapi/asm-generic/ioctls.h
+++ b/include/uapi/asm-generic/ioctls.h
@@ -77,7 +77,7 @@
 #define TIOCGPKT	_IOR('T', 0x38, int) /* Get packet mode state */
 #define TIOCGPTLCK	_IOR('T', 0x39, int) /* Get Pty lock state */
 #define TIOCGEXCL	_IOR('T', 0x40, int) /* Get exclusive mode state */
-#define TIOCGPTPEER	_IOR('T', 0x41, int) /* Safely open the slave */
+#define TIOCGPTPEER	_IO('T', 0x41) /* Safely open the slave */
 
 #define FIONCLEX	0x5450
 #define FIOCLEX		0x5451
-- 
glebfm
