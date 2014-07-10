Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Jul 2014 20:43:43 +0200 (CEST)
Received: from smtp.outflux.net ([198.145.64.163]:36495 "EHLO smtp.outflux.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6860089AbaGJSlBGTVaE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 10 Jul 2014 20:41:01 +0200
Received: from www.outflux.net (serenity.outflux.net [10.2.0.2])
        by vinyl.outflux.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id s6AIeanE013573;
        Thu, 10 Jul 2014 11:40:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Alexei Starovoitov <ast@plumgrid.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <dborkman@redhat.com>,
        Will Drewry <wad@chromium.org>,
        Julien Tinnes <jln@chromium.org>,
        David Drysdale <drysdale@google.com>,
        linux-api@vger.kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v10 03/11] seccomp: split mode setting routines
Date:   Thu, 10 Jul 2014 11:40:23 -0700
Message-Id: <1405017631-27346-4-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1405017631-27346-1-git-send-email-keescook@chromium.org>
References: <1405017631-27346-1-git-send-email-keescook@chromium.org>
X-MIMEDefang-Filter: outflux$Revision: 1.316 $
X-HELO: www.outflux.net
X-Scanned-By: MIMEDefang 2.73
Return-Path: <keescook@www.outflux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41129
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keescook@chromium.org
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

Separates the two mode setting paths to make things more readable with
fewer #ifdefs within function bodies.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/seccomp.c |   71 ++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 48 insertions(+), 23 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 03a5959b7930..812cea2e7ffb 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -489,48 +489,66 @@ long prctl_get_seccomp(void)
 }
 
 /**
- * seccomp_set_mode: internal function for setting seccomp mode
- * @seccomp_mode: requested mode to use
- * @filter: optional struct sock_fprog for use with SECCOMP_MODE_FILTER
- *
- * This function may be called repeatedly with a @seccomp_mode of
- * SECCOMP_MODE_FILTER to install additional filters.  Every filter
- * successfully installed will be evaluated (in reverse order) for each system
- * call the task makes.
+ * seccomp_set_mode_strict: internal function for setting strict seccomp
  *
  * Once current->seccomp.mode is non-zero, it may not be changed.
  *
  * Returns 0 on success or -EINVAL on failure.
  */
-static long seccomp_set_mode(unsigned long seccomp_mode, char __user *filter)
+static long seccomp_set_mode_strict(void)
 {
+	const unsigned long seccomp_mode = SECCOMP_MODE_STRICT;
 	long ret = -EINVAL;
 
 	if (!seccomp_check_mode(seccomp_mode))
 		goto out;
 
-	switch (seccomp_mode) {
-	case SECCOMP_MODE_STRICT:
-		ret = 0;
 #ifdef TIF_NOTSC
-		disable_TSC();
+	disable_TSC();
 #endif
-		break;
+	seccomp_assign_mode(seccomp_mode);
+	ret = 0;
+
+out:
+
+	return ret;
+}
+
 #ifdef CONFIG_SECCOMP_FILTER
-	case SECCOMP_MODE_FILTER:
-		ret = seccomp_attach_user_filter(filter);
-		if (ret)
-			goto out;
-		break;
-#endif
-	default:
+/**
+ * seccomp_set_mode_filter: internal function for setting seccomp filter
+ * @filter: struct sock_fprog containing filter
+ *
+ * This function may be called repeatedly to install additional filters.
+ * Every filter successfully installed will be evaluated (in reverse order)
+ * for each system call the task makes.
+ *
+ * Once current->seccomp.mode is non-zero, it may not be changed.
+ *
+ * Returns 0 on success or -EINVAL on failure.
+ */
+static long seccomp_set_mode_filter(char __user *filter)
+{
+	const unsigned long seccomp_mode = SECCOMP_MODE_FILTER;
+	long ret = -EINVAL;
+
+	if (!seccomp_check_mode(seccomp_mode))
+		goto out;
+
+	ret = seccomp_attach_user_filter(filter);
+	if (ret)
 		goto out;
-	}
 
 	seccomp_assign_mode(seccomp_mode);
 out:
 	return ret;
 }
+#else
+static inline long seccomp_set_mode_filter(char __user *filter)
+{
+	return -EINVAL;
+}
+#endif
 
 /**
  * prctl_set_seccomp: configures current->seccomp.mode
@@ -541,5 +559,12 @@ out:
  */
 long prctl_set_seccomp(unsigned long seccomp_mode, char __user *filter)
 {
-	return seccomp_set_mode(seccomp_mode, filter);
+	switch (seccomp_mode) {
+	case SECCOMP_MODE_STRICT:
+		return seccomp_set_mode_strict();
+	case SECCOMP_MODE_FILTER:
+		return seccomp_set_mode_filter(filter);
+	default:
+		return -EINVAL;
+	}
 }
-- 
1.7.9.5
