Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Oct 2013 12:49:03 +0200 (CEST)
Received: from top.free-electrons.com ([176.31.233.9]:58802 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6865316Ab3JWKh5HsxUi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Oct 2013 12:37:57 +0200
Received: by mail.free-electrons.com (Postfix, from userid 106)
        id 508B57EB; Wed, 23 Oct 2013 12:37:52 +0200 (CEST)
Received: from localhost (unknown [217.39.7.252])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 15D447E8;
        Wed, 23 Oct 2013 12:37:52 +0200 (CEST)
From:   Michael Opdenacker <michael.opdenacker@free-electrons.com>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Michael Opdenacker <michael.opdenacker@free-electrons.com>
Subject: [PATCH] MIPS: remove duplicate define
Date:   Wed, 23 Oct 2013 12:37:44 +0200
Message-Id: <1382524664-3309-1-git-send-email-michael.opdenacker@free-electrons.com>
X-Mailer: git-send-email 1.8.1.2
Return-Path: <michael.opdenacker@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38385
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michael.opdenacker@free-electrons.com
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

This patch removes a duplicate define from
arch/mips/boot/ecoff.h

Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
---
 arch/mips/boot/ecoff.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/boot/ecoff.h b/arch/mips/boot/ecoff.h
index 83e5c38..7a75ce2 100644
--- a/arch/mips/boot/ecoff.h
+++ b/arch/mips/boot/ecoff.h
@@ -12,7 +12,6 @@ typedef struct filehdr {
 } FILHDR;
 #define FILHSZ	sizeof(FILHDR)
 
-#define OMAGIC		0407
 #define MIPSEBMAGIC	0x160
 #define MIPSELMAGIC	0x162
 
-- 
1.8.1.2
