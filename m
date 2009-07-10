Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jul 2009 11:01:53 +0200 (CEST)
Received: from dns1.mips.com ([63.167.95.197]:44643 "EHLO dns1.mips.com"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1491966AbZGJJBq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 10 Jul 2009 11:01:46 +0200
Received: from MTVEXCHANGE.mips.com ([192.168.36.200])
	by dns1.mips.com (8.13.8/8.13.8) with ESMTP id n6A91dCM024353
	for <linux-mips@linux-mips.org>; Fri, 10 Jul 2009 02:01:39 -0700
Received: from mercury.mips.com ([192.168.64.101]) by MTVEXCHANGE.mips.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 10 Jul 2009 02:01:39 -0700
Received: from [192.168.65.97] (linux-raghu [192.168.65.97])
	by mercury.mips.com (8.13.5/8.13.5) with ESMTP id n6A91cjx021847;
	Fri, 10 Jul 2009 02:01:38 -0700 (PDT)
From:	Raghu Gandham <raghu@mips.com>
Subject: [PATCH] Fix compiler warning in vpe.c
To:	linux-mips@linux-mips.org
Cc:	raghu@mips.com, chris@mips.com
Date:	Fri, 10 Jul 2009 02:01:32 -0700
Message-ID: <20090710090132.26187.54479.stgit@linux-raghu>
User-Agent: StGIT/0.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Jul 2009 09:01:39.0179 (UTC) FILETIME=[0928EBB0:01CA013D]
Return-Path: <raghu@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23711
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raghu@mips.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: Raghu Gandham (raghu@mips.com)
---

 arch/mips/kernel/vpe.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/vpe.c b/arch/mips/kernel/vpe.c
index 07b9ec2..3d4ef84 100644
--- a/arch/mips/kernel/vpe.c
+++ b/arch/mips/kernel/vpe.c
@@ -327,7 +327,8 @@ static void layout_sections(struct module *mod, const Elf_Ehdr * hdr,
 			    || (s->sh_flags & masks[m][1])
 			    || s->sh_entsize != ~0UL)
 				continue;
-			s->sh_entsize = get_offset(&mod->core_size, s);
+			s->sh_entsize =
+				get_offset((unsigned long *)&mod->core_size, s);
 		}
 
 		if (m == 0)
