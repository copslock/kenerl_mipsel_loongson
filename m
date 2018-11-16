Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Nov 2018 23:12:13 +0100 (CET)
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38931 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990946AbeKPWLIj08K0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Nov 2018 23:11:08 +0100
Received: by mail-ot1-f67.google.com with SMTP id g27so22730384oth.6;
        Fri, 16 Nov 2018 14:11:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z20+2CzOTLX/2B946rI2J1ZHpCgM0oKasDbqmx4HY5Y=;
        b=WjCUiosl+WlMR6u30wa0Xh6Rpo2MnBonjMO7lcIRAvsTCj8ivw8543hYn61HyQAlvA
         c7O2TOa+J/5CLeU56EjftyyW6Lhot5y4B+khKZuOtez39MfFRMcUN5N4a+DFmz110FkS
         IYkziEqVBmShWl0GudYS1ullWO1ekCByegf8XQ5m4GkW+846vORmhGbd42DhjIWmoQD+
         Yytiqux+bGt84b6pBAEn0owknBWk51m9hYQoF3nHHuoZhUhEx48Vb+K1AgLYXJNZ0AnS
         Lw4Ml3eaTr101uffZ7hf0SlNFw5F/GVOAV3xpFJx/ytaEMXF1ZcsA15FSMv1+QG9WDU8
         rFcA==
X-Gm-Message-State: AGRZ1gJ1i6iFfbstAlXn5VTZCAYZIw/mBhpSgMzMVk8UY86DpbAE92Kb
        DTcXJzePZiqWJu04eCqfvQ==
X-Google-Smtp-Source: AJdET5eaxUPAckeT83rduY/9RFbvb2md1aAZb9TQgnWgNI3PhP1aqsTovP09yU1ErJeR+3XGal+APA==
X-Received: by 2002:a9d:118a:: with SMTP id v10mr7014258otf.281.1542406267698;
        Fri, 16 Nov 2018 14:11:07 -0800 (PST)
Received: from localhost.localdomain (mobile-166-173-57-127.mycingular.net. [166.173.57.127])
        by smtp.googlemail.com with ESMTPSA id p204-v6sm12142631oib.25.2018.11.16.14.11.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 14:11:07 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     James Hogan <jhogan@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>, linux-mips@linux-mips.org
Subject: [PATCH] MIPS: Use device_type helpers to access the node type
Date:   Fri, 16 Nov 2018 16:10:58 -0600
Message-Id: <20181116221104.23024-2-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67333
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

Remove directly accessing device_node.type pointer and use the accessors
instead. This will eventually allow removing the type pointer.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/mips/pci/pci-rt3883.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/mips/pci/pci-rt3883.c b/arch/mips/pci/pci-rt3883.c
index 958899ffe99c..bafbf69e7dc4 100644
--- a/arch/mips/pci/pci-rt3883.c
+++ b/arch/mips/pci/pci-rt3883.c
@@ -445,8 +445,7 @@ static int rt3883_pci_probe(struct platform_device *pdev)
 
 	/* find the PCI host bridge child node */
 	for_each_child_of_node(np, child) {
-		if (child->type &&
-		    of_node_cmp(child->type, "pci") == 0) {
+		if (of_node_is_type(child, "pci")) {
 			rpc->pci_controller.of_node = child;
 			break;
 		}
@@ -464,8 +463,7 @@ static int rt3883_pci_probe(struct platform_device *pdev)
 	for_each_available_child_of_node(rpc->pci_controller.of_node, child) {
 		int devfn;
 
-		if (!child->type ||
-		    of_node_cmp(child->type, "pci") != 0)
+		if (!of_node_is_type(child, "pci"))
 			continue;
 
 		devfn = of_pci_get_devfn(child);
-- 
2.19.1
