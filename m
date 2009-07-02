Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jul 2009 04:49:34 +0200 (CEST)
Received: from dns1.mips.com ([63.167.95.197]:39580 "EHLO dns1.mips.com"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492015AbZGBCrv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Jul 2009 04:47:51 +0200
Received: from MTVEXCHANGE.mips.com ([192.168.36.60])
	by dns1.mips.com (8.13.8/8.13.8) with ESMTP id n622g9Xt016328
	for <linux-mips@linux-mips.org>; Wed, 1 Jul 2009 19:42:09 -0700
Received: from mercury.mips.com ([192.168.64.101]) by MTVEXCHANGE.mips.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 1 Jul 2009 19:42:08 -0700
Received: from [192.168.65.97] (linux-raghu [192.168.65.97])
	by mercury.mips.com (8.13.5/8.13.5) with ESMTP id n622g85i006006;
	Wed, 1 Jul 2009 19:42:08 -0700 (PDT)
From:	Raghu Gandham <raghu@mips.com>
Subject: [PATCH 08/15] Fix compiler warning in vpe.c
To:	linux-mips@linux-mips.org
Cc:	chris@mips.com
Date:	Wed, 01 Jul 2009 19:41:42 -0700
Message-ID: <20090702024142.23268.72001.stgit@linux-raghu>
In-Reply-To: <20090702023938.23268.65453.stgit@linux-raghu>
References: <20090702023938.23268.65453.stgit@linux-raghu>
User-Agent: StGIT/0.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Jul 2009 02:42:08.0662 (UTC) FILETIME=[B191C360:01C9FABE]
Return-Path: <raghu@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23600
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
