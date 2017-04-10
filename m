Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Apr 2017 18:52:52 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:37808 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993979AbdDJQv4JfjjJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Apr 2017 18:51:56 +0200
Received: from localhost (084035110146.static.ipv4.infopact.nl [84.35.110.146])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 57A5FB79;
        Mon, 10 Apr 2017 16:51:49 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
        John Crispin <john@phrozen.org>, james.hogan@imgtec.com,
        arnd@arndb.de, sergei.shtylyov@cogentembedded.com,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.10 056/110] MIPS: Lantiq: fix missing xbar kernel panic
Date:   Mon, 10 Apr 2017 18:42:47 +0200
Message-Id: <20170410164204.363143528@linuxfoundation.org>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170410164201.247583164@linuxfoundation.org>
References: <20170410164201.247583164@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57653
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

4.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hauke Mehrtens <hauke@hauke-m.de>

commit 6ef90877eee63a0d03e83183bb44b64229b624e6 upstream.

Commit 08b3c894e565 ("MIPS: lantiq: Disable xbar fpi burst mode")
accidentally requested the resources from the pmu address region
instead of the xbar registers region, but the check for the return
value of request_mem_region() was wrong. Commit 98ea51cb0c8c ("MIPS:
Lantiq: Fix another request_mem_region() return code check") fixed the
check of the return value of request_mem_region() which made the kernel
panics.
This patch now makes use of the correct memory region for the cross bar.

Fixes: 08b3c894e565 ("MIPS: lantiq: Disable xbar fpi burst mode")
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Cc: John Crispin <john@phrozen.org>
Cc: james.hogan@imgtec.com
Cc: arnd@arndb.de
Cc: sergei.shtylyov@cogentembedded.com
Cc: john@phrozen.org
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/15751
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/lantiq/xway/sysctrl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/lantiq/xway/sysctrl.c
+++ b/arch/mips/lantiq/xway/sysctrl.c
@@ -467,7 +467,7 @@ void __init ltq_soc_init(void)
 
 		if (!np_xbar)
 			panic("Failed to load xbar nodes from devicetree");
-		if (of_address_to_resource(np_pmu, 0, &res_xbar))
+		if (of_address_to_resource(np_xbar, 0, &res_xbar))
 			panic("Failed to get xbar resources");
 		if (request_mem_region(res_xbar.start, resource_size(&res_xbar),
 			res_xbar.name) < 0)
