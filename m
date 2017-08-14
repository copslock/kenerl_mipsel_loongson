Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Aug 2017 20:21:16 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:51938 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993945AbdHNSUQ7M5Hp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Aug 2017 20:20:16 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id E92AAC24CDF7F;
        Mon, 14 Aug 2017 19:20:06 +0100 (IST)
Received: from localhost (10.20.1.88) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 14 Aug 2017 19:20:10
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v2 5/8] MIPS: Prevent direct use of generic_defconfig
Date:   Mon, 14 Aug 2017 11:18:16 -0700
Message-ID: <20170814181819.7376-6-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.0
In-Reply-To: <20170814181819.7376-1-paul.burton@imgtec.com>
References: <20170814181819.7376-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.88]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59575
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

Using generic_defconfig directly is unlikely to be what a user actually
wants to do - it doesn't specify any particular ISA revision & it
doesn't enable any board or driver support, resulting in a largely
useless kernel.

Prevent users from using it directly, printing a helpful message to
point them in the right direction if they attempt to.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

Changes in v2: None

 arch/mips/Makefile | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 0e0aa64a9c88..3db0df37d66a 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -515,6 +515,19 @@ $(generic_defconfigs):
 #
 $(generic_config_dir)/%.config: ;
 
+#
+# Prevent direct use of generic_defconfig, which is intended to be used as the
+# basis of the various ISA-specific targets generated above.
+#
+.PHONY: generic_defconfig
+generic_defconfig:
+	$(Q)echo "generic_defconfig is not intended for direct use, but should instead be"
+	$(Q)echo "used via an ISA-specific target from the following list:"
+	$(Q)echo
+	$(Q)for cfg in $(generic_defconfigs); do echo "  $${cfg}"; done
+	$(Q)echo
+	$(Q)false
+
 #
 # Legacy defconfig compatibility - these targets used to be real defconfigs but
 # now that the boards have been converted to use the generic kernel they are
-- 
2.14.0
