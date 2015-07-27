Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jul 2015 22:03:50 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:47120 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011425AbbG0UDOESkOX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Jul 2015 22:03:14 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 0E3A211FF417D;
        Mon, 27 Jul 2015 21:03:04 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 27 Jul 2015 21:03:07 +0100
Received: from localhost (10.100.200.213) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 27 Jul
 2015 21:03:07 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Guenter Roeck <linux@roeck-us.net>,
        Matthew Fortune <matthew.fortune@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        "Markos Chandras" <markos.chandras@imgtec.com>,
        <stable@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 15/16] MIPS: require O32 FP64 support for MIPS64 with O32 compat
Date:   Mon, 27 Jul 2015 12:58:26 -0700
Message-ID: <1438027107-24420-16-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1438027107-24420-1-git-send-email-paul.burton@imgtec.com>
References: <1438027107-24420-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.213]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48473
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

MIPS32r6 code requires FP64 (ie. FR=1) support. Building a kernel with
support for MIPS32r6 binaries but without support for O32 with FP64 is
therefore a problem which can lead to incorrectly executed userland.

CONFIG_MIPS_O32_FP64_SUPPORT is already selected when the kernel is
configured for MIPS32r6, but not when the kernel is configured for
MIPS64r6 with O32 compat support. Select CONFIG_MIPS_O32_FP64_SUPPORT in
such configurations to prevent building kernels which execute MIPS32r6
userland incorrectly.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: <stable@vger.kernel.org> # v4.0-
---

Changes in v2: None

 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index f501665..a3b1ffe 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1417,6 +1417,7 @@ config CPU_MIPS64_R6
 	select CPU_SUPPORTS_HIGHMEM
 	select CPU_SUPPORTS_MSA
 	select GENERIC_CSUM
+	select MIPS_O32_FP64_SUPPORT if MIPS32_O32
 	help
 	  Choose this option to build a kernel for release 6 or later of the
 	  MIPS64 architecture.  New MIPS processors, starting with the Warrior
-- 
2.4.6
