Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Mar 2015 19:20:32 +0100 (CET)
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:38150 "EHLO
        ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013949AbbCPSTH7Ztx- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Mar 2015 19:19:07 +0100
Received: from localhost (localhost [127.0.0.1])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id 1B5C44608F5
        for <linux-mips@linux-mips.org>; Mon, 16 Mar 2015 18:19:03 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
        by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xd7MYCnDNpXn; Mon, 16 Mar 2015 18:19:00 +0000 (GMT)
Received: from pm-laptop.codethink.co.uk (pm-laptop.dyn.ducie.codethink.co.uk [10.24.1.94])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id 4F6294602F9;
        Mon, 16 Mar 2015 18:18:53 +0000 (GMT)
Received: from pm by pm-laptop.codethink.co.uk with local (Exim 4.84)
        (envelope-from <paul.martin@codethink.co.uk>)
        id 1YXZbI-0003UE-Sk; Mon, 16 Mar 2015 18:18:52 +0000
From:   Paul Martin <paul.martin@codethink.co.uk>
To:     linux-mips@linux-mips.org
Cc:     Paul Martin <paul.martin@codethink.co.uk>
Subject: [PATCH 6/7] MIPS: OCTEON: Make octeon-md5 driver endian-agnostic
Date:   Mon, 16 Mar 2015 18:18:42 +0000
Message-Id: <1426529923-13340-7-git-send-email-paul.martin@codethink.co.uk>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1426529923-13340-1-git-send-email-paul.martin@codethink.co.uk>
References: <1426529923-13340-1-git-send-email-paul.martin@codethink.co.uk>
Return-Path: <paul.martin@codethink.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46410
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.martin@codethink.co.uk
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

The octeon crypto co-processor expects values to be big endian.
Wrap the data transfers with cpu_to_be64() and be64_to_cpu()
transformations.

This passes for all the MD5 test vectors in crypto/testmgr.h

Signed-off-by: Paul Martin <paul.martin@codethink.co.uk>
---
 arch/mips/cavium-octeon/crypto/octeon-crypto.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/cavium-octeon/crypto/octeon-crypto.h b/arch/mips/cavium-octeon/crypto/octeon-crypto.h
index e2a4aec..0e157f1 100644
--- a/arch/mips/cavium-octeon/crypto/octeon-crypto.h
+++ b/arch/mips/cavium-octeon/crypto/octeon-crypto.h
@@ -32,7 +32,7 @@ do {							\
 	__asm__ __volatile__ (				\
 	"dmtc2 %[rt],0x0048+" STR(index)		\
 	:						\
-	: [rt] "d" (value));				\
+	: [rt] "d" (cpu_to_be64(value)));		\
 } while (0)
 
 /*
@@ -47,7 +47,7 @@ do {							\
 	: [rt] "=d" (__value)				\
 	: );						\
 							\
-	__value;					\
+	be64_to_cpu(__value);				\
 })
 
 /*
@@ -58,7 +58,7 @@ do {							\
 	__asm__ __volatile__ (				\
 	"dmtc2 %[rt],0x0040+" STR(index)		\
 	:						\
-	: [rt] "d" (value));				\
+	: [rt] "d" (cpu_to_be64(value)));		\
 } while (0)
 
 /*
@@ -69,7 +69,7 @@ do {							\
 	__asm__ __volatile__ (				\
 	"dmtc2 %[rt],0x4047"				\
 	:						\
-	: [rt] "d" (value));				\
+	: [rt] "d" (cpu_to_be64(value)));		\
 } while (0)
 
 #endif /* __LINUX_OCTEON_CRYPTO_H */
-- 
2.1.4
