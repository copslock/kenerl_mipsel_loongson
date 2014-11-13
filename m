Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Nov 2014 16:53:14 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:38128 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013630AbaKMPwTqnC2a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Nov 2014 16:52:19 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1Xowgu-0007pf-HJ; Thu, 13 Nov 2014 09:52:12 -0600
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH 4/8] MIPS: Fix address type used for early memory detection.
Date:   Thu, 13 Nov 2014 09:52:00 -0600
Message-Id: <1415893924-36351-5-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1415893924-36351-1-git-send-email-Steven.Hill@imgtec.com>
References: <1415893924-36351-1-git-send-email-Steven.Hill@imgtec.com>
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44134
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

From: "Steven J. Hill" <Steven.Hill@imgtec.com>

In 'early_parse_mem' the data type used for the start
and size of a memory region specified on the command line
is incorrect. If 64-bit addressing is used, the value
gets truncated.

Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/kernel/setup.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index bfcbb58..092ea49 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -493,7 +493,7 @@ static int usermem __initdata;
 
 static int __init early_parse_mem(char *p)
 {
-	unsigned long start, size;
+	phys_t start, size;
 
 	/*
 	 * If a user specifies memory size, we
-- 
1.7.10.4
