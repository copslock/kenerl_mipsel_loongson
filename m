Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jan 2015 15:44:45 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:41469 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012311AbbA3Oo3DjoBG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Jan 2015 15:44:29 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id D54CBB7D56ED6
        for <linux-mips@linux-mips.org>; Fri, 30 Jan 2015 14:44:20 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 30 Jan 2015 14:44:23 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.96) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Fri, 30 Jan 2015 14:44:22 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>
Subject: [PATCH 2/2] MIPS: Makefile: Set default ISA level
Date:   Fri, 30 Jan 2015 14:44:16 +0000
Message-ID: <1422629056-27715-2-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1422629056-27715-1-git-send-email-markos.chandras@imgtec.com>
References: <1422629056-27715-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45575
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

When we configure the toolchain, we can set the default
ISA level to be used when none is set in the command line.
This, however, has some undesired consequences when the parameters
used in the command line are incompatible with the built-in ISA
level of the toolchain. In order to minimize such problems, we set
a good default ISA level if the Makefile hasn't set one for the
selected processor.

Cc: Matthew Fortune <Matthew.Fortune@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/Makefile | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 0608ec524d3d..a244fb311a37 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -226,6 +226,15 @@ cflags-y			+= -I$(srctree)/arch/mips/include/asm/mach-generic
 drivers-$(CONFIG_PCI)		+= arch/mips/pci/
 
 #
+# Don't trust the toolchain defaults. Use a sensible -march
+# option but only if we don't have one already.
+#
+ifeq (,$(findstring march=, $(cflags-y)))
+cflags-$(CONFIG_32BIT)			+= -march=mips32
+cflags-$(CONFIG_64BIT)			+= -march=mips64
+endif
+
+#
 # Automatically detect the build format. By default we choose
 # the elf format according to the load address.
 # We can always force a build with a 64-bits symbol format by
-- 
2.2.2
