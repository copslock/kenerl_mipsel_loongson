Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Dec 2006 00:10:09 +0000 (GMT)
Received: from tomts16.bellnexxia.net ([209.226.175.4]:41427 "EHLO
	tomts16-srv.bellnexxia.net") by ftp.linux-mips.org with ESMTP
	id S28585910AbWLUAKE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 21 Dec 2006 00:10:04 +0000
Received: from krystal.dyndns.org ([67.68.205.181])
          by tomts16-srv.bellnexxia.net
          (InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP
          id <20061221001002.NULD12977.tomts16-srv.bellnexxia.net@krystal.dyndns.org>
          for <linux-mips@linux-mips.org>; Wed, 20 Dec 2006 19:10:02 -0500
Received: from localhost (localhost [127.0.0.1])
  (uid 1000)
  by krystal.dyndns.org with local; Wed, 20 Dec 2006 19:10:00 -0500
  id 0014F5A1.4589D0D8.00000EE0
Date:	Wed, 20 Dec 2006 19:10:00 -0500
From:	Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To:	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	Ingo Molnar <mingo@redhat.com>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Christoph Hellwig <hch@infradead.org>,
	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	ltt-dev@shafik.org, systemtap@sources.redhat.com,
	Douglas Niehaus <niehaus@eecs.ku.edu>,
	"Martin J. Bligh" <mbligh@mbligh.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 5/9] atomic.h : standardising atomic primitives
Message-ID: <20061221001000.GK28643@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20061221000351.GF28643@Krystal>
X-Editor: vi
X-Info:	http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 19:09:03 up 119 days, 21:16,  6 users,  load average: 2.22, 1.79, 1.32
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <compudj@krystal.dyndns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13496
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mathieu.desnoyers@polymtl.ca
Precedence: bulk
X-list: linux-mips

64 bits cmpxchg, xchg and add_unless for MIPS.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

--- a/include/asm-mips/atomic.h
+++ b/include/asm-mips/atomic.h
@@ -291,8 +291,9 @@ static __inline__ int atomic_sub_if_posi
 	return result;
 }
 
-#define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
-#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
+#define atomic_cmpxchg(v, o, n) \
+	(((__typeof__((v)->counter)))cmpxchg(&((v)->counter), (o), (n)))
+#define atomic_xchg(v, new) (xchg(&((v)->counter), (new)))
 
 /**
  * atomic_add_unless - add unless the number is a given value
@@ -305,7 +306,7 @@ #define atomic_xchg(v, new) (xchg(&((v)-
  */
 #define atomic_add_unless(v, a, u)				\
 ({								\
-	int c, old;						\
+	__typeof__((v)->counter) c, old;			\
 	c = atomic_read(v);					\
 	while (c != (u) && (old = atomic_cmpxchg((v), c, c + (a))) != c) \
 		c = old;					\
@@ -651,6 +652,29 @@ static __inline__ long atomic64_sub_if_p
 	return result;
 }
 
+#define atomic64_cmpxchg(v, o, n) \
+	(((__typeof__((v)->counter)))cmpxchg(&((v)->counter), (o), (n)))
+#define atomic64_xchg(v, new) (xchg(&((v)->counter), (new)))
+
+/**
+ * atomic64_add_unless - add unless the number is a given value
+ * @v: pointer of type atomic64_t
+ * @a: the amount to add to v...
+ * @u: ...unless v is equal to u.
+ *
+ * Atomically adds @a to @v, so long as it was not @u.
+ * Returns non-zero if @v was not @u, and zero otherwise.
+ */
+#define atomic64_add_unless(v, a, u)				\
+({								\
+	__typeof__((v)->counter) c, old;			\
+	c = atomic_read(v);					\
+	while (c != (u) && (old = atomic64_cmpxchg((v), c, c + (a))) != c) \
+		c = old;					\
+	c != (u);						\
+})
+#define atomic64_inc_not_zero(v) atomic64_add_unless((v), 1, 0)
+
 #define atomic64_dec_return(v) atomic64_sub_return(1,(v))
 #define atomic64_inc_return(v) atomic64_add_return(1,(v))
 

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
