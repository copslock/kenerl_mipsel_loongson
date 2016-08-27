Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Aug 2016 20:16:22 +0200 (CEST)
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36774 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992608AbcH0SP6roWmj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 27 Aug 2016 20:15:58 +0200
Received: by mail-pf0-f195.google.com with SMTP id y134so6683233pfg.3;
        Sat, 27 Aug 2016 11:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pMyfyIUUJKqauYV7yktBSZS7rHAvulMfSSjt9I5CGgc=;
        b=Dqi0TeJa16/tm3tbFlWLtrm7Bj8bOgyMY2EoShptr/uVHQg2/QTIywdtLML49dWdxC
         0LVfDM2Bm2qy78lbZHqEdUjHGXZT+MPw9NcHOxKlD/cKMC6w1FzdQBV6MdqMvg9SypX9
         xYRwMaG484TeZ71+Xv3Sd1C5h+5y6HjEfSx1K1IbFEm+Xrgbw8rwu1F+CpPtPyDkXerk
         jG4Cz+kawTO8GMLcfmLFXNZV9U/EjC7D/NTv1QDkbo+Ifpm1CnNLD2WY93jelt5A1KTs
         o8tHwOYxxWD1P2qXHZyUEsc11j9ZNbeRXCd0oFjblp7ABnzYDJPtjIi2G8yIcavL6LAX
         y/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pMyfyIUUJKqauYV7yktBSZS7rHAvulMfSSjt9I5CGgc=;
        b=U1jo5BW+wyZyc21xqoyMEckq4dsnQZpU9cOkNSQIFTOUrm6PzCiFGC7EBwl4lC6wFH
         UdV/GuaSJHxnowBRqHlci7+ReDpOlcXY6VaFFuSlLe33upG1w8vBE73xbJNoyWYgljcU
         OXKa97MggDdnxw9LYfAD3bkD0i9vCZJnZLieUJVnKXcSyZbaMZiTNcrh6Xk5jVOhM1KB
         wfOGfXvT15AS8ORz3HHbSS2EMUcN1yQz+YP/jk7vwhYqrbb0Vw6C30AfGOrwIsm5qbtv
         enGXU0d2BFVACi/ljBR8fQaaGCU+EdzejxqAZ4VLMvfbUumSINOwf0VbGGLO2uixAH3k
         cwRg==
X-Gm-Message-State: AE9vXwNUaFiNUNaMCV2+yeSUWFurAQZDZQ1WYUIiORtd6Rd8tSLU6tP7w78d3YKW0RoANQ==
X-Received: by 10.98.49.198 with SMTP id x189mr17349703pfx.135.1472321752740;
        Sat, 27 Aug 2016 11:15:52 -0700 (PDT)
Received: from localhost.localdomain ([1.22.68.54])
        by smtp.gmail.com with ESMTPSA id y6sm37747529pav.1.2016.08.27.11.15.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 27 Aug 2016 11:15:52 -0700 (PDT)
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
To:     mpm@selenic.com, herbert@gondor.apana.org.au, robh+dt@kernel.org,
        mark.rutland@arm.com, ralf@linux-mips.org,
        gregkh@linuxfoundation.org, boris.brezillon@free-electrons.com,
        harvey.hunt@imgtec.com, prarit@redhat.com, f.fainelli@gmail.com,
        joshua.henderson@microchip.com, narmstrong@baylibre.com,
        linus.walleij@linaro.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org
Cc:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Subject: [PATCH v2 1/4] hw_random: jz4780-rng: Add devicetree bindings for RNG in JZ4780 SoC
Date:   Sat, 27 Aug 2016 23:44:54 +0530
Message-Id: <1472321697-3094-2-git-send-email-prasannatsmkumar@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1472321697-3094-1-git-send-email-prasannatsmkumar@gmail.com>
References: <1472321697-3094-1-git-send-email-prasannatsmkumar@gmail.com>
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54817
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prasannatsmkumar@gmail.com
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

Add devicetree bindings for hardware random number generator present in
Ingenic JZ4780 SoC.

Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/rng/ingenic,jz4780-rng.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rng/ingenic,jz4780-rng.txt

diff --git a/Documentation/devicetree/bindings/rng/ingenic,jz4780-rng.txt b/Documentation/devicetree/bindings/rng/ingenic,jz4780-rng.txt
new file mode 100644
index 0000000..03abf56
--- /dev/null
+++ b/Documentation/devicetree/bindings/rng/ingenic,jz4780-rng.txt
@@ -0,0 +1,12 @@
+Ingenic jz4780 RNG driver
+
+Required properties:
+- compatible : Should be "ingenic,jz4780-rng"
+- reg : Specifies base physical address and size of the registers.
+
+Example:
+
+rng: rng@100000D8 {
+	compatible = "ingenic,jz4780-rng";
+	reg = <0x100000D8 0x8>;
+};
-- 
2.5.0
