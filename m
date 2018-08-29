Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Aug 2018 15:11:57 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.17.24]:46431 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990474AbeH2NLyJvAZR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Aug 2018 15:11:54 +0200
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue105 [212.227.15.145]) with ESMTPA (Nemesis) id
 0Lutsn-1fmRXB3jsn-0107VC; Wed, 29 Aug 2018 15:11:33 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>
Cc:     linux-arch@vger.kernel.org, y2038@lists.linaro.org,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        viro@zeniv.linux.org.uk, tglx@linutronix.de, edumazet@google.com,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH net-next 3/3] net: socket: implement 64-bit timestamps
Date:   Wed, 29 Aug 2018 15:11:23 +0200
Message-Id: <20180829131123.3866959-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180829130308.3504560-1-arnd@arndb.de>
References: <20180829130308.3504560-1-arnd@arndb.de>
X-Provags-ID: V03:K1:b1U0VM3nN7jE7+NdbSu+AtFcHqE96sDDi89lEJSUmYMGzXptDTS
 i59dVytgCTqcyYT40EhNyPfbR5g2R5CeBwfu6lPrtYheP4AGmlXWkEVg25isBsX74wSHnGw
 b5k+faTgbVQ5EV9FMVy9S6BqGA7ALihzgXjj26ufaC3AA+84AcJtjygyQp0L69h1CxZTOrp
 0azFUPiK7Blg0MKzTWhZw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZC369g1H0S8=:M6hYtpUabmEPQc0VdwgN1W
 gfxjYnleJ3wFp5BIlphc4b/G7y61Xeozhh9CjUlEl4sgAFBnmzqJCZAl2OfZ4YcxG/NbGn4KD
 0II/r89pjN9EJxcMB3nI+4h7VwhSg7WKo2I2qZJLfG2+pWGIrgK7B6QKSptpxEfGy7DoC9ibS
 dFhEVqVcJSauuMNU45RI16GmkwphJC8pRiB7RdsaCmHo87hnMvuFwvNr2ellnAl1C+maPl36M
 WR03bxvsYi1vtP4UGlVMFtc3sD2UyQGLgvgAQVQagZJRJH8/PbXZIfL6biV+BRDPJ+Sj3Nnzo
 71I+Q4+Fn3EdLxKQJB2bnYqAkZf2Ggi+c7nanTlzk/4aBFZWw7zgCcNZRCVGhpcPWYNLkV6eZ
 TWUL0jDPF1EJ7BZ753+sOcA2UQ/1BHdp8Jy0GKuY5FKI2ENA/QDy4mulI639XWs/XmIYtxdOe
 7SB/Jxsolunv84fVmIIXianmHDiIgKKVFjDOl5E9PiJeEnFqOpw/DxIy7tX9hx8V12dx0XODo
 N0Hp/bf9JsLfL/ODcIttd+KI6KM7jLkcqD+24ILfBEm5i0n9YGPMc+5Lo8+fdZtomwcNY4HNf
 HucXZZcBHRqSqDNo6Cxtj7oqKOGvV3aqDYs15i7dzkBSlKVMbFNi6Un6Hmmxf6ZUCtt9Ht18n
 3Sczb0L0XzegSQnymzT6wFz47glOb1Ug8YXmRNkes6ad99oIIB2rwivfGu2eqh6FFCUI=
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65775
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

The 'timeval' and 'timespec' data structures used for socket timestamps
are going to be redefined in user space based on 64-bit time_t in future
versions of the C library to deal with the y2038 overflow problem,
which breaks the ABI definition.

Unlike many modern ioctl commands, SIOCGSTAMP and SIOCGSTAMPNS do not
use the _IOR() macro to encode the size of the transferred data, so it
remains ambiguous whether the application uses the old or new layout.

The best workaround I could find is rather ugly: we redefine the command
code based on the size of the respective data structure with a ternary
operator. This lets it get evaluated as late as possible, hopefully after
that structure is visible to the caller. We cannot use an #ifdef here,
because inux/sockios.h might have been included before any libc header
that could determine the size of time_t.

The ioctl implementation now interprets the new command codes as always
referring to the 64-bit structure on all architectures, while the old
architecture specific command code still refers to the old architecture
specific layout. The new command number is only used when they are
actually different.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/include/uapi/asm/sockios.h  |  4 ++--
 arch/mips/include/uapi/asm/sockios.h   |  4 ++--
 arch/sh/include/uapi/asm/sockios.h     |  5 +++--
 arch/xtensa/include/uapi/asm/sockios.h |  4 ++--
 include/uapi/asm-generic/sockios.h     |  4 ++--
 include/uapi/linux/sockios.h           | 21 +++++++++++++++++++++
 net/socket.c                           | 22 +++++++++++++++++-----
 7 files changed, 49 insertions(+), 15 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/sockios.h b/arch/alpha/include/uapi/asm/sockios.h
index ba287e4b01bf..af92bc27c3be 100644
--- a/arch/alpha/include/uapi/asm/sockios.h
+++ b/arch/alpha/include/uapi/asm/sockios.h
@@ -11,7 +11,7 @@
 #define SIOCSPGRP	_IOW('s', 8, pid_t)
 #define SIOCGPGRP	_IOR('s', 9, pid_t)
 
-#define SIOCGSTAMP	0x8906		/* Get stamp (timeval) */
-#define SIOCGSTAMPNS	0x8907		/* Get stamp (timespec) */
+#define SIOCGSTAMP_OLD	0x8906		/* Get stamp (timeval) */
+#define SIOCGSTAMPNS_OLD 0x8907		/* Get stamp (timespec) */
 
 #endif /* _ASM_ALPHA_SOCKIOS_H */
diff --git a/arch/mips/include/uapi/asm/sockios.h b/arch/mips/include/uapi/asm/sockios.h
index 5b40a88593fa..66f60234f290 100644
--- a/arch/mips/include/uapi/asm/sockios.h
+++ b/arch/mips/include/uapi/asm/sockios.h
@@ -21,7 +21,7 @@
 #define SIOCSPGRP	_IOW('s', 8, pid_t)
 #define SIOCGPGRP	_IOR('s', 9, pid_t)
 
-#define SIOCGSTAMP	0x8906		/* Get stamp (timeval) */
-#define SIOCGSTAMPNS	0x8907		/* Get stamp (timespec) */
+#define SIOCGSTAMP_OLD	0x8906		/* Get stamp (timeval) */
+#define SIOCGSTAMPNS_OLD 0x8907		/* Get stamp (timespec) */
 
 #endif /* _ASM_SOCKIOS_H */
diff --git a/arch/sh/include/uapi/asm/sockios.h b/arch/sh/include/uapi/asm/sockios.h
index 17313d2c3527..ef18a668456d 100644
--- a/arch/sh/include/uapi/asm/sockios.h
+++ b/arch/sh/include/uapi/asm/sockios.h
@@ -10,6 +10,7 @@
 #define SIOCSPGRP	_IOW('s', 8, pid_t)
 #define SIOCGPGRP	_IOR('s', 9, pid_t)
 
-#define SIOCGSTAMP	_IOR('s', 100, struct timeval) /* Get stamp (timeval) */
-#define SIOCGSTAMPNS	_IOR('s', 101, struct timespec) /* Get stamp (timespec) */
+#define SIOCGSTAMP_OLD	_IOR('s', 100, struct timeval) /* Get stamp (timeval) */
+#define SIOCGSTAMPNS_OLD _IOR('s', 101, struct timespec) /* Get stamp (timespec) */
+
 #endif /* __ASM_SH_SOCKIOS_H */
diff --git a/arch/xtensa/include/uapi/asm/sockios.h b/arch/xtensa/include/uapi/asm/sockios.h
index fb8ac3607189..1a1f58f4b75a 100644
--- a/arch/xtensa/include/uapi/asm/sockios.h
+++ b/arch/xtensa/include/uapi/asm/sockios.h
@@ -26,7 +26,7 @@
 #define SIOCSPGRP	_IOW('s', 8, pid_t)
 #define SIOCGPGRP	_IOR('s', 9, pid_t)
 
-#define SIOCGSTAMP	0x8906		/* Get stamp (timeval) */
-#define SIOCGSTAMPNS	0x8907		/* Get stamp (timespec) */
+#define SIOCGSTAMP_OLD	0x8906		/* Get stamp (timeval) */
+#define SIOCGSTAMPNS_OLD 0x8907		/* Get stamp (timespec) */
 
 #endif	/* _XTENSA_SOCKIOS_H */
diff --git a/include/uapi/asm-generic/sockios.h b/include/uapi/asm-generic/sockios.h
index 64f658c7cec2..44fa3ed70483 100644
--- a/include/uapi/asm-generic/sockios.h
+++ b/include/uapi/asm-generic/sockios.h
@@ -8,7 +8,7 @@
 #define FIOGETOWN	0x8903
 #define SIOCGPGRP	0x8904
 #define SIOCATMARK	0x8905
-#define SIOCGSTAMP	0x8906		/* Get stamp (timeval) */
-#define SIOCGSTAMPNS	0x8907		/* Get stamp (timespec) */
+#define SIOCGSTAMP_OLD	0x8906		/* Get stamp (timeval) */
+#define SIOCGSTAMPNS_OLD 0x8907		/* Get stamp (timespec) */
 
 #endif /* __ASM_GENERIC_SOCKIOS_H */
diff --git a/include/uapi/linux/sockios.h b/include/uapi/linux/sockios.h
index d393e9ed3964..7d1bccbbef78 100644
--- a/include/uapi/linux/sockios.h
+++ b/include/uapi/linux/sockios.h
@@ -19,6 +19,7 @@
 #ifndef _LINUX_SOCKIOS_H
 #define _LINUX_SOCKIOS_H
 
+#include <asm/bitsperlong.h>
 #include <asm/sockios.h>
 
 /* Linux-specific socket ioctls */
@@ -27,6 +28,26 @@
 
 #define SOCK_IOC_TYPE	0x89
 
+/*
+ * the timeval/timespec data structure layout is defined by libc,
+ * so we need to cover both possible versions on 32-bit.
+ */
+/* Get stamp (timeval) */
+#define SIOCGSTAMP_NEW	 _IOR(SOCK_IOC_TYPE, 0x06, long long[2])
+/* Get stamp (timespec) */
+#define SIOCGSTAMPNS_NEW _IOR(SOCK_IOC_TYPE, 0x07, long long[2])
+
+#if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
+/* on 64-bit and x32, avoid the ?: operator */
+#define SIOCGSTAMP	SIOCGSTAMP_OLD
+#define SIOCGSTAMPNS	SIOCGSTAMPNS_OLD
+#else
+#define SIOCGSTAMP	((sizeof(struct timeval))  == 8 ? \
+			 SIOCGSTAMP_OLD   : SIOCGSTAMP_NEW)
+#define SIOCGSTAMPNS	((sizeof(struct timespec)) == 8 ? \
+			 SIOCGSTAMPNS_OLD : SIOCGSTAMPNS_NEW)
+#endif
+
 /* Routing table calls. */
 #define SIOCADDRT	0x890B		/* add routing table entry	*/
 #define SIOCDELRT	0x890C		/* delete routing table entry	*/
diff --git a/net/socket.c b/net/socket.c
index 6814e8dc8af1..9762e7d5378b 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1069,14 +1069,24 @@ static long sock_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 
 			err = open_related_ns(&net->ns, get_net_ns);
 			break;
-		case SIOCGSTAMP:
-		case SIOCGSTAMPNS:
+		case SIOCGSTAMP_OLD:
+		case SIOCGSTAMPNS_OLD:
 			if (!sock->ops->gettstamp) {
 				err = -ENOIOCTLCMD;
 				break;
 			}
 			err = sock->ops->gettstamp(sock, argp,
-						   cmd == SIOCGSTAMP, false);
+						   cmd == SIOCGSTAMP_OLD,
+						   !IS_ENABLED(CONFIG_64BIT));
+		case SIOCGSTAMP_NEW:
+		case SIOCGSTAMPNS_NEW:
+			if (!sock->ops->gettstamp) {
+				err = -ENOIOCTLCMD;
+				break;
+			}
+			err = sock->ops->gettstamp(sock, argp,
+						   cmd == SIOCGSTAMP_NEW,
+						   false);
 			break;
 		default:
 			err = sock_do_ioctl(net, sock, cmd, arg);
@@ -3095,8 +3105,8 @@ static int compat_sock_ioctl_trans(struct file *file, struct socket *sock,
 	case SIOCADDRT:
 	case SIOCDELRT:
 		return routing_ioctl(net, sock, cmd, argp);
-	case SIOCGSTAMP:
-	case SIOCGSTAMPNS:
+	case SIOCGSTAMP_OLD:
+	case SIOCGSTAMPNS_OLD:
 		if (!sock->ops->gettstamp)
 			return -ENOIOCTLCMD;
 		return sock->ops->gettstamp(sock, argp, cmd == SIOCGSTAMP,
@@ -3119,6 +3129,8 @@ static int compat_sock_ioctl_trans(struct file *file, struct socket *sock,
 	case SIOCADDDLCI:
 	case SIOCDELDLCI:
 	case SIOCGSKNS:
+	case SIOCGSTAMP_NEW:
+	case SIOCGSTAMPNS_NEW:
 		return sock_ioctl(file, cmd, arg);
 
 	case SIOCGIFFLAGS:
-- 
2.18.0
