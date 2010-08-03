Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Aug 2010 20:24:33 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:19491 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493179Ab0HCSWu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Aug 2010 20:22:50 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c585e950000>; Tue, 03 Aug 2010 11:23:17 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 3 Aug 2010 11:22:48 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 3 Aug 2010 11:22:48 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o73IMiS3026430;
        Tue, 3 Aug 2010 11:22:44 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o73IMhnN026429;
        Tue, 3 Aug 2010 11:22:43 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org, ananth@in.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        masami.hiramatsu.pt@hitachi.com
Cc:     linux-kernel@vger.kernel.org, hschauhan@nulltrace.org,
        David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 5/5] documentation: Mention that KProbes is supported on MIPS
Date:   Tue,  3 Aug 2010 11:22:22 -0700
Message-Id: <1280859742-26364-6-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.1.1
In-Reply-To: <1280859742-26364-1-git-send-email-ddaney@caviumnetworks.com>
References: <1280859742-26364-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 03 Aug 2010 18:22:48.0266 (UTC) FILETIME=[E030A2A0:01CB3338]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27548
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

MIPS now has KProbes support, so kprobes.txt should reflect it.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 Documentation/kprobes.txt |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Documentation/kprobes.txt b/Documentation/kprobes.txt
index 6653017..1762b81 100644
--- a/Documentation/kprobes.txt
+++ b/Documentation/kprobes.txt
@@ -285,6 +285,7 @@ architectures:
 - sparc64 (Return probes not yet implemented.)
 - arm
 - ppc
+- mips
 
 3. Configuring Kprobes
 
-- 
1.7.1.1
