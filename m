Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Oct 2008 00:36:24 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:16435 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S21423429AbYJMXgU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 14 Oct 2008 00:36:20 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B48f3db700000>; Mon, 13 Oct 2008 19:36:16 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 13 Oct 2008 16:36:13 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 13 Oct 2008 16:36:13 -0700
Message-ID: <48F3DB6D.9020108@caviumnetworks.com>
Date:	Mon, 13 Oct 2008 16:36:13 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: [PATCH] MIPS: Align .data.cacheline_aligned based on MIPS_L1_CACHE_SHIFT
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Oct 2008 23:36:13.0460 (UTC) FILETIME=[7ABC4540:01C92D8C]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20736
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Align .data.cacheline_aligned based on the MIPS_L1_CACHE_SHIFT
configuration variable.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
---
 arch/mips/kernel/vmlinux.lds.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index afb119f..58738c8 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -104,7 +104,7 @@ SECTIONS
 	. = ALIGN(_PAGE_SIZE);
 	__nosave_end = .;
 
-	. = ALIGN(32);
+	. = ALIGN(1 << CONFIG_MIPS_L1_CACHE_SHIFT);
 	.data.cacheline_aligned : {
 		*(.data.cacheline_aligned)
 	}
