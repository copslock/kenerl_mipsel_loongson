Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 May 2014 06:43:23 +0200 (CEST)
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36057 "EHLO
        mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822099AbaEGEnQMZcJG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 May 2014 06:43:16 +0200
Received: by mail-pa0-f43.google.com with SMTP id hz1so578576pad.30
        for <multiple recipients>; Tue, 06 May 2014 21:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=ThcEYEgJklxohcL+ceApUDGnx5SocgP3PTKcwk6aFbk=;
        b=marJvvsG9v2w1CPCqQL8lJ12OnMHzEYJXIHpxU55pVKRNkieKkialcWahLZZ3WN3YC
         bdgPMpHRdpsG7dQfPn4y0HnElHBPtxnEnS9r/lv6ZHhK3QhCe6VCuvyy0QrVR8MDSVrg
         /FdYpftdT/Ye4yrZbu2jMb+p/Cu9ujpWQcaB7cBkTwyftEWf+2FjgOylcYIph6YCT3yU
         k476wRAfNRPqhFgAnzaN33cgVboJtkDAcb6mvYsZBsrduCTOwIc/vqVKTQm3T2n9Eg1m
         eW0omA1L8Gc2ToenbC4rky7+L99gDUqCd54s14cF8z3FWJ1kgJNa9CqGsxL6xlWeNfm0
         EyGA==
X-Received: by 10.66.155.7 with SMTP id vs7mr14374392pab.42.1399437788769;
        Tue, 06 May 2014 21:43:08 -0700 (PDT)
Received: from localhost ([103.249.27.141])
        by mx.google.com with ESMTPSA id ak1sm691876pbc.58.2014.05.06.21.43.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 06 May 2014 21:43:07 -0700 (PDT)
Date:   Wed, 7 May 2014 10:13:03 +0530
From:   Himangi Saraogi <himangi774@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     julia.lawall@lip6.fr
Subject: [PATCH] MIPS: Introduce the use of the managed version of kzalloc
Message-ID: <20140507044211.GA3158@himangi-Dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <himangi774@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40037
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
functions.The labels out and out_mem are also removed as they are no
longer required.

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
---
 arch/mips/mti-sead3/sead3-i2c-drv.c | 37 ++++++++++++++-----------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/arch/mips/mti-sead3/sead3-i2c-drv.c b/arch/mips/mti-sead3/sead3-i2c-drv.c
index 1f787a6..4d72e0e 100644
--- a/arch/mips/mti-sead3/sead3-i2c-drv.c
+++ b/arch/mips/mti-sead3/sead3-i2c-drv.c
@@ -304,22 +304,18 @@ static int sead3_i2c_platform_probe(struct platform_device *pdev)
 	int ret;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!r) {
-		ret = -ENODEV;
-		goto out;
-	}
+	if (!r)
+		return -ENODEV;
 
-	priv = kzalloc(sizeof(struct pic32_i2c_platform_data), GFP_KERNEL);
-	if (!priv) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	priv = devm_kzalloc(&pdev->dev,
+			    sizeof(struct pic32_i2c_platform_data),
+			    GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
 
 	priv->base = r->start;
-	if (!priv->base) {
-		ret = -EBUSY;
-		goto out_mem;
-	}
+	if (!priv->base)
+		return -EBUSY;
 
 	priv->xfer_timeout = 200;
 	priv->ack_timeout = 200;
@@ -334,15 +330,11 @@ static int sead3_i2c_platform_probe(struct platform_device *pdev)
 	sead3_i2c_platform_setup(priv);
 
 	ret = i2c_add_numbered_adapter(&priv->adap);
-	if (ret == 0) {
-		platform_set_drvdata(pdev, priv);
-		return 0;
-	}
-
-out_mem:
-	kfree(priv);
-out:
-	return ret;
+	if (ret)
+		return ret;
+	
+	platform_set_drvdata(pdev, priv);
+	return 0;
 }
 
 static int sead3_i2c_platform_remove(struct platform_device *pdev)
@@ -351,7 +343,6 @@ static int sead3_i2c_platform_remove(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, NULL);
 	i2c_del_adapter(&priv->adap);
-	kfree(priv);
 	return 0;
 }
 
-- 
1.9.1
