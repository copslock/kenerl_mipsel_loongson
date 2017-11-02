Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Nov 2017 11:45:33 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.150.244]:34025 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993310AbdKBKpVlSAhI convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 Nov 2017 11:45:21 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx30.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Thu, 02 Nov 2017 10:45:18 +0000
Received: from WR-NOWAKOWSKI.mipstec.com (192.168.159.207) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Thu, 2 Nov 2017 03:44:37 -0700
From:   Marcin Nowakowski <marcin.nowakowski@mips.com>
To:     <james.hogan@mips.com>, <linux-mips@linux-mips.org>
CC:     Marcin Nowakowski <marcin.nowakowski@mips.com>
Subject: [PATCH] Update email address for Marcin Nowakowski
Date:   Thu, 2 Nov 2017 11:45:11 +0100
Message-ID: <1509619511-29856-1-git-send-email-marcin.nowakowski@mips.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [192.168.159.207]
X-BESS-ID: 1509619517-637140-17701-473270-2
X-BESS-VER: 2017.12-r1710252241
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.51
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186511
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn'
        t match header 
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.01 BSF_SC0_SA_TO_FROM_DOMAIN_MATCH META: Sender Domain Matches Recipient Domain 
X-BESS-Outbound-Spam-Status: SCORE=0.51 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_RULE7568M, BSF_BESS_OUTBOUND, BSF_SC0_SA_TO_FROM_DOMAIN_MATCH
X-BESS-BRTS-Status: 1
Return-Path: <Marcin.Nowakowski@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60661
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@mips.com
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

MIPS is no longer part of Imagination Technologies and my @imgtec.com
address will soon stop working. Update any files containing my address
as well as the .mailmap to point to my new @mips.com address.

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@mips.com>
---
 .mailmap                         | 1 +
 arch/mips/generic/kexec.c        | 2 +-
 arch/mips/kernel/probes-common.h | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index c7b10ca..c788c5d 100644
--- a/.mailmap
+++ b/.mailmap
@@ -100,6 +100,7 @@ Leonid I Ananiev <leonid.i.ananiev@intel.com>
 Linas Vepstas <linas@austin.ibm.com>
 Linus Lüssing <linus.luessing@c0d3.blue> <linus.luessing@web.de>
 Linus Lüssing <linus.luessing@c0d3.blue> <linus.luessing@ascom.ch>
+Marcin Nowakowski <marcin.nowakowski@mips.com> <marcin.nowakowski@imgtec.com>
 Mark Brown <broonie@sirena.org.uk>
 Martin Kepplinger <martink@posteo.de> <martin.kepplinger@theobroma-systems.com>
 Martin Kepplinger <martink@posteo.de> <martin.kepplinger@ginzinger.com>
diff --git a/arch/mips/generic/kexec.c b/arch/mips/generic/kexec.c
index e9fb735..1ca409f 100644
--- a/arch/mips/generic/kexec.c
+++ b/arch/mips/generic/kexec.c
@@ -1,6 +1,6 @@
 /*
  * Copyright (C) 2016 Imagination Technologies
- * Author: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
+ * Author: Marcin Nowakowski <marcin.nowakowski@mips.com>
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
diff --git a/arch/mips/kernel/probes-common.h b/arch/mips/kernel/probes-common.h
index dd08e41..d2bf77b 100644
--- a/arch/mips/kernel/probes-common.h
+++ b/arch/mips/kernel/probes-common.h
@@ -1,6 +1,6 @@
 /*
  * Copyright (C) 2016 Imagination Technologies
- * Author: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
+ * Author: Marcin Nowakowski <marcin.nowakowski@mips.com>
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
-- 
2.7.4
