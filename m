Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jan 2016 11:32:08 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:10392 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009270AbcASKb7EILpG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Jan 2016 11:31:59 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 89B4B841139A2;
        Tue, 19 Jan 2016 10:31:50 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Tue, 19 Jan 2016 10:31:52 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Tue, 19 Jan 2016 10:31:52 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Michal Marek <mmarek@suse.com>
CC:     <linux-kernel@vger.kernel.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        James Hogan <james.hogan@imgtec.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        <linux-kbuild@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mips@linux-mips.org>
Subject: [PATCH] kbuild: Remove stale asm-generic wrappers
Date:   Tue, 19 Jan 2016 10:31:43 +0000
Message-ID: <1453199503-30900-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <20160119100154.GJ30608@jhogan-linux.le.imgtec.org>
References: <20160119100154.GJ30608@jhogan-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51211
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

When a header file is removed from generic-y (often accompanied by the
addition of an arch specific header), the generated wrapper file will
persist, and in some cases may still take precedence over the new arch
header.

For example commit f1fe2d21f4e1 ("MIPS: Add definitions for extended
context") removed ucontext.h from generic-y in arch/mips/include/asm/,
and added an arch/mips/include/uapi/asm/ucontext.h. The continued use of
the wrapper when reusing a dirty build tree resulted in build failures
in arch/mips/kernel/signal.c:

arch/mips/kernel/signal.c: In function ‘sc_to_extcontext’:
arch/mips/kernel/signal.c:142:12: error: ‘struct ucontext’ has no member named ‘uc_extcontext’
  return &uc->uc_extcontext;
            ^

Fix by detecting wrapper headers in generated header directories that do
not correspond to a filename in generic-y, and removing them.

Reported-by: Jacek Anaszewski <j.anaszewski@samsung.com>
Reported-by: Hauke Mehrtens <hauke@hauke-m.de>
Reported-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Michal Marek <mmarek@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-kbuild@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-mips@linux-mips.org
---
 scripts/Makefile.asm-generic | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/scripts/Makefile.asm-generic b/scripts/Makefile.asm-generic
index 045e0098e962..7422f6476a8a 100644
--- a/scripts/Makefile.asm-generic
+++ b/scripts/Makefile.asm-generic
@@ -21,3 +21,19 @@ all: $(patsubst %, $(obj)/%, $(generic-y))
 
 $(obj)/%.h:
 	$(call cmd,wrap)
+
+# Remove stale wrappers when the corresponding files are removed from
+# generic-y
+
+quiet_cmd_rmwrap = REMOVE  $(patsubst %.rm,%,$@)
+cmd_rmwrap = rm -f $(patsubst %.rm, %, $@)
+
+all: $(filter-out $(patsubst %, $(obj)/%.rm, $(generic-y)), \
+                  $(patsubst %, %.rm, $(wildcard $(obj)/*.h)))
+
+$(obj)/%.h.rm: FORCE
+	$(call cmd,rmwrap)
+
+.PHONY: $(PHONY)
+PHONY += FORCE
+FORCE: ;
-- 
2.4.10
