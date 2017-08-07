Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Aug 2017 01:03:44 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:50752 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23995126AbdHGXC4aMTdI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Aug 2017 01:02:56 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id E1652C1C12BCB;
        Tue,  8 Aug 2017 00:02:44 +0100 (IST)
Received: from localhost (10.20.1.88) by HHMAIL01.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 8 Aug 2017 00:02:49
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 4/7] MIPS: Prevent direct use of generic_defconfig
Date:   Mon, 7 Aug 2017 16:01:15 -0700
Message-ID: <20170807230119.10629-5-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.0
In-Reply-To: <20170807230119.10629-1-paul.burton@imgtec.com>
References: <20170807230119.10629-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.88]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59410
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

 arch/mips/Makefile | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index a715888179b3..b6f56e251f3b 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -501,6 +501,19 @@ $(generic_defconfigs):
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
