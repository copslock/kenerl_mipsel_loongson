Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Dec 2017 18:48:26 +0100 (CET)
Received: from mout.web.de ([212.227.15.3]:57572 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990412AbdLJRsTKG6s- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 10 Dec 2017 18:48:19 +0100
Received: from [192.168.1.3] ([77.182.0.113]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M6DjG-1fHhC43JVa-00yAoi; Sun, 10
 Dec 2017 18:48:11 +0100
To:     linux-mips@linux-mips.org,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        =?UTF-8?Q?Ralf_B=c3=a4chle?= <ralf@linux-mips.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From:   SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] TC: Delete an error message for a failed memory allocation in
 tc_bus_add_devices()
Message-ID: <bfb63956-346c-aa17-5b06-fbe19ff0a5e3@users.sourceforge.net>
Date:   Sun, 10 Dec 2017 18:48:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:McujoTB788FJuXRNq/BnD1/Gfui+daf9xZDAzeFxdXmslsG4zsy
 n3NBNZmD9VjeTz6a8+MmjU/GGiG40nTISXyAyQE4byUbQHegKHlKCXApi9eNSbnpbvr8y45
 AQVt57CEHs9jG3wYaYHQKKCjkCRwJpTVFI+3UnvCHnn8tpyoeCJtuCE8lkfTpGdtDMC7exH
 2aU+FVXLPEXYeXT8VFD/w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IhW8XMYxImo=:vlCTu/GhE22e6w2h0FW2Z7
 yTFNTo1kar6A1isXe+/dL1LQecAGCnWwzEt9DHusSB8cfjy5EIPa7LG8g49IjMidBuVp7oNYU
 TD1/H4a6j1z6PX3Y5EFcETYMM5dXPGJqRelO2XSvvqzfY8ZRxrymNjt34hhd8Z9db7/LxXdd5
 9nqGGKI8qdR1c0X6DVQUiIHYdDXKIxG0pvg0peqM75EIPlkmahIPN2J47dJRAeidHtvlLI4zL
 hs6bFiRUgYnBCJG/zrEjJtpHzkfOctWrKAyJEpHBkQcmQpx2IHPFEGqMCmWNx17g/Lc0OCWy+
 aWt6IOFoXMx2ZBSPd9zstcN9LLQkh/aeNcKN2WAcoSLp2Bp/hGurZJSnmLTS64yVlLkFouRXg
 6oje/E2Ptxbc6FC/6+tX33QlMp1mI0rEscvTXiLeLDiCmVSPVMTszzU+rTGrIx53+lSdlloie
 dueWAX61MYcs30XCMC7S+S6S6zP7ZDQh96MNdvCheTGfBJ8QeU3ZxPAHfv+fxgxUGSEfkrNTe
 /cshgLd05UiuDg/VxxGQEXbI1qN7WJc498oKUCGx/3izbml1cFPD4tGxvZw31RBYZtzQhi7G8
 7DtjqlLQhEhLgARzB0xvwn3MWToi5BOksJ2yVwMphPPihSa5L3zG/yuOFrjKC443ibGL/twMT
 wIHCXhDevf6aM6VP0nLuJv2RGhbpxDNMYsdyDDyCAQh6GRngfKweb3cEVGPCvwGfz5Ezm8lnA
 59xzWPZR1+SIUdJydqhx6EdxZfPU8JSoP1XImsFvQ3KQtDlasDfd8MejF1euxCEC+n2mi1EMu
 FtTdA9hK9mRO8HlLaR+cJenQwRDOVy4jAB40kg1Vd5VUl1HSMY=
Return-Path: <elfring@users.sourceforge.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61394
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
Date: Sun, 10 Dec 2017 18:42:42 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/tc/tc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tc/tc.c b/drivers/tc/tc.c
index 3be9519654e5..2deb3768a9f6 100644
--- a/drivers/tc/tc.c
+++ b/drivers/tc/tc.c
@@ -82,10 +82,9 @@ static void __init tc_bus_add_devices(struct tc_bus *tbus)
 
 		/* Found a board, allocate it an entry in the list */
 		tdev = kzalloc(sizeof(*tdev), GFP_KERNEL);
-		if (!tdev) {
-			pr_err("tc%x: unable to allocate tc_dev\n", slot);
+		if (!tdev)
 			goto out_err;
-		}
+
 		dev_set_name(&tdev->dev, "tc%x", slot);
 		tdev->bus = tbus;
 		tdev->dev.parent = &tbus->dev;
-- 
2.15.1
