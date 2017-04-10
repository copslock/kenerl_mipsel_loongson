Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Apr 2017 18:41:15 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:35810 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993915AbdDJQklwDb4J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Apr 2017 18:40:41 +0200
Received: from localhost (084035110146.static.ipv4.infopact.nl [84.35.110.146])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A9C00B7C;
        Mon, 10 Apr 2017 16:40:35 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Crispin <john@phrozen.org>,
        Daniel Golle <daniel@makrotopia.org>,
        linux-mips@linux-mips.org, James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 4.4 28/32] MIPS: ralink: Fix typos in rt3883 pinctrl
Date:   Mon, 10 Apr 2017 18:39:18 +0200
Message-Id: <20170410163843.206495624@linuxfoundation.org>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170410163839.055472822@linuxfoundation.org>
References: <20170410163839.055472822@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57639
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Crispin <john@phrozen.org>

commit 7c5a3d813050ee235817b0220dd8c42359a9efd8 upstream.

There are two copy & paste errors in the definition of the 5GHz LNA and
second ethernet pinmux.

Fixes: f576fb6a0700 ("MIPS: ralink: cleanup the soc specific pinmux data")
Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/15328/
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/ralink/rt3883.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/mips/ralink/rt3883.c
+++ b/arch/mips/ralink/rt3883.c
@@ -36,7 +36,7 @@ static struct rt2880_pmx_func uartlite_f
 static struct rt2880_pmx_func jtag_func[] = { FUNC("jtag", 0, 17, 5) };
 static struct rt2880_pmx_func mdio_func[] = { FUNC("mdio", 0, 22, 2) };
 static struct rt2880_pmx_func lna_a_func[] = { FUNC("lna a", 0, 32, 3) };
-static struct rt2880_pmx_func lna_g_func[] = { FUNC("lna a", 0, 35, 3) };
+static struct rt2880_pmx_func lna_g_func[] = { FUNC("lna g", 0, 35, 3) };
 static struct rt2880_pmx_func pci_func[] = {
 	FUNC("pci-dev", 0, 40, 32),
 	FUNC("pci-host2", 1, 40, 32),
@@ -44,7 +44,7 @@ static struct rt2880_pmx_func pci_func[]
 	FUNC("pci-fnc", 3, 40, 32)
 };
 static struct rt2880_pmx_func ge1_func[] = { FUNC("ge1", 0, 72, 12) };
-static struct rt2880_pmx_func ge2_func[] = { FUNC("ge1", 0, 84, 12) };
+static struct rt2880_pmx_func ge2_func[] = { FUNC("ge2", 0, 84, 12) };
 
 static struct rt2880_pmx_group rt3883_pinmux_data[] = {
 	GRP("i2c", i2c_func, 1, RT3883_GPIO_MODE_I2C),
