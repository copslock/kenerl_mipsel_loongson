Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 May 2013 10:17:53 +0200 (CEST)
Received: from sauhun.de ([89.238.76.85]:45525 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823608Ab3EJIRunNZdc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 10 May 2013 10:17:50 +0200
Received: from p5b38793b.dip0.t-ipconnect.de ([91.56.121.59]:35487 helo=localhost)
        by pokefinder.org with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.69)
        (envelope-from <wsa@the-dreams.de>)
        id 1UaiWT-0001Fz-T0; Fri, 10 May 2013 10:17:50 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     linux-kernel@vger.kernel.org
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [RFC 40/42] arch/mips/lantiq/xway: don't check resource with devm_ioremap_resource
Date:   Fri, 10 May 2013 10:17:25 +0200
Message-Id: <1368173847-5661-41-git-send-email-wsa@the-dreams.de>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1368173847-5661-1-git-send-email-wsa@the-dreams.de>
References: <1368173847-5661-1-git-send-email-wsa@the-dreams.de>
Return-Path: <wsa@the-dreams.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36374
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wsa@the-dreams.de
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

devm_ioremap_resource does sanity checks on the given resource. No need to
duplicate this in the driver.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 arch/mips/lantiq/xway/gptu.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/mips/lantiq/xway/gptu.c b/arch/mips/lantiq/xway/gptu.c
index 9861c86..26226f0 100644
--- a/arch/mips/lantiq/xway/gptu.c
+++ b/arch/mips/lantiq/xway/gptu.c
@@ -143,13 +143,8 @@ static int gptu_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "Failed to get resource\n");
-		return -ENOMEM;
-	}
-
 	/* remap gptu register range */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	gptu_membase = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(gptu_membase))
 		return PTR_ERR(gptu_membase);
-- 
1.7.10.4
