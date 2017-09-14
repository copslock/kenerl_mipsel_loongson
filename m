Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Sep 2017 17:52:45 +0200 (CEST)
Received: from fldsmtpe03.verizon.com ([140.108.26.142]:7884 "EHLO
        fldsmtpe03.verizon.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992982AbdINPwhrmgHc convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 14 Sep 2017 17:52:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1505404357; x=1536940357;
  h=from:cc:to:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DoCAd/NLmjNv/qYcaKjJF8hcNpXc0SRrAGfa1RF3+HI=;
  b=SNZnHlJ1SaX1mbPZz2PUDAudhen9WBPS6lbxUNUVOsNTasGx+uzFtFeS
   8ohmpOPcLhlRR2r5xaMdJW6fWCGxSH03fwQWFDLT7sQfDvVZEJFOcgyHP
   ipzbI3rTIWZdW6Wxrwnn0pdDrMxve3yoXwS/GyIbx61uwLVVQEfOQ1+gs
   8=;
Received: from unknown (HELO fldsmtpi02.verizon.com) ([166.68.71.144])
  by fldsmtpe03.verizon.com with ESMTP; 14 Sep 2017 15:52:29 +0000
From:   "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>
Cc:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>
Received: from rogue-10-255-192-101.rogue.vzwcorp.com (HELO apollo.verizonwireless.com) ([10.255.192.101])
  by fldsmtpi02.verizon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Sep 2017 15:51:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1505404283; x=1536940283;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DoCAd/NLmjNv/qYcaKjJF8hcNpXc0SRrAGfa1RF3+HI=;
  b=Hdng4t3sq7ND+f9nWN++ZN5nz9ngVlF3llp1+yTdtNitabUrnm6NCEV6
   SAOONlNZPVt4Bzbu4vfo0JRSB8vvEDd2FVdwFaKPFhrSGMuq4JFRdy+HV
   d3pKugpN79AOcUwDAlcIt1LXwq2bfB8Zv28odgXC6tf2LRrlIs8rzLX20
   0=;
Received: from challenger.odc.vzwcorp.com (HELO mercury.verizonwireless.com) ([10.255.240.24])
  by apollo.verizonwireless.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Sep 2017 11:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1505404283; x=1536940283;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DoCAd/NLmjNv/qYcaKjJF8hcNpXc0SRrAGfa1RF3+HI=;
  b=Hdng4t3sq7ND+f9nWN++ZN5nz9ngVlF3llp1+yTdtNitabUrnm6NCEV6
   SAOONlNZPVt4Bzbu4vfo0JRSB8vvEDd2FVdwFaKPFhrSGMuq4JFRdy+HV
   d3pKugpN79AOcUwDAlcIt1LXwq2bfB8Zv28odgXC6tf2LRrlIs8rzLX20
   0=;
X-Host: challenger.odc.vzwcorp.com
Received: from casac1exh001.uswin.ad.vzwcorp.com ([10.11.218.43])
  by mercury.verizonwireless.com with ESMTP/TLS/AES128-SHA256; 14 Sep 2017 15:51:22 +0000
Received: from OMZP1LUMXCA12.uswin.ad.vzwcorp.com (144.8.22.187) by
 CASAC1EXH001.uswin.ad.vzwcorp.com (10.11.218.43) with Microsoft SMTP Server
 (TLS) id 14.3.248.2; Thu, 14 Sep 2017 08:51:12 -0700
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com (144.8.22.195) by
 OMZP1LUMXCA12.uswin.ad.vzwcorp.com (144.8.22.187) with Microsoft SMTP Server
 (TLS) id 15.0.1263.5; Thu, 14 Sep 2017 10:51:11 -0500
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com ([144.8.22.195]) by
 OMZP1LUMXCA17.uswin.ad.vzwcorp.com ([144.8.22.195]) with mapi id
 15.00.1263.000; Thu, 14 Sep 2017 10:51:11 -0500
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH for 4.9 11/59] MIPS: fix mem=X@Y commandline processing
Thread-Topic: [PATCH for 4.9 11/59] MIPS: fix mem=X@Y commandline processing
Thread-Index: AQHTLXFH4io0S/XDjES/moD5BvZcNQ==
Date:   Thu, 14 Sep 2017 15:51:07 +0000
Message-ID: <20170914155051.8289-11-alexander.levin@verizon.com>
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
X-archive-position: 59996
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

[ Upstream commit 73fbc1eba7ffa3bf0ad12486232a8a1edb4e4411 ]

When a memory offset is specified through the commandline, add the
memory in range PHYS_OFFSET:Y as reserved memory area.
Otherwise the bootmem allocator is initialised with low page equal to
min_low_pfn = PHYS_OFFSET, and in free_all_bootmem will process pages
starting from min_low_pfn instead of PFN(Y).

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/14613/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
---
 arch/mips/kernel/setup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index f66e5ce505b2..38697f25d168 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -589,6 +589,10 @@ static int __init early_parse_mem(char *p)
 		start = memparse(p + 1, &p);
 
 	add_memory_region(start, size, BOOT_MEM_RAM);
+
+	if (start && start > PHYS_OFFSET)
+		add_memory_region(PHYS_OFFSET, start - PHYS_OFFSET,
+				BOOT_MEM_RESERVED);
 	return 0;
 }
 early_param("mem", early_parse_mem);
-- 
2.11.0
