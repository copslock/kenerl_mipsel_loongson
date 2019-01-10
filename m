Return-Path: <SRS0=2fGM=PS=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E06C43612
	for <linux-mips@archiver.kernel.org>; Thu, 10 Jan 2019 17:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CC9F20879
	for <linux-mips@archiver.kernel.org>; Thu, 10 Jan 2019 17:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729758AbfAJRXd (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:23:33 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:41757 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729671AbfAJRXc (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 10 Jan 2019 12:23:32 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mzhax-1hTojh0PtR-00veYw; Thu, 10 Jan 2019 18:22:24 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, mattst88@gmail.com,
        linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, tony.luck@intel.com, fenghua.yu@intel.com,
        geert@linux-m68k.org, monstr@monstr.eu, paul.burton@mips.com,
        deller@gmx.de, benh@kernel.crashing.org, mpe@ellerman.id.au,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, dalias@libc.org,
        davem@davemloft.net, luto@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        jcmvbkbc@gmail.com, akpm@linux-foundation.org,
        deepa.kernel@gmail.com, ebiederm@xmission.com,
        firoz.khan@linaro.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, netdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 02/11] time: Add struct __kernel_timex
Date:   Thu, 10 Jan 2019 18:22:07 +0100
Message-Id: <20190110172216.313063-3-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190110172216.313063-1-arnd@arndb.de>
References: <20190110172216.313063-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bbac36R+LhLZ8+Oo9xPSyADBJ/5d5ogzU0cFHDJf8/4GxYsw3Wg
 sIiWb4Ab2BE1p/973p3l1oNrVyQRYpf/5LO2l8Au8n1Zim29u9sj0NT8nEMvl2pI3HJBo8J
 /r+du4G7mSKK8Ln0J8bA7+RTkjO5HPsOyqvEvvFnS2vZwg5USJendgIxpfX5jGSxpP3dJd4
 Rkn0UKeAupw2nM5fGsddw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RuICwid1NJg=:wqiEQ8d5BExfHMlaj5msbB
 BtgfdXYe5ZBZnmu/1NFkQfvgPM/zjEoPd1dg6JhnXviB38uZshNxJfLUlplLaqag57wr1RN/U
 J0CLo5Gsy5wme4nx20oB9y+h5I21TKg9fmdfJYTRCMQrFIUDyOr9UH4ZMdlg9N9W3nIhIYvEe
 6QZWIILf9pEQ+pnHKZw+98tQ7RdibZzulxWi64QYE0m4ADqBZsRbPTCd2bwzdPOoLjYJETUYz
 3SvPcI/7gjUZsikMT4ATJ09sZc4OWOUBcTNe4W5GyB0vaAAJSKLAVDB7FoLDbl8mm2lEmwH9G
 KHgPyElAkFvCCOdwv1VhwroG9vvkMMCclLKAl0D21e4BhOehmtDJyRHHifjpidJgyvKjJs8lp
 rc6AVemgT2ooKsAlXqFO8K48KmlxG55+V1QVjrbMSd0SR7CiVAW09z/Er6/rpEU9lv0/L//XP
 j1S6qbqWMmZtssCn+vVDusJYHWUfJ18lTZph+Z3APFTeJ8uoQccIcllCaa0K1aKYDWHoZ0L6G
 8BFVr1Do0WK42PGwQmaP5j4DZLX/CC1jDHX0ej9ho9r+yeLsYyugCYe2edqC0MO5sOrSdHvfz
 4q9ItE5ijNINmAwb1E1pINKALcv6CsUzgJi96+Pk8Lux2yxkA1Fsoak+3WtDe6SOnmdOtocd2
 q9O5CiDE78pK7LiG9JhMfNIB0mKjayGb6O0cA6pkGWheJAQoyOdp+6unsxzTIv6sYlQtkaHSx
 t0VAud/LURaO8e8TxVgWWknitX0EuB7BnIEa3w==
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

From: Deepa Dinamani <deepa.kernel@gmail.com>

struct timex uses struct timeval internally.
struct timeval is not y2038 safe.
Introduce a new UAPI type struct __kernel_timex
that is y2038 safe.

struct __kernel_timex uses a timeval type that is
similar to struct __kernel_timespec which preserves the
same structure size across 32 bit and 64 bit ABIs.
struct __kernel_timex also restructures other members of the
structure to make the structure the same on 64 bit and 32 bit
architectures.
Note that struct __kernel_timex is the same as struct timex
on a 64 bit architecture.

The above solution is similar to other new y2038 syscalls
that are being introduced: both 32 bit and 64 bit ABIs
have a common entry, and the compat entry supports the old 32 bit
syscall interface.

Alternatives considered were:
1. Add new time type to struct timex that makes use of padded
   bits. This time type could be based on the struct __kernel_timespec.
   modes will use a flag to notify which time structure should be
   used internally.
   This needs some application level changes on both 64 bit and 32 bit
   architectures. Although 64 bit machines could continue to use the
   older timeval structure without any changes.

2. Add a new u8 type to struct timex that makes use of padded bits. This
   can be used to save higher order tv_sec bits. modes will use a flag to
   notify presence of such a type.
   This will need some application level changes on 32 bit architectures.

3. Add a new compat_timex structure that differs in only the size of the
   time type; keep rest of struct timex the same.
   This requires extra syscalls to manage all 3 cases on 64 bit
   architectures. This will not need any application level changes but will
   add more complexity from kernel side.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 include/linux/timex.h      |  7 +++++++
 include/uapi/linux/timex.h | 41 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/include/linux/timex.h b/include/linux/timex.h
index 39c25dbebfe8..7f40e9e42ecc 100644
--- a/include/linux/timex.h
+++ b/include/linux/timex.h
@@ -53,6 +53,13 @@
 #ifndef _LINUX_TIMEX_H
 #define _LINUX_TIMEX_H
 
+/* CONFIG_64BIT_TIME enables new 64 bit time_t syscalls in the compat path
+ * and 32-bit emulation.
+ */
+#ifndef CONFIG_64BIT_TIME
+#define __kernel_timex timex
+#endif
+
 #include <uapi/linux/timex.h>
 
 #define ADJ_ADJTIME		0x8000	/* switch between adjtime/adjtimex modes */
diff --git a/include/uapi/linux/timex.h b/include/uapi/linux/timex.h
index 92685d826444..a1c6b73016a5 100644
--- a/include/uapi/linux/timex.h
+++ b/include/uapi/linux/timex.h
@@ -92,6 +92,47 @@ struct timex {
 	int  :32; int  :32; int  :32;
 };
 
+struct __kernel_timex_timeval {
+	__kernel_time64_t       tv_sec;
+	long long		tv_usec;
+};
+
+#ifndef __kernel_timex
+struct __kernel_timex {
+	unsigned int modes;	/* mode selector */
+	int :32;            /* pad */
+	long long offset;	/* time offset (usec) */
+	long long freq;	/* frequency offset (scaled ppm) */
+	long long maxerror;/* maximum error (usec) */
+	long long esterror;/* estimated error (usec) */
+	int status;		/* clock command/status */
+	int :32;            /* pad */
+	long long constant;/* pll time constant */
+	long long precision;/* clock precision (usec) (read only) */
+	long long tolerance;/* clock frequency tolerance (ppm)
+				   * (read only)
+				   */
+	struct __kernel_timex_timeval time;	/* (read only, except for ADJ_SETOFFSET) */
+	long long tick;	/* (modified) usecs between clock ticks */
+
+	long long ppsfreq;/* pps frequency (scaled ppm) (ro) */
+	long long jitter; /* pps jitter (us) (ro) */
+	int shift;              /* interval duration (s) (shift) (ro) */
+	int :32;            /* pad */
+	long long stabil;            /* pps stability (scaled ppm) (ro) */
+	long long jitcnt; /* jitter limit exceeded (ro) */
+	long long calcnt; /* calibration intervals (ro) */
+	long long errcnt; /* calibration errors (ro) */
+	long long stbcnt; /* stability limit exceeded (ro) */
+
+	int tai;		/* TAI offset (ro) */
+
+	int  :32; int  :32; int  :32; int  :32;
+	int  :32; int  :32; int  :32; int  :32;
+	int  :32; int  :32; int  :32;
+};
+#endif
+
 /*
  * Mode codes (timex.mode)
  */
-- 
2.20.0

