Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 May 2017 22:52:52 +0200 (CEST)
Received: from mout.web.de ([212.227.15.4]:57073 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994961AbdEWUwlOCFEv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 23 May 2017 22:52:41 +0200
Received: from [192.168.1.2] ([78.49.50.198]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MDxFv-1dAnA927DD-00HRXp; Tue, 23
 May 2017 22:52:22 +0200
Subject: [PATCH 2/5] MIPS: smp-cps: Delete error messages for failed memory
 allocations in cps_prepare_cpus()
From:   SF Markus Elfring <elfring@users.sourceforge.net>
To:     linux-mips@linux-mips.org, Ingo Molnar <mingo@kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Kees Cook <keescook@chromium.org>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        =?UTF-8?Q?Ralf_B=c3=a4chle?= <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <e866716c-5ce4-3658-f944-e310007db127@users.sourceforge.net>
Message-ID: <3e8f04ae-8457-0531-e38e-0e682b99ed3f@users.sourceforge.net>
Date:   Tue, 23 May 2017 22:52:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <e866716c-5ce4-3658-f944-e310007db127@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:m34kLJpDdHW9AmSk1aJ3P+5DZSpxu/YjTp8w653DF8bBd6gOF3o
 1bEo6sqQxkHE2BKn7w3ibxdpBZ5ZQIkw/NrOi8+98zOmFXtA/4fyJxenqchiAdAb3I0Kmnx
 e0VlRl1eDEuV40+GHUNagL5a4pgTu3BqGB00MgTJOSeV6Rflr2zWosuGEKtOG40s+5f0Off
 DWFR3psOfh9Q/R0YL5dYA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mcGrjD4rc3Y=:d2+plXL91iQr0OBJjuEZfy
 7qQd09kOXjvOwaFmRtiIJbw4xpQl7x/Rjh57SvX4J0Sagwn/GeytCTINblbmyJ5V565Nye5St
 EFEtD4Woz8ictoFcLN+JAI3ZnU1iYQ2q1FX39mD9zK4DuzXkT3JPn7kxiG8bOcwxgY40wrTPT
 bxtfd8MloowFTuZj6rtl1/bHercMs5JRIi/AhsczWVEDtja7uPjZM0uanFewUu/GTTGcRIo4Y
 FnGD6dhuz+zhlo6oELqiZP5r4lRuMw4LL0t/wkfjSMEp/XnF+fHpLZIJU1pu4jzz1ReqbhnN/
 0BIzT0SOAKeuRxMYMkIgxOrysDxY1xFvYksVvogvdh53Aj171GwFkBMIwbfbjrdPhlPrqvylG
 T105BRFUw2lNrugL3r3hXqnNlWdxy5v0ZT+Ly0PqDw+6Zmk2zPik/7DP4XQ7lORE/+9X0uv0K
 657siaR55/kFjmk77ekq0M7xQnIoERzUi5Kw/RUI30ag1DDbOcHmp3o99rgXKrn8o5U9gri9P
 YKefdd0cUAGF4SbLxh528pd3LDzP3O83hM+reapwlDewNbo9L5IrYtIQqlvA8vuzYX9zx4RtU
 bu2HE5Vos5JGjq+njzm/s4VAD45olS2A2Dn5049C7Kzx1+CIZ9ZL19/kaf8zKoAU4XNibezt1
 vd2hcvvj3wJX8880twT29NMBumTfzO+oDj0i/8IwSY2CqO0vi6u/XpL0hZZqSx265ZzaKP6fY
 O4AxA0qp6GLAQ/VPXYjm0JQc04wbl/fmRNqEKjGRcYeMc8cgKM+f0gDvcxPUTpCeTdtjrtm0G
 xN98MAV
Return-Path: <elfring@users.sourceforge.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57960
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: elfring@users.sourceforge.net
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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 23 May 2017 21:41:32 +0200

Omit two extra messages for memory allocation failures in this function.

This issue was detected by using the Coccinelle software.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/mips/kernel/smp-cps.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index 36954ddd0b9f..bc8d7f6a62c2 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -171,7 +171,5 @@ static void __init cps_prepare_cpus(unsigned int max_cpus)
-	if (!mips_cps_core_bootcfg) {
-		pr_err("Failed to allocate boot config for %u cores\n", ncores);
+	if (!mips_cps_core_bootcfg)
 		goto err_out;
-	}
 
 	/* Allocate VPE boot configuration structs */
 	for (c = 0; c < ncores; c++) {
@@ -182,8 +180,5 @@ static void __init cps_prepare_cpus(unsigned int max_cpus)
-		if (!mips_cps_core_bootcfg[c].vpe_config) {
-			pr_err("Failed to allocate %u VPE boot configs\n",
-			       core_vpes);
+		if (!mips_cps_core_bootcfg[c].vpe_config)
 			goto err_out;
-		}
 	}
 
 	/* Mark this CPU as booted */
-- 
2.13.0
