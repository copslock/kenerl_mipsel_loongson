Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Nov 2017 21:53:49 +0100 (CET)
Received: from omzsmtpe03.verizonbusiness.com ([199.249.25.208]:5573 "EHLO
        omzsmtpe03.verizonbusiness.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993907AbdKHUxD1GcbC convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 8 Nov 2017 21:53:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=one.verizon.com; i=@one.verizon.com; q=dns/txt;
  s=corp; t=1510174383; x=1541710383;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RVouqR+hRJv9ImmIXStxLXCUPZFxtpFXIghvhzb7CSU=;
  b=VpmolFgexGj3S/vvn8HV5vNE2LbNEQcqCGZ71I9NTLmyZWloozWdyjUf
   +Xbw7dHEgQ3kmUj88Rt+FPbrl3rh9d379G1ja4u4VjhRy3i25zgwtrmkF
   PczkP+gEYExgFWJZQ7CKhB7N9w09sQmtw2w7dwOL2W1JSAImNcG4CTQYs
   M=;
Received: from unknown (HELO fldsmtpi02.verizon.com) ([166.68.71.144])
  by omzsmtpe03.verizonbusiness.com with ESMTP; 08 Nov 2017 20:52:54 +0000
Received: from rogue-10-255-192-101.rogue.vzwcorp.com (HELO apollo.verizonwireless.com) ([10.255.192.101])
  by fldsmtpi02.verizon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 Nov 2017 20:51:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1510174314; x=1541710314;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RVouqR+hRJv9ImmIXStxLXCUPZFxtpFXIghvhzb7CSU=;
  b=mvPa9pZJjHNYrf0Z308to5Eb+SQtkju/oaYf6G1lFw3BUaA9OC6Y7ZXZ
   +yhrJ/o+0RFjkBG3BtcGmIssT2ik/HC5wRi09nNgT56xC71sRYs/enw5e
   HOnjH+i9pPve1DEMqGWYHViXxK57bfCkGiLT/H7ziKNCK7CuWHv209rYp
   U=;
Received: from endeavour.tdc.vzwcorp.com (HELO eris.verizonwireless.com) ([10.254.88.163])
  by apollo.verizonwireless.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 Nov 2017 15:51:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1510174314; x=1541710314;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RVouqR+hRJv9ImmIXStxLXCUPZFxtpFXIghvhzb7CSU=;
  b=mvPa9pZJjHNYrf0Z308to5Eb+SQtkju/oaYf6G1lFw3BUaA9OC6Y7ZXZ
   +yhrJ/o+0RFjkBG3BtcGmIssT2ik/HC5wRi09nNgT56xC71sRYs/enw5e
   HOnjH+i9pPve1DEMqGWYHViXxK57bfCkGiLT/H7ziKNCK7CuWHv209rYp
   U=;
X-Host: endeavour.tdc.vzwcorp.com
Received: from ohtwi1exh001.uswin.ad.vzwcorp.com ([10.144.218.43])
  by eris.verizonwireless.com with ESMTP/TLS/AES128-SHA256; 08 Nov 2017 20:51:53 +0000
Received: from tbwexch17apd.uswin.ad.vzwcorp.com (153.114.162.41) by
 OHTWI1EXH001.uswin.ad.vzwcorp.com (10.144.218.43) with Microsoft SMTP Server
 (TLS) id 14.3.248.2; Wed, 8 Nov 2017 15:51:52 -0500
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com (144.8.22.195) by
 tbwexch17apd.uswin.ad.vzwcorp.com (153.114.162.41) with Microsoft SMTP Server
 (TLS) id 15.0.1263.5; Wed, 8 Nov 2017 15:51:51 -0500
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com (144.8.22.195) by
 OMZP1LUMXCA17.uswin.ad.vzwcorp.com (144.8.22.195) with Microsoft SMTP Server
 (TLS) id 15.0.1263.5; Wed, 8 Nov 2017 14:51:51 -0600
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com ([144.8.22.195]) by
 OMZP1LUMXCA17.uswin.ad.vzwcorp.com ([144.8.22.195]) with mapi id
 15.00.1263.000; Wed, 8 Nov 2017 14:51:51 -0600
From:   "Levin, Alexander (Sasha Levin)" <alexander.levin@one.verizon.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Levin, Alexander (Sasha Levin)" <alexander.levin@one.verizon.com>
Subject: [PATCH AUTOSEL for-4.4 37/39] MIPS: init: Ensure reserved memory
 regions are not added to bootmem
Thread-Topic: [PATCH AUTOSEL for-4.4 37/39] MIPS: init: Ensure reserved memory
 regions are not added to bootmem
Thread-Index: AQHTWNM+TaT8xB/71kaDkPquwzzAhg==
Date:   Wed, 8 Nov 2017 20:50:42 +0000
Message-ID: <20171108205027.27525-37-alexander.levin@verizon.com>
References: <20171108205027.27525-1-alexander.levin@verizon.com>
In-Reply-To: <20171108205027.27525-1-alexander.levin@verizon.com>
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
Return-Path: <alexander.levin@one.verizon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60763
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexander.levin@one.verizon.com
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

[ Upstream commit e89ef66d7682f031f026eee6bba03c8c2248d2a9 ]

Memories managed through boot_mem_map are generally expected to define
non-crossing areas. However, if part of a larger memory block is marked
as reserved, it would still be added to bootmem allocator as an
available block and could end up being overwritten by the allocator.

Prevent this by explicitly marking the memory as reserved it if exists
in the range used by bootmem allocator.

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/14608/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
---
 arch/mips/kernel/setup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 1acaf0939cb5..4f9f1ae49213 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -506,6 +506,10 @@ static void __init bootmem_init(void)
 			continue;
 		default:
 			/* Not usable memory */
+			if (start > min_low_pfn && end < max_low_pfn)
+				reserve_bootmem(boot_mem_map.map[i].addr,
+						boot_mem_map.map[i].size,
+						BOOTMEM_DEFAULT);
 			continue;
 		}
 
-- 
2.11.0
