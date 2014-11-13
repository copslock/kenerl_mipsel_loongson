Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Nov 2014 12:09:13 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:22054 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013600AbaKMLI5dOACN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Nov 2014 12:08:57 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 7AD04A0D55CB5;
        Thu, 13 Nov 2014 11:08:49 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 13 Nov 2014 11:08:51 +0000
Received: from raava.le.imgtec.org (192.168.154.64) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 13 Nov
 2014 11:08:51 +0000
From:   James Cowgill <James.Cowgill@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
        Huacai Chen <chenhc@lemote.com>,
        James Hogan <james.hogan@imgtec.com>,
        James Cowgill <James.Cowgill@imgtec.com>,
        <stable@vger.kernel.org>
Subject: [PATCH 2/2] mips: fix __node_distances undefined error on ip27
Date:   Thu, 13 Nov 2014 11:08:07 +0000
Message-ID: <1415876887-13957-2-git-send-email-James.Cowgill@imgtec.com>
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1415876887-13957-1-git-send-email-James.Cowgill@imgtec.com>
References: <1415876887-13957-1-git-send-email-James.Cowgill@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.64]
Return-Path: <James.Cowgill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44111
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

export the __node_distances symbol in the ip27 memory code to fix the
build error:

  Building modules, stage 2.
  MODPOST 311 modules
ERROR: "__node_distances" [drivers/block/nvme.ko] undefined!
scripts/Makefile.modpost:90: recipe for target '__modpost' failed

when building the kernel with:
 CONFIG_SGI_IP27=y
 CONFIG_BLK_DEV_NVME=m

Signed-off-by: James Cowgill <James.Cowgill@imgtec.com>
Cc: <stable@vger.kernel.org> # v3.15+
Reviewed-by: James Hogan <james.hogan@imgtec.com>
---
 arch/mips/sgi-ip27/ip27-memory.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/sgi-ip27/ip27-memory.c b/arch/mips/sgi-ip27/ip27-memory.c
index a95c00f..a304bcc 100644
--- a/arch/mips/sgi-ip27/ip27-memory.c
+++ b/arch/mips/sgi-ip27/ip27-memory.c
@@ -107,6 +107,7 @@ static void router_recurse(klrou_t *router_a, klrou_t *router_b, int depth)
 }
 
 unsigned char __node_distances[MAX_COMPACT_NODES][MAX_COMPACT_NODES];
+EXPORT_SYMBOL(__node_distances);
 
 static int __init compute_node_distance(nasid_t nasid_a, nasid_t nasid_b)
 {
-- 
2.1.3
