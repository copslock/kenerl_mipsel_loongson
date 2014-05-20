Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 May 2014 20:09:58 +0200 (CEST)
Received: from mail-pb0-f44.google.com ([209.85.160.44]:59355 "EHLO
        mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822270AbaETSJ4GAX2Z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 May 2014 20:09:56 +0200
Received: by mail-pb0-f44.google.com with SMTP id rq2so554971pbb.17
        for <multiple recipients>; Tue, 20 May 2014 11:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=SpYBbxw0FnxIOEyTenX3YIpkgZVgkuSDrtN9+IMpQpM=;
        b=DqZ6bvbBkKUaUQ7Iz90QuhahynowK+sxl/hnPkINCe2pkhiesFVqD8BsBqcAkU0liK
         ipXa6VmXyvIXqCirh9XBE0ZsPyHMaECcq7GooGvZyYVimhx43TWE0B0qFjnVnzoALs5q
         eD7I2HCCHga5DMzj2ohnveIIX6cj7HQH7KWKMLhFMGlcBk+7r8dQTG+TxSwqaf74Je/Q
         CnUBEesddrb2Py2AVpsHo/cq9+CpxzLI0V/xPEztEk/P0Nh2AqiRpH9bo2ttdT4TQYuQ
         OQBC1xei/d0C5L6EqJiDwii9AgPadUIITzBhEZmusRg3CKA5K1tWEELiWYDvvwZ0MXJV
         V7Hw==
X-Received: by 10.66.124.163 with SMTP id mj3mr52685959pab.38.1400609389179;
        Tue, 20 May 2014 11:09:49 -0700 (PDT)
Received: from localhost ([182.65.218.65])
        by mx.google.com with ESMTPSA id qj3sm4204534pbc.91.2014.05.20.11.09.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 20 May 2014 11:09:48 -0700 (PDT)
Date:   Tue, 20 May 2014 23:39:42 +0530
From:   Himangi Saraogi <himangi774@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     julia.lawall@lip6.fr
Subject: [PATCH] MIPS: mti-sead3: Introduce the use of the managed version of
 kzalloc
Message-ID: <20140520180942.GA11445@himangi-Dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <himangi774@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40193
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: himangi774@gmail.com
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

This patch moves data allocated using kzalloc to managed data allocated
using devm_kzalloc and cleans now unnecessary kfrees in probe and remove
functions. Also, the now unnecessary labels out_mem and out are done
away with. The error handling code is moved under if and return 0 is now
at the end of the function.

The following Coccinelle semantic patch was used for making the change:

@platform@
identifier p, probefn, removefn;
@@
struct platform_driver p = {
  .probe = probefn,
  .remove = removefn,
};

@prb@
identifier platform.probefn, pdev;
expression e, e1, e2;
@@
probefn(struct platform_device *pdev, ...) {
  <+...
- e = kzalloc(e1, e2)
+ e = devm_kzalloc(&pdev->dev, e1, e2)
  ...
?-kfree(e);
  ...+>
}

@rem depends on prb@
identifier platform.removefn;
expression e;
@@
removefn(...) {
  <...
- kfree(e);
  ...>
}

Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
Acked-by: Julia Lawall <julia.lawall@lip6.fr>
---
 arch/mips/mti-sead3/sead3-pic32-i2c-drv.c | 36 +++++++++++--------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/arch/mips/mti-sead3/sead3-pic32-i2c-drv.c b/arch/mips/mti-sead3/sead3-pic32-i2c-drv.c
index b921e5e..80fe194 100644
--- a/arch/mips/mti-sead3/sead3-pic32-i2c-drv.c
+++ b/arch/mips/mti-sead3/sead3-pic32-i2c-drv.c
@@ -312,16 +312,13 @@ static int i2c_platform_probe(struct platform_device *pdev)
 
 	pr_debug("i2c_platform_probe\n");
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!r) {
-		ret = -ENODEV;
-		goto out;
-	}
+	if (!r)
+		return -ENODEV;
 
-	priv = kzalloc(sizeof(struct i2c_platform_data), GFP_KERNEL);
-	if (!priv) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	priv = devm_kzalloc(&pdev->dev, sizeof(struct i2c_platform_data),
+			    GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
 
 	/* FIXME: need to allocate resource in PIC32 space */
 #if 0
@@ -330,10 +327,8 @@ static int i2c_platform_probe(struct platform_device *pdev)
 #else
 	priv->base = r->start;
 #endif
-	if (!priv->base) {
-		ret = -EBUSY;
-		goto out_mem;
-	}
+	if (!priv->base)
+		return -EBUSY;
 
 	priv->xfer_timeout = 200;
 	priv->ack_timeout = 200;
@@ -348,17 +343,13 @@ static int i2c_platform_probe(struct platform_device *pdev)
 	i2c_platform_setup(priv);
 
 	ret = i2c_add_numbered_adapter(&priv->adap);
-	if (ret == 0) {
-		platform_set_drvdata(pdev, priv);
-		return 0;
+	if (ret) {
+		i2c_platform_disable(priv);
+		return ret;
 	}
 
-	i2c_platform_disable(priv);
-
-out_mem:
-	kfree(priv);
-out:
-	return ret;
+	platform_set_drvdata(pdev, priv);
+	return 0;
 }
 
 static int i2c_platform_remove(struct platform_device *pdev)
@@ -369,7 +360,6 @@ static int i2c_platform_remove(struct platform_device *pdev)
 	platform_set_drvdata(pdev, NULL);
 	i2c_del_adapter(&priv->adap);
 	i2c_platform_disable(priv);
-	kfree(priv);
 	return 0;
 }
 
-- 
1.9.1
