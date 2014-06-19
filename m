Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jun 2014 22:27:02 +0200 (CEST)
Received: from mail.savoirfairelinux.com ([209.172.62.77]:64282 "EHLO
        mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816676AbaFSU07DOQKJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Jun 2014 22:26:59 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.savoirfairelinux.com (Postfix) with ESMTP id A7C7AC96006;
        Thu, 19 Jun 2014 16:26:52 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
        by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3r5FVTCnJxsW; Thu, 19 Jun 2014 16:26:52 -0400 (EDT)
Received: from localhost (mtl.savoirfairelinux.net [208.88.110.46])
        by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 5A76EC96008;
        Thu, 19 Jun 2014 16:26:52 -0400 (EDT)
From:   Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>,
        John Crispin <blogic@openwrt.org>,
        Qais Yousef <Qais.Yousef@imgtec.com>
Cc:     linux-kernel@vger.kernel.org,
        Jerome Oufella <jerome.oufella@savoirfairelinux.com>,
        Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
Subject: [PATCH 1/1] MIPS: APRP: Fix an issue when device_create() fails.
Date:   Thu, 19 Jun 2014 16:30:23 -0400
Message-Id: <1403209823-6376-1-git-send-email-sebastien.bourdelin@savoirfairelinux.com>
X-Mailer: git-send-email 1.8.3.4
Return-Path: <sebastien.bourdelin@savoirfairelinux.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40640
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sebastien.bourdelin@savoirfairelinux.com
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

If a call to device_create() fails for a channel during the initialize
loop, we need to clean the devices entries already created before
leaving.

Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
---
 arch/mips/kernel/rtlx-cmp.c | 3 +++
 arch/mips/kernel/rtlx-mt.c  | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/mips/kernel/rtlx-cmp.c b/arch/mips/kernel/rtlx-cmp.c
index 758fb3c..d26dcc4 100644
--- a/arch/mips/kernel/rtlx-cmp.c
+++ b/arch/mips/kernel/rtlx-cmp.c
@@ -77,6 +77,9 @@ int __init rtlx_module_init(void)
 		dev = device_create(mt_class, NULL, MKDEV(major, i), NULL,
 				    "%s%d", RTLX_MODULE_NAME, i);
 		if (IS_ERR(dev)) {
+			while (i--)
+				device_destroy(mt_class, MKDEV(major, i));
+
 			err = PTR_ERR(dev);
 			goto out_chrdev;
 		}
diff --git a/arch/mips/kernel/rtlx-mt.c b/arch/mips/kernel/rtlx-mt.c
index 5a66b97..cb95470 100644
--- a/arch/mips/kernel/rtlx-mt.c
+++ b/arch/mips/kernel/rtlx-mt.c
@@ -103,6 +103,9 @@ int __init rtlx_module_init(void)
 		dev = device_create(mt_class, NULL, MKDEV(major, i), NULL,
 				    "%s%d", RTLX_MODULE_NAME, i);
 		if (IS_ERR(dev)) {
+			while (i--)
+				device_destroy(mt_class, MKDEV(major, i));
+
 			err = PTR_ERR(dev);
 			goto out_chrdev;
 		}
-- 
1.8.3.4
