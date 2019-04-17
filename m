Return-Path: <SRS0=g2b/=ST=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA9EC282DA
	for <linux-mips@archiver.kernel.org>; Wed, 17 Apr 2019 20:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB62D2183E
	for <linux-mips@archiver.kernel.org>; Wed, 17 Apr 2019 20:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387644AbfDQU5h (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:57:37 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:45069 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbfDQU5h (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Wed, 17 Apr 2019 16:57:37 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MkHhB-1gahF83LpJ-00keJw; Wed, 17 Apr 2019 22:57:03 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     netdev@vger.kernel.org
Cc:     y2038@lists.linaro.org,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Willem de Bruijn <willemb@google.com>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH 3/3 v3] net: socket: implement 64-bit timestamps
Date:   Wed, 17 Apr 2019 22:56:11 +0200
Message-Id: <20190417205659.2036372-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190417205404.1877560-1-arnd@arndb.de>
References: <20190417205404.1877560-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:fLF87FKLhuibjNxg7ic7AvBqD7egtFNp7l4yl8HevvFIw+EAQdl
 Pf/SYEW0fqYsY7Ki84lr2ZHF0nWMCp0ARmuojW2l/ijkbH4FhqMjrHuJxS6CARjyY57wKlT
 hFLJHN0bqADJAZGeaYXQ/at0BGDxxtRgRvfey2DYFlCpofbSPQAWL5/4Mf9OKNWGekQ6SLK
 GNz4EEHIhKJPrlPEJTHKg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wNlTYIhQd8k=:l7V9cMDpW13sHhKeY2PaXI
 7qgWSOMERym/jZRRts6DCxKtziMd1JOWaQO339u0rRJ0w4pxvpKupoInWlkKu7d7W7wBEYKYl
 pbV+hyb9rUu1iCd2K5EJScfNn6HvDUvbY6b+8yNBKuF4+Gicj/C+15Gqf7DrZHG5dUZ2NbqC7
 e0BDZ3zsbCwtp1LCteZVH2IFxY64DDlWkkxd8HbcOYRiN9MCgr0aj2flpRSuS6ftwGUKzHqNT
 4DIRWbSXKapdrt4UFelupGbSfcufv1WaY8DyJX4TzRM9s2rinB6HMTuUWFoeVO0hPShlFI7KC
 +p/B0Gnb/nVjhekCIftV21COD85pPs/5xPjcJSHZh/IPygq8ZrbWJ5IOEMJYeUIuAOhr28Xmr
 WiRiSQKt1ZINYPSUIUpSFegSn18Wqddp0q9RjY2zNRP9mm9gXLHqKkK7t63AqpKP1E47yO++A
 6Wx6uZnzVIol/WKSW3WWHIh6hKBYtqv2+gadtNPkjdhGAVLsFSLZ9wR9Z/YAfUM4kUIEgA0iR
 wYz5nUUYgZnjUAG7c+o7+VrDWqG2Wq0sLpPDthO8hin3iKR4p1aO+SqUBNGDYMXhVnHE//6wS
 +ChR36qIowB4f4/NJUeAx9LRzwHPDsD+3iHacmy0FizDAbhlQKYH70D/uRsRlc3Qmwu181cBx
 dJzUgXs0E/xLW2t3nKfV+foyfJ2FnRjqd0V4SH8pbCXL8XxQY3cI8vV362JYc/FZGYvnww3Jd
 9QpljfsmdlVTC8tf+05PDK0v7HYZo6VFSmxLTQ==
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

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
v3: no changes since v1
---
 arch/alpha/include/uapi/asm/sockios.h  |  4 ++--
 arch/mips/include/uapi/asm/sockios.h   |  4 ++--
 arch/sh/include/uapi/asm/sockios.h     |  5 +++--
 arch/xtensa/include/uapi/asm/sockios.h |  4 ++--
 include/uapi/asm-generic/sockios.h     |  4 ++--
 include/uapi/linux/sockios.h           | 21 +++++++++++++++++++++
 net/socket.c                           | 24 ++++++++++++++++++------
 7 files changed, 50 insertions(+), 16 deletions(-)

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
index ab624d42ead5..8d9d4fc7d962 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1164,14 +1164,24 @@ static long sock_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 
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
@@ -3324,11 +3334,11 @@ static int compat_sock_ioctl_trans(struct file *file, struct socket *sock,
 	case SIOCADDRT:
 	case SIOCDELRT:
 		return routing_ioctl(net, sock, cmd, argp);
-	case SIOCGSTAMP:
-	case SIOCGSTAMPNS:
+	case SIOCGSTAMP_OLD:
+	case SIOCGSTAMPNS_OLD:
 		if (!sock->ops->gettstamp)
 			return -ENOIOCTLCMD;
-		return sock->ops->gettstamp(sock, argp, cmd == SIOCGSTAMP,
+		return sock->ops->gettstamp(sock, argp, cmd == SIOCGSTAMP_OLD,
 					    !COMPAT_USE_64BIT_TIME);
 
 	case SIOCBONDSLAVEINFOQUERY:
@@ -3348,6 +3358,8 @@ static int compat_sock_ioctl_trans(struct file *file, struct socket *sock,
 	case SIOCADDDLCI:
 	case SIOCDELDLCI:
 	case SIOCGSKNS:
+	case SIOCGSTAMP_NEW:
+	case SIOCGSTAMPNS_NEW:
 		return sock_ioctl(file, cmd, arg);
 
 	case SIOCGIFFLAGS:
-- 
2.20.0

