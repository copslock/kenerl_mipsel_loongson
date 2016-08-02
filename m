Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Aug 2016 13:12:16 +0200 (CEST)
Received: from mga11.intel.com ([192.55.52.93]:47695 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992951AbcHBLMJc1J5N (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 2 Aug 2016 13:12:09 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP; 02 Aug 2016 04:12:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,459,1464678000"; 
   d="scan'208";a="1006924119"
Received: from shsibuild003.sh.intel.com ([10.239.146.225])
  by orsmga001.jf.intel.com with ESMTP; 02 Aug 2016 04:12:00 -0700
From:   Baole Ni <baolex.ni@intel.com>
To:     ralf@linux-mips.org, fenghua.yu@intel.com, robert.jarzmik@free.fr,
        linux@armlinux.org.uk
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        chuansheng.liu@intel.com, baolex.ni@intel.com
Subject: [PATCH 0014/1285] Replace numeric parameter like 0444 with macro
Date:   Tue,  2 Aug 2016 18:34:21 +0800
Message-Id: <20160802103421.14690-1-baolex.ni@intel.com>
X-Mailer: git-send-email 2.9.2
Return-Path: <baolex.ni@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54395
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: baolex.ni@intel.com
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

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 arch/mips/txx9/generic/7segled.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/txx9/generic/7segled.c b/arch/mips/txx9/generic/7segled.c
index 566c58b..1fcd1ec 100644
--- a/arch/mips/txx9/generic/7segled.c
+++ b/arch/mips/txx9/generic/7segled.c
@@ -55,8 +55,8 @@ static ssize_t raw_store(struct device *dev,
 	return size;
 }
 
-static DEVICE_ATTR(ascii, 0200, NULL, ascii_store);
-static DEVICE_ATTR(raw, 0200, NULL, raw_store);
+static DEVICE_ATTR(ascii, S_IWUSR, NULL, ascii_store);
+static DEVICE_ATTR(raw, S_IWUSR, NULL, raw_store);
 
 static ssize_t map_seg7_show(struct device *dev,
 			     struct device_attribute *attr,
@@ -76,7 +76,7 @@ static ssize_t map_seg7_store(struct device *dev,
 	return size;
 }
 
-static DEVICE_ATTR(map_seg7, 0600, map_seg7_show, map_seg7_store);
+static DEVICE_ATTR(map_seg7, S_IRUSR | S_IWUSR, map_seg7_show, map_seg7_store);
 
 static struct bus_type tx_7segled_subsys = {
 	.name		= "7segled",
-- 
2.9.2
