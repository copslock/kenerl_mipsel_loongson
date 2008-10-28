Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2008 00:07:29 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:48660 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S22532712AbYJ1AEo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Oct 2008 00:04:44 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B490656f60008>; Mon, 27 Oct 2008 20:04:06 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 27 Oct 2008 17:03:09 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 27 Oct 2008 17:03:09 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id m9S034wW003280;
	Mon, 27 Oct 2008 17:03:04 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id m9S034fA003279;
	Mon, 27 Oct 2008 17:03:04 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: [PATCH 09/36] Enable mips32 style bitops for Cavium OCTEON.
Date:	Mon, 27 Oct 2008 17:02:41 -0700
Message-Id: <1225152181-3221-9-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1225152181-3221-8-git-send-email-ddaney@caviumnetworks.com>
References: <490655B6.4030406@caviumnetworks.com>
 <1225152181-3221-1-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-2-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-3-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-4-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-5-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-6-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-7-git-send-email-ddaney@caviumnetworks.com>
 <1225152181-3221-8-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 28 Oct 2008 00:03:09.0538 (UTC) FILETIME=[8FC6B420:01C93890]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21018
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

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
1.5.6.5
