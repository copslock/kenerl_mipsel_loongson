Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Sep 2017 17:55:09 +0200 (CEST)
Received: from fldsmtpe03.verizon.com ([140.108.26.142]:8023 "EHLO
        fldsmtpe03.verizon.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994754AbdINPxTvTQoc convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 14 Sep 2017 17:53:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1505404399; x=1536940399;
  h=from:cc:to:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xXEiUrHv7qqh23ZJG0WR5HfOZC4wD3hDeYY1LowJs8I=;
  b=ShPsaLaVf2NeWPHo0+ZIeyRSGiUcdrHVIrGa6X/jCu6C97Fga/bj5BFW
   dL0s0POfrDGwRZWlCZRC7pWb4NnWN9SIvyuydPXaZjUkDSZ/m8CddysXr
   wKO5iwFcHKi2X0bDJS4PjQr2AagcF0i5WhimhuHsXNWJFWEpz38Q2Keqf
   0=;
Received: from unknown (HELO fldsmtpi03.verizon.com) ([166.68.71.145])
  by fldsmtpe03.verizon.com with ESMTP; 14 Sep 2017 15:53:13 +0000
From:   "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>
Cc:     Arvind Yadav <arvind.yadav.cs@gmail.com>,
        "antonynpavlov@gmail.com" <antonynpavlov@gmail.com>,
        "albeu@free.fr" <albeu@free.fr>,
        "hackpascal@gmail.com" <hackpascal@gmail.com>,
        "sboyd@codeaurora.org" <sboyd@codeaurora.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>
Received: from rogue-10-255-192-101.rogue.vzwcorp.com (HELO atlantis.verizonwireless.com) ([10.255.192.101])
  by fldsmtpi03.verizon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Sep 2017 15:52:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1505404366; x=1536940366;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xXEiUrHv7qqh23ZJG0WR5HfOZC4wD3hDeYY1LowJs8I=;
  b=PabQn6cJ3npsDQMNNZCGGxLAXsIQlQLMRC40GMpy1mTOfRKhJAwzGT4M
   odgo2wRuA3WClzes44kpvXk0ko0hABVHEsmikyCmDIYMJJt5qLxR5sYg3
   9iF5SX48B2wjrJj5UfiyHJLP5tIB9VexLJXBLPvT0Pi1gynHHtNtLOrp7
   o=;
Received: from discovery.odc.vzwcorp.com (HELO mercury.verizonwireless.com) ([10.255.240.25])
  by atlantis.verizonwireless.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Sep 2017 11:52:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1505404366; x=1536940366;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xXEiUrHv7qqh23ZJG0WR5HfOZC4wD3hDeYY1LowJs8I=;
  b=PabQn6cJ3npsDQMNNZCGGxLAXsIQlQLMRC40GMpy1mTOfRKhJAwzGT4M
   odgo2wRuA3WClzes44kpvXk0ko0hABVHEsmikyCmDIYMJJt5qLxR5sYg3
   9iF5SX48B2wjrJj5UfiyHJLP5tIB9VexLJXBLPvT0Pi1gynHHtNtLOrp7
   o=;
X-Host: discovery.odc.vzwcorp.com
Received: from casac1exh001.uswin.ad.vzwcorp.com ([10.11.218.43])
  by mercury.verizonwireless.com with ESMTP/TLS/AES128-SHA256; 14 Sep 2017 15:52:45 +0000
Received: from scwexch18apd.uswin.ad.vzwcorp.com (153.114.130.37) by
 CASAC1EXH001.uswin.ad.vzwcorp.com (10.11.218.43) with Microsoft SMTP Server
 (TLS) id 14.3.248.2; Thu, 14 Sep 2017 08:52:29 -0700
Received: from OMZP1LUMXCA12.uswin.ad.vzwcorp.com (144.8.22.187) by
 scwexch18apd.uswin.ad.vzwcorp.com (153.114.130.37) with Microsoft SMTP Server
 (TLS) id 15.0.1263.5; Thu, 14 Sep 2017 08:52:28 -0700
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com (144.8.22.195) by
 OMZP1LUMXCA12.uswin.ad.vzwcorp.com (144.8.22.187) with Microsoft SMTP Server
 (TLS) id 15.0.1263.5; Thu, 14 Sep 2017 10:52:11 -0500
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com ([144.8.22.195]) by
 OMZP1LUMXCA17.uswin.ad.vzwcorp.com ([144.8.22.195]) with mapi id
 15.00.1263.000; Thu, 14 Sep 2017 10:52:11 -0500
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH for 4.9 58/59] mips: ath79: clock:- Unmap region obtained by
 of_iomap
Thread-Topic: [PATCH for 4.9 58/59] mips: ath79: clock:- Unmap region obtained
 by of_iomap
Thread-Index: AQHTLXFP3p96o/uLh0+s77IM4ncRdQ==
Date:   Thu, 14 Sep 2017 15:51:21 +0000
Message-ID: <20170914155051.8289-58-alexander.levin@verizon.com>
References: <20170914155051.8289-1-alexander.levin@verizon.com>
In-Reply-To: <20170914155051.8289-1-alexander.levin@verizon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.144.60.250]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <alexander.levin@verizon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60002
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexander.levin@verizon.com
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
---
 arch/mips/ath79/clock.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/mips/ath79/clock.c b/arch/mips/ath79/clock.c
index cc3a1e33a600..7e2bb12b64ea 100644
--- a/arch/mips/ath79/clock.c
+++ b/arch/mips/ath79/clock.c
@@ -508,16 +508,19 @@ static void __init ath79_clocks_init_dt_ng(struct device_node *np)
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
 
-- 
2.11.0
