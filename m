Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Oct 2017 10:57:59 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:52916 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993920AbdJFI5qfkgco (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Oct 2017 10:57:46 +0200
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0FA7C5B1;
        Fri,  6 Oct 2017 08:57:39 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        John Crispin <john@phrozen.org>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.4 28/50] MIPS: Lantiq: Fix another request_mem_region() return code check
Date:   Fri,  6 Oct 2017 10:53:16 +0200
Message-Id: <20171006083709.689541839@linuxfoundation.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171006083705.157012217@linuxfoundation.org>
References: <20171006083705.157012217@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60304
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

From: Arnd Bergmann <arnd@arndb.de>


[ Upstream commit 98ea51cb0c8ce009d9da1fd7b48f0ff1d7a9bbb0 ]

Hauke already fixed a couple of them, but one instance remains
that checks for a negative integer when it should check
for a NULL pointer:

arch/mips/lantiq/xway/sysctrl.c: In function 'ltq_soc_init':
arch/mips/lantiq/xway/sysctrl.c:473:19: error: ordered comparison of pointer with integer zero [-Werror=extra]

Fixes: 6e807852676a ("MIPS: Lantiq: Fix check for return value of request_mem_region()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: John Crispin <john@phrozen.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/15043/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/lantiq/xway/sysctrl.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/mips/lantiq/xway/sysctrl.c
+++ b/arch/mips/lantiq/xway/sysctrl.c
@@ -469,8 +469,8 @@ void __init ltq_soc_init(void)
 			panic("Failed to load xbar nodes from devicetree");
 		if (of_address_to_resource(np_xbar, 0, &res_xbar))
 			panic("Failed to get xbar resources");
-		if (request_mem_region(res_xbar.start, resource_size(&res_xbar),
-			res_xbar.name) < 0)
+		if (!request_mem_region(res_xbar.start, resource_size(&res_xbar),
+			res_xbar.name))
 			panic("Failed to get xbar resources");
 
 		ltq_xbar_membase = ioremap_nocache(res_xbar.start,
