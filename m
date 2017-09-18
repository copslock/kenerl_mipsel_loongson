Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Sep 2017 02:41:27 +0200 (CEST)
Received: from omzsmtpe02.verizonbusiness.com ([199.249.25.209]:35034 "EHLO
        omzsmtpe02.verizonbusiness.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992899AbdIRAlO0PjYn convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 18 Sep 2017 02:41:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1505695274; x=1537231274;
  h=from:cc:to:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1PiA/7hbP0CSxgJtJl70X3GLiLO6ci8/LAckPzAAOcA=;
  b=H2lneJogsEjo12YmzZdFoINWQziSiJJJj1FTrupo53r5y/0AaINMJUDQ
   BQ9YMsFLXLLekm/+webB6PXqlHuJ+BZ3qfGzQhXL33jSM/UNjDbejeWTb
   F2yfiGSDQaTOKqwZv0YoyObpsYEC77k+6wGwqzOmz04/jCsLH3S3HnE7/
   c=;
Received: from unknown (HELO fldsmtpi01.verizon.com) ([166.68.71.143])
  by omzsmtpe02.verizonbusiness.com with ESMTP; 18 Sep 2017 00:41:06 +0000
From:   "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>
Cc:     Matt Redfearn <matt.redfearn@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>
Received: from rogue-10-255-192-101.rogue.vzwcorp.com (HELO atlantis.verizonwireless.com) ([10.255.192.101])
  by fldsmtpi01.verizon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 18 Sep 2017 00:40:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1505695237; x=1537231237;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1PiA/7hbP0CSxgJtJl70X3GLiLO6ci8/LAckPzAAOcA=;
  b=nLrhNoR44y29birxmEUzjgnNG39GnjzAkL4UJ9wtu6b+kUb8e9fiUc6j
   q5uMzM+iPxJnY1ISOqh3hWsiHpIB607V+BE/kag2sAQHc5uWOLlmzmi3z
   TZWTIY/HImg7Tkre7FaEKTMSdTuGrDdi9oNnnosbB+KcEVgckeGK2d1jZ
   8=;
Received: from viking.odc.vzwcorp.com (HELO mercury.verizonwireless.com) ([10.255.240.26])
  by atlantis.verizonwireless.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 17 Sep 2017 20:40:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1505695236; x=1537231236;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1PiA/7hbP0CSxgJtJl70X3GLiLO6ci8/LAckPzAAOcA=;
  b=ZaI+lZbFvjsVxybOVz2F1YSVNPbFzNWgiOIZiD530laEpanvC67exlSW
   Pk69/B7KAT7/u844gW8XGe6et5jlunnEULXQCVh4ay8WbI3EIBQsKSyp/
   OQHxsIgj6vmAOfBX5ZwVnnMg74WvzvMvm14Jr8klFB0v4R8pAps/s/qy9
   w=;
X-Host: viking.odc.vzwcorp.com
Received: from casac1exh003.uswin.ad.vzwcorp.com ([10.11.218.45])
  by mercury.verizonwireless.com with ESMTP/TLS/AES128-SHA256; 18 Sep 2017 00:40:35 +0000
Received: from scwexch18apd.uswin.ad.vzwcorp.com (153.114.130.37) by
 CASAC1EXH003.uswin.ad.vzwcorp.com (10.11.218.45) with Microsoft SMTP Server
 (TLS) id 14.3.248.2; Sun, 17 Sep 2017 17:40:35 -0700
Received: from OMZP1LUMXCA18.uswin.ad.vzwcorp.com (144.8.22.196) by
 scwexch18apd.uswin.ad.vzwcorp.com (153.114.130.37) with Microsoft SMTP Server
 (TLS) id 15.0.1263.5; Sun, 17 Sep 2017 17:40:34 -0700
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com (144.8.22.195) by
 OMZP1LUMXCA18.uswin.ad.vzwcorp.com (144.8.22.196) with Microsoft SMTP Server
 (TLS) id 15.0.1263.5; Sun, 17 Sep 2017 19:40:32 -0500
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com ([144.8.22.195]) by
 OMZP1LUMXCA17.uswin.ad.vzwcorp.com ([144.8.22.195]) with mapi id
 15.00.1263.000; Sun, 17 Sep 2017 19:40:32 -0500
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH for 4.9 20/39] MIPS: smp-cps: Fix retrieval of VPE mask on big
 endian CPUs
Thread-Topic: [PATCH for 4.9 20/39] MIPS: smp-cps: Fix retrieval of VPE mask
 on big endian CPUs
Thread-Index: AQHTMBa7cAT55jX4e0aHgSeODMY58w==
Date:   Mon, 18 Sep 2017 00:40:32 +0000
Message-ID: <20170918004024.7247-3-alexander.levin@verizon.com>
References: <20170918004024.7247-1-alexander.levin@verizon.com>
In-Reply-To: <20170918004024.7247-1-alexander.levin@verizon.com>
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
X-archive-position: 60047
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

From: Matt Redfearn <matt.redfearn@imgtec.com>

[ Upstream commit fb2155e3c30dc2043b52020e26965067a3e7779c ]

The vpe_mask member of struct core_boot_config is of type atomic_t,
which is a 32bit type. In cps-vec.S this member was being retrieved by a
PTR_L macro, which on 64bit systems is a 64bit load. On little endian
systems this is OK, since the double word that is retrieved will have
the required less significant word in the correct position. However, on
big endian systems the less significant word of the load is retrieved
from address+4, and the more significant from address+0. The destination
register therefore ends up with the required word in the more
significant word
e.g. when starting the second VP of a big endian 64bit system, the load

PTR_L    ta2, COREBOOTCFG_VPEMASK(a0)

ends up setting register ta2 to 0x0000000300000000

When this value is written to the CPC it is ignored, since it is
invalid to write anything larger than 4 bits. This results in any VP
other than VP0 in a core failing to start in 64bit big endian systems.

Change the load to a 32bit load word instruction to fix the bug.

Fixes: f12401d7219f ("MIPS: smp-cps: Pull boot config retrieval out of mips_cps_boot_vpes")
Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/15787/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
---
 arch/mips/kernel/cps-vec.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
index 59476a607add..a00e87b0256d 100644
--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -361,7 +361,7 @@ LEAF(mips_cps_get_bootcfg)
 	END(mips_cps_get_bootcfg)
 
 LEAF(mips_cps_boot_vpes)
-	PTR_L	ta2, COREBOOTCFG_VPEMASK(a0)
+	lw	ta2, COREBOOTCFG_VPEMASK(a0)
 	PTR_L	ta3, COREBOOTCFG_VPECONFIG(a0)
 
 #if defined(CONFIG_CPU_MIPSR6)
-- 
2.11.0
