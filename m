Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Apr 2017 12:58:01 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:33358 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993859AbdDPK5xqu8BS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 16 Apr 2017 12:57:53 +0200
Received: from localhost (LFbn-1-12060-104.w90-92.abo.wanadoo.fr [90.92.122.104])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2B0D1720;
        Sun, 16 Apr 2017 10:57:46 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 3.18 135/145] MIPS: ip27: Disable qlge driver in defconfig
Date:   Sun, 16 Apr 2017 12:50:28 +0200
Message-Id: <20170416080207.749803379@linuxfoundation.org>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170416080200.205458595@linuxfoundation.org>
References: <20170416080200.205458595@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57705
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit b617649468390713db1515ea79fc772d2eb897a8 upstream.

One of the last remaining failures in kernelci.org is for a gcc bug:

drivers/net/ethernet/qlogic/qlge/qlge_main.c:4819:1: error: insn does not satisfy its constraints:
drivers/net/ethernet/qlogic/qlge/qlge_main.c:4819:1: internal compiler error: in extract_constrain_insn, at recog.c:2190

This is apparently broken in gcc-6 but fixed in gcc-7, and I cannot
reproduce the problem here. However, it is clear that ip27_defconfig
does not actually need this driver as the platform has only PCI-X but
not PCIe, and the qlge adapter in turn is PCIe-only.

The driver was originally enabled in 2010 along with lots of other
drivers.

Fixes: 59d302b342e5 ("MIPS: IP27: Make defconfig useful again.")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/15197/
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/configs/ip27_defconfig |    1 -
 1 file changed, 1 deletion(-)

--- a/arch/mips/configs/ip27_defconfig
+++ b/arch/mips/configs/ip27_defconfig
@@ -206,7 +206,6 @@ CONFIG_MLX4_EN=m
 # CONFIG_MLX4_DEBUG is not set
 CONFIG_TEHUTI=m
 CONFIG_BNX2X=m
-CONFIG_QLGE=m
 CONFIG_SFC=m
 CONFIG_BE2NET=m
 CONFIG_LIBERTAS_THINFIRM=m
