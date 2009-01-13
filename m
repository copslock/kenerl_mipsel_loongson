Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jan 2009 18:50:11 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:20287 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S21103680AbZAMStu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Jan 2009 18:49:50 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B496ce20c0000>; Tue, 13 Jan 2009 13:48:45 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 13 Jan 2009 10:47:44 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 13 Jan 2009 10:47:43 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n0DIldpT021242;
	Tue, 13 Jan 2009 10:47:39 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n0DIlcuo021240;
	Tue, 13 Jan 2009 10:47:38 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	rusty@rustcorp.com.au, torvalds@linux-foundation.org,
	akpm@linux-foundation.org
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	travis@sgi.com, David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 1/2] Make irq_*_affinity depend on CONFIG_GENERIC_HARDIRQS too.
Date:	Tue, 13 Jan 2009 10:47:37 -0800
Message-Id: <1231872458-21218-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.6
In-Reply-To: <496CE153.5010802@caviumnetworks.com>
References: <496CE153.5010802@caviumnetworks.com>
X-OriginalArrivalTime: 13 Jan 2009 18:47:43.0949 (UTC) FILETIME=[6B777FD0:01C975AF]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21731
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
