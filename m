Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Feb 2017 10:27:42 +0100 (CET)
Received: from nbd.name ([IPv6:2a01:4f8:131:30e2::2]:56032 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992244AbdBTJ1d6am34 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 20 Feb 2017 10:27:33 +0100
From:   John Crispin <john@phrozen.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <john@phrozen.org>,
        Daniel Golle <daniel@makrotopia.org>
Subject: [PATCH] arch: mips: ralink: fix typo in pinctrl lna_g_func
Date:   Mon, 20 Feb 2017 10:27:31 +0100
Message-Id: <1487582851-39806-1-git-send-email-john@phrozen.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56873
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

There is a copy & paste error in the definition of the 5GHz LNA pinmux.

Tested-by: John Crispin <john@phrozen.org>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 arch/mips/ralink/rt3883.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/ralink/rt3883.c b/arch/mips/ralink/rt3883.c
index c4ffd43..f9025a0 100644
--- a/arch/mips/ralink/rt3883.c
+++ b/arch/mips/ralink/rt3883.c
@@ -35,7 +35,7 @@
 static struct rt2880_pmx_func jtag_func[] = { FUNC("jtag", 0, 17, 5) };
 static struct rt2880_pmx_func mdio_func[] = { FUNC("mdio", 0, 22, 2) };
 static struct rt2880_pmx_func lna_a_func[] = { FUNC("lna a", 0, 32, 3) };
-static struct rt2880_pmx_func lna_g_func[] = { FUNC("lna a", 0, 35, 3) };
+static struct rt2880_pmx_func lna_g_func[] = { FUNC("lna g", 0, 35, 3) };
 static struct rt2880_pmx_func pci_func[] = {
 	FUNC("pci-dev", 0, 40, 32),
 	FUNC("pci-host2", 1, 40, 32),
-- 
1.7.10.4
