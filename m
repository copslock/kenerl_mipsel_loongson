Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 May 2017 22:33:02 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:50648 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23995036AbdEWUcyUhoev (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 May 2017 22:32:54 +0200
Received: from localhost (LStLambert-658-1-235-21.w80-13.abo.wanadoo.fr [80.13.254.21])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 50E3E8D9;
        Tue, 23 May 2017 20:32:47 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@caviumnetworks.com>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.9 144/164] MIPS: Loongson-3: Select MIPS_L1_CACHE_SHIFT_6
Date:   Tue, 23 May 2017 22:09:21 +0200
Message-Id: <20170523200913.302131196@linuxfoundation.org>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170523200907.297534241@linuxfoundation.org>
References: <20170523200907.297534241@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57957
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

From: Huacai Chen <chenhc@lemote.com>

commit 17c99d9421695a0e0de18bf1e7091d859e20ec1d upstream.

Some newer Loongson-3 have 64 bytes cache lines, so select
MIPS_L1_CACHE_SHIFT_6.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Cc: John Crispin <john@phrozen.org>
Cc: Steven J . Hill <Steven.Hill@caviumnetworks.com>
Cc: Fuxin Zhang <zhangfx@lemote.com>
Cc: Zhangjin Wu <wuzhangjin@gmail.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/15755/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1368,6 +1368,7 @@ config CPU_LOONGSON3
 	select WEAK_ORDERING
 	select WEAK_REORDERING_BEYOND_LLSC
 	select MIPS_PGD_C0_CONTEXT
+	select MIPS_L1_CACHE_SHIFT_6
 	select GPIOLIB
 	help
 		The Loongson 3 processor implements the MIPS64R2 instruction
