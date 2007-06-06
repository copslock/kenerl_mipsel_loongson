Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2007 05:48:58 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:22764 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20022100AbXFFEoG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 Jun 2007 05:44:06 +0100
Received: (qmail 26314 invoked by uid 511); 6 Jun 2007 04:50:08 -0000
Received: from unknown (HELO localhost.localdomain) (192.168.2.233)
  by lemote.com with SMTP; 6 Jun 2007 04:50:08 -0000
From:	tiansm@lemote.com
To:	linux-mips@linux-mips.org
Cc:	Fuxin Zhang <zhangfx@lemote.com>
Subject: [PATCH] add Loongson support to /proc/cpuinfo
Date:	Wed,  6 Jun 2007 12:42:38 +0800
Message-Id: <11811049641617-git-send-email-tiansm@lemote.com>
X-Mailer: git-send-email 1.5.2.1
In-Reply-To: <11811049622818-git-send-email-tiansm@lemote.com>
References: <11811049622818-git-send-email-tiansm@lemote.com>
Return-Path: <tiansm@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15277
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiansm@lemote.com
Precedence: bulk
X-list: linux-mips

From: Fuxin Zhang <zhangfx@lemote.com>

Signed-off-by: Fuxin Zhang <zhangfx@lemote.com>
---
 arch/mips/kernel/proc.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index 5ddc2e9..e915117 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -84,6 +84,7 @@ static const char *cpu_name[] = {
 	[CPU_VR4181A]	= "NEC VR4181A",
 	[CPU_SR71000]	= "Sandcraft SR71000",
 	[CPU_PR4450]	= "Philips PR4450",
+	[CPU_LOONGSON2]	= "ICT Loongson-2",
 };
 
 
-- 
1.5.2.1
