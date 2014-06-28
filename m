Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Jun 2014 16:57:24 +0200 (CEST)
Received: from mv-drv-hcb003.ocn.ad.jp ([118.23.109.133]:42501 "EHLO
        mv-drv-hcb003.ocn.ad.jp" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6859961AbaF1O5TId0uk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 Jun 2014 16:57:19 +0200
Received: from vcmba.ocn.ne.jp (localhost.localdomain [127.0.0.1])
        by mv-drv-hcb003.ocn.ad.jp (Postfix) with ESMTP id CF1515642D8;
        Sat, 28 Jun 2014 23:57:16 +0900 (JST)
Received: from anemo-PC-VJ22.flets-east.jp (p16146-ipngn402funabasi.chiba.ocn.ne.jp [180.58.11.146])
        by vcmba.ocn.ne.jp (Postfix) with ESMTP;
        Sat, 28 Jun 2014 23:57:16 +0900 (JST)
From:   Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH] MIPS: TXx9: delete an unused variable in tx4927_pcibios_setup
Date:   Sat, 28 Jun 2014 23:57:13 +0900
Message-Id: <1403967433-4157-1-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.7.9.5
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40905
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
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

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/pci/ops-tx4927.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/pci/ops-tx4927.c b/arch/mips/pci/ops-tx4927.c
index 0e046d8..d54ea93 100644
--- a/arch/mips/pci/ops-tx4927.c
+++ b/arch/mips/pci/ops-tx4927.c
@@ -199,8 +199,6 @@ static struct {
 
 char *tx4927_pcibios_setup(char *str)
 {
-	unsigned long val;
-
 	if (!strncmp(str, "trdyto=", 7)) {
 		u8 val = 0;
 		if (kstrtou8(str + 7, 0, &val) == 0)
-- 
1.7.9.5
