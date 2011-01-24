Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Jan 2011 23:52:18 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:7312 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491101Ab1AXWvy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Jan 2011 23:51:54 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d3e02b90000>; Mon, 24 Jan 2011 14:52:41 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 24 Jan 2011 14:51:52 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 24 Jan 2011 14:51:52 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id p0OMpnHh023367;
        Mon, 24 Jan 2011 14:51:49 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p0OMpm2V023366;
        Mon, 24 Jan 2011 14:51:48 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 3/4] MIPS: Fix GCC-4.6 'set but not used' warning in ieee754int.h
Date:   Mon, 24 Jan 2011 14:51:36 -0800
Message-Id: <1295909497-23317-4-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1295909497-23317-1-git-send-email-ddaney@caviumnetworks.com>
References: <1295909497-23317-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 24 Jan 2011 22:51:52.0175 (UTC) FILETIME=[4A9627F0:01CBBC19]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29051
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

GCC-4.6 can find more unused code than previous versions could.

In the case of arch/mips/math-emu/ieee754int.h, the COMPXSP and
COMPXDP macros are used in several places, but a couple of them leave
xs unused.  The easiest thing to do is mark it as __maybe_unused to
quiet the warning.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/math-emu/ieee754int.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/math-emu/ieee754int.h b/arch/mips/math-emu/ieee754int.h
index 2701d95..2a7d43f 100644
--- a/arch/mips/math-emu/ieee754int.h
+++ b/arch/mips/math-emu/ieee754int.h
@@ -70,7 +70,7 @@
 
 
 #define COMPXSP \
-  unsigned xm; int xe; int xs; int xc
+  unsigned xm; int xe; int xs __maybe_unused; int xc
 
 #define COMPYSP \
   unsigned ym; int ye; int ys; int yc
@@ -104,7 +104,7 @@
 
 
 #define COMPXDP \
-u64 xm; int xe; int xs; int xc
+u64 xm; int xe; int xs __maybe_unused; int xc
 
 #define COMPYDP \
 u64 ym; int ye; int ys; int yc
-- 
1.7.2.3
