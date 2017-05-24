Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 May 2017 19:01:38 +0200 (CEST)
Received: from mout.web.de ([212.227.15.4]:59107 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994067AbdEXRB23REag (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 May 2017 19:01:28 +0200
Received: from [192.168.1.2] ([92.228.187.15]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MXSg2-1dQEpN13d0-00WaFS; Wed, 24
 May 2017 19:01:19 +0200
To:     linux-mips@linux-mips.org, John Crispin <john@phrozen.org>,
        =?UTF-8?Q?Ralf_B=c3=a4chle?= <ralf@linux-mips.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From:   SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] MIPS: ralink: Delete an error message for a failed memory
 allocation in rt_timer_probe()
Message-ID: <0e1ec180-eb78-144f-03fa-2843efe57670@users.sourceforge.net>
Date:   Wed, 24 May 2017 19:01:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:WW5YcbjdBqny5XfQYzBpmIOgrkJj+YUPQkBEXn0G+zIq5LCSE6f
 KiZueR11Q7/JN9yP4xII4PDXhGrRK5+pq4GkHSjddf0/We3uI8zkxKQd5MMRGiQ4PPPY4RU
 4e2+my89y5haris3/YbHxEXXMMlzNOxSN5G2oyZhAB3z/ajUhd7qExnfy/QvpKwRVoD+uBP
 HFYIXR4ZlQ4Vw7FHtTaHA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:h6siouhF2r0=:Zgm7bOcJzNlerF24DUEh9y
 HOVgB46EgTtmlyMREByYdcsQqeezFQMTZTVEkBJirETabPo8pWBK5mjswtGOQvqqO2Vv3wzi+
 L9TaRG6e1vdw1sHSOEekunfJrEHs7v+FJ7RQl3NnccegpDmDX91UTRmOB8tfOHpYWk+SDU2nM
 qEThuCr4G5OhRf5wEYtb4ugYQYGpqDaQ4sai8FGN/sJJQmFAFKOEwHex0mSJQ23J2Um6IxZWh
 XmUVLd1gcsEgqQk4v1/Hu+unWlhZeP/BzQq4AyMRmJwz3iWUL391UjFjZMj9g2Py6WmJaiVjz
 XD+ZisJmj5kplxjdnsohxzibsx+hLsejbjjd7ZgCnQX8j7cNLLf+L1BEECfFFjeJAEDrB7mnp
 GNbDazN+tEnCV1OldtQk7v94jrvnYdneJDbQwRPLIpIUcSs7MtqGlJsy7FR4hGJIctztcIiTC
 yAI47DoeJWEet8yYxgU8I7KiJAIJIzIlnDMcLqd0DOJj616tpF4mwRMvwgRfHf4SeqfUm8+LM
 r3en97rXPrE6W1hBeFZDmbIVB3AQKD71sABAm32ssPLEUVO8pcWX5OcmWWy1ss71Wv1ytZO0Z
 glRxDBczPoWGKD0IsScII00wA72AT0vpFfqrXhrXrOhbuBtBl0q5UblcCj4hb9cXWA9KCFhhu
 Id2dJ8e0GgP1tgRntcaE/qD1BFbMbpyKWD0VQXXAVdrbQWy4VpwQ/62OgkpBbM5j5Zh3+/VJ5
 MY5Z8gbp5fTssAUZW73RVvIJ6YN0/XhUp10WO+nGn+j49UnIhpdmPfOgfRKHloSJI7RrUJSCU
 nUkBUcm
Return-Path: <elfring@users.sourceforge.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57990
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
Date: Wed, 24 May 2017 18:56:35 +0200

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/mips/ralink/timer.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/mips/ralink/timer.c b/arch/mips/ralink/timer.c
index d4469b20d176..efccb444d6bc 100644
--- a/arch/mips/ralink/timer.c
+++ b/arch/mips/ralink/timer.c
@@ -103,10 +103,8 @@ static int rt_timer_probe(struct platform_device *pdev)
 	struct clk *clk;
 
 	rt = devm_kzalloc(&pdev->dev, sizeof(*rt), GFP_KERNEL);
-	if (!rt) {
-		dev_err(&pdev->dev, "failed to allocate memory\n");
+	if (!rt)
 		return -ENOMEM;
-	}
 
 	rt->irq = platform_get_irq(pdev, 0);
 	if (!rt->irq) {
-- 
2.13.0
