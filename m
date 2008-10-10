Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Oct 2008 17:59:31 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:22224 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S21157587AbYJJQ72 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 10 Oct 2008 17:59:28 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B48ef89e90000>; Fri, 10 Oct 2008 12:59:22 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 10 Oct 2008 09:59:21 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 10 Oct 2008 09:59:20 -0700
Message-ID: <48EF89E8.1090300@caviumnetworks.com>
Date:	Fri, 10 Oct 2008 09:59:20 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: [PATCH] MIPS: Use __cpuinit for mips_probe_watch_registers.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Oct 2008 16:59:20.0849 (UTC) FILETIME=[8A12F010:01C92AF9]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20710
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Use __cpuinit for mips_probe_watch_registers.

This function is called whenever a cpu is added, it cannot be __init.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/kernel/watch.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/watch.c b/arch/mips/kernel/watch.c
index e9c4f5d..c154069 100644
--- a/arch/mips/kernel/watch.c
+++ b/arch/mips/kernel/watch.c
@@ -100,7 +100,7 @@ void mips_clear_watch_registers(void)
 	}
 }
 
-__init void mips_probe_watch_registers(struct cpuinfo_mips *c)
+__cpuinit void mips_probe_watch_registers(struct cpuinfo_mips *c)
 {
 	unsigned int t;
 
