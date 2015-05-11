Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 May 2015 19:58:08 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:35753 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27027474AbbEKRzufKKOw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 May 2015 19:55:50 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4E25DBBF;
        Mon, 11 May 2015 17:55:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adrien Schildknecht <adrien+dev@schischi.me>, m@bues.ch,
        zajec5@gmail.com, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.0 22/72] SSB: fix Kconfig dependencies
Date:   Mon, 11 May 2015 10:54:28 -0700
Message-Id: <20150511175437.781872162@linuxfoundation.org>
X-Mailer: git-send-email 2.4.0
In-Reply-To: <20150511175437.112151861@linuxfoundation.org>
References: <20150511175437.112151861@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47319
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

4.0-stable review patch.  If anyone has any objections, please let me know.

------------------


From: Adrien Schildknecht <adrien+dev@schischi.me>

Commit 179fa46fb666c8f2aa2bbb1f3114d5d826d59d3d upstream.

The commit 21400f252a97 ("MIPS: BCM47XX: Make ssb init NVRAM instead of
bcm47xx polling it") introduces a dependency to SSB_SFLASH but did not
add it to the Kconfig.

drivers/ssb/driver_mipscore.c:216:36: error: 'struct ssb_mipscore' has no
member named 'sflash'
  struct ssb_sflash *sflash = &mcore->sflash;
                                    ^
drivers/ssb/driver_mipscore.c:249:12: error: dereferencing pointer to
incomplete type
  if (sflash->present) {
            ^

Signed-off-by: Adrien Schildknecht <adrien+dev@schischi.me>
Cc: m@bues.ch
Cc: zajec5@gmail.com
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/9598/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ssb/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/ssb/Kconfig
+++ b/drivers/ssb/Kconfig
@@ -130,6 +130,7 @@ config SSB_DRIVER_MIPS
 	bool "SSB Broadcom MIPS core driver"
 	depends on SSB && MIPS
 	select SSB_SERIAL
+	select SSB_SFLASH
 	help
 	  Driver for the Sonics Silicon Backplane attached
 	  Broadcom MIPS core.
