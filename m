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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012AAC282DA
	for <linux-mips@archiver.kernel.org>; Fri,  1 Feb 2019 15:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B227D20855
	for <linux-mips@archiver.kernel.org>; Fri,  1 Feb 2019 15:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XP7KRo9s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbfBAPqC (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:46:02 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36528 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728634AbfBAPqB (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Fri, 1 Feb 2019 10:46:01 -0500
Received: by mail-pf1-f195.google.com with SMTP id b85so3396778pfc.3;
        Fri, 01 Feb 2019 07:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dF2LAdEhafWzIQxJixmVAE4RRAMYhlC7Kg9jv7I5j10=;
        b=XP7KRo9svwCOnSGr/XwaOFUopNKEZ1AZtkrvqQRRfkESyrydFcLoLJD1oZ6GF/csvD
         udoA6fJdJlwf7fz+Oxt3YVchPP7ADbR2O0DEJ7NfJbyCcyMhqcyE93+x2oJFisrS7MV4
         uCzrL1kVK05zz2cpVMju/2xMFdF24fy3U3YP8l4+PgPW1b6tVRD9HA+FN/zJw0gRHZCi
         nNWEYxMlHs441Plq5yVXT8XU5IgEOZiDn7T1Edy7Bjw6s4HZUsfkSheZ50qutXk+eZ+F
         /HGtYliVmFdoyNG28IS5ccJcb8zCcCbIDIIaUx+pAYlcXd8+afYo6jTQc858W8TvW7q8
         A58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dF2LAdEhafWzIQxJixmVAE4RRAMYhlC7Kg9jv7I5j10=;
        b=CbpJk7bYnSa8tH4Tb/iBPDTQigNmUc4a/gdR4Zj5bjSXyV+bcXvJ2YUPrytrEgmVYK
         6TIwTz2vRwQfypHDiGd6x+CcyozBuqBI3/2CyqXzy/Do4P3s/VKlpROQbhNmIgKC99N3
         nk793JXt/5cG9rbxnKqhwxmcjKVNoMmetJ2E7GuVvjyjlgBWka4SjXMY5UEWh8xAE65e
         N0lbg2nYln/HDtqYU+CWunW01374FDz2x2+RYIQfLbTXGLzUKRglZZiK+ZWwAuBPUdGp
         NRr94bmwlseSf7CXzwz2VmaB99f+soDvcfJ7V4EJK4CL636yS4XejLEJ6V8ICQw1A8Un
         xuQA==
X-Gm-Message-State: AHQUAuZ8u7pjfY+KxY9fir2RlXH/TOPLguofrGVMJSGj7w2yAdmI+Bmu
        TAN6lsND7bGVlH25rWBA46Y=
X-Google-Smtp-Source: AHgI3IZxSwIL7fDZMETlnvedDaHRSlssfqXyO1M+p2LvR0kLdr5faSEu9tPn9N7hBYrxbM8Lqg/dLA==
X-Received: by 2002:a63:a553:: with SMTP id r19mr2734654pgu.53.1549035960242;
        Fri, 01 Feb 2019 07:46:00 -0800 (PST)
Received: from localhost.localdomain ([49.206.15.111])
        by smtp.gmail.com with ESMTPSA id z9sm25886959pfd.99.2019.02.01.07.45.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 07:45:59 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org,
        ccaulfie@redhat.com, deller@gmx.de, paulus@samba.org,
        ralf@linux-mips.org, rth@twiddle.net, cluster-devel@redhat.com,
        linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [PATCH net-next v4 12/12] sock: Add SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW
Date:   Fri,  1 Feb 2019 07:43:56 -0800
Message-Id: <20190201154356.15536-13-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190201154356.15536-1-deepa.kernel@gmail.com>
References: <20190201154356.15536-1-deepa.kernel@gmail.com>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Add new socket timeout options that are y2038 safe.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: ccaulfie@redhat.com
Cc: davem@davemloft.net
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
 arch/alpha/include/uapi/asm/socket.h  | 12 +++++--
 arch/mips/include/uapi/asm/socket.h   | 11 ++++--
 arch/parisc/include/uapi/asm/socket.h | 10 ++++--
 arch/sparc/include/uapi/asm/socket.h  | 11 ++++--
 include/uapi/asm-generic/socket.h     | 11 ++++--
 net/core/sock.c                       | 49 ++++++++++++++++++++-------
 6 files changed, 81 insertions(+), 23 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
index 9826d1db71d0..0d0fddb7e738 100644
--- a/arch/alpha/include/uapi/asm/socket.h
+++ b/arch/alpha/include/uapi/asm/socket.h
@@ -119,19 +119,25 @@
 #define SO_TIMESTAMPNS_NEW      64
 #define SO_TIMESTAMPING_NEW     65
 
-#if !defined(__KERNEL__)
+#define SO_RCVTIMEO_NEW         66
+#define SO_SNDTIMEO_NEW         67
 
-#define	SO_RCVTIMEO SO_RCVTIMEO_OLD
-#define	SO_SNDTIMEO SO_SNDTIMEO_OLD
+#if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
 #define SO_TIMESTAMP		SO_TIMESTAMP_OLD
 #define SO_TIMESTAMPNS		SO_TIMESTAMPNS_OLD
 #define SO_TIMESTAMPING         SO_TIMESTAMPING_OLD
+
+#define SO_RCVTIMEO		SO_RCVTIMEO_OLD
+#define SO_SNDTIMEO		SO_SNDTIMEO_OLD
 #else
 #define SO_TIMESTAMP (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMP_OLD : SO_TIMESTAMP_NEW)
 #define SO_TIMESTAMPNS (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMPNS_OLD : SO_TIMESTAMPNS_NEW)
 #define SO_TIMESTAMPING (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMPING_OLD : SO_TIMESTAMPING_NEW)
+
+#define SO_RCVTIMEO (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_RCVTIMEO_OLD : SO_RCVTIMEO_NEW)
+#define SO_SNDTIMEO (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_SNDTIMEO_OLD : SO_SNDTIMEO_NEW)
 #endif
 
 #define SCM_TIMESTAMP           SO_TIMESTAMP
diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
index 96cc0e907f12..eb9f33f8a8b3 100644
--- a/arch/mips/include/uapi/asm/socket.h
+++ b/arch/mips/include/uapi/asm/socket.h
@@ -130,18 +130,25 @@
 #define SO_TIMESTAMPNS_NEW      64
 #define SO_TIMESTAMPING_NEW     65
 
+#define SO_RCVTIMEO_NEW         66
+#define SO_SNDTIMEO_NEW         67
+
 #if !defined(__KERNEL__)
 
-#define	SO_RCVTIMEO SO_RCVTIMEO_OLD
-#define	SO_SNDTIMEO SO_SNDTIMEO_OLD
 #if __BITS_PER_LONG == 64
 #define SO_TIMESTAMP		SO_TIMESTAMP_OLD
 #define SO_TIMESTAMPNS		SO_TIMESTAMPNS_OLD
 #define SO_TIMESTAMPING		SO_TIMESTAMPING_OLD
+
+#define SO_RCVTIMEO             SO_RCVTIMEO_OLD
+#define SO_SNDTIMEO             SO_SNDTIMEO_OLD
 #else
 #define SO_TIMESTAMP (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMP_OLD : SO_TIMESTAMP_NEW)
 #define SO_TIMESTAMPNS (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMPNS_OLD : SO_TIMESTAMPNS_NEW)
 #define SO_TIMESTAMPING (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMPING_OLD : SO_TIMESTAMPING_NEW)
+
+#define SO_RCVTIMEO (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_RCVTIMEO_OLD : SO_RCVTIMEO_NEW)
+#define SO_SNDTIMEO (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_SNDTIMEO_OLD : SO_SNDTIMEO_NEW)
 #endif
 
 #define SCM_TIMESTAMP           SO_TIMESTAMP
diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
index 046f0cd9cce4..16e428f03526 100644
--- a/arch/parisc/include/uapi/asm/socket.h
+++ b/arch/parisc/include/uapi/asm/socket.h
@@ -111,18 +111,24 @@
 #define SO_TIMESTAMPNS_NEW      0x4039
 #define SO_TIMESTAMPING_NEW     0x403A
 
+#define SO_RCVTIMEO_NEW         0x4040
+#define SO_SNDTIMEO_NEW         0x4041
+
 #if !defined(__KERNEL__)
 
-#define	SO_RCVTIMEO SO_RCVTIMEO_OLD
-#define	SO_SNDTIMEO SO_SNDTIMEO_OLD
 #if __BITS_PER_LONG == 64
 #define SO_TIMESTAMP		SO_TIMESTAMP_OLD
 #define SO_TIMESTAMPNS		SO_TIMESTAMPNS_OLD
 #define SO_TIMESTAMPING         SO_TIMESTAMPING_OLD
+#define SO_RCVTIMEO		SO_RCVTIMEO_OLD
+#define SO_SNDTIMEO		SO_SNDTIMEO_OLD
 #else
 #define SO_TIMESTAMP (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMP_OLD : SO_TIMESTAMP_NEW)
 #define SO_TIMESTAMPNS (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMPNS_OLD : SO_TIMESTAMPNS_NEW)
 #define SO_TIMESTAMPING (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMPING_OLD : SO_TIMESTAMPING_NEW)
+
+#define SO_RCVTIMEO (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_RCVTIMEO_OLD : SO_RCVTIMEO_NEW)
+#define SO_SNDTIMEO (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_SNDTIMEO_OLD : SO_SNDTIMEO_NEW)
 #endif
 
 #define SCM_TIMESTAMP           SO_TIMESTAMP
diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
index 342ffdc3b424..8c9f74a66b55 100644
--- a/arch/sparc/include/uapi/asm/socket.h
+++ b/arch/sparc/include/uapi/asm/socket.h
@@ -112,19 +112,26 @@
 #define SO_TIMESTAMPNS_NEW       0x0042
 #define SO_TIMESTAMPING_NEW      0x0043
 
+#define SO_RCVTIMEO_NEW          0x0044
+#define SO_SNDTIMEO_NEW          0x0045
+
 #if !defined(__KERNEL__)
 
-#define SO_RCVTIMEO              SO_RCVTIMEO_OLD
-#define SO_SNDTIMEO              SO_SNDTIMEO_OLD
 
 #if __BITS_PER_LONG == 64
 #define SO_TIMESTAMP		SO_TIMESTAMP_OLD
 #define SO_TIMESTAMPNS		SO_TIMESTAMPNS_OLD
 #define SO_TIMESTAMPING		SO_TIMESTAMPING_OLD
+
+#define SO_RCVTIMEO		SO_RCVTIMEO_OLD
+#define SO_SNDTIMEO		SO_SNDTIMEO_OLD
 #else
 #define SO_TIMESTAMP (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMP_OLD : SO_TIMESTAMP_NEW)
 #define SO_TIMESTAMPNS (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMPNS_OLD : SO_TIMESTAMPNS_NEW)
 #define SO_TIMESTAMPING (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMPING_OLD : SO_TIMESTAMPING_NEW)
+
+#define SO_RCVTIMEO (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_RCVTIMEO_OLD : SO_RCVTIMEO_NEW)
+#define SO_SNDTIMEO (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_SNDTIMEO_OLD : SO_SNDTIMEO_NEW)
 #endif
 
 #define SCM_TIMESTAMP          SO_TIMESTAMP
diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index c56b8b487c12..c8b430cb6dc4 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -114,19 +114,26 @@
 #define SO_TIMESTAMPNS_NEW      64
 #define SO_TIMESTAMPING_NEW     65
 
+#define SO_RCVTIMEO_NEW         66
+#define SO_SNDTIMEO_NEW         67
+
 #if !defined(__KERNEL__)
 
-#define	SO_RCVTIMEO SO_RCVTIMEO_OLD
-#define	SO_SNDTIMEO SO_SNDTIMEO_OLD
 #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
 /* on 64-bit and x32, avoid the ?: operator */
 #define SO_TIMESTAMP		SO_TIMESTAMP_OLD
 #define SO_TIMESTAMPNS		SO_TIMESTAMPNS_OLD
 #define SO_TIMESTAMPING		SO_TIMESTAMPING_OLD
+
+#define SO_RCVTIMEO		SO_RCVTIMEO_OLD
+#define SO_SNDTIMEO		SO_SNDTIMEO_OLD
 #else
 #define SO_TIMESTAMP (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMP_OLD : SO_TIMESTAMP_NEW)
 #define SO_TIMESTAMPNS (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMPNS_OLD : SO_TIMESTAMPNS_NEW)
 #define SO_TIMESTAMPING (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMPING_OLD : SO_TIMESTAMPING_NEW)
+
+#define SO_RCVTIMEO (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_RCVTIMEO_OLD : SO_RCVTIMEO_NEW)
+#define SO_SNDTIMEO (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_SNDTIMEO_OLD : SO_SNDTIMEO_NEW)
 #endif
 
 #define SCM_TIMESTAMP           SO_TIMESTAMP
diff --git a/net/core/sock.c b/net/core/sock.c
index 0e29e0b0338f..3a74adae23d0 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -335,9 +335,10 @@ int __sk_backlog_rcv(struct sock *sk, struct sk_buff *skb)
 }
 EXPORT_SYMBOL(__sk_backlog_rcv);
 
-static int sock_get_timeout(long timeo, void *optval)
+static int sock_get_timeout(long timeo, void *optval, bool old_timeval)
 {
-	struct __kernel_old_timeval tv;
+	struct __kernel_sock_timeval tv;
+	int size;
 
 	if (timeo == MAX_SCHEDULE_TIMEOUT) {
 		tv.tv_sec = 0;
@@ -353,13 +354,23 @@ static int sock_get_timeout(long timeo, void *optval)
 		return sizeof(tv32);
 	}
 
-	*(struct __kernel_old_timeval *)optval = tv;
-	return sizeof(tv);
+	if (old_timeval) {
+		struct __kernel_old_timeval old_tv;
+		old_tv.tv_sec = tv.tv_sec;
+		old_tv.tv_usec = tv.tv_usec;
+		*(struct __kernel_old_timeval *)optval = old_tv;
+		size = sizeof(old_tv);
+	} else {
+		*(struct __kernel_sock_timeval *)optval = tv;
+		size = sizeof(tv);
+	}
+
+	return size;
 }
 
-static int sock_set_timeout(long *timeo_p, char __user *optval, int optlen)
+static int sock_set_timeout(long *timeo_p, char __user *optval, int optlen, bool old_timeval)
 {
-	struct __kernel_old_timeval tv;
+	struct __kernel_sock_timeval tv;
 
 	if (in_compat_syscall() && !COMPAT_USE_64BIT_TIME) {
 		struct old_timeval32 tv32;
@@ -371,6 +382,15 @@ static int sock_set_timeout(long *timeo_p, char __user *optval, int optlen)
 			return -EFAULT;
 		tv.tv_sec = tv32.tv_sec;
 		tv.tv_usec = tv32.tv_usec;
+	} else if (old_timeval) {
+		struct __kernel_old_timeval old_tv;
+
+		if (optlen < sizeof(old_tv))
+			return -EINVAL;
+		if (copy_from_user(&old_tv, optval, sizeof(old_tv)))
+			return -EFAULT;
+		tv.tv_sec = old_tv.tv_sec;
+		tv.tv_usec = old_tv.tv_usec;
 	} else {
 		if (optlen < sizeof(tv))
 			return -EINVAL;
@@ -394,8 +414,8 @@ static int sock_set_timeout(long *timeo_p, char __user *optval, int optlen)
 	*timeo_p = MAX_SCHEDULE_TIMEOUT;
 	if (tv.tv_sec == 0 && tv.tv_usec == 0)
 		return 0;
-	if (tv.tv_sec < (MAX_SCHEDULE_TIMEOUT/HZ - 1))
-		*timeo_p = tv.tv_sec * HZ + DIV_ROUND_UP(tv.tv_usec, USEC_PER_SEC / HZ);
+	if (tv.tv_sec < (MAX_SCHEDULE_TIMEOUT / HZ - 1))
+		*timeo_p = tv.tv_sec * HZ + DIV_ROUND_UP((unsigned long)tv.tv_usec, USEC_PER_SEC / HZ);
 	return 0;
 }
 
@@ -942,11 +962,13 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case SO_RCVTIMEO_OLD:
-		ret = sock_set_timeout(&sk->sk_rcvtimeo, optval, optlen);
+	case SO_RCVTIMEO_NEW:
+		ret = sock_set_timeout(&sk->sk_rcvtimeo, optval, optlen, optname == SO_RCVTIMEO_OLD);
 		break;
 
 	case SO_SNDTIMEO_OLD:
-		ret = sock_set_timeout(&sk->sk_sndtimeo, optval, optlen);
+	case SO_SNDTIMEO_NEW:
+		ret = sock_set_timeout(&sk->sk_sndtimeo, optval, optlen, optname == SO_SNDTIMEO_OLD);
 		break;
 
 	case SO_ATTACH_FILTER:
@@ -1171,6 +1193,7 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 		struct linger ling;
 		struct old_timeval32 tm32;
 		struct __kernel_old_timeval tm;
+		struct  __kernel_sock_timeval stm;
 		struct sock_txtime txtime;
 	} v;
 
@@ -1280,11 +1303,13 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case SO_RCVTIMEO_OLD:
-		lv = sock_get_timeout(sk->sk_rcvtimeo, optval);
+	case SO_RCVTIMEO_NEW:
+		lv = sock_get_timeout(sk->sk_rcvtimeo, optval, SO_RCVTIMEO_OLD == optname);
 		break;
 
 	case SO_SNDTIMEO_OLD:
-		lv = sock_get_timeout(sk->sk_sndtimeo, optval);
+	case SO_SNDTIMEO_NEW:
+		lv = sock_get_timeout(sk->sk_sndtimeo, optval, SO_SNDTIMEO_OLD == optname);
 		break;
 
 	case SO_RCVLOWAT:
-- 
2.17.1

