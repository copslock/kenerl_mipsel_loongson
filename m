Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Dec 2017 11:55:58 +0100 (CET)
Received: from mail-wm0-x241.google.com ([IPv6:2a00:1450:400c:c09::241]:38130
        "EHLO mail-wm0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990433AbdLZKzvXUuy5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Dec 2017 11:55:51 +0100
Received: by mail-wm0-x241.google.com with SMTP id 64so34453658wme.3;
        Tue, 26 Dec 2017 02:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=PmfNFtJA1042ei4jOV0B3Ph+6z1bUVVZZAKpaSI3Vfk=;
        b=TY388VTsk+rFmJRCOsHqRCYGcC8Mf9nUlR5jdCHl5nieBaivabC7S71MyYOAMHU2Yy
         Y7CChx1FBUBbRuwEWD+ce3G3i3MpdgZ1a2RylZCQDzhxdbeERGys+SJc3uZuK5U4nJJs
         3llPtX5RcJ2jsXGMQANqEmrKgkO3PQFVPq2qpQG1Qw6YVMG2jHEB+k5SAJwNnSkm79/q
         N4NKo7reRYyzbnPPnJcmsWIq780skg0Ap+n14WQ/+xfG7cjv1KjbrsZHb917sfoH/VMC
         QjRDMiF4Ws9T2xZ1qwJfLUls2709PdSw94YDPSOrqPefxsRXr9GsZQzqBI2AHdyn4EZe
         gjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=PmfNFtJA1042ei4jOV0B3Ph+6z1bUVVZZAKpaSI3Vfk=;
        b=mVNsWHqvMPoapbR1c58Zr5BfL/bMVw2ai9+N4RT9+9/wBwuwt4qedZE9dEgAWnloE6
         zxD2y0wPykOBvNkuiadfXZf1yhgxcWaE9H7IU8g56dTlQLdJeNNvJKFEvr/cmhQEeqhV
         2jF7InzBH7mefNCsDtkHihsPAVKNirtEg+BKxDz+SQNPMWZf1pqsDjyPoDWNXPDiI56x
         RIC91tCbOiePj6fTz89m5XmZmEgz8BqoWGN17mYL6lMKszfGPtmQkmkbH4sDAAVZVZlG
         hBov7qPO+UpheVZ3nlSDITGgK/9zOmyZxwdiFfLp20pvCwkSzfKs9xdrNIae6RqKhlaU
         da3w==
X-Gm-Message-State: AKGB3mIPIEcXjTMcjhUaILGpLERq0YJTBr2eOIS4cNkSvVNUptwyyTYi
        vkzLukbw0us8lsw1BJR8iF4=
X-Google-Smtp-Source: ACJfBosGOO2FO/6DMu9oB1Vz2nRsb748hYKyLGFvxsdmk8cTMcBB0aiESIqgIejBOioCo8eK3qaIug==
X-Received: by 10.28.55.72 with SMTP id e69mr19461238wma.154.1514285745966;
        Tue, 26 Dec 2017 02:55:45 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-226-121.fbx.proxad.net. [78.225.226.121])
        by smtp.gmail.com with ESMTPSA id c2sm41989590wrc.81.2017.12.26.02.55.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Dec 2017 02:55:45 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 46F0D10C1B2E; Tue, 26 Dec 2017 11:55:44 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@mips.com>,
        Paul Burton <paul.burton@mips.com>,
        Ingo Molnar <mingo@kernel.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: Use proper @return keyword
Date:   Tue, 26 Dec 2017 11:55:31 +0100
Message-Id: <20171226105532.23452-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61595
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: malat@debian.org
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

Fix non-fatal warning:

arch/mips/kernel/branch.c:418: warning: Excess function parameter 'returns' description in '__compute_return_epc_for_insn'

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/mips/kernel/branch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
index b79ed9af9886..e0d3a432e1e3 100644
--- a/arch/mips/kernel/branch.c
+++ b/arch/mips/kernel/branch.c
@@ -399,7 +399,7 @@ int __MIPS16e_compute_return_epc(struct pt_regs *regs)
  *
  * @regs:	Pointer to pt_regs
  * @insn:	branch instruction to decode
- * @returns:	-EFAULT on error and forces SIGILL, and on success
+ * @return:	-EFAULT on error and forces SIGILL, and on success
  *		returns 0 or BRANCH_LIKELY_TAKEN as appropriate after
  *		evaluating the branch.
  *
-- 
2.11.0
