Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Aug 2018 03:53:08 +0200 (CEST)
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36892 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994577AbeH1BxDcGvAq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Aug 2018 03:53:03 +0200
Received: by mail-oi0-f65.google.com with SMTP id p84-v6so20861oic.4;
        Mon, 27 Aug 2018 18:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FIlqiwbxmyq+1NLBpi9+7kMnKdv5zmm5EjPQT9vSv2A=;
        b=GG5NpquEhNr68nsypWD4rvse0ocUOyUrvXbytpgE4BGAaB9AQX5dz61jGHTa1us+Nd
         /S8b3z09ITDUVMKOhT2EQUnboZDpE0WgtzXRD04gTmAV8ky4Nj2bzJ3spLJ8jeZCdncT
         whOqUXOcjWrZRsDhFuexH0bKnTHIT/iIWcdJAJ5d9q9wTZ88k98ikIfGQGmliSWwnMDE
         4gArA4dmfcvj5eWs5klBzj1FVxhq1C3/RByKN6uybjZbGWj2Yeo4JwPv6IR3Q8kWjJGs
         Rs2DA8IfK4n/5Lu9lskCLPxv37Ks0FNzwEoBEfJxKXuSGgfMzG93cS+HxIODjnaxdVxO
         RA7Q==
X-Gm-Message-State: APzg51AkVv0Yz3q0OBpvQAfJs+mIPo7SiO9Wp6SD4FTlVi5FKqXnf8rp
        IClh33T0QojSIrHNPLjzog==
X-Google-Smtp-Source: ANB0VdaGHvNfUC9yw4DZrBNHnoHN9mDN4WXaFVI0RPtKz+ultWcUAUl0MO1GqJy/xBikvrqCm7bZjg==
X-Received: by 2002:aca:3a57:: with SMTP id h84-v6mr1072882oia.336.1535421177409;
        Mon, 27 Aug 2018 18:52:57 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id n71-v6sm1652696oig.48.2018.08.27.18.52.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 18:52:56 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        John Crispin <john@phrozen.org>, linux-mips@linux-mips.org
Subject: [PATCH] MIPS: Convert to using %pOFn instead of device_node.name
Date:   Mon, 27 Aug 2018 20:52:05 -0500
Message-Id: <20180828015252.28511-4-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65758
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: John Crispin <john@phrozen.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/mips/cavium-octeon/octeon-irq.c | 16 ++++++++--------
 arch/mips/netlogic/common/irq.c      | 14 +++++++-------
 arch/mips/ralink/cevt-rt3352.c       |  6 +++---
 arch/mips/ralink/ill_acc.c           |  2 +-
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index 8272d8c648ca..cc1d8525e651 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -1180,8 +1180,8 @@ static int octeon_irq_gpio_xlat(struct irq_domain *d,
 		type = IRQ_TYPE_LEVEL_LOW;
 		break;
 	default:
-		pr_err("Error: (%s) Invalid irq trigger specification: %x\n",
-		       node->name,
+		pr_err("Error: (%pOFn) Invalid irq trigger specification: %x\n",
+		       node,
 		       trigger);
 		type = IRQ_TYPE_LEVEL_LOW;
 		break;
@@ -2271,8 +2271,8 @@ static int __init octeon_irq_init_cib(struct device_node *ciu_node,
 
 	parent_irq = irq_of_parse_and_map(ciu_node, 0);
 	if (!parent_irq) {
-		pr_err("ERROR: Couldn't acquire parent_irq for %s\n",
-			ciu_node->name);
+		pr_err("ERROR: Couldn't acquire parent_irq for %pOFn\n",
+			ciu_node);
 		return -EINVAL;
 	}
 
@@ -2283,7 +2283,7 @@ static int __init octeon_irq_init_cib(struct device_node *ciu_node,
 
 	addr = of_get_address(ciu_node, 0, NULL, NULL);
 	if (!addr) {
-		pr_err("ERROR: Couldn't acquire reg(0) %s\n", ciu_node->name);
+		pr_err("ERROR: Couldn't acquire reg(0) %pOFn\n", ciu_node);
 		return -EINVAL;
 	}
 	host_data->raw_reg = (u64)phys_to_virt(
@@ -2291,7 +2291,7 @@ static int __init octeon_irq_init_cib(struct device_node *ciu_node,
 
 	addr = of_get_address(ciu_node, 1, NULL, NULL);
 	if (!addr) {
-		pr_err("ERROR: Couldn't acquire reg(1) %s\n", ciu_node->name);
+		pr_err("ERROR: Couldn't acquire reg(1) %pOFn\n", ciu_node);
 		return -EINVAL;
 	}
 	host_data->en_reg = (u64)phys_to_virt(
@@ -2299,8 +2299,8 @@ static int __init octeon_irq_init_cib(struct device_node *ciu_node,
 
 	r = of_property_read_u32(ciu_node, "cavium,max-bits", &val);
 	if (r) {
-		pr_err("ERROR: Couldn't read cavium,max-bits from %s\n",
-			ciu_node->name);
+		pr_err("ERROR: Couldn't read cavium,max-bits from %pOFn\n",
+			ciu_node);
 		return r;
 	}
 	host_data->max_bits = val;
diff --git a/arch/mips/netlogic/common/irq.c b/arch/mips/netlogic/common/irq.c
index f4961bc9a61d..cf33dd8a487e 100644
--- a/arch/mips/netlogic/common/irq.c
+++ b/arch/mips/netlogic/common/irq.c
@@ -291,7 +291,7 @@ static int __init xlp_of_pic_init(struct device_node *node,
 	/* we need a hack to get the PIC's SoC chip id */
 	ret = of_address_to_resource(node, 0, &res);
 	if (ret < 0) {
-		pr_err("PIC %s: reg property not found!\n", node->name);
+		pr_err("PIC %pOFn: reg property not found!\n", node);
 		return -EINVAL;
 	}
 
@@ -304,21 +304,21 @@ static int __init xlp_of_pic_init(struct device_node *node,
 				break;
 		}
 		if (socid == NLM_NR_NODES) {
-			pr_err("PIC %s: Node mapping for bus %d not found!\n",
-					node->name, bus);
+			pr_err("PIC %pOFn: Node mapping for bus %d not found!\n",
+					node, bus);
 			return -EINVAL;
 		}
 	} else {
 		socid = (res.start >> 18) & 0x3;
 		if (!nlm_node_present(socid)) {
-			pr_err("PIC %s: node %d does not exist!\n",
-							node->name, socid);
+			pr_err("PIC %pOFn: node %d does not exist!\n",
+							node, socid);
 			return -EINVAL;
 		}
 	}
 
 	if (!nlm_node_present(socid)) {
-		pr_err("PIC %s: node %d does not exist!\n", node->name, socid);
+		pr_err("PIC %pOFn: node %d does not exist!\n", node, socid);
 		return -EINVAL;
 	}
 
@@ -326,7 +326,7 @@ static int __init xlp_of_pic_init(struct device_node *node,
 		nlm_irq_to_xirq(socid, PIC_IRQ_BASE), PIC_IRQ_BASE,
 		&xlp_pic_irq_domain_ops, NULL);
 	if (xlp_pic_domain == NULL) {
-		pr_err("PIC %s: Creating legacy domain failed!\n", node->name);
+		pr_err("PIC %pOFn: Creating legacy domain failed!\n", node);
 		return -EINVAL;
 	}
 	pr_info("Node %d: IRQ domain created for PIC@%pR\n", socid, &res);
diff --git a/arch/mips/ralink/cevt-rt3352.c b/arch/mips/ralink/cevt-rt3352.c
index 92f284d2b802..61a08943eb2f 100644
--- a/arch/mips/ralink/cevt-rt3352.c
+++ b/arch/mips/ralink/cevt-rt3352.c
@@ -134,7 +134,7 @@ static int __init ralink_systick_init(struct device_node *np)
 	systick.dev.min_delta_ticks = 0x3;
 	systick.dev.irq = irq_of_parse_and_map(np, 0);
 	if (!systick.dev.irq) {
-		pr_err("%s: request_irq failed", np->name);
+		pr_err("%pOFn: request_irq failed", np);
 		return -EINVAL;
 	}
 
@@ -146,8 +146,8 @@ static int __init ralink_systick_init(struct device_node *np)
 
 	clockevents_register_device(&systick.dev);
 
-	pr_info("%s: running - mult: %d, shift: %d\n",
-			np->name, systick.dev.mult, systick.dev.shift);
+	pr_info("%pOFn: running - mult: %d, shift: %d\n",
+			np, systick.dev.mult, systick.dev.shift);
 
 	return 0;
 }
diff --git a/arch/mips/ralink/ill_acc.c b/arch/mips/ralink/ill_acc.c
index 765d5ba98fa2..fc056f2acfeb 100644
--- a/arch/mips/ralink/ill_acc.c
+++ b/arch/mips/ralink/ill_acc.c
@@ -62,7 +62,7 @@ static int __init ill_acc_of_setup(void)
 
 	pdev = of_find_device_by_node(np);
 	if (!pdev) {
-		pr_err("%s: failed to lookup pdev\n", np->name);
+		pr_err("%pOFn: failed to lookup pdev\n", np);
 		return -EINVAL;
 	}
 
-- 
2.17.1
