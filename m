Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Sep 2017 06:46:00 +0200 (CEST)
Received: from omzsmtpe03.verizonbusiness.com ([199.249.25.208]:16929 "EHLO
        omzsmtpe03.verizonbusiness.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991550AbdITEpyI3LR9 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 20 Sep 2017 06:45:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1505882753; x=1537418753;
  h=from:cc:to:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1yontPG1P74X54WmVcMbw2nWm8YKYQddXpV6SIhxGWw=;
  b=mBKvpEmXmQxydQYwD1RFAwuOM2p3/5BOj60g4c1kjxL7jf0Jg0IYvHx+
   6nIRL1CmFGI2qVlYVN5oo9ZVxf8Zh1X3ivNWSj6YPPFSGpmdTDFaBpTmj
   zksBP6060UVP4cT7qC0klDWg/gV9jgwkXIIMxDfLcevb2gkvYkL9b/DsG
   M=;
Received: from unknown (HELO fldsmtpi01.verizon.com) ([166.68.71.143])
  by omzsmtpe03.verizonbusiness.com with ESMTP; 20 Sep 2017 04:45:45 +0000
From:   "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, John Crispin <john@phrozen.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>
Received: from rogue-10-255-192-101.rogue.vzwcorp.com (HELO atlantis.verizonwireless.com) ([10.255.192.101])
  by fldsmtpi01.verizon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 Sep 2017 04:45:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1505882721; x=1537418721;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1yontPG1P74X54WmVcMbw2nWm8YKYQddXpV6SIhxGWw=;
  b=N5i0sZEiemNvrh3TIy0rGqZYn3bmum3v4vi4e1C9PBRWLuFpnfBKeg3B
   rTZXFFVuNGghemkNGLllUAkMgjV6SJSXVKLZ2ISof2HIWGeF8+FnvyjZp
   yYusYbYMbqWsj7qB2E9LIxuqWJVHPi/1zyKu4AaO9uB/11nRbUG8DS2v5
   w=;
Received: from viking.odc.vzwcorp.com (HELO mercury.verizonwireless.com) ([10.255.240.26])
  by atlantis.verizonwireless.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 Sep 2017 00:45:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1505882720; x=1537418720;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1yontPG1P74X54WmVcMbw2nWm8YKYQddXpV6SIhxGWw=;
  b=sUfTHvE1OTvQ6hORyXNXFr4j22hO+3J53LOnYxQO+wOiNEthrQ7P8g2E
   BXb71hfYU7UkMOd4Cko7pJw0nyHOyvLSiZKMHqQBaJL/JTMj3aDlcHbKu
   3f7zkdtv2m+JaojhBKG7MKJKkq5PFUBOjWAf2mwSRb+F2sXvynqmhNDmV
   8=;
X-Host: viking.odc.vzwcorp.com
Received: from casac1exh001.uswin.ad.vzwcorp.com ([10.11.218.43])
  by mercury.verizonwireless.com with ESMTP/TLS/AES128-SHA256; 20 Sep 2017 04:45:19 +0000
Received: from scwexch18apd.uswin.ad.vzwcorp.com (153.114.130.37) by
 CASAC1EXH001.uswin.ad.vzwcorp.com (10.11.218.43) with Microsoft SMTP Server
 (TLS) id 14.3.248.2; Tue, 19 Sep 2017 21:45:19 -0700
Received: from OMZP1LUMXCA14.uswin.ad.vzwcorp.com (144.8.22.189) by
 scwexch18apd.uswin.ad.vzwcorp.com (153.114.130.37) with Microsoft SMTP Server
 (TLS) id 15.0.1263.5; Tue, 19 Sep 2017 21:45:18 -0700
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com (144.8.22.195) by
 OMZP1LUMXCA14.uswin.ad.vzwcorp.com (144.8.22.189) with Microsoft SMTP Server
 (TLS) id 15.0.1263.5; Tue, 19 Sep 2017 23:45:17 -0500
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com ([144.8.22.195]) by
 OMZP1LUMXCA17.uswin.ad.vzwcorp.com ([144.8.22.195]) with mapi id
 15.00.1263.000; Tue, 19 Sep 2017 23:45:17 -0500
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH review for 4.4 30/47] MIPS: Lantiq: Fix another
 request_mem_region() return code check
Thread-Topic: [PATCH review for 4.4 30/47] MIPS: Lantiq: Fix another
 request_mem_region() return code check
Thread-Index: AQHTMcs7JSUhJYXtEkSs2C8QyTbM+g==
Date:   Wed, 20 Sep 2017 04:45:07 +0000
Message-ID: <20170920044445.7392-30-alexander.levin@verizon.com>
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
X-archive-position: 60076
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
index daf580ce5ca2..2528181232fd 100644
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
