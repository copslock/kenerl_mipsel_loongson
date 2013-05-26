Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 26 May 2013 09:52:56 +0200 (CEST)
Received: from intranet.asianux.com ([58.214.24.6]:43147 "EHLO
        intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822998Ab3EZHwtBSa-M (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 26 May 2013 09:52:49 +0200
Received: by intranet.asianux.com (Postfix, from userid 103)
        id 723DD18402BE; Sun, 26 May 2013 15:52:39 +0800 (CST)
Received: from [10.1.0.143] (unknown [219.143.36.82])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by intranet.asianux.com (Postfix) with ESMTP id 2E4261840257;
        Sun, 26 May 2013 15:52:39 +0800 (CST)
Message-ID: <51A1BF15.7070905@asianux.com>
Date:   Sun, 26 May 2013 15:51:49 +0800
From:   Chen Gang <gang.chen@asianux.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
MIME-Version: 1.0
To:     ralf@linux-mips.org, blogic@openwrt.org
CC:     linux-mips@linux-mips.org, Linux-Arch <linux-arch@vger.kernel.org>
Subject: [PATCH] arch: mips: lantiq: using strlcpy() instead of strncpy()
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <gang.chen@asianux.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36598
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gang.chen@asianux.com
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


'compatible' is used by strlen() in __of_device_is_compatible().

So for NUL terminated string, need always be sure of ended by zero.

'of_ids' is not a structure in "include/uapi/*", so not need initialize
all bytes, just use strlcpy() instead of strncpy().


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/mips/lantiq/prom.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
index 9f9e875..49c4603 100644
--- a/arch/mips/lantiq/prom.c
+++ b/arch/mips/lantiq/prom.c
@@ -112,7 +112,7 @@ int __init plat_of_setup(void)
 	if (!of_have_populated_dt())
 		panic("device tree not present");
 
-	strncpy(of_ids[0].compatible, soc_info.compatible,
+	strlcpy(of_ids[0].compatible, soc_info.compatible,
 		sizeof(of_ids[0].compatible));
 	strncpy(of_ids[1].compatible, "simple-bus",
 		sizeof(of_ids[1].compatible));
-- 
1.7.7.6
