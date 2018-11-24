Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Nov 2018 03:22:17 +0100 (CET)
Received: from mail-yb1-xb41.google.com ([IPv6:2607:f8b0:4864:20::b41]:46376
        "EHLO mail-yb1-xb41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993030AbeKXCWM60wiq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Nov 2018 03:22:12 +0100
Received: by mail-yb1-xb41.google.com with SMTP id i17-v6so5367244ybp.13;
        Fri, 23 Nov 2018 18:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GyvyFcwRfMPWcg4xrgZrrHd275SRdRZ4mgQA5ESToIQ=;
        b=I2sqVYJfTXZdwhaY98g0d5YAXEt8HufNw9SfzovCwhqzCT6mczH5e+qfoK7ZWh0ey7
         GQCH5UrKRi5pVfUnaR5Z28i2pQNnqYzNU4g3Tq13ATk9XxyY6icVpgFi5dZbm7Kd461u
         P6D7C0IeCw3GfeZchPEU/dqXih/d2BjgCykbbPi8tUZ0rX/NjgaCs4jF0PTjWfyhHctd
         cs/RdhpDgw+jNFF+jAuRr6V0jaMm04ktgIVwMuwdjHXknHnj1WEIFmToXzU2Te5uc1mb
         1tJ/49RUiUxFgKBWgsT45aChwZ3VWieRiDSX9X6Lea0HfKuEDFtyExZbzQb5m7fVgVRb
         N3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GyvyFcwRfMPWcg4xrgZrrHd275SRdRZ4mgQA5ESToIQ=;
        b=ixO5jr1u6ISvJ2B/wp/QGVtmdQGd8Rj4vp80iyuqTHH3nluiLo0IJbV4MI/3MlnGF2
         nf/mRlAclB61g96rp5bwN8kSS81dqkybZoDwz5GGDgA5LydRcnkibVi5Ad50F1YjLt0M
         smHyj9xYtvuDg53M8lLaTRJBGvqIeNYV9B7eua0FpBwRWoMnL2TaHGSZslQzTF6/lkcc
         8a+ixTiRsvCa8Rb6qxBn5DCxZ1zUli6X54aiGksLnpht4n1lCHIV54o8UMdtTaMiL181
         Go/Jr2R/DEXKS8j35hW4mmhd3twwsVsmZ4nOC02AdUmWx9kG7DSm5LMgo64NCV9hCd+I
         w/7Q==
X-Gm-Message-State: AA+aEWZe5bJ+EOmUXTzRVM0JVqrsaDnSQBTxbVdf5CJ9QxBEtQlwsXgz
        mrXZrrLdtwuECEwhOwLmvcU=
X-Google-Smtp-Source: AFSGD/VAHc0TrO8hxKvlc0jMgGPQeFq28K9BNCc9q+Itx0i9jIVIGFwJi3e3UhW4ZUiKARRV6K4sfg==
X-Received: by 2002:a25:4644:: with SMTP id t65-v6mr18996484yba.43.1543026132051;
        Fri, 23 Nov 2018 18:22:12 -0800 (PST)
Received: from deepa-ubuntu.lan (c-98-234-52-213.hsd1.ca.comcast.net. [98.234.52.213])
        by smtp.gmail.com with ESMTPSA id w1sm6947292ywd.49.2018.11.23.18.22.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 18:22:11 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, viro@zeniv.linux.org.uk, arnd@arndb.de,
        y2038@lists.linaro.org, jejb@parisc-linux.org, ralf@linux-mips.org,
        rth@twiddle.net, linux-alpha@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linux-rdma@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [PATCH 7/8] socket: Add SO_TIMESTAMP[NS]_NEW
Date:   Fri, 23 Nov 2018 18:20:34 -0800
Message-Id: <20181124022035.17519-8-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181124022035.17519-1-deepa.kernel@gmail.com>
References: <20181124022035.17519-1-deepa.kernel@gmail.com>
Return-Path: <deepa.kernel@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67470
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: deepa.kernel@gmail.com
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

Add SO_TIMESTAMP_NEW and SO_TIMESTAMPNS_NEW variants of
socket timestamp options.
These are the y2038 safe versions of the SO_TIMESTAMP_OLD
and SO_TIMESTAMPNS_OLD for all architectures.

Note that the format of scm_timestamping.ts[0] is not changed
in this patch.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: jejb@parisc-linux.org
Cc: ralf@linux-mips.org
Cc: rth@twiddle.net
Cc: linux-alpha@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: linux-parisc@vger.kernel.org
Cc: linux-rdma@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: sparclinux@vger.kernel.org
---
 arch/alpha/include/uapi/asm/socket.h  | 15 ++++++-
 arch/mips/include/uapi/asm/socket.h   | 14 +++++-
 arch/parisc/include/uapi/asm/socket.h | 14 +++++-
 arch/sparc/include/uapi/asm/socket.h  | 14 +++++-
 include/linux/skbuff.h                | 18 ++++++++
 include/net/sock.h                    |  1 +
 include/uapi/asm-generic/socket.h     | 15 ++++++-
 net/core/sock.c                       | 18 ++++++++
 net/ipv4/tcp.c                        | 61 +++++++++++++++++++--------
 net/rds/af_rds.c                      |  8 +++-
 net/rds/recv.c                        | 16 ++++++-
 net/socket.c                          | 47 +++++++++++++++------
 12 files changed, 197 insertions(+), 44 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
index 00e45c80e574..352e3dc0b3d9 100644
--- a/arch/alpha/include/uapi/asm/socket.h
+++ b/arch/alpha/include/uapi/asm/socket.h
@@ -3,6 +3,7 @@
 #define _UAPI_ASM_SOCKET_H
 
 #include <asm/sockios.h>
+#include <asm/bitsperlong.h>
 
 /* For setsockopt(2) */
 /*
@@ -110,12 +111,22 @@
 
 #define SO_TIMESTAMP_OLD         29
 #define SO_TIMESTAMPNS_OLD       35
+
 #define SO_TIMESTAMPING_OLD      37
 
+#define SO_TIMESTAMP_NEW         62
+#define SO_TIMESTAMPNS_NEW       63
+
 #if !defined(__KERNEL__)
 
-#define SO_TIMESTAMP           SO_TIMESTAMP_OLD
-#define SO_TIMESTAMPNS         SO_TIMESTAMPNS_OLD
+#if __BITS_PER_LONG == 64
+#define SO_TIMESTAMP		SO_TIMESTAMP_OLD
+#define SO_TIMESTAMPNS		SO_TIMESTAMPNS_OLD
+#else
+#define SO_TIMESTAMP (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMP_OLD : SO_TIMESTAMP_NEW)
+#define SO_TIMESTAMPNS (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMPNS_OLD : SO_TIMESTAMPNS_NEW)
+#endif
+
 #define SO_TIMESTAMPING        SO_TIMESTAMPING_OLD
 
 #define SCM_TIMESTAMP          SO_TIMESTAMP
diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
index b9553f770346..d1752e3f1248 100644
--- a/arch/mips/include/uapi/asm/socket.h
+++ b/arch/mips/include/uapi/asm/socket.h
@@ -11,6 +11,7 @@
 #define _UAPI_ASM_SOCKET_H
 
 #include <asm/sockios.h>
+#include <asm/bitsperlong.h>
 
 /*
  * For setsockopt(2)
@@ -123,10 +124,19 @@
 #define SO_TIMESTAMPNS_OLD       35
 #define SO_TIMESTAMPING_OLD      37
 
+#define SO_TIMESTAMP_NEW         62
+#define SO_TIMESTAMPNS_NEW       63
+
 #if !defined(__KERNEL__)
 
-#define SO_TIMESTAMP           SO_TIMESTAMP_OLD
-#define SO_TIMESTAMPNS         SO_TIMESTAMPNS_OLD
+#if __BITS_PER_LONG == 64
+#define SO_TIMESTAMP		SO_TIMESTAMP_OLD
+#define SO_TIMESTAMPNS		SO_TIMESTAMPNS_OLD
+#else
+#define SO_TIMESTAMP (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMP_OLD : SO_TIMESTAMP_NEW)
+#define SO_TIMESTAMPNS (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMPNS_OLD : SO_TIMESTAMPNS_NEW)
+#endif
+
 #define SO_TIMESTAMPING        SO_TIMESTAMPING_OLD
 
 #define SCM_TIMESTAMP          SO_TIMESTAMP
diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
index 37cdfe64bb27..0a45b668abd1 100644
--- a/arch/parisc/include/uapi/asm/socket.h
+++ b/arch/parisc/include/uapi/asm/socket.h
@@ -3,6 +3,7 @@
 #define _UAPI_ASM_SOCKET_H
 
 #include <asm/sockios.h>
+#include <asm/bitsperlong.h>
 
 /* For setsockopt(2) */
 #define SOL_SOCKET	0xffff
@@ -104,10 +105,19 @@
 #define SO_TIMESTAMPNS_OLD       0x4013
 #define SO_TIMESTAMPING_OLD      0x4020
 
+#define SO_TIMESTAMP_NEW         0x4037
+#define SO_TIMESTAMPNS_NEW       0x4038
+
 #if !defined(__KERNEL__)
 
-#define SO_TIMESTAMP           SO_TIMESTAMP_OLD
-#define SO_TIMESTAMPNS         SO_TIMESTAMPNS_OLD
+#if __BITS_PER_LONG == 64
+#define SO_TIMESTAMP		SO_TIMESTAMP_OLD
+#define SO_TIMESTAMPNS		SO_TIMESTAMPNS_OLD
+#else
+#define SO_TIMESTAMP (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMP_OLD : SO_TIMESTAMP_NEW)
+#define SO_TIMESTAMPNS (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMPNS_OLD : SO_TIMESTAMPNS_NEW)
+#endif
+
 #define SO_TIMESTAMPING        SO_TIMESTAMPING_OLD
 
 #define SCM_TIMESTAMP          SO_TIMESTAMP
diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
index ca573641fc6c..dc8527cae5a7 100644
--- a/arch/sparc/include/uapi/asm/socket.h
+++ b/arch/sparc/include/uapi/asm/socket.h
@@ -3,6 +3,7 @@
 #define _ASM_SOCKET_H
 
 #include <asm/sockios.h>
+#include <asm/bitsperlong.h>
 
 /* For setsockopt(2) */
 #define SOL_SOCKET	0xffff
@@ -105,10 +106,19 @@
 #define SO_TIMESTAMPNS_OLD       0x0021
 #define SO_TIMESTAMPING_OLD      0x0023
 
+#define SO_TIMESTAMP_NEW         0x0040
+#define SO_TIMESTAMPNS_NEW       0x0041
+
 #if !defined(__KERNEL__)
 
-#define SO_TIMESTAMP           SO_TIMESTAMP_OLD
-#define SO_TIMESTAMPNS         SO_TIMESTAMPNS_OLD
+#if __BITS_PER_LONG == 64
+#define SO_TIMESTAMP		SO_TIMESTAMP_OLD
+#define SO_TIMESTAMPNS		SO_TIMESTAMPNS_OLD
+#else
+#define SO_TIMESTAMP (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMP_OLD : SO_TIMESTAMP_NEW)
+#define SO_TIMESTAMPNS (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMPNS_OLD : SO_TIMESTAMPNS_NEW)
+#endif
+
 #define SO_TIMESTAMPING        SO_TIMESTAMPING_OLD
 
 #define SCM_TIMESTAMP          SO_TIMESTAMP
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index e2dc01330cb1..1e42c4a2209d 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3465,12 +3465,30 @@ static inline void skb_get_timestamp(const struct sk_buff *skb,
 	*stamp = ns_to_kernel_old_timeval(skb->tstamp);
 }
 
+static inline void skb_get_new_timestamp(const struct sk_buff *skb,
+				     struct sock_timeval *stamp)
+{
+	struct timespec64 ts = ktime_to_timespec64(skb->tstamp);
+
+	stamp->tv_sec = ts.tv_sec;
+	stamp->tv_usec = ts.tv_nsec / 1000;
+}
+
 static inline void skb_get_timestampns(const struct sk_buff *skb,
 				       struct timespec *stamp)
 {
 	*stamp = ktime_to_timespec(skb->tstamp);
 }
 
+static inline void skb_get_new_timestampns(const struct sk_buff *skb,
+				       struct __kernel_timespec *stamp)
+{
+	struct timespec64 ts = ktime_to_timespec64(skb->tstamp);
+
+	stamp->tv_sec = ts.tv_sec;
+	stamp->tv_nsec = ts.tv_nsec;
+}
+
 static inline void __net_timestamp(struct sk_buff *skb)
 {
 	skb->tstamp = ktime_get_real();
diff --git a/include/net/sock.h b/include/net/sock.h
index 8143c4c1a49d..9edf909dc176 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -801,6 +801,7 @@ enum sock_flags {
 	SOCK_RCU_FREE, /* wait rcu grace period in sk_destruct() */
 	SOCK_TXTIME,
 	SOCK_XDP, /* XDP is attached */
+	SOCK_TSTAMP_NEW, /* Indicates 64 bit timestamps always */
 };
 
 #define SK_FLAGS_TIMESTAMP ((1UL << SOCK_TIMESTAMP) | (1UL << SOCK_TIMESTAMPING_RX_SOFTWARE))
diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index dc704e41203d..0b0fae6b57a9 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -3,6 +3,7 @@
 #define __ASM_GENERIC_SOCKET_H
 
 #include <asm/sockios.h>
+#include <asm/bitsperlong.h>
 
 /* For setsockopt(2) */
 #define SOL_SOCKET	1
@@ -107,10 +108,20 @@
 #define SO_TIMESTAMPNS_OLD       35
 #define SO_TIMESTAMPING_OLD      37
 
+#define SO_TIMESTAMP_NEW         62
+#define SO_TIMESTAMPNS_NEW       63
+
 #if !defined(__KERNEL__)
 
-#define SO_TIMESTAMP           SO_TIMESTAMP_OLD
-#define SO_TIMESTAMPNS         SO_TIMESTAMPNS_OLD
+#if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
+/* on 64-bit and x32, avoid the ?: operator */
+#define SO_TIMESTAMP		SO_TIMESTAMP_OLD
+#define SO_TIMESTAMPNS		SO_TIMESTAMPNS_OLD
+#else
+#define SO_TIMESTAMP (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMP_OLD : SO_TIMESTAMP_NEW)
+#define SO_TIMESTAMPNS (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMPNS_OLD : SO_TIMESTAMPNS_NEW)
+#endif
+
 #define SO_TIMESTAMPING        SO_TIMESTAMPING_OLD
 
 #define SCM_TIMESTAMP          SO_TIMESTAMP
diff --git a/net/core/sock.c b/net/core/sock.c
index e60036618205..7b485dfaa400 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -652,15 +652,23 @@ static void setsockopt_timestamp(struct sock *sk, int type, int val)
 	if (!val) {
 		sock_reset_flag(sk, SOCK_RCVTSTAMP);
 		sock_reset_flag(sk, SOCK_RCVTSTAMPNS);
+		sock_reset_flag(sk, SOCK_TSTAMP_NEW);
 		return;
 	}
 
+	if (type == SO_TIMESTAMP_NEW || type == SO_TIMESTAMPNS_NEW)
+		sock_set_flag(sk, SOCK_TSTAMP_NEW);
+	else
+		sock_reset_flag(sk, SOCK_TSTAMP_NEW);
+
 	switch (type) {
 	case SO_TIMESTAMP_OLD:
+	case SO_TIMESTAMP_NEW:
 		sock_reset_flag(sk, SOCK_RCVTSTAMPNS);
 		sock_set_flag(sk, SOCK_RCVTSTAMP);
 		break;
 	case SO_TIMESTAMPNS_OLD:
+	case SO_TIMESTAMPNS_NEW:
 		sock_reset_flag(sk, SOCK_RCVTSTAMP);
 		sock_set_flag(sk, SOCK_RCVTSTAMPNS);
 		break;
@@ -837,7 +845,9 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case SO_TIMESTAMP_OLD:
+	case SO_TIMESTAMP_NEW:
 	case SO_TIMESTAMPNS_OLD:
+	case SO_TIMESTAMPNS_NEW:
 		setsockopt_timestamp(sk, optname, valbool);
 		break;
 
@@ -1202,6 +1212,14 @@ int sock_getsockopt(struct socket *sock, int level, int optname,
 		v.val = sock_flag(sk, SOCK_RCVTSTAMPNS);
 		break;
 
+	case SO_TIMESTAMP_NEW:
+		v.val = sock_flag(sk, SOCK_RCVTSTAMP) && sock_flag(sk, SOCK_TSTAMP_NEW);
+		break;
+
+	case SO_TIMESTAMPNS_NEW:
+		v.val = sock_flag(sk, SOCK_RCVTSTAMPNS) && sock_flag(sk, SOCK_TSTAMP_NEW);
+		break;
+
 	case SO_TIMESTAMPING_OLD:
 		v.val = sk->sk_tsflags;
 		break;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 805d9965a210..b470f470343a 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1860,30 +1860,57 @@ static void tcp_update_recv_tstamps(struct sk_buff *skb,
 		tss->ts[2] = (struct timespec) {0};
 }
 
-/* Similar to __sock_recv_timestamp, but does not require an skb */
-static void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
-			       struct scm_timestamping *tss)
+static void tcp_recv_sw_timestamp(struct msghdr *msg, const struct sock *sk, struct timespec64 *ts)
 {
-	struct __kernel_old_timeval tv;
-	bool has_timestamping = false;
+	int new_tstamp = sock_flag(sk, SOCK_TSTAMP_NEW);
 
-	if (tss->ts[0].tv_sec || tss->ts[0].tv_nsec) {
+	if (ts->tv_sec || ts->tv_nsec) {
 		if (sock_flag(sk, SOCK_RCVTSTAMPNS)) {
-			put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMPNS_OLD,
-				 sizeof(tss->ts[0]), &tss->ts[0]);
+			if (new_tstamp) {
+				struct __kernel_timespec kts = {ts->tv_sec, ts->tv_nsec};
+
+				put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMPNS_NEW,
+					 sizeof(kts), &kts);
+			} else {
+				struct timespec ts_old = timespec64_to_timespec(*ts);
+
+				put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMPNS_OLD,
+					 sizeof(ts), &ts_old);
+			}
 		} else if (sock_flag(sk, SOCK_RCVTSTAMP)) {
-			tv.tv_sec = tss->ts[0].tv_sec;
-			tv.tv_usec = tss->ts[0].tv_nsec / 1000;
+			if (new_tstamp) {
+				struct sock_timeval stv;
 
-			put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMP_OLD,
-				 sizeof(tv), &tv);
-		}
+				stv.tv_sec = ts->tv_sec;
+				stv.tv_usec = ts->tv_nsec / 1000;
 
-		if (sk->sk_tsflags & SOF_TIMESTAMPING_SOFTWARE)
-			has_timestamping = true;
-		else
-			tss->ts[0] = (struct timespec) {0};
+				put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMP_NEW,
+					 sizeof(stv), &stv);
+			} else {
+				struct __kernel_old_timeval tv;
+
+				tv.tv_sec = ts->tv_sec;
+				tv.tv_usec = ts->tv_nsec / 1000;
+				put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMP_NEW,
+					 sizeof(tv), &tv);
+			}
+		}
 	}
+}
+
+/* Similar to __sock_recv_timestamp, but does not require an skb */
+static void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
+			       struct scm_timestamping *tss)
+{
+	bool has_timestamping = false;
+	struct timespec64 ts = timespec_to_timespec64(tss->ts[0]);
+
+	tcp_recv_sw_timestamp(msg, sk, &ts);
+
+	if (sk->sk_tsflags & SOF_TIMESTAMPING_SOFTWARE)
+		has_timestamping = true;
+	else
+		tss->ts[0] = (struct timespec) {0};
 
 	if (tss->ts[2].tv_sec || tss->ts[2].tv_nsec) {
 		if (sk->sk_tsflags & SOF_TIMESTAMPING_RAW_HARDWARE)
diff --git a/net/rds/af_rds.c b/net/rds/af_rds.c
index eeb4639adbe5..65571a6273c3 100644
--- a/net/rds/af_rds.c
+++ b/net/rds/af_rds.c
@@ -348,7 +348,7 @@ static int rds_set_transport(struct rds_sock *rs, char __user *optval,
 }
 
 static int rds_enable_recvtstamp(struct sock *sk, char __user *optval,
-				 int optlen)
+				 int optlen, int optname)
 {
 	int val, valbool;
 
@@ -360,6 +360,9 @@ static int rds_enable_recvtstamp(struct sock *sk, char __user *optval,
 
 	valbool = val ? 1 : 0;
 
+	if (optname == SO_TIMESTAMP_NEW)
+		sock_set_flag(sk, SOCK_TSTAMP_NEW);
+
 	if (valbool)
 		sock_set_flag(sk, SOCK_RCVTSTAMP);
 	else
@@ -431,8 +434,9 @@ static int rds_setsockopt(struct socket *sock, int level, int optname,
 		release_sock(sock->sk);
 		break;
 	case SO_TIMESTAMP_OLD:
+	case SO_TIMESTAMP_NEW:
 		lock_sock(sock->sk);
-		ret = rds_enable_recvtstamp(sock->sk, optval, optlen);
+		ret = rds_enable_recvtstamp(sock->sk, optval, optlen, optname);
 		release_sock(sock->sk);
 		break;
 	case SO_RDS_MSG_RXPATH_LATENCY:
diff --git a/net/rds/recv.c b/net/rds/recv.c
index 435bf2320cd3..4c3fd56dc4ca 100644
--- a/net/rds/recv.c
+++ b/net/rds/recv.c
@@ -550,8 +550,20 @@ static int rds_cmsg_recv(struct rds_incoming *inc, struct msghdr *msg,
 	if ((inc->i_rx_tstamp != 0) &&
 	    sock_flag(rds_rs_to_sk(rs), SOCK_RCVTSTAMP)) {
 		struct __kernel_old_timeval tv = ns_to_kernel_old_timeval(inc->i_rx_tstamp);
-		ret = put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMP_OLD,
-			       sizeof(tv), &tv);
+
+		if (!sock_flag(rds_rs_to_sk(rs), SOCK_TSTAMP_NEW)) {
+			ret = put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMP_OLD,
+				       sizeof(tv), &tv);
+		} else {
+			struct sock_timeval sk_tv;
+
+			sk_tv.tv_sec = tv.tv_sec;
+			sk_tv.tv_usec = tv.tv_usec;
+
+			ret = put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMP_NEW,
+				       sizeof(sk_tv), &sk_tv);
+		}
+
 		if (ret)
 			goto out;
 	}
diff --git a/net/socket.c b/net/socket.c
index d3defba55547..9abeb6bc9cfe 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -699,6 +699,38 @@ static void put_ts_pktinfo(struct msghdr *msg, struct sk_buff *skb)
 		 sizeof(ts_pktinfo), &ts_pktinfo);
 }
 
+static void sock_recv_sw_timestamp(struct msghdr *msg, struct sock *sk,
+				   struct sk_buff *skb)
+{
+	if (sock_flag(sk, SOCK_TSTAMP_NEW)) {
+		if (!sock_flag(sk, SOCK_RCVTSTAMPNS)) {
+			struct sock_timeval tv;
+
+			skb_get_new_timestamp(skb, &tv);
+			put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMP_NEW,
+				 sizeof(tv), &tv);
+		} else {
+			struct __kernel_timespec ts;
+
+			skb_get_new_timestampns(skb, &ts);
+			put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMPNS_NEW,
+				 sizeof(ts), &ts);
+		}
+	}
+	if (!sock_flag(sk, SOCK_RCVTSTAMPNS)) {
+		struct __kernel_old_timeval tv;
+
+		skb_get_timestamp(skb, &tv);
+		put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMP_OLD,
+			 sizeof(tv), &tv);
+	} else {
+		struct timespec ts;
+
+		skb_get_timestampns(skb, &ts);
+		put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMPNS_OLD,
+			 sizeof(ts), &ts);
+	}
+}
 /*
  * called from sock_recv_timestamp() if sock_flag(sk, SOCK_RCVTSTAMP)
  * or sock_flag(sk, SOCK_RCVTSTAMPNS)
@@ -719,19 +751,8 @@ void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
 		false_tstamp = 1;
 	}
 
-	if (need_software_tstamp) {
-		if (!sock_flag(sk, SOCK_RCVTSTAMPNS)) {
-			struct __kernel_old_timeval tv;
-			skb_get_timestamp(skb, &tv);
-			put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMP_OLD,
-				 sizeof(tv), &tv);
-		} else {
-			struct timespec ts;
-			skb_get_timestampns(skb, &ts);
-			put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMPNS_OLD,
-				 sizeof(ts), &ts);
-		}
-	}
+	if (need_software_tstamp)
+		sock_recv_sw_timestamp(msg, sk, skb);
 
 	memset(&tss, 0, sizeof(tss));
 	if ((sk->sk_tsflags & SOF_TIMESTAMPING_SOFTWARE) &&
-- 
2.17.1
