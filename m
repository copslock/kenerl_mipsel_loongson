Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jun 2007 16:43:24 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.172]:56334 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20022491AbXFDPmU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 4 Jun 2007 16:42:20 +0100
Received: by ug-out-1314.google.com with SMTP id m3so851214ugc
        for <linux-mips@linux-mips.org>; Mon, 04 Jun 2007 08:41:18 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=NjPQKiYGHry3KqoXYyoWgMeelk67gIZJ1PtmX9wx75+icnY1X1OCpF4HMNHUC+V0K8Sr4RQ9SMnHyJ1kdg7Q49RCsm5KnSziW9cryyQ2dYwSZnhl75sD2zDY62Q+Jncg62NND6i8oXDjAPpMIJN71sS9rNfEo5a0O2HZeK3wo2A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=VUwbJ1GKYr9Sfh6xNACSlMfEZk6ACL0u7t2GkWSdf85Z7WKHmU+FYv5ZDXIuGn7eVsQbc4khgKgCGHUv2qDwnXOH040wKs8//wakULV4+ygIuhetr/kLGxfQy/TDJwGQTD9TZJnGnCmnm3PbWm6yYo6haMIFKUNJ9dqH83jkNwI=
Received: by 10.67.19.13 with SMTP id w13mr3212659ugi.1180971678518;
        Mon, 04 Jun 2007 08:41:18 -0700 (PDT)
Received: from spoutnik.innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTP id b33sm1072117ika.2007.06.04.08.41.16;
        Mon, 04 Jun 2007 08:41:17 -0700 (PDT)
Received: by spoutnik.innova-card.com (Postfix, from userid 500)
	id 76FF723F773; Mon,  4 Jun 2007 17:46:36 +0200 (CEST)
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: [PATCH 3/5] Make PAGE_OFFSET aware of PHYS_OFFSET
Date:	Mon,  4 Jun 2007 17:46:33 +0200
Message-Id: <1180971996831-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.5.1.4
In-Reply-To: <1180971995757-git-send-email-fbuihuu@gmail.com>
References: <1180971995757-git-send-email-fbuihuu@gmail.com>
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15242
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: Franck Bui-Huu <fbuihuu@gmail.com>

For platforms that use PHYS_OFFSET and do not use a mapped kernel,
this patch automatically adds PHYS_OFFSET into PAGE_OFFSET.
Therefore there are no more needs for them to redefine PAGE_OFFSET.

For mapped kernel, they need to redefine PAGE_OFFSET anyways.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 include/asm-mips/mach-generic/spaces.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/asm-mips/mach-generic/spaces.h b/include/asm-mips/mach-generic/spaces.h
index c90900b..96c8971 100644
--- a/include/asm-mips/mach-generic/spaces.h
+++ b/include/asm-mips/mach-generic/spaces.h
@@ -72,7 +72,7 @@
  * This handles the memory map.
  */
 #ifndef PAGE_OFFSET
-#define PAGE_OFFSET		CAC_BASE
+#define PAGE_OFFSET		(CAC_BASE + PHYS_OFFSET)
 #endif
 
 
-- 
1.5.1.4
