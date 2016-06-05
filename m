Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Jun 2016 23:53:44 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:60444 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27042465AbcFEVw5vQT9p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 5 Jun 2016 23:52:57 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DEDFF83D;
        Sun,  5 Jun 2016 21:52:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J . Hill" <sjhill@realitydiluted.com>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.6 012/121] MIPS: Loongson-3: Fix build error after ld-version.sh modification
Date:   Sun,  5 Jun 2016 14:42:44 -0700
Message-Id: <20160605214418.082269264@linuxfoundation.org>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20160605214417.708509043@linuxfoundation.org>
References: <20160605214417.708509043@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53840
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

4.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huacai Chen <chenhc@lemote.com>

commit 820880cdba0137baff6cc0e828c3c418c363ae44 upstream.

Commit d5ece1cb074b2c ("Fix ld-version.sh to handle large 3rd version
part") modifies the ld version description. This causes a build error
on Loongson-3, so fix it.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Steven J . Hill <sjhill@realitydiluted.com>
Cc: Fuxin Zhang <zhangfx@lemote.com>
Cc: Zhangjin Wu <wuzhangjin@gmail.com>
Cc: Huacai Chen <chenhc@lemote.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/12890/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/loongson64/Platform |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/loongson64/Platform
+++ b/arch/mips/loongson64/Platform
@@ -31,7 +31,7 @@ cflags-$(CONFIG_CPU_LOONGSON3)	+= -Wa,--
 # can't easily be used safely within the kbuild framework.
 #
 ifeq ($(call cc-ifversion, -ge, 0409, y), y)
-  ifeq ($(call ld-ifversion, -ge, 22500000, y), y)
+  ifeq ($(call ld-ifversion, -ge, 225000000, y), y)
     cflags-$(CONFIG_CPU_LOONGSON3)  += \
       $(call cc-option,-march=loongson3a -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS64)
   else
