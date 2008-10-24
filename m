Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 02:00:30 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:28518 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S22251728AbYJXA5u (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Oct 2008 01:57:50 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49011d650000>; Thu, 23 Oct 2008 20:57:09 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 23 Oct 2008 17:57:08 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 23 Oct 2008 17:57:08 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id m9O0v3Ib005597;
	Thu, 23 Oct 2008 17:57:03 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id m9O0v3VC005596;
	Thu, 23 Oct 2008 17:57:03 -0700
From:	ddaney@caviumnetworks.com
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: [PATCH 09/37] Enable mips32 style bitops for Cavium OCTEON.
Date:	Thu, 23 Oct 2008 17:56:33 -0700
Message-Id: <1224809821-5532-10-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1224809821-5532-1-git-send-email-ddaney@caviumnetworks.com>
References: <1224809821-5532-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 24 Oct 2008 00:57:08.0219 (UTC) FILETIME=[708734B0:01C93573]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20888
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

From: David Daney <ddaney@caviumnetworks.com>

Enable the basic bitops like __ffs and so forth that would normally be
on if we were MIPS32 or MIPS64, but aren't since Cavium sets neither.

Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Signed-off-by: David Daney<ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/bitops.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/bitops.h b/arch/mips/include/asm/bitops.h
index 49df8c4..6f5f225 100644
--- a/arch/mips/include/asm/bitops.h
+++ b/arch/mips/include/asm/bitops.h
@@ -558,7 +558,8 @@ static inline void __clear_bit_unlock(unsigned long nr, volatile unsigned long *
 	__clear_bit(nr, addr);
 }
 
-#if defined(CONFIG_CPU_MIPS32) || defined(CONFIG_CPU_MIPS64)
+#if defined(CONFIG_CPU_MIPS32) || defined(CONFIG_CPU_MIPS64) \
+ || defined(CONFIG_CPU_CAVIUM_OCTEON)
 
 /*
  * Return the bit position (0..63) of the most significant 1 bit in a word
-- 
1.5.5.1
