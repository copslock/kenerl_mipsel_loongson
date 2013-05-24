Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 May 2013 23:55:02 +0200 (CEST)
Received: from mail-pd0-f179.google.com ([209.85.192.179]:65005 "EHLO
        mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835044Ab3EXVyXUosFW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 May 2013 23:54:23 +0200
Received: by mail-pd0-f179.google.com with SMTP id q11so4588887pdj.38
        for <multiple recipients>; Fri, 24 May 2013 14:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=aWup584eBdZbnQDa4Rfe7XwGx7cRT8YF7tCkHYW0VQA=;
        b=ty946ETQ7UjxYdOSJg9BSkda4ltPuh3Kf1sMVPjoLMxulDQsLwa6muZSsK19GfiElU
         wDMHuts+uF8ImNF+n1EpRhgJ2mDhpEDfIwocPz676pBtdB1J7cwu4q60a4jL00g3JSlj
         luIiffh2Ewt4ivTY3uXl9rRfsyHZZotD8iGoUVDFYuMcUOmT5o1IvxgJP18g0lAl6QdK
         cuiH3p0MztevBZ97LrmcVumZXILqS2JjrBLbFiwpGLeLPBh+j1ybKtsqeNJ79hlhmfzU
         HvpL+SZKiuQoSxlJ2Zo3FFEllYEcvQcFvRoZ1BCOxG2698stP4ewbSY4JuIQLEhdzDB8
         zSgA==
X-Received: by 10.66.197.202 with SMTP id iw10mr19911601pac.178.1369432456716;
        Fri, 24 May 2013 14:54:16 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id w8sm17689683pbo.9.2013.05.24.14.54.14
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 14:54:15 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r4OLsDxb013628;
        Fri, 24 May 2013 14:54:13 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r4OLsDFQ013627;
        Fri, 24 May 2013 14:54:13 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>
Subject: [PATCH 2/3] MIPS: Don't try to decode microMIPS branch instructions where they cannot exist.
Date:   Fri, 24 May 2013 14:54:09 -0700
Message-Id: <1369432450-13583-3-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1369432450-13583-1-git-send-email-ddaney.cavm@gmail.com>
References: <1369432450-13583-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36593
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

In mm_isBranchInstr() we can short circuit the entire function if
!cpu_has_mmips.

Signed-off-by: David Daney <david.daney@cavium.com>
Cc: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/math-emu/cp1emu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index f03771900..e773659 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -471,6 +471,9 @@ int mm_isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 	unsigned int fcr31;
 	unsigned int bit;
 
+	if (!cpu_has_mmips)
+		return 0;
+
 	switch (insn.mm_i_format.opcode) {
 	case mm_pool32a_op:
 		if ((insn.mm_i_format.simmediate & MM_POOL32A_MINOR_MASK) ==
-- 
1.7.11.7
