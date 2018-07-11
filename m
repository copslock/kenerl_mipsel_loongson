Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2018 10:23:06 +0200 (CEST)
Received: from mail-pl0-x244.google.com ([IPv6:2607:f8b0:400e:c01::244]:34183
        "EHLO mail-pl0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993514AbeGKIW6xTreZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Jul 2018 10:22:58 +0200
Received: by mail-pl0-x244.google.com with SMTP id z9-v6so8842438plo.1;
        Wed, 11 Jul 2018 01:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=pcK9d1nRShv/j8b1gDXxovfMQ0b3ktOA0nZHCFonlb8=;
        b=b+CKcL1OC+3kxyDd+XoYKeindS+++g1gU2i1BVdwG7+P/6mCMaxAOqT9SUNNqBuHB9
         nExkQyy98Cn30TaNRdVO1JqnVKwiktvUIoJFoPxr8Lnu3Mrj2918vA3QAvpyB96zSZLu
         U0WLOGDwEhewRm4SBqiVracXnu1eKwoDnVfygc0zgsyhNwMGNI3QkMFVE9z9gtpreVnp
         dWgli3S+GImmCarh+P20naDxHx4zMtkoBMNiTBDxp9Le5R9rZvZa/NkarW3nYexYCocb
         pIPLmOyij81ivDItNI/Zkz7iPxW9iy+Jm9MdQO3S66SDJ/CQsCLL4gNVOK+MloBDOVK5
         zz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=pcK9d1nRShv/j8b1gDXxovfMQ0b3ktOA0nZHCFonlb8=;
        b=I5ZrVHIuVaLmPdD/+j2OD1tO5Rhw9aixr2Ejzh5apvKsXbjs+L4fKrM/8jT/B/phF/
         BsLu9aQ16sqPtefew287EwBhNv2pdrhwS5DwnikuBo2PPAK7WjRBVCZ1/nuswDrnLXo3
         IEVyrPqD5eINvJl/QavmzsWvZ5xFPci0GyFzujg958DiDF+hS5c/ryyhVbLJoXBLdSp4
         aF9stB+bbO7pEHL3wQQBQVHiMcAnT3gT3fDjxyPaGn/0Y+eYajO2i/lc/SanVij+TbcS
         KrNnL1rHcBFi+AH6NPFPHcbr0VL+V1lqkw052CdrVLe5OR5yHLl10gArwoBhJQVfppxH
         FExQ==
X-Gm-Message-State: APt69E1PxeQd3z8Y4jj36d4WWnQqlrCX8lHWaXBnYQbc6rN2HaOmmHl7
        nn5w7XYTwq7eogRayJM/C5Fpmg==
X-Google-Smtp-Source: AAOMgpcPMY0jVavxjU3AffxUUbOgfZkLyxWWiJ9nIkqZSFgbiXkTxgik4KHdaLt8FwXSTGxjQyLxyw==
X-Received: by 2002:a17:902:6047:: with SMTP id a7-v6mr27640778plt.188.1531297372073;
        Wed, 11 Jul 2018 01:22:52 -0700 (PDT)
Received: from software.domain.org ([104.251.228.27])
        by smtp.gmail.com with ESMTPSA id g10-v6sm28875841pgs.17.2018.07.11.01.22.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Jul 2018 01:22:51 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH RFC] MIPS: Make UTS_MACHINE reflect big-endian/little-endian
Date:   Wed, 11 Jul 2018 16:28:17 +0800
Message-Id: <1531297697-7952-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64772
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

It seems like some application use "uname" command's output to do
something different between big-endian and little-endian, so we make
UTS_MACHINE reflect both 32bit/64bit and big-endian/little-endian.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index e2122cc..a21c3a1 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -38,11 +38,11 @@ endif
 
 ifdef CONFIG_32BIT
 tool-archpref		= $(32bit-tool-archpref)
-UTS_MACHINE		:= mips
+UTS_MACHINE		:= $(32bit-tool-archpref)
 endif
 ifdef CONFIG_64BIT
 tool-archpref		= $(64bit-tool-archpref)
-UTS_MACHINE		:= mips64
+UTS_MACHINE		:= $(64bit-tool-archpref)
 endif
 
 ifneq ($(SUBARCH),$(ARCH))
-- 
2.7.0
