Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Oct 2014 11:34:52 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:25657 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010922AbaJIJeoIk0Ga (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Oct 2014 11:34:44 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id A10B2E8F41A7F
        for <linux-mips@linux-mips.org>; Thu,  9 Oct 2014 10:34:35 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 9 Oct 2014 10:34:37 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.56) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 9 Oct 2014 10:34:37 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 1/3] MIPS: Malta: Do not build the malta-amon.c file if CMP is not enabled
Date:   Thu, 9 Oct 2014 10:34:19 +0100
Message-ID: <1412847261-7930-2-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.1.2
In-Reply-To: <1412847261-7930-1-git-send-email-markos.chandras@imgtec.com>
References: <1412847261-7930-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.56]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43116
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

The malta-amon.c file provides functions to access the YAMON Monitoring
interface to bring up secondary VPEs in case of SMP/CMP. As a
result of which, there is no need to build it if CMP is not used.

Reviewed-by: Paul Burton <paul.burton@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/mti-malta/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/mti-malta/Makefile b/arch/mips/mti-malta/Makefile
index b9510ea8db56..6510ace272d4 100644
--- a/arch/mips/mti-malta/Makefile
+++ b/arch/mips/mti-malta/Makefile
@@ -5,8 +5,9 @@
 # Copyright (C) 2008 Wind River Systems, Inc.
 #   written by Ralf Baechle <ralf@linux-mips.org>
 #
-obj-y				:= malta-amon.o malta-display.o malta-init.o \
+obj-y				:= malta-display.o malta-init.o \
 				   malta-int.o malta-memory.o malta-platform.o \
 				   malta-reset.o malta-setup.o malta-time.o
 
+obj-$(CONFIG_MIPS_CMP)		+= malta-amon.o
 obj-$(CONFIG_MIPS_MALTA_PM)	+= malta-pm.o
-- 
2.1.2
