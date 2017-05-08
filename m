Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 May 2017 17:25:41 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:44011 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993911AbdEHPZebMGqC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 8 May 2017 17:25:34 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id AB4C21A495B;
        Mon,  8 May 2017 17:25:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkn153 (rtrkn153.domain.local [192.168.236.145])
        by mail.rt-rk.com (Postfix) with ESMTPSA id 94C871A4958;
        Mon,  8 May 2017 17:25:28 +0200 (CEST)
From:   "Petar Jovanovic" <petar.jovanovic@rt-rk.com>
To:     "'Petar Jovanovic'" <Petar.Jovanovic@imgtec.com>,
        <linux-mips@linux-mips.org>
Cc:     <ralf@linux-mips.org>, <david.daney@cavium.com>
References: <1489600751-82884-1-git-send-email-petar.jovanovic@rt-rk.com>,<001b01d2ae25$d7554b80$85ffe280$@rt-rk.com> <56EA75BA695AE044ACFB41322F6D2BF4013D036343@BADAG02.ba.imgtec.org>
In-Reply-To: <56EA75BA695AE044ACFB41322F6D2BF4013D036343@BADAG02.ba.imgtec.org>
Subject: RE: [PATCH] MIPS: Octeon: Expose support for mips32r1, mips32r2 and mips64r1
Date:   Mon, 8 May 2017 17:25:28 +0200
Message-ID: <002c01d2c80f$52e66060$f8b32120$@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQFk0u1L5Xxe++MwOaWf1NpDgdbVAQD+Q8JBAi8P7/eirQ4FEA==
Content-Language: en-us
Return-Path: <petar.jovanovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57861
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: petar.jovanovic@rt-rk.com
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

Can anyone take a look at this? Thank you.

-----Original Message-----
From: Petar Jovanovic [mailto:Petar.Jovanovic@imgtec.com] 
Sent: Tuesday, April 25, 2017 7:25 PM
To: Petar Jovanovic <petar.jovanovic@rt-rk.com>; linux-mips@linux-mips.org
Cc: ralf@linux-mips.org; david.daney@cavium.com
Subject: RE: [PATCH] MIPS: Octeon: Expose support for mips32r1, mips32r2 and
mips64r1

ping
________________________________________
From: Petar Jovanovic [petar.jovanovic@rt-rk.com]
Sent: Wednesday, April 05, 2017 6:01 PM
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org; david.daney@cavium.com; Petar Jovanovic
Subject: RE: [PATCH] MIPS: Octeon: Expose support for mips32r1, mips32r2 and
mips64r1

ping.

-----Original Message-----
From: Petar Jovanovic [mailto:petar.jovanovic@rt-rk.com]
Sent: Wednesday, March 15, 2017 6:59 PM
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org; david.daney@cavium.com; petar.jovanovic@imgtec.com;
Petar Jovanovic <petar.jovanovic@rt-rk.com>
Subject: [PATCH] MIPS: Octeon: Expose support for mips32r1, mips32r2 and
mips64r1

Define Cavium Octeon as a CPU that has support for mips32r1, mips32r2 and
mips64r1. This will affect show_cpuinfo() that will now correctly expose
mips32r1, mips32r2 and mips64r1 as supported ISAs.

Signed-off-by: Petar Jovanovic <petar.jovanovic@rt-rk.com>
---
 arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git
a/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
b/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
index bd8b9bb..a4f7986 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
@@ -46,9 +46,9 @@
 #define cpu_has_64bits         1
 #define cpu_has_octeon_cache   1
 #define cpu_has_saa            octeon_has_saa()
-#define cpu_has_mips32r1       0
-#define cpu_has_mips32r2       0
-#define cpu_has_mips64r1       0
+#define cpu_has_mips32r1       1
+#define cpu_has_mips32r2       1
+#define cpu_has_mips64r1       1
 #define cpu_has_mips64r2       1
 #define cpu_has_dsp            0
 #define cpu_has_dsp2           0
--
1.9.1

=
