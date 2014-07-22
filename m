Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2014 00:25:59 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:59041 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822197AbaGVWZz52J6U (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Jul 2014 00:25:55 +0200
Received: from c-67-160-228-185.hsd1.ca.comcast.net ([67.160.228.185] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.71)
        (envelope-from <kamal@canonical.com>)
        id 1X9iS9-0001eS-6p; Tue, 22 Jul 2014 22:22:33 +0000
Received: from kamal by fourier with local (Exim 4.82)
        (envelope-from <kamal@whence.com>)
        id 1X9iS7-0005CF-9a; Tue, 22 Jul 2014 15:22:31 -0700
From:   Kamal Mostafa <kamal@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     Leif Lindholm <leif.lindholm@linaro.org>,
        Grant Likely <grant.likely@linaro.org>,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        gaurav.minocha@alumni.ubc.ca, Ralf Baechle <ralf@linux-mips.org>,
        Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 3.8 029/116] MIPS: DTS: Fix missing device_type="memory" property in memory nodes
Date:   Tue, 22 Jul 2014 15:20:40 -0700
Message-Id: <1406067727-19683-30-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1406067727-19683-1-git-send-email-kamal@canonical.com>
References: <1406067727-19683-1-git-send-email-kamal@canonical.com>
X-Extended-Stable: 3.8
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41507
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kamal@canonical.com
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

3.8.13.27 -stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leif Lindholm <leif.lindholm@linaro.org>

commit 1d530fa42a317deca1c4a4780d18e2dbf316e0cb upstream.

A few platforms lack a 'device_type = "memory"' for their memory
nodes, relying on an old ppc quirk in order to discover its memory.
Add the missing data so that all parsing code can find memory nodes
correctly.

Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
Acked-by: John Crispin <blogic@openwrt.org>
Signed-off-by: Grant Likely <grant.likely@linaro.org>
Cc: linux-mips@linux-mips.org
Cc: devicetree@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: gaurav.minocha@alumni.ubc.ca
Patchwork: https://patchwork.linux-mips.org/patch/6989/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
[ kamal: backport to 3.8-stable: only lantiq/dts/easy50712.dts ]
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/lantiq/dts/easy50712.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/lantiq/dts/easy50712.dts b/arch/mips/lantiq/dts/easy50712.dts
index 68c1731..de53a1b 100644
--- a/arch/mips/lantiq/dts/easy50712.dts
+++ b/arch/mips/lantiq/dts/easy50712.dts
@@ -8,6 +8,7 @@
 	};
 
 	memory@0 {
+		device_type = "memory";
 		reg = <0x0 0x2000000>;
 	};
 
-- 
1.9.1
