Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 May 2017 18:43:21 +0200 (CEST)
Received: from mout.web.de ([212.227.15.3]:55687 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993953AbdEXQnNxOhAg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 May 2017 18:43:13 +0200
Received: from [192.168.1.2] ([92.228.187.15]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MSazE-1dLJAN0b3M-00RYfM; Wed, 24
 May 2017 18:42:59 +0200
To:     linux-mips@linux-mips.org, Paul Burton <paul.burton@imgtec.com>,
        =?UTF-8?Q?Ralf_B=c3=a4chle?= <ralf@linux-mips.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From:   SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] MIPS: Alchemy: Delete an error message for a failed memory
 allocation in alchemy_pci_probe()
Message-ID: <6ebb5193-239f-5c34-c5f6-2be8a2fa79a5@users.sourceforge.net>
Date:   Wed, 24 May 2017 18:42:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:Z4nSJyuirF5AvyZyWNTcYsleLikH/pfRylIban42vJEBOzISO7M
 793x7+bYdpheiVjGpsLkPL2VKaeWEheTttf4z7COhnA3VPwnIWhF/VoEDlyAP3hgekF4ct9
 tHWMis2Hf0A6/Amm3dTIKqTPcgXnAlUTR6mOo+ldnBE/jDoKNOIz3HiuXOyhyDg69hrvV4w
 QbMnV2VtIPSoumsiFKaQQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:x/gbEUgqO7A=:uc2CF+7LNkBWHkPerhgDFs
 yD3PvMP4sUSV9rfYGO7ZrWfuiPg0s7HEH4U36Fh2Z8SNCb5W6mg3urvyXZ405JBi2AvvQ/MQU
 oXLczCs0xJs6K/3takf3pAziSa2M39tg8dGSnZOBb8CNPgnxklz0VSbBgd/sNCR3d2Sv381kh
 YrSeUd0YpcByqdMjOHZr8LSm2yGp5lA3kUr1NVQlITP8xPuJ4gvSNcmFRgr7d3I+nEA0CnvZx
 zDTeCElG+XhRS8uHX/D9ThVh8NTojxo38G2AEMOQpmCEZ7UNVoer+2u1drP7twSZLxSTiYPk6
 AX5TwETE5q2qWungdjesQliiBTOSVDO3LyU6Y+0nVsIJeX/ur5SH/wIFGAScqru4OYCwoglrA
 av4uTnON8FWaJyDzyjGXzGSx/HKmqOoYAaeTNqgta1FSpjFIAN2pqiIWTFvzhA3q+NmU9fAdo
 AB1eCC2ZhJbKXYVizhIZxN5mMUrspb5q+oLMIk4EqTKp2hYbb/oHhz3I6h6Jo23UAiZ8FfDV5
 2rfVz8JRqUL8+hB9fW7rGqHRgLdEjPHgkWqdrVVcPlvOMmBDBoaCo+Xk/aa6Eb2bI38W5FxLK
 R89ZsdrF6IVVp+6hnPbYtzed0MM1UVPtgKSkD8rVo8763Zm62DRkrvgnF1HWmv93lIlpSrbcu
 qBEcGoZ6AaJ1T7r6GKQ94ABHw6Ks3ECctTjWspd7gSHpAPnelQrWfID5n4VfNea3QYaW7C+NW
 MXgYRgfoq5/eR4OkyTDi2U3AImA9D1qLcHBXfMXT3Bzht/6rp2p7yL6rzM44677oC2Uz5I+pv
 +gLIFAa
Return-Path: <elfring@users.sourceforge.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57989
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
Date: Wed, 24 May 2017 18:32:21 +0200

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/mips/pci/pci-alchemy.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/pci/pci-alchemy.c b/arch/mips/pci/pci-alchemy.c
index e99ca7702d8a..a58c3290bd4e 100644
--- a/arch/mips/pci/pci-alchemy.c
+++ b/arch/mips/pci/pci-alchemy.c
@@ -377,7 +377,6 @@ static int alchemy_pci_probe(struct platform_device *pdev)
 
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
 	if (!ctx) {
-		dev_err(&pdev->dev, "no memory for pcictl context\n");
 		ret = -ENOMEM;
 		goto out;
 	}
-- 
2.13.0
