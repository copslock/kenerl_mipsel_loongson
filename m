Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Dec 2017 19:20:47 +0100 (CET)
Received: from mail-pf0-x243.google.com ([IPv6:2607:f8b0:400e:c00::243]:37977
        "EHLO mail-pf0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990421AbdLJSUh06m0- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 10 Dec 2017 19:20:37 +0100
Received: by mail-pf0-x243.google.com with SMTP id u25so9889047pfg.5;
        Sun, 10 Dec 2017 10:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=aYrcLpL5PtQRNd+EFsu9C9w3E7zmMfFGJfG4uOB3BJY=;
        b=iw0TGEJ6geohipMHqvN7VOju+v5J5Lh7BbOTd8cpUGhM5Fww9NFqtDIikKmf/J2ttQ
         r8rgPKO18imOYvTqfyGK1IregMVoDVUBSAsykcj/f51Mj1x7my/v/vCPC55RvqvNFh3f
         ZhyVhye3syizim0l4cStY41Mwdhhh8lldGGUGYcA7eIo7Sy3rdMC8oREG5N0Ur28EM32
         2tdGNS7L/oxgBiG0pvZPYpIBcpEmSkoZJ+3ZkFCojEUc+8bMHmL1bgIIgYupV0jqcLB3
         8cEOzYxopKfS1o74MQUAvm9/5BjEE8x2ACwBrvFM0eRLkZK48lYGtxnodKPNdBh7V/16
         IHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aYrcLpL5PtQRNd+EFsu9C9w3E7zmMfFGJfG4uOB3BJY=;
        b=S6J6MRVRluj+/krhUIF/AFf/so6ZKXwTOXUtj1y4t8ovJK00pzSIxKhmXfr1cdy6Ae
         4yp1FSV+2AcweS+gqBb7o4g5s5g0N+ELTng6tndcIA4JNCe/FiMZz6FSOGETl95cn+dK
         SfeLrryiWVIjdZUKT609ppqncMgNpDxwYh5icwrWWL/q81jvMnJSMcNyKTm5/ZKNslCd
         4a93cqblRSRJk9mXFDjcYZTV1tcTSDkaOD7T6K4vUTXlfaaMywkQnL/iXHI+nfdtsRVH
         XA3IFS3a/l2gLRIAakYe77ESylL2kMPoOfdtVmj9/IgG3xS5ZF+c7iUbsnn0C4LupZ2K
         A5nA==
X-Gm-Message-State: AKGB3mIzS+WAuz7wZgv1Yxlrj0ZZQvtnhKEN2n7a1y9c1wuIk7jhEGwB
        CVIMLDN8nxcq+hiJbOU97qVvV4Ab
X-Google-Smtp-Source: AGs4zMbfK8pw8PI78gL2B5BZMNEfehx6khcL66XOSzOOuSeyHi7iEdTB2i1tysX/zfbPmFHhnRgYUA==
X-Received: by 10.98.149.72 with SMTP id p69mr5002124pfd.76.1512930029013;
        Sun, 10 Dec 2017 10:20:29 -0800 (PST)
Received: from krishna-pc.photonmax3g.wifi ([49.200.244.9])
        by smtp.gmail.com with ESMTPSA id w19sm24817595pfa.127.2017.12.10.10.20.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 10 Dec 2017 10:20:28 -0800 (PST)
From:   Pravin Shedge <pravin.shedge4linux@gmail.com>
To:     ralf@linux-mips.org, jhogan@kernel.org, paul.burton@mips.com,
        Steven.Hill@cavium.com, alex.belits@cavium.com,
        linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, pravin.shedge4linux@gmail.com
Subject: [PATCH 35/45] arch/mips: remove duplicate includes
Date:   Sun, 10 Dec 2017 23:50:17 +0530
Message-Id: <1512930017-4573-1-git-send-email-pravin.shedge4linux@gmail.com>
X-Mailer: git-send-email 2.7.4
Return-Path: <pravin.shedge4linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61395
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pravin.shedge4linux@gmail.com
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

These duplicate includes have been found with scripts/checkincludes.pl but
they have been removed manually to avoid removing false positives.

Signed-off-by: Pravin Shedge <pravin.shedge4linux@gmail.com>
---
 arch/mips/mm/init.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 84b7b59..400676c 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -30,7 +30,6 @@
 #include <linux/hardirq.h>
 #include <linux/gfp.h>
 #include <linux/kcore.h>
-#include <linux/export.h>
 #include <linux/initrd.h>
 
 #include <asm/asm-offsets.h>
@@ -46,7 +45,6 @@
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
 #include <asm/fixmap.h>
-#include <asm/maar.h>
 
 /*
  * We have up to 8 empty zeroed pages so we can map one of the right colour
-- 
2.7.4
