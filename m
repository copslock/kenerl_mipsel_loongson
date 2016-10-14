Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Oct 2016 11:19:37 +0200 (CEST)
Received: from mailapp02.imgtec.com ([217.156.133.132]:20983 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992105AbcJNJTUrTDdr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Oct 2016 11:19:20 +0200
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id 48A846BA14EE3;
        Fri, 14 Oct 2016 10:19:12 +0100 (IST)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by HHMAIL03.hh.imgtec.org
 (10.44.0.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 14 Oct 2016
 10:19:14 +0100
Received: from localhost (10.100.200.203) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 14 Oct
 2016 10:19:14 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 2/2] MIPS: malta: Fixup reboot
Date:   Fri, 14 Oct 2016 10:17:32 +0100
Message-ID: <20161014091732.27536-2-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161014091732.27536-1-paul.burton@imgtec.com>
References: <e50cd48c-e0c4-9bfc-b265-383a33eac569@roeck-us.net>
 <20161014091732.27536-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.203]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55429
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

Commit 10b6ea0959de ("MIPS: Malta: Use syscon-reboot driver to reboot")
converted the Malta board to use the generic syscon-reboot driver to
handle reboots, but incorrectly used the value 0x4d rather than 0x42 as
the magic to write to the reboot register.

I also incorrectly believed that syscon/regmap would default to native
endianness, but this isn't the case. Force this by specifying with a
native-endian property in the devicetree.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: 10b6ea0959de ("MIPS: Malta: Use syscon-reboot driver to reboot")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
Hi Guenter,

Apologies for that! Hopefully this fixes it up for you. I've tested QEMU
in both endiannesses & it now works for me, as well as real hardware.

Hi Ralf,

Apologies for the brokenness! Feel free to apply this as a fixup if it's
not too late, otherwise it would be great to get into mainline ASAP.
---
 arch/mips/boot/dts/mti/malta.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/mti/malta.dts b/arch/mips/boot/dts/mti/malta.dts
index 85468bf..48f696a 100644
--- a/arch/mips/boot/dts/mti/malta.dts
+++ b/arch/mips/boot/dts/mti/malta.dts
@@ -94,12 +94,13 @@
 	fpga_regs: system-controller@1f000000 {
 		compatible = "mti,malta-fpga", "syscon", "simple-mfd";
 		reg = <0x1f000000 0x1000>;
+		native-endian;
 
 		reboot {
 			compatible = "syscon-reboot";
 			regmap = <&fpga_regs>;
 			offset = <0x500>;
-			mask = <0x4d>;
+			mask = <0x42>;
 		};
 	};
 
-- 
2.10.0
