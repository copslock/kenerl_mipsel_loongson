Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Feb 2017 13:34:04 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:24728 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993896AbdBPMd6BvfG4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Feb 2017 13:33:58 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id D221EEB6C5CF0;
        Thu, 16 Feb 2017 12:33:48 +0000 (GMT)
Received: from ian-pozella.kl.imgtec.org (10.40.9.40) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 16 Feb 2017 12:33:51 +0000
From:   Ian Pozella <Ian.Pozella@imgtec.com>
To:     <ralf@linux-mips.org>, <James.Hogan@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Ian Pozella <Ian.Pozella@imgtec.com>
Subject: [PATCH] MIPS: DTS: add img directory to Makefile
Date:   Thu, 16 Feb 2017 12:33:30 +0000
Message-ID: <1487248410-9493-1-git-send-email-Ian.Pozella@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.40.9.40]
Return-Path: <Ian.Pozella@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56849
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Ian.Pozella@imgtec.com
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

An img directory exists for the Pistchio Soc but the directory
itself isn't in the dts Makefile meaning the dtbs never get built.

Signed-off-by: Ian Pozella <Ian.Pozella@imgtec.com>
---
 arch/mips/boot/dts/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
index fc7a0a9..b9db492 100644
--- a/arch/mips/boot/dts/Makefile
+++ b/arch/mips/boot/dts/Makefile
@@ -1,5 +1,6 @@
 dts-dirs	+= brcm
 dts-dirs	+= cavium-octeon
+dts-dirs	+= img
 dts-dirs	+= ingenic
 dts-dirs	+= lantiq
 dts-dirs	+= mti
-- 
2.7.4
