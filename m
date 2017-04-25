Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Apr 2017 19:25:04 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:37263 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993927AbdDYRYyWZVL3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Apr 2017 19:24:54 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 03831F034F287;
        Tue, 25 Apr 2017 18:24:44 +0100 (IST)
Received: from HHMAIL-X.hh.imgtec.org (10.100.10.113) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 25 Apr 2017 18:24:47 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by HHMAIL-X.hh.imgtec.org
 (10.100.10.113) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 25 Apr
 2017 18:24:47 +0100
Received: from BADAG02.ba.imgtec.org ([fe80::612d:e977:c603:32d6]) by
 bamail02.ba.imgtec.org ([::1]) with mapi id 14.03.0266.001; Tue, 25 Apr 2017
 10:24:44 -0700
From:   Petar Jovanovic <Petar.Jovanovic@imgtec.com>
To:     Petar Jovanovic <petar.jovanovic@rt-rk.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "david.daney@cavium.com" <david.daney@cavium.com>
Subject: RE: [PATCH] MIPS: Octeon: Expose support for mips32r1, mips32r2 and
 mips64r1
Thread-Topic: [PATCH] MIPS: Octeon: Expose support for mips32r1, mips32r2
 and mips64r1
Thread-Index: AQHSnbX++bP4lnkFiE+wD6odSKTYpKG3hZqAgB8Qjxg=
Date:   Tue, 25 Apr 2017 17:24:43 +0000
Message-ID: <56EA75BA695AE044ACFB41322F6D2BF4013D036343@BADAG02.ba.imgtec.org>
References: <1489600751-82884-1-git-send-email-petar.jovanovic@rt-rk.com>,<001b01d2ae25$d7554b80$85ffe280$@rt-rk.com>
In-Reply-To: <001b01d2ae25$d7554b80$85ffe280$@rt-rk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [89.216.37.146]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Petar.Jovanovic@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57788
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Petar.Jovanovic@imgtec.com
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

ping
________________________________________
From: Petar Jovanovic [petar.jovanovic@rt-rk.com]
Sent: Wednesday, April 05, 2017 6:01 PM
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org; david.daney@cavium.com; Petar Jovanovic
Subject: RE: [PATCH] MIPS: Octeon: Expose support for mips32r1, mips32r2 and mips64r1

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
