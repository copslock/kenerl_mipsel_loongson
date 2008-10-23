Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2008 17:30:56 +0100 (BST)
Received: from smtp16.dti.ne.jp ([202.216.231.191]:18828 "EHLO
	smtp16.dti.ne.jp") by ftp.linux-mips.org with ESMTP
	id S22230035AbYJWQaw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Oct 2008 17:30:52 +0100
Received: from [192.168.1.3] (PPPax526.tokyo-ip.dti.ne.jp [210.170.129.26]) by smtp16.dti.ne.jp (3.11s) with ESMTP AUTH id m9NGUmII006676;Fri, 24 Oct 2008 01:30:49 +0900 (JST)
Message-ID: <4900A6B8.90704@ruby.dti.ne.jp>
Date:	Fri, 24 Oct 2008 01:30:48 +0900
From:	Shinya Kuribayashi <skuribay@ruby.dti.ne.jp>
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	shinya.kuribayashi@necel.com
Subject: [PATCH 05/12] MIPS: Remove emma2rh_sync on read operation
References: <4900A510.3000101@ruby.dti.ne.jp>
In-Reply-To: <4900A510.3000101@ruby.dti.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <skuribay@ruby.dti.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20863
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: skuribay@ruby.dti.ne.jp
Precedence: bulk
X-list: linux-mips

It's totally a waste of CPU cycles.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi@necel.com>
---
 arch/mips/include/asm/emma/emma2rh.h |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/emma/emma2rh.h b/arch/mips/include/asm/emma/emma2rh.h
index 458548e..cd84850 100644
--- a/arch/mips/include/asm/emma/emma2rh.h
+++ b/arch/mips/include/asm/emma/emma2rh.h
@@ -206,7 +206,6 @@ static inline void emma2rh_out32(u32 offset, u32 val)
 static inline u32 emma2rh_in32(u32 offset)
 {
 	u32 val = *(volatile u32 *)(EMMA2RH_BASE | offset);
-	emma2rh_sync();
 	return val;
 }
 
@@ -219,7 +218,6 @@ static inline void emma2rh_out16(u32 offset, u16 val)
 static inline u16 emma2rh_in16(u32 offset)
 {
 	u16 val = *(volatile u16 *)(EMMA2RH_BASE | offset);
-	emma2rh_sync();
 	return val;
 }
 
@@ -232,7 +230,6 @@ static inline void emma2rh_out8(u32 offset, u8 val)
 static inline u8 emma2rh_in8(u32 offset)
 {
 	u8 val = *(volatile u8 *)(EMMA2RH_BASE | offset);
-	emma2rh_sync();
 	return val;
 }
 
