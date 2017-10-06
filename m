Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Oct 2017 10:55:24 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:52044 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993921AbdJFIybhxppo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Oct 2017 10:54:31 +0200
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0CF51723;
        Fri,  6 Oct 2017 08:54:25 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arvind Yadav <arvind.yadav.cs@gmail.com>,
        antonynpavlov@gmail.com, albeu@free.fr, hackpascal@gmail.com,
        sboyd@codeaurora.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.9 056/104] mips: ath79: clock:- Unmap region obtained by of_iomap
Date:   Fri,  6 Oct 2017 10:51:34 +0200
Message-Id: <20171006083849.029960382@linuxfoundation.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171006083840.743659740@linuxfoundation.org>
References: <20171006083840.743659740@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60301
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arvind Yadav <arvind.yadav.cs@gmail.com>


[ Upstream commit b3d91db3f71d5f70ea60d900425a3f96aeb3d065 ]

Free memory mapping, if ath79_clocks_init_dt_ng is not successful.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Fixes: 3bdf1071ba7d ("MIPS: ath79: update devicetree clock support for AR9132")
Cc: antonynpavlov@gmail.com
Cc: albeu@free.fr
Cc: hackpascal@gmail.com
Cc: sboyd@codeaurora.org
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/14915/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/ath79/clock.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/arch/mips/ath79/clock.c
+++ b/arch/mips/ath79/clock.c
@@ -508,16 +508,19 @@ static void __init ath79_clocks_init_dt_
 		ar9330_clk_init(ref_clk, pll_base);
 	else {
 		pr_err("%s: could not find any appropriate clk_init()\n", dnfn);
-		goto err_clk;
+		goto err_iounmap;
 	}
 
 	if (of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data)) {
 		pr_err("%s: could not register clk provider\n", dnfn);
-		goto err_clk;
+		goto err_iounmap;
 	}
 
 	return;
 
+err_iounmap:
+	iounmap(pll_base);
+
 err_clk:
 	clk_put(ref_clk);
 
