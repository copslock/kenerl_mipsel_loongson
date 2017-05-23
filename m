Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 May 2017 22:55:15 +0200 (CEST)
Received: from mout.web.de ([212.227.15.3]:49602 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23995044AbdEWUyz5m2Av (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 23 May 2017 22:54:55 +0200
Received: from [192.168.1.2] ([78.49.50.198]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LZvw5-1desrJ0d8X-00lorh; Tue, 23
 May 2017 22:54:20 +0200
Subject: [PATCH 4/5] MIPS: VPE: Improve a size determination in two functions
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
Message-ID: <cf85a732-6901-4eca-2848-71e35e7ce95d@users.sourceforge.net>
Date:   Tue, 23 May 2017 22:54:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <e866716c-5ce4-3658-f944-e310007db127@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:du0VG0Czw9aq+6FvXs7FtFcsyfnVG8uGC5wdJDWRn8QmDh/XlUW
 VtNs6H/1SYMx3NNin2RnQZfgjvXqaMOakpcGNVwjMS1o7D2JHxMizWSAeDesDZEjydXR7AH
 SZCBTEoa2SjiLlMVTWd0HuNpaAi6Sc86f28lyxf3qQT/Z9rjtsgSg8fzE36B/VC6B+lkiNR
 n4iP0qTd2AnCf1mX0aLLA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:O04vx4fOC1k=:dxLV0msjBnF7Y1Ea6P2Goz
 4apJDZFALpEh5UzbHCB4kX6Mev43kvTSe78SQkIItQVTNrhdf45v6Ghv+OcZnQK08tQrVladh
 dqa9SgKo5+wIlpnPxmtIAvM+PgkwMIRIsKDmPckahO29eakoj98aSpzJcNVfOUY+7yzn44oeZ
 NJdjLK9xgRgU6CR4g3HWxwBcpI0esONRyOjrM6WyHWTV0+7dOiPuEX/6nY+pW3cDsxDRXw2Ox
 fEzOG3j2ovP6NBVienTDLqAestx4p5+4+EuoWvvMKq2CdmLX2fBYeXmxPjliRkKWSStE8ap+J
 20h3rWrLJecrvi16somLnuKlxDyKR2eXY7p8w8VkWDf41znY3ub3dJK//b2ecS9qY41sG53JW
 vLlG3l+tObcnTQLpPyTl5tRYDrl13MO/Kpl88LwNS0dPO6ykmtHkWGb6qKvarwso0/M2ak2EB
 oUAH7j7suHvv/SJDwGXIy8WXj5h19HM3U7SCCAHqt0oXsCGU+Onegwqop7zxaHy4J6xiwX6AI
 CGTQmXQTw1ZPczJ/E2S4742znWVoiUVgfmMONSb20Sja3dxfpBA0F9lW6rcYnz/o6Pl4wMI9I
 Dc/d8kEKwJ4YsQP+eo//CMABqzymk3wWQUkpe2m+634emADvs1fK8ahb8emJMafLrghRiCGIY
 GfFTNAatOFjVj0acXAuNC78HQPridqdOFWHY8Kke0t8bCugGMXsaVOBwbAF+yUo8bNPx9x3eg
 lgi3d9kRzdud2kDq6oCKTIOvf4RpRx1EIaX8FXhZbSovaZk/hbtz+K1IKIJ0zaLpsrDj2WUdx
 lz9mKAH
Return-Path: <elfring@users.sourceforge.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57962
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
Date: Tue, 23 May 2017 22:04:17 +0200

Replace the specification of two data structures by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/mips/kernel/vpe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/vpe.c b/arch/mips/kernel/vpe.c
index 721b1523b740..ed019218496b 100644
--- a/arch/mips/kernel/vpe.c
+++ b/arch/mips/kernel/vpe.c
@@ -93,7 +93,7 @@ struct vpe *alloc_vpe(int minor)
 {
 	struct vpe *v;
 
-	v = kzalloc(sizeof(struct vpe), GFP_KERNEL);
+	v = kzalloc(sizeof(*v), GFP_KERNEL);
 	if (v == NULL)
 		goto out;
 
@@ -114,7 +114,7 @@ struct tc *alloc_tc(int index)
 {
 	struct tc *tc;
 
-	tc = kzalloc(sizeof(struct tc), GFP_KERNEL);
+	tc = kzalloc(sizeof(*tc), GFP_KERNEL);
 	if (tc == NULL)
 		goto out;
 
-- 
2.13.0
