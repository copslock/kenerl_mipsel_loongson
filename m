Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Mar 2015 13:36:57 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:57270 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27014635AbbCZMgzKJoBL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 Mar 2015 13:36:55 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t2QCatG4012137;
        Thu, 26 Mar 2015 13:36:55 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t2QCatIC012136;
        Thu, 26 Mar 2015 13:36:55 +0100
Date:   Thu, 26 Mar 2015 13:36:55 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH V8 7/8] MIPS: Loongson-3: Add chipset ACPI platform driver
Message-ID: <20150326123654.GC9705@linux-mips.org>
References: <1426213706-28542-1-git-send-email-chenhc@lemote.com>
 <1426213706-28542-2-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1426213706-28542-2-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46541
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Fri, Mar 13, 2015 at 10:28:26AM +0800, Huacai Chen wrote:

> This add south-bridge (SB700/SB710/SB800 chipset) ACPI platform driver
> for Loongson-3. This will be used by EC (Embedded Controller, used by
> laptops) driver and STR (Suspend To RAM).

No Kconfig options?  In commit 6/8 the Kconfig help text promises:

+++ b/drivers/platform/mips/Kconfig
@@ -0,0 +1,26 @@ 
+#
+# MIPS Platform Specific Drivers
+#
+
+menuconfig MIPS_PLATFORM_DEVICES
+	bool "MIPS Platform Specific Device Drivers"
+	default y
+	help
+	  Say Y here to get to see options for device drivers of various
+	  MIPS platforms, including vendor-specific netbook/laptop/desktop
+	  extension and hardware monitor drivers. This option itself does
+	  not add any kernel code.

Then this patch adds  loongson-specific code that will be built for all
MIPS platforms.  And it will fail to build for non-loongson platforms.

  Ralf
