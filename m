Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Sep 2017 06:47:13 +0200 (CEST)
Received: from omzsmtpe01.verizonbusiness.com ([199.249.25.210]:28137 "EHLO
        omzsmtpe01.verizonbusiness.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990924AbdITEp5ziic9 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 20 Sep 2017 06:45:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1505882757; x=1537418757;
  h=from:cc:to:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=acP+7bhBHw56vjsxi9fE4pvlxF8qQ5VK+4PalyO3lDs=;
  b=Xaa/eHRaEJxfbvOdhRUQjcIhGeqUY9rIFW68JaOks590i9Bvn30IFj3p
   EZe0UGhhramqta/ThK4r7n2BWR0JqT0NsShFOIPFMNknBf45GTuALNCmO
   PCaZmn4uo7WwewdJzB2W1zhExQDjA/yWWpgGHmEq/urhY8uPywLHwsz+H
   Q=;
Received: from unknown (HELO fldsmtpi03.verizon.com) ([166.68.71.145])
  by omzsmtpe01.verizonbusiness.com with ESMTP; 20 Sep 2017 04:45:49 +0000
From:   "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>
Cc:     Colin Ian King <colin.king@canonical.com>,
        John Crispin <john@phrozen.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>
Received: from rogue-10-255-192-101.rogue.vzwcorp.com (HELO apollo.verizonwireless.com) ([10.255.192.101])
  by fldsmtpi03.verizon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 Sep 2017 04:45:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1505882710; x=1537418710;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=acP+7bhBHw56vjsxi9fE4pvlxF8qQ5VK+4PalyO3lDs=;
  b=gH0kzvquYNEuNphYzNb74BPQMgb7An27Y9OTURMQP71G2JGkgUiUrJOi
   xsklM5pY4S0OmhjtsbcBE9RPgI2PCYtfKmkKd87tGdSUaByYSq1iF0WYu
   QWzZXim/RdOe2FBJD7YY8Y8UY2KpuVWHUJFFnVXO9WCzFLwICqW1RCK/z
   c=;
Received: from challenger.odc.vzwcorp.com (HELO mercury.verizonwireless.com) ([10.255.240.24])
  by apollo.verizonwireless.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 Sep 2017 00:45:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1505882710; x=1537418710;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=acP+7bhBHw56vjsxi9fE4pvlxF8qQ5VK+4PalyO3lDs=;
  b=gH0kzvquYNEuNphYzNb74BPQMgb7An27Y9OTURMQP71G2JGkgUiUrJOi
   xsklM5pY4S0OmhjtsbcBE9RPgI2PCYtfKmkKd87tGdSUaByYSq1iF0WYu
   QWzZXim/RdOe2FBJD7YY8Y8UY2KpuVWHUJFFnVXO9WCzFLwICqW1RCK/z
   c=;
X-Host: challenger.odc.vzwcorp.com
Received: from casac1exh001.uswin.ad.vzwcorp.com ([10.11.218.43])
  by mercury.verizonwireless.com with ESMTP/TLS/AES128-SHA256; 20 Sep 2017 04:45:09 +0000
Received: from scwexch28apd.uswin.ad.vzwcorp.com (153.114.130.47) by
 CASAC1EXH001.uswin.ad.vzwcorp.com (10.11.218.43) with Microsoft SMTP Server
 (TLS) id 14.3.248.2; Tue, 19 Sep 2017 21:45:09 -0700
Received: from OMZP1LUMXCA11.uswin.ad.vzwcorp.com (144.8.22.186) by
 scwexch28apd.uswin.ad.vzwcorp.com (153.114.130.47) with Microsoft SMTP Server
 (TLS) id 15.0.1263.5; Tue, 19 Sep 2017 21:45:08 -0700
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com (144.8.22.195) by
 OMZP1LUMXCA11.uswin.ad.vzwcorp.com (144.8.22.186) with Microsoft SMTP Server
 (TLS) id 15.0.1263.5; Tue, 19 Sep 2017 23:45:04 -0500
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com ([144.8.22.195]) by
 OMZP1LUMXCA17.uswin.ad.vzwcorp.com ([144.8.22.195]) with mapi id
 15.00.1263.000; Tue, 19 Sep 2017 23:45:04 -0500
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH review for 4.4 08/47] MIPS: ralink: Fix incorrect assignment
 on ralink_soc
Thread-Topic: [PATCH review for 4.4 08/47] MIPS: ralink: Fix incorrect
 assignment on ralink_soc
Thread-Index: AQHTMcs4aww23NXkXE2x2CcC9MDN6g==
Date:   Wed, 20 Sep 2017 04:45:01 +0000
Message-ID: <20170920044445.7392-8-alexander.levin@verizon.com>
References: <20170920044445.7392-1-alexander.levin@verizon.com>
In-Reply-To: <20170920044445.7392-1-alexander.levin@verizon.com>
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
X-archive-position: 60079
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

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 08d90c81b714482dceb5323d14f6617bcf55ee61 ]

ralink_soc sould be assigned to RT3883_SOC, replace incorrect
comparision with assignment.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Fixes: 418d29c87061 ("MIPS: ralink: Unify SoC id handling")
Cc: John Crispin <john@phrozen.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/14903/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
---
 arch/mips/ralink/rt3883.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/ralink/rt3883.c b/arch/mips/ralink/rt3883.c
index 3c575093f8f1..f2a6e1b8cce0 100644
--- a/arch/mips/ralink/rt3883.c
+++ b/arch/mips/ralink/rt3883.c
@@ -144,5 +144,5 @@ void prom_soc_init(struct ralink_soc_info *soc_info)
 
 	rt2880_pinmux_data = rt3883_pinmux_data;
 
-	ralink_soc == RT3883_SOC;
+	ralink_soc = RT3883_SOC;
 }
-- 
2.11.0
