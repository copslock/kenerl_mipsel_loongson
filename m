Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Mar 2017 15:37:21 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:33986 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993331AbdCPOeOgcoa0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Mar 2017 15:34:14 +0100
Received: from localhost (unknown [183.98.136.252])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7448BB49;
        Thu, 16 Mar 2017 14:34:07 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.9 07/44] MIPS: Update ip27_defconfig for SCSI_DH change
Date:   Thu, 16 Mar 2017 23:29:32 +0900
Message-Id: <20170316142926.290494351@linuxfoundation.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20170316142925.994282609@linuxfoundation.org>
References: <20170316142925.994282609@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57348
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit ea58fca1842a5dc410cae4167b01643db971a4e2 upstream.

Since linux-4.3, SCSI_DH is a bool symbol, causing a warning in
kernelci.org:

arch/mips/configs/ip27_defconfig:136:warning: symbol value 'm' invalid for SCSI_DH

This updates the defconfig to have the feature built-in.

Fixes: 086b91d052eb ("scsi_dh: integrate into the core SCSI code")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/15001/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/configs/ip27_defconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/configs/ip27_defconfig
+++ b/arch/mips/configs/ip27_defconfig
@@ -133,7 +133,7 @@ CONFIG_LIBFC=m
 CONFIG_SCSI_QLOGIC_1280=y
 CONFIG_SCSI_PMCRAID=m
 CONFIG_SCSI_BFA_FC=m
-CONFIG_SCSI_DH=m
+CONFIG_SCSI_DH=y
 CONFIG_SCSI_DH_RDAC=m
 CONFIG_SCSI_DH_HP_SW=m
 CONFIG_SCSI_DH_EMC=m
