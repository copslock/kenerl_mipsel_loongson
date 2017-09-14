Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Sep 2017 17:54:22 +0200 (CEST)
Received: from omzsmtpe01.verizonbusiness.com ([199.249.25.210]:46652 "EHLO
        omzsmtpe01.verizonbusiness.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994753AbdINPxOBljfc convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 14 Sep 2017 17:53:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1505404393; x=1536940393;
  h=from:cc:to:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yNRUdmY/S5Rebb/GBqI5y/FHVkkGrnjFXCDH8vc404w=;
  b=FbfHdF3x27sYbv2VjUkgyXeVoo4tjSm/9xKSV0Zks5to2jxcI2aj3Uc4
   Wmy9ZDiofWNXccrRX6/M2vQKcSHh8/EPaU1IsaifvrAOk6p1xDWyxK428
   YY24HTBCGOqxxOBPvhe0oJtJ6Ucn18GHV63gVvTRaW9fxujDJPXQOB9hL
   Y=;
Received: from unknown (HELO fldsmtpi01.verizon.com) ([166.68.71.143])
  by omzsmtpe01.verizonbusiness.com with ESMTP; 14 Sep 2017 15:53:06 +0000
From:   "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, John Crispin <john@phrozen.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>
Received: from rogue-10-255-192-101.rogue.vzwcorp.com (HELO apollo.verizonwireless.com) ([10.255.192.101])
  by fldsmtpi01.verizon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Sep 2017 15:52:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1505404347; x=1536940347;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yNRUdmY/S5Rebb/GBqI5y/FHVkkGrnjFXCDH8vc404w=;
  b=XkRcSEROhoDvJgriCPMB2dsPWaLYfVBdMmWSA/bDlsiy+TsEqZ7O7/bq
   uqS4PWSCwM+Jtelf7bIWKmjCHK2EU2OaRdGhp7CA/h9K0RXnQExgYRUul
   Mi4NHy4anhXYgFpWtFyGnNYm6YvDD8jlICScTqLQwux5XSAl5hXe8oVoE
   s=;
Received: from ranger.odc.vzwcorp.com (HELO mercury.verizonwireless.com) ([10.255.240.27])
  by apollo.verizonwireless.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Sep 2017 11:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1505404347; x=1536940347;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yNRUdmY/S5Rebb/GBqI5y/FHVkkGrnjFXCDH8vc404w=;
  b=XkRcSEROhoDvJgriCPMB2dsPWaLYfVBdMmWSA/bDlsiy+TsEqZ7O7/bq
   uqS4PWSCwM+Jtelf7bIWKmjCHK2EU2OaRdGhp7CA/h9K0RXnQExgYRUul
   Mi4NHy4anhXYgFpWtFyGnNYm6YvDD8jlICScTqLQwux5XSAl5hXe8oVoE
   s=;
X-Host: ranger.odc.vzwcorp.com
Received: from casac1exh003.uswin.ad.vzwcorp.com ([10.11.218.45])
  by mercury.verizonwireless.com with ESMTP/TLS/AES128-SHA256; 14 Sep 2017 15:52:26 +0000
Received: from scwexch24apd.uswin.ad.vzwcorp.com (153.114.130.43) by
 CASAC1EXH003.uswin.ad.vzwcorp.com (10.11.218.45) with Microsoft SMTP Server
 (TLS) id 14.3.248.2; Thu, 14 Sep 2017 08:52:12 -0700
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com (144.8.22.195) by
 scwexch24apd.uswin.ad.vzwcorp.com (153.114.130.43) with Microsoft SMTP Server
 (TLS) id 15.0.1263.5; Thu, 14 Sep 2017 08:52:11 -0700
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com (144.8.22.195) by
 OMZP1LUMXCA17.uswin.ad.vzwcorp.com (144.8.22.195) with Microsoft SMTP Server
 (TLS) id 15.0.1263.5; Thu, 14 Sep 2017 10:52:10 -0500
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com ([144.8.22.195]) by
 OMZP1LUMXCA17.uswin.ad.vzwcorp.com ([144.8.22.195]) with mapi id
 15.00.1263.000; Thu, 14 Sep 2017 10:52:10 -0500
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH for 4.9 57/59] MIPS: Lantiq: Fix another request_mem_region()
 return code check
Thread-Topic: [PATCH for 4.9 57/59] MIPS: Lantiq: Fix another
 request_mem_region() return code check
Thread-Index: AQHTLXFPV0xtfHiiX0OoZ5w6F24/1w==
Date:   Thu, 14 Sep 2017 15:51:20 +0000
Message-ID: <20170914155051.8289-57-alexander.levin@verizon.com>
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
X-archive-position: 60000
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

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 98ea51cb0c8ce009d9da1fd7b48f0ff1d7a9bbb0 ]

Hauke already fixed a couple of them, but one instance remains
that checks for a negative integer when it should check
for a NULL pointer:

arch/mips/lantiq/xway/sysctrl.c: In function 'ltq_soc_init':
arch/mips/lantiq/xway/sysctrl.c:473:19: error: ordered comparison of pointer with integer zero [-Werror=extra]

Fixes: 6e807852676a ("MIPS: Lantiq: Fix check for return value of request_mem_region()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: John Crispin <john@phrozen.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/15043/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
---
 arch/mips/lantiq/xway/sysctrl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
index 90565477dfbd..95bec460b651 100644
--- a/arch/mips/lantiq/xway/sysctrl.c
+++ b/arch/mips/lantiq/xway/sysctrl.c
@@ -469,8 +469,8 @@ void __init ltq_soc_init(void)
 			panic("Failed to load xbar nodes from devicetree");
 		if (of_address_to_resource(np_xbar, 0, &res_xbar))
 			panic("Failed to get xbar resources");
-		if (request_mem_region(res_xbar.start, resource_size(&res_xbar),
-			res_xbar.name) < 0)
+		if (!request_mem_region(res_xbar.start, resource_size(&res_xbar),
+			res_xbar.name))
 			panic("Failed to get xbar resources");
 
 		ltq_xbar_membase = ioremap_nocache(res_xbar.start,
-- 
2.11.0
