Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Aug 2015 17:11:33 +0200 (CEST)
Received: from mail-wi0-f181.google.com ([209.85.212.181]:34467 "EHLO
        mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010980AbbHBPLbuLc8c (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Aug 2015 17:11:31 +0200
Received: by wibud3 with SMTP id ud3so107847825wib.1
        for <linux-mips@linux-mips.org>; Sun, 02 Aug 2015 08:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=+r8sF4w0xlGkUyEX1ndkLhesiPD/4JgnVoMHVcaaRa4=;
        b=TsA8AQN1KzYQP583bLEjhckoBCRV2bn+StO5pn4tmxvFImRO6/NTUkpYpM9RXIgfcZ
         No4JquenPu+CoNV5G1UzNIMktxeTSX5fgeKP6DsoGF9Hw91XH3yNdopYPcO22L6syPVG
         72XMAnZXpZi9kutxAGxgRq7CBwcCNcHy09qoVuNaHccl0ef8wyFKfdFpX3XunAKNHsaq
         wTGjG1P0xo5v7hHi5uT0ieUa9+P6w0Fy9ukaSZ0cJNEWooAhvlB2sRxrvtW4H47PwypT
         Ld1AtJ387MIsdGfR1UdWDjYSqR6NCtAvJmYJjO830zAEv1x+kSDmm9wy4dWoS8lI4h0i
         ToNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+r8sF4w0xlGkUyEX1ndkLhesiPD/4JgnVoMHVcaaRa4=;
        b=cTmb1Pri9JNIHWmiTozRkuBtXtOjahDhCoTirdPxY3bfu2rX0m96wxGfM4NoZXsOQ2
         bApOQcZ5mMO1EEQsToOMj4Mk5pZ3p8zQSm4I9qaK0wxU6fDsr0zQGHgHz/pAM5H7WQEg
         WWHFOMabqKagUY4jfeIYyjZLtXK12V0hzdpXQs2g0KQfW0zDkmaq8Uma1YfQd5fZlt/7
         N3k0lf6/MuiRmTUWgcy3C/MXa3syWP2mZAyLHQkULPIDzB3YJqEDFB0j2ZsC3q92kGfG
         7aWUqggPEcVWc62eAfLeahFZqWlGa3SKXeTGdeOaZtNQ2tJM0GF+Pukavy0HO/hFqUqE
         LaOw==
X-Gm-Message-State: ALoCoQmha+laAICyJOiygwK/pI554tCH+PpBPStQedhGnmzzAQyU9WImpXgOmOfGSKdYrgZGJ7A/
X-Received: by 10.194.95.71 with SMTP id di7mr26302745wjb.125.1438528286432;
        Sun, 02 Aug 2015 08:11:26 -0700 (PDT)
Received: from andreyknvl.muc.corp.google.com ([172.18.0.61])
        by smtp.gmail.com with ESMTPSA id n6sm8637283wix.1.2015.08.02.08.11.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Aug 2015 08:11:25 -0700 (PDT)
Received: by andreyknvl.muc.corp.google.com (Postfix, from userid 206546)
        id 076ED200BC3; Sun,  2 Aug 2015 17:11:24 +0200 (CEST)
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Russell King <linux@arm.linux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Duyck <alexander.h.duyck@redhat.com>,
        Andre Przywara <andre.przywara@arm.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Borislav Petkov <bp@suse.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-metag@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH v2] arch: use WRITE_ONCE/READ_ONCE in smp_store_release/smp_load_acquire
Date:   Sun,  2 Aug 2015 17:11:04 +0200
Message-Id: <1438528264-714-1-git-send-email-andreyknvl@google.com>
X-Mailer: git-send-email 2.5.0.rc2.392.g76e840b
Return-Path: <andreyknvl@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48532
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andreyknvl@google.com
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

Replace ACCESS_ONCE() macro in smp_store_release() and smp_load_acquire()
with WRITE_ONCE() and READ_ONCE() on x86, arm, arm64, ia64, metag, mips,
powerpc, s390, sparc and asm-generic since ACCESS_ONCE does not work
reliably on non-scalar types.

WRITE_ONCE() and READ_ONCE() were introduced in the commits 230fa253df63
("kernel: Provide READ_ONCE and ASSIGN_ONCE") and 43239cbe79fc ("kernel:
Change ASSIGN_ONCE(val, x) to WRITE_ONCE(x, val)").

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
Changed in v2:
  - Other archs besides x86.

 arch/arm/include/asm/barrier.h      | 4 ++--
 arch/arm64/include/asm/barrier.h    | 4 ++--
 arch/ia64/include/asm/barrier.h     | 4 ++--
 arch/metag/include/asm/barrier.h    | 4 ++--
 arch/mips/include/asm/barrier.h     | 4 ++--
 arch/powerpc/include/asm/barrier.h  | 4 ++--
 arch/s390/include/asm/barrier.h     | 4 ++--
 arch/sparc/include/asm/barrier_64.h | 4 ++--
 arch/x86/include/asm/barrier.h      | 8 ++++----
 include/asm-generic/barrier.h       | 4 ++--
 10 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm/include/asm/barrier.h b/arch/arm/include/asm/barrier.h
index 6c2327e..7039357 100644
--- a/arch/arm/include/asm/barrier.h
+++ b/arch/arm/include/asm/barrier.h
@@ -67,12 +67,12 @@
 do {									\
 	compiletime_assert_atomic_type(*p);				\
 	smp_mb();							\
-	ACCESS_ONCE(*p) = (v);						\
+	WRITE_ONCE(*p, v);						\
 } while (0)
 
 #define smp_load_acquire(p)						\
 ({									\
-	typeof(*p) ___p1 = ACCESS_ONCE(*p);				\
+	typeof(*p) ___p1 = READ_ONCE(*p);				\
 	compiletime_assert_atomic_type(*p);				\
 	smp_mb();							\
 	___p1;								\
diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 0fa47c4..ef93b20 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -44,12 +44,12 @@
 do {									\
 	compiletime_assert_atomic_type(*p);				\
 	barrier();							\
-	ACCESS_ONCE(*p) = (v);						\
+	WRITE_ONCE(*p, v);						\
 } while (0)
 
 #define smp_load_acquire(p)						\
 ({									\
-	typeof(*p) ___p1 = ACCESS_ONCE(*p);				\
+	typeof(*p) ___p1 = READ_ONCE(*p);				\
 	compiletime_assert_atomic_type(*p);				\
 	barrier();							\
 	___p1;								\
diff --git a/arch/ia64/include/asm/barrier.h b/arch/ia64/include/asm/barrier.h
index 843ba43..df896a1 100644
--- a/arch/ia64/include/asm/barrier.h
+++ b/arch/ia64/include/asm/barrier.h
@@ -66,12 +66,12 @@
 do {									\
 	compiletime_assert_atomic_type(*p);				\
 	barrier();							\
-	ACCESS_ONCE(*p) = (v);						\
+	WRITE_ONCE(*p, v);						\
 } while (0)
 
 #define smp_load_acquire(p)						\
 ({									\
-	typeof(*p) ___p1 = ACCESS_ONCE(*p);				\
+	typeof(*p) ___p1 = READ_ONCE(*p);				\
 	compiletime_assert_atomic_type(*p);				\
 	barrier();							\
 	___p1;								\
diff --git a/arch/metag/include/asm/barrier.h b/arch/metag/include/asm/barrier.h
index 5a696e5..172b7e5 100644
--- a/arch/metag/include/asm/barrier.h
+++ b/arch/metag/include/asm/barrier.h
@@ -90,12 +90,12 @@ static inline void fence(void)
 do {									\
 	compiletime_assert_atomic_type(*p);				\
 	smp_mb();							\
-	ACCESS_ONCE(*p) = (v);						\
+	WRITE_ONCE(*p, v);						\
 } while (0)
 
 #define smp_load_acquire(p)						\
 ({									\
-	typeof(*p) ___p1 = ACCESS_ONCE(*p);				\
+	typeof(*p) ___p1 = READ_ONCE(*p);				\
 	compiletime_assert_atomic_type(*p);				\
 	smp_mb();							\
 	___p1;								\
diff --git a/arch/mips/include/asm/barrier.h b/arch/mips/include/asm/barrier.h
index 7ecba84..752e0b8 100644
--- a/arch/mips/include/asm/barrier.h
+++ b/arch/mips/include/asm/barrier.h
@@ -133,12 +133,12 @@
 do {									\
 	compiletime_assert_atomic_type(*p);				\
 	smp_mb();							\
-	ACCESS_ONCE(*p) = (v);						\
+	WRITE_ONCE(*p, v);						\
 } while (0)
 
 #define smp_load_acquire(p)						\
 ({									\
-	typeof(*p) ___p1 = ACCESS_ONCE(*p);				\
+	typeof(*p) ___p1 = READ_ONCE(*p);				\
 	compiletime_assert_atomic_type(*p);				\
 	smp_mb();							\
 	___p1;								\
diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
index 51ccc72..0eca6ef 100644
--- a/arch/powerpc/include/asm/barrier.h
+++ b/arch/powerpc/include/asm/barrier.h
@@ -76,12 +76,12 @@
 do {									\
 	compiletime_assert_atomic_type(*p);				\
 	smp_lwsync();							\
-	ACCESS_ONCE(*p) = (v);						\
+	WRITE_ONCE(*p, v);						\
 } while (0)
 
 #define smp_load_acquire(p)						\
 ({									\
-	typeof(*p) ___p1 = ACCESS_ONCE(*p);				\
+	typeof(*p) ___p1 = READ_ONCE(*p);				\
 	compiletime_assert_atomic_type(*p);				\
 	smp_lwsync();							\
 	___p1;								\
diff --git a/arch/s390/include/asm/barrier.h b/arch/s390/include/asm/barrier.h
index e6f8615..d48fe01 100644
--- a/arch/s390/include/asm/barrier.h
+++ b/arch/s390/include/asm/barrier.h
@@ -42,12 +42,12 @@
 do {									\
 	compiletime_assert_atomic_type(*p);				\
 	barrier();							\
-	ACCESS_ONCE(*p) = (v);						\
+	WRITE_ONCE(*p, v);						\
 } while (0)
 
 #define smp_load_acquire(p)						\
 ({									\
-	typeof(*p) ___p1 = ACCESS_ONCE(*p);				\
+	typeof(*p) ___p1 = READ_ONCE(*p);				\
 	compiletime_assert_atomic_type(*p);				\
 	barrier();							\
 	___p1;								\
diff --git a/arch/sparc/include/asm/barrier_64.h b/arch/sparc/include/asm/barrier_64.h
index 809941e..14a9286 100644
--- a/arch/sparc/include/asm/barrier_64.h
+++ b/arch/sparc/include/asm/barrier_64.h
@@ -60,12 +60,12 @@ do {	__asm__ __volatile__("ba,pt	%%xcc, 1f\n\t" \
 do {									\
 	compiletime_assert_atomic_type(*p);				\
 	barrier();							\
-	ACCESS_ONCE(*p) = (v);						\
+	WRITE_ONCE(*p, v);						\
 } while (0)
 
 #define smp_load_acquire(p)						\
 ({									\
-	typeof(*p) ___p1 = ACCESS_ONCE(*p);				\
+	typeof(*p) ___p1 = READ_ONCE(*p);				\
 	compiletime_assert_atomic_type(*p);				\
 	barrier();							\
 	___p1;								\
diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index e51a8f8..d2bcfbe 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -57,12 +57,12 @@
 do {									\
 	compiletime_assert_atomic_type(*p);				\
 	smp_mb();							\
-	ACCESS_ONCE(*p) = (v);						\
+	WRITE_ONCE(*p, v);						\
 } while (0)
 
 #define smp_load_acquire(p)						\
 ({									\
-	typeof(*p) ___p1 = ACCESS_ONCE(*p);				\
+	typeof(*p) ___p1 = READ_ONCE(*p);				\
 	compiletime_assert_atomic_type(*p);				\
 	smp_mb();							\
 	___p1;								\
@@ -74,12 +74,12 @@ do {									\
 do {									\
 	compiletime_assert_atomic_type(*p);				\
 	barrier();							\
-	ACCESS_ONCE(*p) = (v);						\
+	WRITE_ONCE(*p, v);						\
 } while (0)
 
 #define smp_load_acquire(p)						\
 ({									\
-	typeof(*p) ___p1 = ACCESS_ONCE(*p);				\
+	typeof(*p) ___p1 = READ_ONCE(*p);				\
 	compiletime_assert_atomic_type(*p);				\
 	barrier();							\
 	___p1;								\
diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index 55e3abc..b42afad 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -108,12 +108,12 @@
 do {									\
 	compiletime_assert_atomic_type(*p);				\
 	smp_mb();							\
-	ACCESS_ONCE(*p) = (v);						\
+	WRITE_ONCE(*p, v);						\
 } while (0)
 
 #define smp_load_acquire(p)						\
 ({									\
-	typeof(*p) ___p1 = ACCESS_ONCE(*p);				\
+	typeof(*p) ___p1 = READ_ONCE(*p);				\
 	compiletime_assert_atomic_type(*p);				\
 	smp_mb();							\
 	___p1;								\
-- 
2.5.0.rc2.392.g76e840b
