Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 May 2018 13:03:09 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:43378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994792AbeE1LDBduBA0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 May 2018 13:03:01 +0200
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D37220883;
        Mon, 28 May 2018 11:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1527505375;
        bh=8qvT2QhIW14Ai+gdsXRAu4tWqqUH060xu7U/HES6gQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vKlu+Q8/vrl2u5+lem4GpfXiuMnYb29eFZAAyr76kCFP0b3Be5fAUW8a2iDfxqnuV
         FZ2GNBXaeiy14GdLKLQ4T9wd/1NzAN4GE43OkdgfVmVwtH2oRp9v0/8AekAHfoHWOl
         buPSAkrwev5f/12lWjCo4acyieI/A8Qzo/YQrI2s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joe Perches <joe@perches.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 475/496] MIPS: Octeon: Fix logging messages with spurious periods after newlines
Date:   Mon, 28 May 2018 12:04:20 +0200
Message-Id: <20180528100339.920020213@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <SRS0=WbIs=IP=linuxfoundation.org=gregkh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64108
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joe Perches <joe@perches.com>

[ Upstream commit db6775ca6e0353d2618ca7d5e210fc36ad43bbd4 ]

Using a period after a newline causes bad output.

Fixes: 64b139f97c01 ("MIPS: OCTEON: irq: add CIB and other fixes")
Signed-off-by: Joe Perches <joe@perches.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/17886/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/cavium-octeon/octeon-irq.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -2271,7 +2271,7 @@ static int __init octeon_irq_init_cib(st
 
 	parent_irq = irq_of_parse_and_map(ciu_node, 0);
 	if (!parent_irq) {
-		pr_err("ERROR: Couldn't acquire parent_irq for %s\n.",
+		pr_err("ERROR: Couldn't acquire parent_irq for %s\n",
 			ciu_node->name);
 		return -EINVAL;
 	}
@@ -2283,7 +2283,7 @@ static int __init octeon_irq_init_cib(st
 
 	addr = of_get_address(ciu_node, 0, NULL, NULL);
 	if (!addr) {
-		pr_err("ERROR: Couldn't acquire reg(0) %s\n.", ciu_node->name);
+		pr_err("ERROR: Couldn't acquire reg(0) %s\n", ciu_node->name);
 		return -EINVAL;
 	}
 	host_data->raw_reg = (u64)phys_to_virt(
@@ -2291,7 +2291,7 @@ static int __init octeon_irq_init_cib(st
 
 	addr = of_get_address(ciu_node, 1, NULL, NULL);
 	if (!addr) {
-		pr_err("ERROR: Couldn't acquire reg(1) %s\n.", ciu_node->name);
+		pr_err("ERROR: Couldn't acquire reg(1) %s\n", ciu_node->name);
 		return -EINVAL;
 	}
 	host_data->en_reg = (u64)phys_to_virt(
@@ -2299,7 +2299,7 @@ static int __init octeon_irq_init_cib(st
 
 	r = of_property_read_u32(ciu_node, "cavium,max-bits", &val);
 	if (r) {
-		pr_err("ERROR: Couldn't read cavium,max-bits from %s\n.",
+		pr_err("ERROR: Couldn't read cavium,max-bits from %s\n",
 			ciu_node->name);
 		return r;
 	}
@@ -2309,7 +2309,7 @@ static int __init octeon_irq_init_cib(st
 					   &octeon_irq_domain_cib_ops,
 					   host_data);
 	if (!cib_domain) {
-		pr_err("ERROR: Couldn't irq_domain_add_linear()\n.");
+		pr_err("ERROR: Couldn't irq_domain_add_linear()\n");
 		return -ENOMEM;
 	}
 
