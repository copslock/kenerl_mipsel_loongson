Return-Path: <SRS0=z0u9=PQ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6771C43387
	for <linux-mips@archiver.kernel.org>; Tue,  8 Jan 2019 05:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89FE02087E
	for <linux-mips@archiver.kernel.org>; Tue,  8 Jan 2019 05:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldZu1KMf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbfAHFXn (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 8 Jan 2019 00:23:43 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40865 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfAHFXm (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 8 Jan 2019 00:23:42 -0500
Received: by mail-pl1-f194.google.com with SMTP id u18so1295694plq.7;
        Mon, 07 Jan 2019 21:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fsxApbPTdH0ZVYT58ewomrGU7r5AJ7JG2rjpSw7mFu4=;
        b=ldZu1KMfk/1+FgOSV0qg+oIQlleKEWVHqLtXsS4idX3pvzho2OBPue0rPol6gJRsIa
         sFjbuejPz0tO9x5X8qnwH2t8FWAgr8EsfxqPEl713qZx6BO4J9pXAHq94eCqg972QtiH
         fO4ltlbVNc60/aferzTWKXbUrgPFxWuh//Qd8+e7OhjOSTdeOumXIlmsoCZLQ+IRZcRq
         y/xjJPu9aO/AffFyvIsLQYPizB1X5YL0ykxyDEEvD/RXfX6M5+Nk8HvsrpWv4iOA7yxr
         vPzxjk/fTwt8WIUWfU+atgj9bYfu7ltYMDhKAVAV9eTqRvWaV2AVAjIdXc5XsuqBEgun
         a4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fsxApbPTdH0ZVYT58ewomrGU7r5AJ7JG2rjpSw7mFu4=;
        b=b1dWA6wUUUIGbvZZYuyPglO/LRPMB2GlewORT4smQwQMhbcGR9BVdCIkK375zEKFf4
         KKZGl2QBwz32tWptry2DoSmq+cslQylFxCvs9iAFWMsS6ar6y5HTFClq907cdUh9FixT
         eGbj6JplBM16AktZa7OaI5YPhm24d0JKyqv1Xi9XRuGv8VcWRwaiXc1flmfJyJWQN/Fn
         kxMyZcYlMnnR3zxR0rmiUZW6vEE9fuGdCDkfHqoDHXN5+YemlROUJu/3W51RqIpxtUA4
         uxI6ctWYOq2/mQODf6vjFbBiRMzbs5Kw2MlyGOBeqP5SUPggbyX7IyZOmt59YmjPNiXz
         WVBg==
X-Gm-Message-State: AJcUukfD+d4NpJ0EVeJ60EKzS8um5DDfyGPLJXyxE/xsSwUjmAYSbOVB
        qUVqSIkfUThmn/VmN6AhOz4=
X-Google-Smtp-Source: ALg8bN4xVGo7Zrmlr6oQHTVbi+Wi7CE0X1SN12+BnVP21GkxeCswTGIkslT5NC1TVFZPMM2n9/M8oA==
X-Received: by 2002:a17:902:4601:: with SMTP id o1mr364016pld.243.1546925020738;
        Mon, 07 Jan 2019 21:23:40 -0800 (PST)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id x127sm102710626pfd.156.2019.01.07.21.23.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 21:23:40 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org,
        ccaulfie@redhat.com, deller@gmx.de, paulus@samba.org,
        ralf@linux-mips.org, rth@twiddle.net, cluster-devel@redhat.com,
        linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [PATCH 2/3] socket: Rename SO_RCVTIMEO/ SO_SNDTIMEO with _OLD suffixes
Date:   Mon,  7 Jan 2019 21:22:54 -0800
Message-Id: <20190108052255.10699-3-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190108052255.10699-1-deepa.kernel@gmail.com>
References: <20190108052255.10699-1-deepa.kernel@gmail.com>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

SO_RCVTIMEO and SO_SNDTIMEO socket options use struct timeval
as the time format. struct timeval is not y2038 safe.
The subsequent patches in the series add support for new socket
timeout options with _NEW suffix that are y2038 safe.
Rename the existing options with _OLD suffix forms so that the
right option is enabled for userspace applications according
to the architecture and time_t definition of libc.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: ccaulfie@redhat.com
Cc: deller@gmx.de
Cc: paulus@samba.org
Cc: ralf@linux-mips.org
Cc: rth@twiddle.net
Cc: cluster-devel@redhat.com
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-alpha@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-mips@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: sparclinux@vger.kernel.org
---
 arch/alpha/include/uapi/asm/socket.h   | 7 +++++--
 arch/mips/include/uapi/asm/socket.h    | 6 ++++--
 arch/parisc/include/uapi/asm/socket.h  | 6 ++++--
 arch/powerpc/include/uapi/asm/socket.h | 4 ++--
 arch/sparc/include/uapi/asm/socket.h   | 6 ++++--
 fs/dlm/lowcomms.c                      | 4 ++--
 include/net/sock.h                     | 4 ++--
 include/uapi/asm-generic/socket.h      | 6 ++++--
 net/compat.c                           | 4 ++--
 net/core/sock.c                        | 8 ++++----
 10 files changed, 33 insertions(+), 22 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
index da08412bd49f..ea3ba981d8a0 100644
--- a/arch/alpha/include/uapi/asm/socket.h
+++ b/arch/alpha/include/uapi/asm/socket.h
@@ -31,8 +31,8 @@
 #define SO_RCVBUFFORCE	0x100b
 #define	SO_RCVLOWAT	0x1010
 #define	SO_SNDLOWAT	0x1011
-#define	SO_RCVTIMEO	0x1012
-#define	SO_SNDTIMEO	0x1013
+#define	SO_RCVTIMEO_OLD	0x1012
+#define	SO_SNDTIMEO_OLD	0x1013
 #define SO_ACCEPTCONN	0x1014
 #define SO_PROTOCOL	0x1028
 #define SO_DOMAIN	0x1029
@@ -120,6 +120,9 @@
 
 #if !defined(__KERNEL__)
 
+#define	SO_RCVTIMEO SO_RCVTIMEO_OLD
+#define	SO_SNDTIMEO SO_SNDTIMEO_OLD
+
 #if __BITS_PER_LONG == 64
 #define SO_TIMESTAMP		SO_TIMESTAMP_OLD
 #define SO_TIMESTAMPNS		SO_TIMESTAMPNS_OLD
diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
index 1e48f67f1052..4dde20d64690 100644
--- a/arch/mips/include/uapi/asm/socket.h
+++ b/arch/mips/include/uapi/asm/socket.h
@@ -39,8 +39,8 @@
 #define SO_RCVBUF	0x1002	/* Receive buffer. */
 #define SO_SNDLOWAT	0x1003	/* send low-water mark */
 #define SO_RCVLOWAT	0x1004	/* receive low-water mark */
-#define SO_SNDTIMEO	0x1005	/* send timeout */
-#define SO_RCVTIMEO	0x1006	/* receive timeout */
+#define SO_SNDTIMEO_OLD	0x1005	/* send timeout */
+#define SO_RCVTIMEO_OLD	0x1006	/* receive timeout */
 #define SO_ACCEPTCONN	0x1009
 #define SO_PROTOCOL	0x1028	/* protocol type */
 #define SO_DOMAIN	0x1029	/* domain/socket family */
@@ -130,6 +130,8 @@
 
 #if !defined(__KERNEL__)
 
+#define	SO_RCVTIMEO SO_RCVTIMEO_OLD
+#define	SO_SNDTIMEO SO_SNDTIMEO_OLD
 #if __BITS_PER_LONG == 64
 #define SO_TIMESTAMP		SO_TIMESTAMP_OLD
 #define SO_TIMESTAMPNS		SO_TIMESTAMPNS_OLD
diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
index e8d6cf20f9a4..546937fa0d8b 100644
--- a/arch/parisc/include/uapi/asm/socket.h
+++ b/arch/parisc/include/uapi/asm/socket.h
@@ -22,8 +22,8 @@
 #define SO_RCVBUFFORCE	0x100b
 #define SO_SNDLOWAT	0x1003
 #define SO_RCVLOWAT	0x1004
-#define SO_SNDTIMEO	0x1005
-#define SO_RCVTIMEO	0x1006
+#define SO_SNDTIMEO_OLD	0x1005
+#define SO_RCVTIMEO_OLD	0x1006
 #define SO_ERROR	0x1007
 #define SO_TYPE		0x1008
 #define SO_PROTOCOL	0x1028
@@ -111,6 +111,8 @@
 
 #if !defined(__KERNEL__)
 
+#define	SO_RCVTIMEO SO_RCVTIMEO_OLD
+#define	SO_SNDTIMEO SO_SNDTIMEO_OLD
 #if __BITS_PER_LONG == 64
 #define SO_TIMESTAMP		SO_TIMESTAMP_OLD
 #define SO_TIMESTAMPNS		SO_TIMESTAMPNS_OLD
diff --git a/arch/powerpc/include/uapi/asm/socket.h b/arch/powerpc/include/uapi/asm/socket.h
index 94de465e0920..12aa0c43e775 100644
--- a/arch/powerpc/include/uapi/asm/socket.h
+++ b/arch/powerpc/include/uapi/asm/socket.h
@@ -11,8 +11,8 @@
 
 #define SO_RCVLOWAT	16
 #define SO_SNDLOWAT	17
-#define SO_RCVTIMEO	18
-#define SO_SNDTIMEO	19
+#define SO_RCVTIMEO_OLD	18
+#define SO_SNDTIMEO_OLD	19
 #define SO_PASSCRED	20
 #define SO_PEERCRED	21
 
diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
index fc65bf6b6440..bdc396211627 100644
--- a/arch/sparc/include/uapi/asm/socket.h
+++ b/arch/sparc/include/uapi/asm/socket.h
@@ -21,8 +21,8 @@
 #define SO_BSDCOMPAT    0x0400
 #define SO_RCVLOWAT     0x0800
 #define SO_SNDLOWAT     0x1000
-#define SO_RCVTIMEO     0x2000
-#define SO_SNDTIMEO     0x4000
+#define SO_RCVTIMEO_OLD     0x2000
+#define SO_SNDTIMEO_OLD     0x4000
 #define SO_ACCEPTCONN	0x8000
 
 #define SO_SNDBUF	0x1001
@@ -112,6 +112,8 @@
 
 #if !defined(__KERNEL__)
 
+#define	SO_RCVTIMEO	SO_RCVTIMEO_OLD
+#define	SO_SNDTIMEO	SO_SNDTIMEO_OLD
 #if __BITS_PER_LONG == 64
 #define SO_TIMESTAMP		SO_TIMESTAMP_OLD
 #define SO_TIMESTAMPNS		SO_TIMESTAMPNS_OLD
diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 76976d6e50f9..c98ad9777ad9 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -1089,12 +1089,12 @@ static void sctp_connect_to_sock(struct connection *con)
 	 * since O_NONBLOCK argument in connect() function does not work here,
 	 * then, we should restore the default value of this attribute.
 	 */
-	kernel_setsockopt(sock, SOL_SOCKET, SO_SNDTIMEO, (char *)&tv,
+	kernel_setsockopt(sock, SOL_SOCKET, SO_SNDTIMEO_OLD, (char *)&tv,
 			  sizeof(tv));
 	result = sock->ops->connect(sock, (struct sockaddr *)&daddr, addr_len,
 				   0);
 	memset(&tv, 0, sizeof(tv));
-	kernel_setsockopt(sock, SOL_SOCKET, SO_SNDTIMEO, (char *)&tv,
+	kernel_setsockopt(sock, SOL_SOCKET, SO_SNDTIMEO_OLD, (char *)&tv,
 			  sizeof(tv));
 
 	if (result == -EINPROGRESS)
diff --git a/include/net/sock.h b/include/net/sock.h
index 6679f3c120b0..98965a9a2bf4 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -292,8 +292,8 @@ struct sock_common {
   *	@sk_peer_pid: &struct pid for this socket's peer
   *	@sk_peer_cred: %SO_PEERCRED setting
   *	@sk_rcvlowat: %SO_RCVLOWAT setting
-  *	@sk_rcvtimeo: %SO_RCVTIMEO setting
-  *	@sk_sndtimeo: %SO_SNDTIMEO setting
+  *	@sk_rcvtimeo: %SO_RCVTIMEO_OLD setting
+  *	@sk_sndtimeo: %SO_SNDTIMEO_OLD setting
   *	@sk_txhash: computed flow hash for use on transmit
   *	@sk_filter: socket filtering instructions
   *	@sk_timer: sock cleanup timer
diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index 94e618a4a43f..9e370586fb19 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -30,8 +30,8 @@
 #define SO_PEERCRED	17
 #define SO_RCVLOWAT	18
 #define SO_SNDLOWAT	19
-#define SO_RCVTIMEO	20
-#define SO_SNDTIMEO	21
+#define SO_RCVTIMEO_OLD	20
+#define SO_SNDTIMEO_OLD	21
 #endif
 
 /* Security levels - as per NRL IPv6 - don't actually do anything */
@@ -114,6 +114,8 @@
 
 #if !defined(__KERNEL__)
 
+#define	SO_RCVTIMEO SO_RCVTIMEO_OLD
+#define	SO_SNDTIMEO SO_SNDTIMEO_OLD
 #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
 /* on 64-bit and x32, avoid the ?: operator */
 #define SO_TIMESTAMP		SO_TIMESTAMP_OLD
diff --git a/net/compat.c b/net/compat.c
index cbc15f65033c..19e047f70f64 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -378,7 +378,7 @@ static int compat_sock_setsockopt(struct socket *sock, int level, int optname,
 		return do_set_attach_filter(sock, level, optname,
 					    optval, optlen);
 	if (!COMPAT_USE_64BIT_TIME &&
-	    (optname == SO_RCVTIMEO || optname == SO_SNDTIMEO))
+	    (optname == SO_RCVTIMEO_OLD || optname == SO_SNDTIMEO_OLD))
 		return do_set_sock_timeout(sock, level, optname, optval, optlen);
 
 	return sock_setsockopt(sock, level, optname, optval, optlen);
@@ -450,7 +450,7 @@ static int compat_sock_getsockopt(struct socket *sock, int level, int optname,
 				char __user *optval, int __user *optlen)
 {
 	if (!COMPAT_USE_64BIT_TIME &&
-	    (optname == SO_RCVTIMEO || optname == SO_SNDTIMEO))
+	    (optname == SO_RCVTIMEO_OLD || optname == SO_SNDTIMEO_OLD))
 		return do_get_sock_timeout(sock, level, optname, optval, optlen);
 	return sock_getsockopt(sock, level, optname, optval, optlen);
 }
diff --git a/net/core/sock.c b/net/core/sock.c
index af0fb33624e2..42914ca3186c 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -889,11 +889,11 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
 			sk->sk_rcvlowat = val ? : 1;
 		break;
 
-	case SO_RCVTIMEO:
+	case SO_RCVTIMEO_OLD:
 		ret = sock_set_timeout(&sk->sk_rcvtimeo, optval, optlen);
 		break;
 
-	case SO_SNDTIMEO:
+	case SO_SNDTIMEO_OLD:
 		ret = sock_set_timeout(&sk->sk_sndtimeo, optval, optlen);
 		break;
 
@@ -1222,7 +1222,7 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 		v.val = sk->sk_tsflags;
 		break;
 
-	case SO_RCVTIMEO:
+	case SO_RCVTIMEO_OLD:
 		lv = sizeof(struct __kernel_old_timeval);
 		if (sk->sk_rcvtimeo == MAX_SCHEDULE_TIMEOUT) {
 			v.tm.tv_sec = 0;
@@ -1233,7 +1233,7 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 		}
 		break;
 
-	case SO_SNDTIMEO:
+	case SO_SNDTIMEO_OLD:
 		lv = sizeof(struct __kernel_old_timeval);
 		if (sk->sk_sndtimeo == MAX_SCHEDULE_TIMEOUT) {
 			v.tm.tv_sec = 0;
-- 
2.17.1

