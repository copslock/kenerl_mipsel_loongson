Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Sep 2017 17:53:11 +0200 (CEST)
Received: from fldsmtpe03.verizon.com ([140.108.26.142]:7884 "EHLO
        fldsmtpe03.verizon.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994624AbdINPwiZXzdc convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 14 Sep 2017 17:52:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1505404358; x=1536940358;
  h=from:cc:to:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QgHpTVeTsxblXQDTDmiINQzgNhhF9xIDlEpQDmuG4s8=;
  b=TUozuu310OdKn4gjQ9VwRiooJFKW7MQ6t510wIXuTfrLGmFwDQy62XsI
   xQ/If6XLkm96vDRubjOSGNtMgMbUBzBt6X3q6/uRnpHfbfONX2fOL4lQU
   KU7pWHNED+YEKJnkIkhzeVmUyMii9yvN9/BqMB2Qkl1LQgJtivvaGjOr3
   E=;
Received: from unknown (HELO fldsmtpi02.verizon.com) ([166.68.71.144])
  by fldsmtpe03.verizon.com with ESMTP; 14 Sep 2017 15:52:29 +0000
From:   "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>
Cc:     Colin Ian King <colin.king@canonical.com>,
        John Crispin <john@phrozen.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>
Received: from rogue-10-255-192-101.rogue.vzwcorp.com (HELO apollo.verizonwireless.com) ([10.255.192.101])
  by fldsmtpi02.verizon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Sep 2017 15:52:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1505404325; x=1536940325;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QgHpTVeTsxblXQDTDmiINQzgNhhF9xIDlEpQDmuG4s8=;
  b=sUskQGTNoHOBcddfui5yGUWh3WlskfbmxEprLjEtk/KM9AUaaLB60RDe
   LXmMQYLUOSriPV/iExOpiC8bXXfJhpkkSjS3at+cZnMWZFL/MoM4LDgGr
   XEN4wrrJOamoUNkN2CsPPUXhgQc8YcKkHd/QUBulueSLnIyST7Q3O3P1c
   w=;
Received: from ranger.odc.vzwcorp.com (HELO mercury.verizonwireless.com) ([10.255.240.27])
  by apollo.verizonwireless.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Sep 2017 11:52:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1505404325; x=1536940325;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QgHpTVeTsxblXQDTDmiINQzgNhhF9xIDlEpQDmuG4s8=;
  b=sUskQGTNoHOBcddfui5yGUWh3WlskfbmxEprLjEtk/KM9AUaaLB60RDe
   LXmMQYLUOSriPV/iExOpiC8bXXfJhpkkSjS3at+cZnMWZFL/MoM4LDgGr
   XEN4wrrJOamoUNkN2CsPPUXhgQc8YcKkHd/QUBulueSLnIyST7Q3O3P1c
   w=;
X-Host: ranger.odc.vzwcorp.com
Received: from casac1exh003.uswin.ad.vzwcorp.com ([10.11.218.45])
  by mercury.verizonwireless.com with ESMTP/TLS/AES128-SHA256; 14 Sep 2017 15:51:47 +0000
Received: from scwexch11apd.uswin.ad.vzwcorp.com (153.114.130.30) by
 CASAC1EXH003.uswin.ad.vzwcorp.com (10.11.218.45) with Microsoft SMTP Server
 (TLS) id 14.3.248.2; Thu, 14 Sep 2017 08:51:28 -0700
Received: from OMZP1LUMXCA14.uswin.ad.vzwcorp.com (144.8.22.189) by
 scwexch11apd.uswin.ad.vzwcorp.com (153.114.130.30) with Microsoft SMTP Server
 (TLS) id 15.0.1263.5; Thu, 14 Sep 2017 08:51:27 -0700
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com (144.8.22.195) by
 OMZP1LUMXCA14.uswin.ad.vzwcorp.com (144.8.22.189) with Microsoft SMTP Server
 (TLS) id 15.0.1263.5; Thu, 14 Sep 2017 10:51:13 -0500
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com ([144.8.22.195]) by
 OMZP1LUMXCA17.uswin.ad.vzwcorp.com ([144.8.22.195]) with mapi id
 15.00.1263.000; Thu, 14 Sep 2017 10:51:13 -0500
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH for 4.9 14/59] MIPS: ralink: Fix incorrect assignment on
 ralink_soc
Thread-Topic: [PATCH for 4.9 14/59] MIPS: ralink: Fix incorrect assignment on
 ralink_soc
Thread-Index: AQHTLXFI3fgp30MEbEu0HHOMWMN0zQ==
Date:   Thu, 14 Sep 2017 15:51:08 +0000
Message-ID: <20170914155051.8289-14-alexander.levin@verizon.com>
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
X-archive-position: 59997
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
index 9e4631acfcb5..3e68e35daf21 100644
--- a/arch/mips/ralink/rt3883.c
+++ b/arch/mips/ralink/rt3883.c
@@ -145,5 +145,5 @@ void prom_soc_init(struct ralink_soc_info *soc_info)
 
 	rt2880_pinmux_data = rt3883_pinmux_data;
 
-	ralink_soc == RT3883_SOC;
+	ralink_soc = RT3883_SOC;
 }
-- 
2.11.0
