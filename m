Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Apr 2015 16:08:44 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:50172 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026172AbbD0OHtAVtNF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Apr 2015 16:07:49 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id DC2F3175AD514;
        Mon, 27 Apr 2015 15:07:42 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 27 Apr 2015 15:07:45 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Mon, 27 Apr 2015 15:07:44 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 4/4] MIPS: Malta: Select 32bit DMA zone for 64-bit kernels
Date:   Mon, 27 Apr 2015 15:07:19 +0100
Message-ID: <1430143639-22580-5-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.0.5
In-Reply-To: <1430143639-22580-1-git-send-email-james.hogan@imgtec.com>
References: <1430143639-22580-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47092
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

Enable the 32-bit DMA zone for 64-bit Malta kernels so that devices with
32-bit coherent DMA masks aren't constrained to the low 16MB DMA zone,
which can easily be exhausted when there is lots of static kernel data
due to lock and RCU debugging.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index f5016656494f..3feebda50ea2 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -434,6 +434,7 @@ config MIPS_MALTA
 	select SYS_SUPPORTS_MULTITHREADING
 	select SYS_SUPPORTS_SMARTMIPS
 	select SYS_SUPPORTS_ZBOOT
+	select ZONE_DMA32 if 64BIT
 	help
 	  This enables support for the MIPS Technologies Malta evaluation
 	  board.
-- 
2.0.5
