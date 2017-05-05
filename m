Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 May 2017 21:50:59 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.126.130]:49464 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993941AbdEETtDM036p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 May 2017 21:49:03 +0200
Received: from wuerfel.lan ([78.42.17.5]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MHwWD-1d3hsZ3tkb-003faS; Fri, 05 May 2017 21:48:39 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     stable@vger.kernel.org, Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 3.16-stable 86/87] MIPS: TXx9: Delete an unused variable in tx4927_pcibios_setup
Date:   Fri,  5 May 2017 21:47:44 +0200
Message-Id: <20170505194745.3627137-87-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20170505194745.3627137-1-arnd@arndb.de>
References: <20170505194745.3627137-1-arnd@arndb.de>
X-Provags-ID: V03:K0:DnDlacf8V0vsrNNzUbm9t5pCckPEqgP4GiEMEJfStwmbTiFqS0P
 MLvDrM+LNHoXpWEzY53B1bktd94W+JHphP8b09eIBT1Nlcg15ZGjsq3ZrC0sw1SuK2W4Bc8
 35OEp4M2SxP+d22lneOUoV2+tApF1XXlkyzmKwCz+YQ5oT148SAEBnS3PpOX6tN/urJTig1
 qlvWGt8HRMhbwnvmG3TaQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:z5xSBdqGGiU=:Oi42b7lkrrbnBG9O5TEiip
 fq0lrm+s/53utNd8aMAwdxC7Qa1w0BPu6hw+iWjhRQx+YjJ6xfUC8qDrmkXnCHJtpgpxFdLUk
 HZUucZXId2UcWN9vsumJqbyljJpkJqrqkxACNjAjjV3MOD+5HUm2dY0Jq1Bqb7geonBk2mhRd
 29dJ+6C5F/AjJwqWdKz5gCgK18yuxc2zKYgd0yYJsrYIoALDVIaaIPOB5tP+nNrNlO4xaCPVl
 0JTWTz6Qt/OahQaOKxVM525btWzKpGurDRVocEgUe7gjgrVhL3ncG1jg+0y7oMAa8sBR+l0TY
 Pm31aLw0JFZwZFr8bd62mfrjZYfCocvIW9yN+qsxhgv/+hnNtiOlU2/UwetgpcO+rqsf3d1Fp
 XTw3I/TxsRj3gxjOYe/fDg3FGJSZHNUlrdus4ZQ2u20IWH7TLZcuMkuGQIpDvfd4JF2Up3ikT
 nb5xVralgwhJ4Qu/GhbuMURwSqkEBftsKnmXAeP7pJHNpE8N5uejGF1ysTCCI89CtntjLVJMh
 HsSnxB6ErnbxV0m265TT1JnY4XNYhTtzMerATYx7Ezl46t8c/6Zty27LeNQZ6RXX9pA8I5/kR
 V6lc/A+QXN6lXFNYwD/3zndkYNwyWwTfH7MxSfbjQTRJogpWgzp5h83GMaDPisG1WlAUPe5uH
 0nTpJB91Vhm0OcDqD42SGm7beOjb7BhEUctZykXhmXTJ6nIokYYoXZCMVUrscPVIGD/I=
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57857
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Commit 32a51c797870e434c2afbfe60399c6497fc524ed upstream.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/7216/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/pci/ops-tx4927.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/pci/ops-tx4927.c b/arch/mips/pci/ops-tx4927.c
index 0e046d82e4e3..d54ea93651ac 100644
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
2.9.0
