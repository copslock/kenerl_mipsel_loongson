Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Oct 2014 11:49:51 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:34609 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011673AbaJQJtt1rMup (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Oct 2014 11:49:49 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 0FC34DEFB1C2E
        for <linux-mips@linux-mips.org>; Fri, 17 Oct 2014 10:49:40 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 17 Oct 2014 10:49:42 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.141) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 17 Oct 2014 10:49:41 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH] MIPS: sibyte: Include the swarm subdir to the sb1250 LittleSur builds
Date:   Fri, 17 Oct 2014 10:49:38 +0100
Message-ID: <1413539378-4107-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.1.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.141]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43326
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

Fixes the following randconfig build problem:

arch/mips/built-in.o: In function `show_cpuinfo':
proc.c:(.text+0xde84): undefined reference to `get_system_type'
arch/mips/built-in.o: In function `sb1250_setup':
(.init.text+0x428): undefined reference to `get_system_type'
arch/mips/built-in.o: In function `setup_arch':
(.init.text+0x178c): undefined reference to `plat_mem_setup'
Makefile:930: recipe for target 'vmlinux' failed

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
Only compile tested.
---
 arch/mips/sibyte/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/sibyte/Makefile b/arch/mips/sibyte/Makefile
index c8ed2c807e69..455c40d6d625 100644
--- a/arch/mips/sibyte/Makefile
+++ b/arch/mips/sibyte/Makefile
@@ -25,3 +25,4 @@ obj-$(CONFIG_SIBYTE_RHONE)	+= swarm/
 obj-$(CONFIG_SIBYTE_SENTOSA)	+= swarm/
 obj-$(CONFIG_SIBYTE_SWARM)	+= swarm/
 obj-$(CONFIG_SIBYTE_BIGSUR)	+= swarm/
+obj-$(CONFIG_SIBYTE_LITTLESUR)	+= swarm/
-- 
2.1.2
