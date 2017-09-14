Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Sep 2017 17:54:43 +0200 (CEST)
Received: from fldsmtpe03.verizon.com ([140.108.26.142]:8023 "EHLO
        fldsmtpe03.verizon.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994004AbdINPxTFDDgc convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 14 Sep 2017 17:53:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1505404398; x=1536940398;
  h=from:cc:to:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E2DqOeyfyCun4SCg1mtc2NYP0R153j09P+M/IF5BWe8=;
  b=HKu5oBwxZ3WzaUvRUBSlt8II0YH4AfUOeLF1nk2tNSbro4IJOuhL+8ui
   +LpVK4S7asj+gLPFTECoSKwX0bGg3hDVtkmc7lSTqwKKs4hYpH8M/mbbz
   oT/2joox6Io7OXha+HEa7iftvhlW1fVgUSiekXc/vA38IBqEmauyVypjC
   Q=;
Received: from unknown (HELO fldsmtpi03.verizon.com) ([166.68.71.145])
  by fldsmtpe03.verizon.com with ESMTP; 14 Sep 2017 15:53:13 +0000
From:   "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>
Cc:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>
Received: from rogue-10-255-192-101.rogue.vzwcorp.com (HELO atlantis.verizonwireless.com) ([10.255.192.101])
  by fldsmtpi03.verizon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Sep 2017 15:51:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1505404287; x=1536940287;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E2DqOeyfyCun4SCg1mtc2NYP0R153j09P+M/IF5BWe8=;
  b=ZlHFDDa2b24U3O7tjdw+dC/wT7lBC54MhLif9ToBya7GiHHC+yATo6Fh
   TTab+guqF//5k7HiucvM+rgYe0vsffZw1E0pjE1l/7K9d9+JlScYYcsXW
   XBObEqdsVp/nVGdh4R82XvI9SNz8N1eKx0kewC6StDFSV2sA0cYMubP2g
   k=;
Received: from ranger.odc.vzwcorp.com (HELO mercury.verizonwireless.com) ([10.255.240.27])
  by atlantis.verizonwireless.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Sep 2017 11:51:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1505404287; x=1536940287;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E2DqOeyfyCun4SCg1mtc2NYP0R153j09P+M/IF5BWe8=;
  b=ZlHFDDa2b24U3O7tjdw+dC/wT7lBC54MhLif9ToBya7GiHHC+yATo6Fh
   TTab+guqF//5k7HiucvM+rgYe0vsffZw1E0pjE1l/7K9d9+JlScYYcsXW
   XBObEqdsVp/nVGdh4R82XvI9SNz8N1eKx0kewC6StDFSV2sA0cYMubP2g
   k=;
X-Host: ranger.odc.vzwcorp.com
Received: from casac1exh001.uswin.ad.vzwcorp.com ([10.11.218.43])
  by mercury.verizonwireless.com with ESMTP/TLS/AES128-SHA256; 14 Sep 2017 15:51:26 +0000
Received: from scwexch03apd.uswin.ad.vzwcorp.com (153.114.130.22) by
 CASAC1EXH001.uswin.ad.vzwcorp.com (10.11.218.43) with Microsoft SMTP Server
 (TLS) id 14.3.248.2; Thu, 14 Sep 2017 08:51:17 -0700
Received: from OMZP1LUMXCA16.uswin.ad.vzwcorp.com (144.8.22.194) by
 scwexch03apd.uswin.ad.vzwcorp.com (153.114.130.22) with Microsoft SMTP Server
 (TLS) id 15.0.1263.5; Thu, 14 Sep 2017 08:51:16 -0700
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com (144.8.22.195) by
 OMZP1LUMXCA16.uswin.ad.vzwcorp.com (144.8.22.194) with Microsoft SMTP Server
 (TLS) id 15.0.1263.5; Thu, 14 Sep 2017 10:51:11 -0500
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com ([144.8.22.195]) by
 OMZP1LUMXCA17.uswin.ad.vzwcorp.com ([144.8.22.195]) with mapi id
 15.00.1263.000; Thu, 14 Sep 2017 10:51:12 -0500
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH for 4.9 12/59] MIPS: kexec: Do not reserve invalid crashkernel
 memory on boot
Thread-Topic: [PATCH for 4.9 12/59] MIPS: kexec: Do not reserve invalid
 crashkernel memory on boot
Thread-Index: AQHTLXFHVT+E5kfQ/0a1BpnqQ8S27w==
Date:   Thu, 14 Sep 2017 15:51:08 +0000
Message-ID: <20170914155051.8289-12-alexander.levin@verizon.com>
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
X-archive-position: 60001
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

From: Marcin Nowakowski <marcin.nowakowski@imgtec.com>

[ Upstream commit a8f108d70c74d83574c157648383eb2e4285a190 ]

Do not reserve memory for the crashkernel if the commandline argument
points to a wrong location. This can happen if the location is specified
wrong or if the same commandline is reused when starting the crashkernel
- in the latter case the reserved memory would point to the location
from which the crashkernel is executing.

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/14612/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
---
 arch/mips/kernel/setup.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 38697f25d168..d64ee5d3cc89 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -668,6 +668,11 @@ static void __init mips_parse_crashkernel(void)
 	if (ret != 0 || crash_size <= 0)
 		return;
 
+	if (!memory_region_available(crash_base, crash_size)) {
+		pr_warn("Invalid memory region reserved for crash kernel\n");
+		return;
+	}
+
 	crashk_res.start = crash_base;
 	crashk_res.end	 = crash_base + crash_size - 1;
 }
-- 
2.11.0
