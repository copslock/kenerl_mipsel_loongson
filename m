Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Oct 2012 19:46:16 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:59693 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6869784Ab2JERqIbDeDv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Oct 2012 19:46:08 +0200
Received: by mail-pb0-f49.google.com with SMTP id xa7so2254166pbc.36
        for <multiple recipients>; Fri, 05 Oct 2012 10:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=FUnrQZigyPqaFj9J0NpgI7l7vxzlAvDybR/nvqyb1AU=;
        b=uCvNIhoblS8SWhbFzZRMC6fr1PnYgid0lq+At35yl1QQmus73jMLQ7o3+WC6xEcjnS
         7rywyuwqfq0hHWuFFIW36BZGNsjo5x8/DxqLL5oyn+orZ/pk1nfP6EfuJr/L9hnCwf/A
         M9IbG+uSGpQAOljhH7mE5fyfElPudhbRFymXTGxm1MUNM03YcJUs8aCMSSfakh/Qp7lN
         43YMG0iPnDVXrWfPr9BoPAjC+b8uJvPj6zjttrnYv2032X16CqLozyRE5yTBN9JaZhb6
         3O/2dM0MJ+qOzi2/bve+54z9UOXUjSHpYI1bTEzGPWdr+UmsLLE+Wc8ut3/N2WmJDFhV
         hHLA==
Received: by 10.66.77.74 with SMTP id q10mr8042686paw.81.1349459161590;
        Fri, 05 Oct 2012 10:46:01 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id pj10sm6366783pbb.46.2012.10.05.10.45.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 05 Oct 2012 10:46:00 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id q95Hjccg004401;
        Fri, 5 Oct 2012 10:45:38 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id q95HjYjo004399;
        Fri, 5 Oct 2012 10:45:34 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>,
        David Howells <dhowells@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Dave Jones <davej@redhat.com>
Subject: [PATCH] Partially revert a1ce39288e6fbef (UAPI: (Scripted) Convert #include "..." to #include <path/...> in kernel system headers)
Date:   Fri,  5 Oct 2012 10:45:30 -0700
Message-Id: <1349459130-4367-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.4
X-archive-position: 34638
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

Syntax errors were introduced into include/linux/libfdt.h by the
offending commit, revert the changes made to this file.  The kernel
again compiles, thus restoring harmony and balance to the universe.

Signed-off-by: David Daney <david.daney@cavium.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Dave Jones <davej@redhat.com>
---
 include/linux/libfdt.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/libfdt.h b/include/linux/libfdt.h
index a0c3bf6..4c0306c 100644
--- a/include/linux/libfdt.h
+++ b/include/linux/libfdt.h
@@ -2,7 +2,7 @@
 #define _INCLUDE_LIBFDT_H_
 
 #include <linux/libfdt_env.h>
-#include <>
-#include <>
+#include "../../scripts/dtc/libfdt/fdt.h"
+#include "../../scripts/dtc/libfdt/libfdt.h"
 
 #endif /* _INCLUDE_LIBFDT_H_ */
-- 
1.7.11.4
