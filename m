Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Jan 2017 14:10:34 +0100 (CET)
Received: from smtpbguseast2.qq.com ([54.204.34.130]:54062 "EHLO
        smtpbguseast2.qq.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990513AbdADNK1F4CEr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Jan 2017 14:10:27 +0100
X-QQ-mid: Xesmtp20t1483535417tq3yx910q
Received: from Red54.com (unknown [183.39.159.125])
        by esmtp4.qq.com (ESMTP) with SMTP id 0
        for <linux-mips@linux-mips.org>; Wed, 04 Jan 2017 21:10:15 +0800 (CST)
X-QQ-SSF: 00000000000000000M104F00000000U
X-QQ-FEAT: 5gms5Di3ODgn5NY3k+JbADeNtlDe59P0i/U2D0eBLah2ngjpI6Aj24m+uvqFD
        5hgpZe8YGgJbNTb+7uE494ViqTQMOC1LA+l33JRBsczpULKKUEMiBcZk6znKAvRSjBmasKy
        R416w1MHFlJs0XANe3Kyvh/WkOlauUgUEU61nJSgBKq9qBD0hKgDcbLrlHfblUYEySDGgmT
        vGe8Sf/gA224ConxmADdfe0XPx6r+fa5Pk1aJ94NxhSYB83+i9fPXOITpJh9OsC3J5HCZix
        kXpa/+qg1aQiLn
X-QQ-GoodBg: 0
Received: by Red54.com (sSMTP sendmail emulation); Wed, 04 Jan 2017 21:10:15 +0800
Date:   Wed, 4 Jan 2017 21:10:15 +0800
From:   =?utf-8?B?6LCi6Ie06YKmIChYSUUgWmhpYmFuZyk=?= <Yeking@Red54.com>
To:     linux-mips@linux-mips.org
Subject: [PATCH] MIPS: Loongson: Return system type LOONGSON LS1
Message-ID: <20170104131015.GA20749@red54.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.7.2 (2016-11-26)
X-QQ-SENDSIZE: 520
Feedback-ID: Xesmtp:Red54.com:bgforeign:bgforeign1
X-QQ-Bgrelay: 1
Return-Path: <Yeking@Red54.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56154
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Yeking@Red54.com
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

Loongson 1 is a 32-bit MIPS CPU family with PRID 0x4220.

Signed-off-by: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
---
 arch/mips/loongson32/common/setup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/loongson32/common/setup.c b/arch/mips/loongson32/common/setup.c
index 5f7fb52b..d5890642 100644
--- a/arch/mips/loongson32/common/setup.c
+++ b/arch/mips/loongson32/common/setup.c
@@ -26,6 +26,8 @@ const char *get_system_type(void)
 		return "LOONGSON LS1B";
 #elif defined(CONFIG_LOONGSON1_LS1C)
 		return "LOONGSON LS1C";
+#else
+		return "LOONGSON LS1";
 #endif
 	default:
 		return "LOONGSON (unknown)";
-- 
2.11.0
