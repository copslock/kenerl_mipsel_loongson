Return-Path: <SRS0=+ky4=QI=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AA6C282DA
	for <linux-mips@archiver.kernel.org>; Fri,  1 Feb 2019 15:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0351720855
	for <linux-mips@archiver.kernel.org>; Fri,  1 Feb 2019 15:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GB0CpwEh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730208AbfBAPpv (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:45:51 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33601 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729417AbfBAPpu (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Fri, 1 Feb 2019 10:45:50 -0500
Received: by mail-pl1-f196.google.com with SMTP id z23so3410034plo.0;
        Fri, 01 Feb 2019 07:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L+eRszaVcLJhzXj2o2NlyRdmZKWD9e+IePzjE+CEeas=;
        b=GB0CpwEhcke4UA2ODfF7QoeMePw8fiBcd/3p9Xx5u1gfvoanw87Fncx2aT93xGzbJk
         NFi+hkp5gRxlOqg+6t/eDipHC0oGFyKxbGqhnuagu3JIpguxd58hILhz2lQQ0B/5feop
         kzHHJCynkd3xxnlEudZuIFsLj9acdtVDqp+U+DtjkU5npU1jWTcHooYpT2zoIGpqWaG+
         rk1uEfMbgcUgggwOMaIWrUsvxZ4DqMTUG8bWRMKZTSJ32K2XXHl4uyxZCA+DCG3kJKD6
         A4imtJJR2S/YnxTSKkhybhSfHIjO6nX/R/OODBfTENTPlM7VmX6uCmEkZM93R3tiueWP
         U4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L+eRszaVcLJhzXj2o2NlyRdmZKWD9e+IePzjE+CEeas=;
        b=noHCLh7YuqkoY0cZvUo4FQR9PhMZPm2qEyCHDqeu+Aemsc0enpi5tQbCeBiv2NIZwA
         CIPZbooIGrO0x7kjRobcxWuURGzXNWqx0Kidak8NyiSTLHcJ+JM27eLwVbpJ+lknIZVg
         wWm7zlouYRia6NMG0e+Q8xFOye5pZ81sPE2MAx7BeKD0nootxPNfrBM2BJjVX/9yTyrH
         9YPllKDwV86sjjwc+tNUijT59Ogv6PYH7lcKIsd6pBoO7mBX9EP3T/cUyanUXNFXon6Y
         uqgOhCvc9JyzQWM6FR1NWGrBouiy04SqYHON7S1aTKqiFTbpaG9ikOED+EcTQvjG1H4z
         o5qA==
X-Gm-Message-State: AJcUukdjGUBxuxBKyG4MhFURq6gq8gHh5nbcnfwi47O3yP2uG9Cc+yWR
        XR4zfBwD99dLJOe9UaUfZiU=
X-Google-Smtp-Source: ALg8bN64qzo97aUdVkordA6l0tw9WewI0kuC6dAcsqisGCt1ubeL/7DdPcZ6HEv6oXRv3cDJ85mszQ==
X-Received: by 2002:a17:902:2dc3:: with SMTP id p61mr39322887plb.166.1549035949480;
        Fri, 01 Feb 2019 07:45:49 -0800 (PST)
Received: from localhost.localdomain ([49.206.15.111])
        by smtp.gmail.com with ESMTPSA id z9sm25886959pfd.99.2019.02.01.07.45.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 07:45:48 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org,
        ccaulfie@redhat.com, deller@gmx.de, paulus@samba.org,
        ralf@linux-mips.org, rth@twiddle.net, cluster-devel@redhat.com,
        linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [PATCH net-next v4 11/12] socket: Rename SO_RCVTIMEO/ SO_SNDTIMEO with _OLD suffixes
Date:   Fri,  1 Feb 2019 07:43:55 -0800
Message-Id: <20190201154356.15536-12-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190201154356.15536-1-deepa.kernel@gmail.com>
References: <20190201154356.15536-1-deepa.kernel@gmail.com>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

SO_RCVTIMEO and SO_SNDTIMEO socket options use struct timeval
as the time format. struct timeval is not y2038 safe.
The subsequent patches in the series add support for new socket
timeout options with _NEW suffix that will use y2038 safe
data structures. Although the existing struct timeval layout
is sufficiently wide to represent timeouts, because of the way
libc will interpret time_t based on user defined flag, these
new flags provide a way of having a structure that is the same
for all architectures consistently.
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
 arch/sparc/include/uapi/asm/socket.h   | 7 +++++--
 fs/dlm/lowcomms.c                      | 4 ++--
 include/uapi/asm-generic/socket.h      | 6 ++++--
 net/core/sock.c                        | 8 ++++----
 8 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
index 934ea6268f1a..9826d1db71d0 100644
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
@@ -121,6 +121,9 @@
 
 #if !defined(__KERNEL__)
 
+#define	SO_RCVTIMEO SO_RCVTIMEO_OLD
+#define	SO_SNDTIMEO SO_SNDTIMEO_OLD
+
 #if __BITS_PER_LONG == 64
 #define SO_TIMESTAMP		SO_TIMESTAMP_OLD
 #define SO_TIMESTAMPNS		SO_TIMESTAMPNS_OLD
diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
index 110f9506d64f..96cc0e907f12 100644
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
@@ -132,6 +132,8 @@
 
 #if !defined(__KERNEL__)
 
+#define	SO_RCVTIMEO SO_RCVTIMEO_OLD
+#define	SO_SNDTIMEO SO_SNDTIMEO_OLD
 #if __BITS_PER_LONG == 64
 #define SO_TIMESTAMP		SO_TIMESTAMP_OLD
 #define SO_TIMESTAMPNS		SO_TIMESTAMPNS_OLD
diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
index bee2a9dde656..046f0cd9cce4 100644
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
@@ -113,6 +113,8 @@
 
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
index 2b38dda51426..342ffdc3b424 100644
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
@@ -114,6 +114,9 @@
 
 #if !defined(__KERNEL__)
 
+#define SO_RCVTIMEO              SO_RCVTIMEO_OLD
+#define SO_SNDTIMEO              SO_SNDTIMEO_OLD
+
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
diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index 2713e0fa68ef..c56b8b487c12 100644
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
@@ -116,6 +116,8 @@
 
 #if !defined(__KERNEL__)
 
+#define	SO_RCVTIMEO SO_RCVTIMEO_OLD
+#define	SO_SNDTIMEO SO_SNDTIMEO_OLD
 #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
 /* on 64-bit and x32, avoid the ?: operator */
 #define SO_TIMESTAMP		SO_TIMESTAMP_OLD
diff --git a/net/core/sock.c b/net/core/sock.c
index a7c2f6287616..0e29e0b0338f 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -941,11 +941,11 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
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
 
@@ -1279,11 +1279,11 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 		v.val = sk->sk_tsflags;
 		break;
 
-	case SO_RCVTIMEO:
+	case SO_RCVTIMEO_OLD:
 		lv = sock_get_timeout(sk->sk_rcvtimeo, optval);
 		break;
 
-	case SO_SNDTIMEO:
+	case SO_SNDTIMEO_OLD:
 		lv = sock_get_timeout(sk->sk_sndtimeo, optval);
 		break;
 
-- 
2.17.1

