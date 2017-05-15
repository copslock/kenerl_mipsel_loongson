Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 May 2017 13:34:14 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:39937 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994788AbdEOLeIZdF7g convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 May 2017 13:34:08 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id A83C0FADEFA35;
        Mon, 15 May 2017 12:33:57 +0100 (IST)
Received: from HHMAIL-X.hh.imgtec.org (10.100.10.113) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 15 May 2017 12:34:00 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by HHMAIL-X.hh.imgtec.org
 (10.100.10.113) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 15 May
 2017 12:33:59 +0100
Received: from BADAG02.ba.imgtec.org ([fe80::612d:e977:c603:32d6]) by
 bamail02.ba.imgtec.org ([fe80::5efe:10.20.40.28%12]) with mapi id
 14.03.0266.001; Mon, 15 May 2017 04:33:57 -0700
From:   Petar Jovanovic <Petar.Jovanovic@imgtec.com>
To:     Petar Jovanovic <petar.jovanovic@rt-rk.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "david.daney@cavium.com" <david.daney@cavium.com>
Subject: RE: [PATCH] MIPS: Octeon: Expose support for mips32r1, mips32r2 and
 mips64r1
Thread-Topic: [PATCH] MIPS: Octeon: Expose support for mips32r1, mips32r2
 and mips64r1
Thread-Index: AQHSnbX++bP4lnkFiE+wD6odSKTYpKG3hZqAgB8QjxiAFMJoAIAKSgX9
Date:   Mon, 15 May 2017 11:33:56 +0000
Message-ID: <56EA75BA695AE044ACFB41322F6D2BF4013D048E49@BADAG02.ba.imgtec.org>
References: <1489600751-82884-1-git-send-email-petar.jovanovic@rt-rk.com>,<001b01d2ae25$d7554b80$85ffe280$@rt-rk.com>
 <56EA75BA695AE044ACFB41322F6D2BF4013D036343@BADAG02.ba.imgtec.org>,<002c01d2c80f$52e66060$f8b32120$@rt-rk.com>
In-Reply-To: <002c01d2c80f$52e66060$f8b32120$@rt-rk.com>
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
X-archive-position: 57892
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

Anyone? This small change has been on the list for two months now.
Thanks in advance.
________________________________________
From: Petar Jovanovic [petar.jovanovic@rt-rk.com]
Sent: Monday, May 08, 2017 5:25 PM
To: Petar Jovanovic; linux-mips@linux-mips.org
Cc: ralf@linux-mips.org; david.daney@cavium.com
Subject: RE: [PATCH] MIPS: Octeon: Expose support for mips32r1, mips32r2 and mips64r1

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
