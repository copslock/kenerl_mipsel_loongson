Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Dec 2010 00:55:31 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:4099 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492618Ab0LTXzE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Dec 2010 00:55:04 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d0fed020000>; Mon, 20 Dec 2010 15:55:46 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 20 Dec 2010 15:56:23 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 20 Dec 2010 15:56:23 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id oBKNsvb3012888;
        Mon, 20 Dec 2010 15:54:57 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id oBKNstqr012887;
        Mon, 20 Dec 2010 15:54:55 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 1/2] MIPS: Declare uasm bbit0 and bbit1 functions.
Date:   Mon, 20 Dec 2010 15:54:49 -0800
Message-Id: <1292889290-12849-2-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1292889290-12849-1-git-send-email-ddaney@caviumnetworks.com>
References: <1292889290-12849-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 20 Dec 2010 23:56:23.0236 (UTC) FILETIME=[8175F040:01CBA0A1]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28661
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

these are already defined, but declaring them allow them to be used
outside of uasm.c.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/uasm.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
index 99dae68..d361df3 100644
--- a/arch/mips/include/asm/uasm.h
+++ b/arch/mips/include/asm/uasm.h
@@ -117,6 +117,8 @@ Ip_u2u1u3(_xori);
 Ip_u2u1msbu3(_dins);
 Ip_u2u1msbu3(_dinsm);
 Ip_u1(_syscall);
+Ip_u1u2s3(_bbit0);
+Ip_u1u2s3(_bbit1);
 
 /* Handle labels. */
 struct uasm_label {
-- 
1.7.2.3
