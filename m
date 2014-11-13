Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Nov 2014 12:08:58 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:13971 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013596AbaKMLI4r3tSu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Nov 2014 12:08:56 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id B106137FAA84C;
        Thu, 13 Nov 2014 11:08:48 +0000 (GMT)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 13 Nov
 2014 11:08:50 +0000
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 13 Nov 2014 11:08:50 +0000
Received: from raava.le.imgtec.org (192.168.154.64) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 13 Nov
 2014 11:08:49 +0000
From:   James Cowgill <James.Cowgill@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
        Huacai Chen <chenhc@lemote.com>,
        James Hogan <james.hogan@imgtec.com>,
        James Cowgill <James.Cowgill@imgtec.com>,
        <stable@vger.kernel.org>
Subject: [PATCH 1/2] mips: fix __node_distances undefined error on loongson3
Date:   Thu, 13 Nov 2014 11:08:06 +0000
Message-ID: <1415876887-13957-1-git-send-email-James.Cowgill@imgtec.com>
X-Mailer: git-send-email 2.1.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.64]
Return-Path: <James.Cowgill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44110
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: James.Cowgill@imgtec.com
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

export the __node_distances symbol in the loongson3 numa code to fix the
build error:

  Building modules, stage 2.
  MODPOST 221 modules
ERROR: "__node_distances" [drivers/block/nvme.ko] undefined!
scripts/Makefile.modpost:90: recipe for target '__modpost' failed

when building the kernel with:
 CONFIG_CPU_LOONGSON3=y
 CONFIG_NUMA=y
 CONFIG_BLK_DEV_NVME=m

Signed-off-by: James Cowgill <James.Cowgill@imgtec.com>
Cc: <stable@vger.kernel.org> # v3.17+
Reviewed-by: James Hogan <james.hogan@imgtec.com>
---
 arch/mips/loongson/loongson-3/numa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/loongson/loongson-3/numa.c b/arch/mips/loongson/loongson-3/numa.c
index 37ed184..42323bc 100644
--- a/arch/mips/loongson/loongson-3/numa.c
+++ b/arch/mips/loongson/loongson-3/numa.c
@@ -33,6 +33,7 @@
 
 static struct node_data prealloc__node_data[MAX_NUMNODES];
 unsigned char __node_distances[MAX_NUMNODES][MAX_NUMNODES];
+EXPORT_SYMBOL(__node_distances);
 struct node_data *__node_data[MAX_NUMNODES];
 EXPORT_SYMBOL(__node_data);
 
-- 
2.1.3
