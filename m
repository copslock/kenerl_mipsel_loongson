Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Sep 2016 11:10:32 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:46425 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991061AbcI1JJpLf1XG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Sep 2016 11:09:45 +0200
Received: from localhost (unknown [89.202.203.52])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 039808D4;
        Wed, 28 Sep 2016 09:09:38 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        "Steven J . Hill" <Steven.Hill@caviumnetworks.com>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.4 66/73] MIPS: Add a missing ".set pop" in an early commit
Date:   Wed, 28 Sep 2016 11:05:36 +0200
Message-Id: <20160928090438.582695078@linuxfoundation.org>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20160928090434.509091655@linuxfoundation.org>
References: <20160928090434.509091655@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55275
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

From: Huacai Chen <chenhc@lemote.com>

commit 3cbc6fc9c99f1709203711f125bc3b79487aba06 upstream.

Commit 842dfc11ea9a21 ("MIPS: Fix build with binutils 2.24.51+") missing
a ".set pop" in macro fpu_restore_16even, so add it.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Acked-by: Manuel Lauss <manuel.lauss@gmail.com>
Cc: Steven J . Hill <Steven.Hill@caviumnetworks.com>
Cc: Fuxin Zhang <zhangfx@lemote.com>
Cc: Zhangjin Wu <wuzhangjin@gmail.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/14210/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/asmmacro.h |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/mips/include/asm/asmmacro.h
+++ b/arch/mips/include/asm/asmmacro.h
@@ -135,6 +135,7 @@
 	ldc1	$f28, THREAD_FPR28(\thread)
 	ldc1	$f30, THREAD_FPR30(\thread)
 	ctc1	\tmp, fcr31
+	.set	pop
 	.endm
 
 	.macro	fpu_restore_16odd thread
