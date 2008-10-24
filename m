Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 17:31:40 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:28515 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S22305007AbYJXQb3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Oct 2008 17:31:29 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4901f8520000>; Fri, 24 Oct 2008 12:31:14 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 24 Oct 2008 09:31:14 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 24 Oct 2008 09:31:14 -0700
Message-ID: <4901F851.8010103@caviumnetworks.com>
Date:	Fri, 24 Oct 2008 09:31:13 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>,
	linux-mips <linux-mips@linux-mips.org>
CC:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH][MIPS] fix kgdb build error
References: <20081025001725.7ac18a1b.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20081025001725.7ac18a1b.yoichi_yuasa@tripeaks.co.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Oct 2008 16:31:14.0130 (UTC) FILETIME=[EE7E8B20:01C935F5]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20942
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Yoichi Yuasa wrote:
> ptrace.h needs #include <linux/types.h>
> 
[...]

Can you try this completely untested patch instead?

If it works, I will give it a more thorough test over the next few
weeks.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/ptrace.h |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/ptrace.h
index 3356873..2426bb7 100644
--- a/arch/mips/include/asm/ptrace.h
+++ b/arch/mips/include/asm/ptrace.h
@@ -84,25 +84,25 @@ enum pt_watch_style {
 	pt_watch_style_mips64
 };
 struct mips32_watch_regs {
-	uint32_t watchlo[8];
+	unsigned int watchlo[8];
 	/* Lower 16 bits of watchhi. */
-	uint16_t watchhi[8];
+	unsigned short watchhi[8];
 	/* Valid mask and I R W bits.
 	 * bit 0 -- 1 if W bit is usable.
 	 * bit 1 -- 1 if R bit is usable.
 	 * bit 2 -- 1 if I bit is usable.
 	 * bits 3 - 11 -- Valid watchhi mask bits.
 	 */
-	uint16_t watch_masks[8];
+	unsigned short watch_masks[8];
 	/* The number of valid watch register pairs.  */
-	uint32_t num_valid;
+	unsigned int num_valid;
 } __attribute__((aligned(8)));
 
 struct mips64_watch_regs {
-	uint64_t watchlo[8];
-	uint16_t watchhi[8];
-	uint16_t watch_masks[8];
-	uint32_t num_valid;
+	unsigned long long watchlo[8];
+	unsigned short watchhi[8];
+	unsigned short watch_masks[8];
+	unsigned int num_valid;
 } __attribute__((aligned(8)));
 
 struct pt_watch_regs {
