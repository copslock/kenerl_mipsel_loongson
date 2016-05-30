Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 May 2016 23:12:02 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:42411 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27040282AbcE3VLfmZ0vl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 May 2016 23:11:35 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 95FBE93D;
        Mon, 30 May 2016 21:11:29 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ralf Baechle <ralf@linux-mips.org>, Petr Malat <oss@malat.biz>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Christopher Ferris <cferris@google.com>,
        linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
        linux-ia64@vger.kernel.org
Subject: [PATCH 4.6 092/100] SIGNAL: Move generic copy_siginfo() to signal.h
Date:   Mon, 30 May 2016 13:50:27 -0700
Message-Id: <20160530204911.401732344@linuxfoundation.org>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20160530204908.422037419@linuxfoundation.org>
References: <20160530204908.422037419@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53711
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

commit ca9eb49aa9562eaadf3cea071ec7018ad6800425 upstream.

The generic copy_siginfo() is currently defined in
asm-generic/siginfo.h, after including uapi/asm-generic/siginfo.h which
defines the generic struct siginfo. However this makes it awkward for an
architecture to use it if it has to define its own struct siginfo (e.g.
MIPS and potentially IA64), since it means that asm-generic/siginfo.h
can only be included after defining the arch-specific siginfo, which may
be problematic if the arch-specific definition needs definitions from
uapi/asm-generic/siginfo.h.

It is possible to work around this by first including
uapi/asm-generic/siginfo.h to get the constants before defining the
arch-specific siginfo, and include asm-generic/siginfo.h after. However
uapi headers can't be included by other uapi headers, so that first
include has to be in an ifdef __kernel__, with the non __kernel__ case
including the non-UAPI header instead.

Instead of that mess, move the generic copy_siginfo() definition into
linux/signal.h, which allows an arch-specific uapi/asm/siginfo.h to
include asm-generic/siginfo.h and define the arch-specific siginfo, and
for the generic copy_siginfo() to see that arch-specific definition.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Petr Malat <oss@malat.biz>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Christopher Ferris <cferris@google.com>
Cc: linux-arch@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: linux-ia64@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/12478/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/asm-generic/siginfo.h |   15 ---------------
 include/linux/signal.h        |   15 +++++++++++++++
 2 files changed, 15 insertions(+), 15 deletions(-)

--- a/include/asm-generic/siginfo.h
+++ b/include/asm-generic/siginfo.h
@@ -17,21 +17,6 @@
 struct siginfo;
 void do_schedule_next_timer(struct siginfo *info);
 
-#ifndef HAVE_ARCH_COPY_SIGINFO
-
-#include <linux/string.h>
-
-static inline void copy_siginfo(struct siginfo *to, struct siginfo *from)
-{
-	if (from->si_code < 0)
-		memcpy(to, from, sizeof(*to));
-	else
-		/* _sigchld is currently the largest know union member */
-		memcpy(to, from, __ARCH_SI_PREAMBLE_SIZE + sizeof(from->_sifields._sigchld));
-}
-
-#endif
-
 extern int copy_siginfo_to_user(struct siginfo __user *to, const struct siginfo *from);
 
 #endif
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -28,6 +28,21 @@ struct sigpending {
 	sigset_t signal;
 };
 
+#ifndef HAVE_ARCH_COPY_SIGINFO
+
+#include <linux/string.h>
+
+static inline void copy_siginfo(struct siginfo *to, struct siginfo *from)
+{
+	if (from->si_code < 0)
+		memcpy(to, from, sizeof(*to));
+	else
+		/* _sigchld is currently the largest know union member */
+		memcpy(to, from, __ARCH_SI_PREAMBLE_SIZE + sizeof(from->_sifields._sigchld));
+}
+
+#endif
+
 /*
  * Define some primitives to manipulate sigset_t.
  */
