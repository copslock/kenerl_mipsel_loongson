Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 May 2017 20:10:51 +0200 (CEST)
Received: from mout.web.de ([212.227.15.4]:52305 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994768AbdEWSKnNkJQ2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 23 May 2017 20:10:43 +0200
Received: from [192.168.1.2] ([78.49.50.198]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LwHmQ-1e1Hsz2ZhO-018293; Tue, 23
 May 2017 20:10:27 +0200
To:     linux-mips@linux-mips.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        David Daney <david.daney@cavium.com>,
        =?UTF-8?Q?Ralf_B=c3=a4chle?= <ralf@linux-mips.org>,
        "Steven J. Hill" <steven.hill@cavium.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From:   SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] MIPS: Octeon: Delete an error message for a failed memory
 allocation in octeon_irq_init_gpio()
Message-ID: <7995eb17-f2ec-54ad-f4d4-7b3dd8337d33@users.sourceforge.net>
Date:   Tue, 23 May 2017 20:10:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:j39+XGXSuomo5uwpI7Qvb7MpsauPrlwNtBj+HM+8pKmLKnb/Bnl
 O81nqmQ1UH2NYY1hsctJiVwJuTFchbRU3kCAze46/vN6zOvN0eP0G/ROO60OS+9tgNRZvVT
 iq30sJJajYDzmoFR7bcxH+P/ZuEL/NL3v1welbTPAtmbxHuhaJqLeSGSHTlWMD07Ey+A4X2
 GsCjZAtlXxy7CbTDBx6jA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pYMLSqaE4HI=:K+Xcmc2rxteF6DH9JwGnS8
 SNYsgghFnnGFA5nefY5HSfoYkzVmfYippCKm11NIvEWv/+pGapp9LbDfeAkfA7vEc7fvM9yj5
 WvINE5ok3Shwcf5ldJzzSmLSvrfka6jvn1IK03ido7nfOJL+iKlt8ohx260JlEJglEOwKgWUL
 qYp9F7+BpZdFZspGuJCzKDemfRoPRkKrZIuy9dRhkAD28VdE8KdE0QqBSUWadf5Vilbzbelec
 KqAn0BDvdokoBLB5gr38/WEQgxUwmaBi7+LW50C+40A5bYkykV3siI0Vu01sh+cEBazn3+4UA
 39kUS/SALdy/6tXScUz/J9d8tHt95REXIrIQJXuy21PImu/FYGNwLQN5XTVmYljetS8rkTjpC
 dPMyTcK094LHPD+hCdrDfDFHSPidH1PfPvGBwQBd5F7J1X4ulwneMu0hKLfvloObt4i+zGJl5
 erzPkuT1LZCxq3scOxHVfx/SPVp+erU2L6CSYQdM/f61tdMbwtVlcn5GFoRT/EvQnq6cGmMXO
 nSKsgLEIMaUBplWArNbz4CdSgSJJb3Gp2PzOqHBWJXN/UpAupIW6Qx+9oAf6Cy98nu3SqajHY
 yeC6o+LgO+/Z6TIus3DcgLQ1W+X7+VEUkOSDRGZw8kbg/ulXvQF2mVBTGfX3HYdRurdXuTKsW
 pRIfa0xEWuwcuRYtsOTWdBXOXvQzDu0ZpzY6gGX3BI3emsCiZF2tlWOnKMFK4RHIzuBFYtoLv
 hBDg3GHQ3wLekqn9JYgtTI68xh1chBn56iagK2osNp4YIWYvbQ68iDsOPqCDQ4GjKflAKQPCn
 35IMY7y
Return-Path: <elfring@users.sourceforge.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57951
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
Date: Tue, 23 May 2017 20:00:06 +0200

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/mips/cavium-octeon/octeon-irq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index c1eb1ff7c800..050c08ece5b6 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -1615,7 +1615,6 @@ static int __init octeon_irq_init_gpio(
 		irq_domain_add_linear(
 			gpio_node, 16, &octeon_irq_domain_gpio_ops, gpiod);
 	} else {
-		pr_warn("Cannot allocate memory for GPIO irq_domain.\n");
 		return -ENOMEM;
 	}
 
-- 
2.13.0
