Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jun 2016 20:34:55 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:49668 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27042350AbcFOSaW1aKpW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Jun 2016 20:30:22 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 5E69BDB3914CA;
        Wed, 15 Jun 2016 19:30:12 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 15 Jun 2016 19:30:16 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>
Subject: [PATCH 15/17] MIPS: Add define for Config.VI (virtual icache) bit
Date:   Wed, 15 Jun 2016 19:29:59 +0100
Message-ID: <1466015401-24433-16-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1466015401-24433-1-git-send-email-james.hogan@imgtec.com>
References: <1466015401-24433-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54069
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

The Config.VI bit specifies that the instruction cache is virtually
tagged, which is checked in c-r4k.c's probe_pcache(). Add a proper
definition for it in mipsregs.h and make use of it.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/mipsregs.h | 1 +
 arch/mips/mm/c-r4k.c             | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 8b1b37d50d15..def9d8d13f6e 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -533,6 +533,7 @@
 #define TX49_CONF_CWFON		(_ULCAST_(1) << 27)
 
 /* Bits specific to the MIPS32/64 PRA.	*/
+#define MIPS_CONF_VI		(_ULCAST_(1) <<  3)
 #define MIPS_CONF_MT		(_ULCAST_(7) <<	 7)
 #define MIPS_CONF_MT_TLB	(_ULCAST_(1) <<  7)
 #define MIPS_CONF_MT_FTLB	(_ULCAST_(4) <<  7)
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index ef7f925dd1b0..7a9c345e87e5 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1206,7 +1206,7 @@ static void probe_pcache(void)
 			      c->icache.linesz;
 		c->icache.waybit = __ffs(icache_size/c->icache.ways);
 
-		if (config & 0x8)		/* VI bit */
+		if (config & MIPS_CONF_VI)
 			c->icache.flags |= MIPS_CACHE_VTAG;
 
 		/*
-- 
2.4.10
