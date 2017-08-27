Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Aug 2017 21:56:34 +0200 (CEST)
Received: from mail-lf0-x22c.google.com ([IPv6:2a00:1450:4010:c07::22c]:32929
        "EHLO mail-lf0-x22c.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23995079AbdH0T40LT3XV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 27 Aug 2017 21:56:26 +0200
Received: by mail-lf0-x22c.google.com with SMTP id y15so15286683lfd.0
        for <linux-mips@linux-mips.org>; Sun, 27 Aug 2017 12:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:user-agent:date:to:cc:subject:mime-version
         :content-disposition;
        bh=hqgIbfFzBoqE3Jf00o1qxQY5jW5m2Cqnj3W5z+bjDmM=;
        b=ORvJhERaTs08HFujA3oXj3Fiue4yxACnGctCyOJEiT1770V7wKK1A+QGmKPG+n2kTL
         NjvkDazTtZlQlsYc17rX2I5fO+J//so8+w0Gz89ZaZFuMjprrl7aItHrq7pZDkkOWTNU
         z9HshBfAYbFm1DlDbBGexuaMm4rHOLTqNgPDFV4N9x8UNZS1VBScgdpzzA7X4SptjLwj
         RG2TkYYxYjEp7M9umRRF04kZsWkAwm/3rh2TROGN+s87vX0/4aAMdQlrllReMU3ArKBG
         GtOq8gkbx0O0732wcQxqVNagapHURKB1lM17k6fGTWbDfSNkycicdTXLEVqBvqNiGRlV
         YIsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:user-agent:date:to:cc:subject
         :mime-version:content-disposition;
        bh=hqgIbfFzBoqE3Jf00o1qxQY5jW5m2Cqnj3W5z+bjDmM=;
        b=In6n67tIaBroSX9HmNyKgmp87syhwzuL8M2kwKnH9x7Dm2Td54kc2Oux7Fh1enqUvO
         zMouyogXrtsTdbpjigzR6r74jX38wanb5Hk6nsdh6ztdWWXf5q0HEg3QJPWLSz8VuUpT
         lzOu859N+7BkO1+yK6w/gidYKikLcma53DVX6bYZ6+qJRlZ9Ek7Uk49/kThCvYdPgL+1
         paB2gg+po4W9CpgRcqa+TMWoWxicQoft1+fQD3Q6Ar2trGziSeF9xeBcUVWRAB6Cbjq0
         t+rfGLGBEazD7GA0Um0OwEQBexf61g8zRS7EqzScW5aJ+p4NxzGuTny6MflQFH4tWwz/
         yEZA==
X-Gm-Message-State: AHYfb5jkUJLa1+3ps+m8QlLrJmbDqX7wkpzy/PBxM0BTDpP/wJlhsXzk
        YkncFqwd1wVcLQB3
X-Received: by 10.46.69.131 with SMTP id s125mr1959653lja.131.1503863778027;
        Sun, 27 Aug 2017 12:56:18 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.80.216])
        by smtp.gmail.com with ESMTPSA id d192sm2007659lfe.89.2017.08.27.12.56.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Aug 2017 12:56:16 -0700 (PDT)
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
X-Google-Original-From: "Sergei Shtylyov" <headless@wasted.cogentembedded.com>
Received: by wasted.cogentembedded.com (sSMTP sendmail emulation); Sun, 27 Aug 2017 22:56:13 +0300
Message-Id: <20170827195613.904715064@cogentembedded.com>
User-Agent: quilt/0.64
Date:   Sun, 27 Aug 2017 22:55:09 +0300
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tejun Heo <tj@kernel.org>,
        linux-ide@vger.kernel.org ("open list:LIBATA PATA DRIVERS")
Cc:     linux-mips@linux-mips.org,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH] pata_octeon_cf: use of_property_read_{bool|u32}()
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=pata_octeon_cf-use-of_property_read_-bool-u32.patch
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59828
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

The Octeon CF driver basically  open-codes of_property_read_{bool|u32}()
using  of_{find|get}_property() calls in its  probe() method.  Using the
modern DT APIs saves 2 LoCs and 16 bytes of object code (MIPS gcc 3.4.3).

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 drivers/ata/pata_octeon_cf.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

Index: libata/drivers/ata/pata_octeon_cf.c
===================================================================
--- libata.orig/drivers/ata/pata_octeon_cf.c
+++ libata/drivers/ata/pata_octeon_cf.c
@@ -840,7 +840,6 @@ static int octeon_cf_probe(struct platfo
 	struct property *reg_prop;
 	int n_addr, n_size, reg_len;
 	struct device_node *node;
-	const void *prop;
 	void __iomem *cs0;
 	void __iomem *cs1 = NULL;
 	struct ata_host *host;
@@ -850,7 +849,7 @@ static int octeon_cf_probe(struct platfo
 	void __iomem *base;
 	struct octeon_cf_port *cf_port;
 	int rv = -ENOMEM;
-
+	u32 bus_width;
 
 	node = pdev->dev.of_node;
 	if (node == NULL)
@@ -860,11 +859,10 @@ static int octeon_cf_probe(struct platfo
 	if (!cf_port)
 		return -ENOMEM;
 
-	cf_port->is_true_ide = (of_find_property(node, "cavium,true-ide", NULL) != NULL);
+	cf_port->is_true_ide = of_property_read_bool(node, "cavium,true-ide");
 
-	prop = of_get_property(node, "cavium,bus-width", NULL);
-	if (prop)
-		is_16bit = (be32_to_cpup(prop) == 16);
+	if (of_property_read_u32(node, "cavium,bus-width", &bus_width) == 0)
+		is_16bit = (bus_width == 16);
 	else
 		is_16bit = false;
 
