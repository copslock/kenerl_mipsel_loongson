Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Sep 2013 16:11:26 +0200 (CEST)
Received: from mms3.broadcom.com ([216.31.210.19]:4691 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6818702Ab3IWOLToB57O (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 23 Sep 2013 16:11:19 +0200
Received: from [10.9.208.55] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 23 Sep 2013 07:00:21 -0700
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS07.corp.ad.broadcom.com (10.9.208.55) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Mon, 23 Sep 2013 07:11:00 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP
 Server id 14.1.438.0; Mon, 23 Sep 2013 07:11:00 -0700
Received: from xl-blr-01.broadcom.com (xl-blr-01.ban.broadcom.com
 [10.132.130.166]) by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 07CEC246A5; Mon, 23 Sep 2013 07:11:00 -0700 (PDT)
Received: by xl-blr-01.broadcom.com (Postfix, from userid 31394) id
 8672D146A499; Mon, 23 Sep 2013 19:40:55 +0530 (IST)
From:   "Ashok Kumar" <ashoks@broadcom.com>
To:     linux-mips@linux-mips.org, gerg@uclinux.org
cc:     ralf@linux-mips.org, "Ashok Kumar" <ashoks@broadcom.com>
Subject: [PATCH] MIPS: fix mapstart when using initrd
Date:   Mon, 23 Sep 2013 19:40:26 +0530
Message-ID: <1379945426-32205-1-git-send-email-ashoks@broadcom.com>
X-Mailer: git-send-email 1.7.6
MIME-Version: 1.0
X-WSS-ID: 7E5E96FF2L887512444-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <ashoks@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37931
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ashoks@broadcom.com
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

When initrd is present in the PFN right after the _end, bootmem
bitmap(mapstart) overwrites it. So check for initrd_end in
mapstart calculation.

Signed-off-by: Ashok Kumar <ashoks@broadcom.com>
---
This is seen after the commit
"mips: fix start of free memory when using initrd"
in git://git.linux-mips.org/pub/scm/ralf/upstream-sfr.git branch

Tested the image on MIPS platform creating the above
said scenario and initrd was corrupted.

 arch/mips/kernel/setup.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 5342385..dfb8585 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -364,6 +364,11 @@ static void __init bootmem_init(void)
 	}
 
 	/*
+	 * mapstart should be after initrd_end
+	 */
+	mapstart = max(mapstart, (unsigned long)PFN_UP(__pa(initrd_end)));
+
+	/*
 	 * Initialize the boot-time allocator with low memory only.
 	 */
 	bootmap_size = init_bootmem_node(NODE_DATA(0), mapstart,
-- 
1.7.6
