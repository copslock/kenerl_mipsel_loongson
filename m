Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Nov 2017 21:56:48 +0100 (CET)
Received: from fldsmtpe03.verizon.com ([140.108.26.142]:58707 "EHLO
        fldsmtpe03.verizon.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993922AbdKHUxlkZLyC convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 8 Nov 2017 21:53:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=one.verizon.com; i=@one.verizon.com; q=dns/txt;
  s=corp; t=1510174421; x=1541710421;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UZEdUT3DWNVfZQsLhjNaToO2Aj/SamDHW/OCpjDVKdQ=;
  b=NONJPuZfYPcHnNJxXfVnieGmAVVOO+NHmkvY5fh2QUH2LNODZQOUfY5i
   tlV5Mpmxlmi8tDSNLqvVb5r/RtZKZK/lm0m0uZ3pJlugcBM4ReC25gl9x
   ueoxKMxDO5AbyCIYnhpMESouYPbwXKyekdrmWi2aZStBWJ5YRC1nzsonT
   8=;
Received: from unknown (HELO fldsmtpi01.verizon.com) ([166.68.71.143])
  by fldsmtpe03.verizon.com with ESMTP; 08 Nov 2017 20:53:32 +0000
Received: from rogue-10-255-192-101.rogue.vzwcorp.com (HELO atlantis.verizonwireless.com) ([10.255.192.101])
  by fldsmtpi01.verizon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 Nov 2017 20:50:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1510174257; x=1541710257;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UZEdUT3DWNVfZQsLhjNaToO2Aj/SamDHW/OCpjDVKdQ=;
  b=puHTg7u40Zl9hSuCv69nQhtupODuYGG6yfnohEGq3Tz4fySWb7eOnexN
   f5CAmsBHDKNMNL1EdbV4Q2mQ/9ERsY92jC0jjJ1EE1qC7kXrPvjHtdnUH
   nYUvmGIBEOzSuvpEUEThtKjhtvyMifOprrgImFqNY/hSwHPDCgWCAd5pI
   Y=;
Received: from mariner.tdc.vzwcorp.com (HELO eris.verizonwireless.com) ([10.254.88.84])
  by atlantis.verizonwireless.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 Nov 2017 15:50:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1510174257; x=1541710257;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UZEdUT3DWNVfZQsLhjNaToO2Aj/SamDHW/OCpjDVKdQ=;
  b=puHTg7u40Zl9hSuCv69nQhtupODuYGG6yfnohEGq3Tz4fySWb7eOnexN
   f5CAmsBHDKNMNL1EdbV4Q2mQ/9ERsY92jC0jjJ1EE1qC7kXrPvjHtdnUH
   nYUvmGIBEOzSuvpEUEThtKjhtvyMifOprrgImFqNY/hSwHPDCgWCAd5pI
   Y=;
X-Host: mariner.tdc.vzwcorp.com
Received: from ohtwi1exh003.uswin.ad.vzwcorp.com ([10.144.218.45])
  by eris.verizonwireless.com with ESMTP/TLS/AES128-SHA256; 08 Nov 2017 20:50:57 +0000
Received: from tbwexch08apd.uswin.ad.vzwcorp.com (153.114.162.32) by
 OHTWI1EXH003.uswin.ad.vzwcorp.com (10.144.218.45) with Microsoft SMTP Server
 (TLS) id 14.3.248.2; Wed, 8 Nov 2017 15:50:57 -0500
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com (144.8.22.195) by
 tbwexch08apd.uswin.ad.vzwcorp.com (153.114.162.32) with Microsoft SMTP Server
 (TLS) id 15.0.1263.5; Wed, 8 Nov 2017 15:50:56 -0500
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com (144.8.22.195) by
 OMZP1LUMXCA17.uswin.ad.vzwcorp.com (144.8.22.195) with Microsoft SMTP Server
 (TLS) id 15.0.1263.5; Wed, 8 Nov 2017 14:50:55 -0600
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com ([144.8.22.195]) by
 OMZP1LUMXCA17.uswin.ad.vzwcorp.com ([144.8.22.195]) with mapi id
 15.00.1263.000; Wed, 8 Nov 2017 14:50:55 -0600
From:   "Levin, Alexander (Sasha Levin)" <alexander.levin@one.verizon.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Levin, Alexander (Sasha Levin)" <alexander.levin@one.verizon.com>
Subject: [PATCH AUTOSEL for-4.9 50/53] MIPS: init: Ensure reserved memory
 regions are not added to bootmem
Thread-Topic: [PATCH AUTOSEL for-4.9 50/53] MIPS: init: Ensure reserved memory
 regions are not added to bootmem
Thread-Index: AQHTWNMobceePwY/N0CXCkumr3M0VQ==
Date:   Wed, 8 Nov 2017 20:50:07 +0000
Message-ID: <20171108204940.27321-50-alexander.levin@verizon.com>
References: <20171108204940.27321-1-alexander.levin@verizon.com>
In-Reply-To: <20171108204940.27321-1-alexander.levin@verizon.com>
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
X-archive-position: 60771
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
index 265605771fb9..695950361d2a 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -551,6 +551,10 @@ static void __init bootmem_init(void)
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
