Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Feb 2017 11:16:23 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:7283 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993411AbdBMKQQomphb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Feb 2017 11:16:16 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 353384AACB8CC;
        Mon, 13 Feb 2017 10:16:03 +0000 (GMT)
Received: from WR-NOWAKOWSKI.kl.imgtec.org (10.80.2.5) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 13 Feb 2017 10:16:05 +0000
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>
CC:     Michal Marek <mmarek@suse.com>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Subject: [PATCH RESEND] Kbuild: add cpp_its_S in ksym_dep_filter
Date:   Mon, 13 Feb 2017 11:15:56 +0100
Message-ID: <1486980956-4733-1-git-send-email-marcin.nowakowski@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56786
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@imgtec.com
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

Add a new command cpp_its_S introduced in:
cf2a5e0bb4c6 ("MIPS: Support generating Flattened Image Trees (.itb)")
to ksym_dep_filter handler - otherwise a warning is produced during the
build of MIPS platforms (when vmlinux.*.itb target is chosen)

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
---
 scripts/Kbuild.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 1792198..d6ca649 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -284,7 +284,7 @@ ksym_dep_filter =                                                            \
 	    $(CPP) $(call flags_nodeps,c_flags) -D__KSYM_DEPS__ $< ;;        \
 	  as_*_S|cpp_s_S)                                                    \
 	    $(CPP) $(call flags_nodeps,a_flags) -D__KSYM_DEPS__ $< ;;        \
-	  boot*|build*|*cpp_lds_S|dtc|host*|vdso*) : ;;                      \
+	  boot*|build*|cpp_its_S|*cpp_lds_S|dtc|host*|vdso*) : ;;            \
 	  *) echo "Don't know how to preprocess $(1)" >&2; false ;;          \
 	esac | tr ";" "\n" | sed -rn 's/^.*=== __KSYM_(.*) ===.*$$/KSYM_\1/p'
 
-- 
2.7.4
