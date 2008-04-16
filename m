Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Apr 2008 02:39:29 +0100 (BST)
Received: from smtp-out1.tiscali.nl ([195.241.79.176]:32466 "EHLO
	smtp-out1.tiscali.nl") by ftp.linux-mips.org with ESMTP
	id S20022489AbYDPBj1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 16 Apr 2008 02:39:27 +0100
Received: from [82.171.187.43] (helo=[192.168.1.2])
	by smtp-out1.tiscali.nl with esmtp (Tiscali http://www.tiscali.nl)
	id 1JlwcQ-0007lQ-1K; Wed, 16 Apr 2008 03:39:26 +0200
Message-ID: <480558CA.7090800@tiscali.nl>
Date:	Wed, 16 Apr 2008 03:39:22 +0200
From:	Roel Kluin <12o3l@tiscali.nl>
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
MIME-Version: 1.0
To:	ralf@linux-mips.org
CC:	linux-mips@linux-mips.org, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/6] MIPS: irixelf: fix test unsigned var < 0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <12o3l@tiscali.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18931
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: 12o3l@tiscali.nl
Precedence: bulk
X-list: linux-mips

v is unsigned, cast to signed to evaluate the do_brk() return value,
    
Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
---
diff --git a/arch/mips/kernel/irixelf.c b/arch/mips/kernel/irixelf.c
index 290d8e3..fad2a2a 100644
--- a/arch/mips/kernel/irixelf.c
+++ b/arch/mips/kernel/irixelf.c
@@ -583,15 +583,15 @@ static void irix_map_prda_page(void)
 	unsigned long v;
 	struct prda *pp;
 
 	down_write(&current->mm->mmap_sem);
 	v =  do_brk(PRDA_ADDRESS, PAGE_SIZE);
 	up_write(&current->mm->mmap_sem);
 
-	if (v < 0)
+	if ((long) v < 0)
 		return;
 
 	pp = (struct prda *) v;
 	pp->prda_sys.t_pid  = task_pid_vnr(current);
 	pp->prda_sys.t_prid = read_c0_prid();
 	pp->prda_sys.t_rpid = task_pid_vnr(current);
 
