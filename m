Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jan 2009 22:56:56 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:39065 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S21365048AbZAHW4e (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 Jan 2009 22:56:34 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4966847a0000>; Thu, 08 Jan 2009 17:55:59 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 8 Jan 2009 14:55:49 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 8 Jan 2009 14:55:49 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n08MtkCd029477;
	Thu, 8 Jan 2009 14:55:46 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n08MtjO3029475;
	Thu, 8 Jan 2009 14:55:45 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	rusty@rustcorp.com.au, torvalds@linux-foundation.org
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	travis@sgi.com, David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 1/2] Make irq_*_affinity depend on CONFIG_GENERIC_HARDIRQS too.
Date:	Thu,  8 Jan 2009 14:55:44 -0800
Message-Id: <1231455345-29453-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.6
In-Reply-To: <496683D0.6000509@caviumnetworks.com>
References: <496683D0.6000509@caviumnetworks.com>
X-OriginalArrivalTime: 08 Jan 2009 22:55:49.0635 (UTC) FILETIME=[3FF62D30:01C971E4]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21701
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

In interrupt.h these functions are declared only if
CONFIG_GENERIC_HARDIRQS is set.  We should define them under identical
conditions.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 kernel/irq/manage.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index cd0cd8d..618a64f 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -15,7 +15,7 @@
 
 #include "internals.h"
 
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) && defined(CONFIG_GENERIC_HARDIRQS)
 cpumask_var_t irq_default_affinity;
 
 static int init_irq_default_affinity(void)
-- 
1.5.6.6
