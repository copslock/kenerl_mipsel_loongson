Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Aug 2017 04:09:41 +0200 (CEST)
Received: from smtpbgbr2.qq.com ([54.207.22.56]:36223 "EHLO smtpbgbr2.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990517AbdHJCJciLa9C (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 10 Aug 2017 04:09:32 +0200
X-QQ-mid: bizesmtp4t1502330906ta8i1vbso
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Thu, 10 Aug 2017 10:07:19 +0800 (CST)
X-QQ-SSF: 01100000004000F0FMF0000A0000000
X-QQ-FEAT: /A5Igf99+LSO5Si8AZ21QzpUSIoYBQylLNNoVWnRRLp/ZGQJ+5qAX82Agcc9V
        XunKqTEZ0v2s0xSo3zrXzCK6uHrTPQ7044jlSR5e820X5mzjMsmPQI2Zjl1Xi8bcN7CaxLa
        RpHq1J1zRsCg/RHZDADIWUK6Wc4lxMJeuuMlwcGlMAIFTRfko5DCOYPBeglkNf2JKH/fFYT
        QMEQ8F30mNqtkXQnp6iqGUmiARNwHrmbVTjN15Gn60X61vd0Mr6KpZwi41/jkR8Ta9D5GqB
        hBVlgPUkgQYp1unMpcBWnUT7E=
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH 5/8] MIPS: Align kernel load address to 64KB
Date:   Thu, 10 Aug 2017 10:04:39 +0800
Message-Id: <1502330682-16812-4-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1502330682-16812-1-git-send-email-chenhc@lemote.com>
References: <1502330433-16670-1-git-send-email-chenhc@lemote.com>
 <1502330682-16812-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:lemote.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59467
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

KEXEC assume kernel align to PAGE_SIZE, and 64KB is the largest
PAGE_SIZE.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/boot/compressed/calc_vmlinuz_load_addr.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/mips/boot/compressed/calc_vmlinuz_load_addr.c b/arch/mips/boot/compressed/calc_vmlinuz_load_addr.c
index 37fe58c..1dcaef4 100644
--- a/arch/mips/boot/compressed/calc_vmlinuz_load_addr.c
+++ b/arch/mips/boot/compressed/calc_vmlinuz_load_addr.c
@@ -45,11 +45,10 @@ int main(int argc, char *argv[])
 	vmlinuz_load_addr = vmlinux_load_addr + vmlinux_size;
 
 	/*
-	 * Align with 16 bytes: "greater than that used for any standard data
-	 * types by a MIPS compiler." -- See MIPS Run Linux (Second Edition).
+	 * Align with 64KB: KEXEC assume kernel align to PAGE_SIZE
 	 */
 
-	vmlinuz_load_addr += (16 - vmlinux_size % 16);
+	vmlinuz_load_addr += (65536 - vmlinux_size % 65536);
 
 	printf("0x%llx\n", vmlinuz_load_addr);
 
-- 
2.7.0




