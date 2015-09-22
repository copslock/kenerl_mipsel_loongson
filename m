Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2015 20:57:22 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:57500 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009133AbbIVS5UdOuzP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Sep 2015 20:57:20 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 29380BD80A005;
        Tue, 22 Sep 2015 19:57:11 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 22 Sep 2015 19:57:14 +0100
Received: from localhost (192.168.159.189) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 22 Sep
 2015 19:57:13 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] MIPS: malta: split obj-y entries across lines
Date:   Tue, 22 Sep 2015 11:56:36 -0700
Message-ID: <1442948198-14507-2-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.5.3
In-Reply-To: <1442948198-14507-1-git-send-email-paul.burton@imgtec.com>
References: <1442948198-14507-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.189]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49325
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Split the obj-y entries to their own lines such that it's easier to see
what's going on when adding or removing entries.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/mti-malta/Makefile | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/mips/mti-malta/Makefile b/arch/mips/mti-malta/Makefile
index ea35587..87c85a5 100644
--- a/arch/mips/mti-malta/Makefile
+++ b/arch/mips/mti-malta/Makefile
@@ -5,9 +5,15 @@
 # Copyright (C) 2008 Wind River Systems, Inc.
 #   written by Ralf Baechle <ralf@linux-mips.org>
 #
-obj-y				:= malta-display.o malta-dt.o malta-init.o \
-				   malta-int.o malta-memory.o malta-platform.o \
-				   malta-reset.o malta-setup.o malta-time.o
+obj-y				+= malta-display.o
+obj-y				+= malta-dt.o
+obj-y				+= malta-init.o
+obj-y				+= malta-int.o
+obj-y				+= malta-memory.o
+obj-y				+= malta-platform.o
+obj-y				+= malta-reset.o
+obj-y				+= malta-setup.o
+obj-y				+= malta-time.o
 
 obj-$(CONFIG_MIPS_CMP)		+= malta-amon.o
 obj-$(CONFIG_MIPS_MALTA_PM)	+= malta-pm.o
-- 
2.5.3
