Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Jul 2013 00:09:28 +0200 (CEST)
Received: from mail-pb0-f45.google.com ([209.85.160.45]:38066 "EHLO
        mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6831321Ab3G2WHSAeKfF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Jul 2013 00:07:18 +0200
Received: by mail-pb0-f45.google.com with SMTP id mc8so5158047pbc.18
        for <multiple recipients>; Mon, 29 Jul 2013 15:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=aS11ZRjQy9KVcNja7bTOr1SWBMRoG8Ct8LGyp6r5AbA=;
        b=TnWlR3ZWBg997JsHks1Z4TGTp+KAAmpjMDAS6luy31/fO1rPYdM2GwVFaXGGkc6arR
         nczfEcL5+lQ8KTf+rut+W7mJl9pvHKSMb1X0c9cMNmCK5/azKvN9bRkn8ShtmdBNKnCy
         XlJCSsPyKo2OzViwMF0N5/CVlG72NzjHHbiuh7MkrVntLKVQdheTWXK3AI+4YyZq0E/d
         BJ5zHAmDvFdian4iS7ytTY+LMEGkIbqpJcViB0VPqRWbluAGwHyL+1GOPQvRWUQpjLGo
         DcZQ2pJNrFneh47+h/F4wsJFnAaTK7zAloBTpOiTC7thls5b7ygGAl6gbLSsilRqTB9V
         lblQ==
X-Received: by 10.66.37.43 with SMTP id v11mr33209869paj.108.1375135631533;
        Mon, 29 Jul 2013 15:07:11 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id ht5sm78979707pbb.29.2013.07.29.15.07.10
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 29 Jul 2013 15:07:10 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r6TM79uQ031005;
        Mon, 29 Jul 2013 15:07:09 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r6TM78KL031004;
        Mon, 29 Jul 2013 15:07:08 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH 4/5] MIPS: Generate OCTEON3 TLB handlers with the same features as OCTEON2.
Date:   Mon, 29 Jul 2013 15:07:03 -0700
Message-Id: <1375135624-30950-5-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1375135624-30950-1-git-send-email-ddaney.cavm@gmail.com>
References: <1375135624-30950-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37398
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

From the point of view of the TLB Exception handlers, OCTEON3 and
OCTEON2 need the same code.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/mm/tlbex.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index 556cb48..821b451 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -85,6 +85,7 @@ static int use_bbit_insns(void)
 	case CPU_CAVIUM_OCTEON:
 	case CPU_CAVIUM_OCTEON_PLUS:
 	case CPU_CAVIUM_OCTEON2:
+	case CPU_CAVIUM_OCTEON3:
 		return 1;
 	default:
 		return 0;
@@ -95,6 +96,7 @@ static int use_lwx_insns(void)
 {
 	switch (current_cpu_type()) {
 	case CPU_CAVIUM_OCTEON2:
+	case CPU_CAVIUM_OCTEON3:
 		return 1;
 	default:
 		return 0;
-- 
1.7.11.7
