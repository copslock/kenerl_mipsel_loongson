Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Nov 2017 21:53:08 +0100 (CET)
Received: from omzsmtpe03.verizonbusiness.com ([199.249.25.208]:5573 "EHLO
        omzsmtpe03.verizonbusiness.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993905AbdKHUxBj0azC convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 8 Nov 2017 21:53:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=one.verizon.com; i=@one.verizon.com; q=dns/txt;
  s=corp; t=1510174381; x=1541710381;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iAjjKJ/P5mJZXvONkSvWFvQHnmmroi09NqYCX3oF0Vk=;
  b=FFfHMIrIURwy3K6RAGEo4MOiriatuREmEvyJ+JcOoNurIpzLsQ1vA26R
   juyiRhT8nMexCLjigCDde4fPYioslw1i5h70aY+U/+pHRj2EBJCvMMnoe
   QOetsux46Afed0r0QFXdzxTbObH94+iHRSH4la+3KKCkAU2V29Zv0JH7F
   I=;
Received: from unknown (HELO fldsmtpi02.verizon.com) ([166.68.71.144])
  by omzsmtpe03.verizonbusiness.com with ESMTP; 08 Nov 2017 20:52:53 +0000
Received: from rogue-10-255-192-101.rogue.vzwcorp.com (HELO apollo.verizonwireless.com) ([10.255.192.101])
  by fldsmtpi02.verizon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 Nov 2017 20:51:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1510174313; x=1541710313;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iAjjKJ/P5mJZXvONkSvWFvQHnmmroi09NqYCX3oF0Vk=;
  b=Z4QC7kJvKM6cQcmH8N2c/GWUKFwlEot8Kmy4RGBAzt28aFYmaDt22eFp
   C71GpSzLzaua2oZTVDKXBRTJ0Np/FKfdg6471MrtUXkzMUJjM7IebUyi/
   2Tnz4I/MdFCwEFUVS30X9FuyTP95LsRR1jbxQ+1AMvl5DfE7QU7YNZOJu
   c=;
Received: from endeavour.tdc.vzwcorp.com (HELO eris.verizonwireless.com) ([10.254.88.163])
  by apollo.verizonwireless.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 Nov 2017 15:51:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1510174313; x=1541710313;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iAjjKJ/P5mJZXvONkSvWFvQHnmmroi09NqYCX3oF0Vk=;
  b=Z4QC7kJvKM6cQcmH8N2c/GWUKFwlEot8Kmy4RGBAzt28aFYmaDt22eFp
   C71GpSzLzaua2oZTVDKXBRTJ0Np/FKfdg6471MrtUXkzMUJjM7IebUyi/
   2Tnz4I/MdFCwEFUVS30X9FuyTP95LsRR1jbxQ+1AMvl5DfE7QU7YNZOJu
   c=;
X-Host: endeavour.tdc.vzwcorp.com
Received: from ohtwi1exh003.uswin.ad.vzwcorp.com ([10.144.218.45])
  by eris.verizonwireless.com with ESMTP/TLS/AES128-SHA256; 08 Nov 2017 20:51:52 +0000
Received: from OMZP1LUMXCA12.uswin.ad.vzwcorp.com (144.8.22.187) by
 OHTWI1EXH003.uswin.ad.vzwcorp.com (10.144.218.45) with Microsoft SMTP Server
 (TLS) id 14.3.248.2; Wed, 8 Nov 2017 15:51:51 -0500
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com (144.8.22.195) by
 OMZP1LUMXCA12.uswin.ad.vzwcorp.com (144.8.22.187) with Microsoft SMTP Server
 (TLS) id 15.0.1263.5; Wed, 8 Nov 2017 14:51:50 -0600
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com ([144.8.22.195]) by
 OMZP1LUMXCA17.uswin.ad.vzwcorp.com ([144.8.22.195]) with mapi id
 15.00.1263.000; Wed, 8 Nov 2017 14:51:50 -0600
From:   "Levin, Alexander (Sasha Levin)" <alexander.levin@one.verizon.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Levin, Alexander (Sasha Levin)" <alexander.levin@one.verizon.com>
Subject: [PATCH AUTOSEL for-4.4 36/39] MIPS: init: Ensure bootmem does not
 corrupt reserved memory
Thread-Topic: [PATCH AUTOSEL for-4.4 36/39] MIPS: init: Ensure bootmem does
 not corrupt reserved memory
Thread-Index: AQHTWNM+KYtYtgLh+0GHUBoYvIxWmg==
Date:   Wed, 8 Nov 2017 20:50:42 +0000
Message-ID: <20171108205027.27525-36-alexander.levin@verizon.com>
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
X-archive-position: 60761
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

[ Upstream commit d9b5b658210f28ed9f70c757d553e679d76e2986 ]

Current init code initialises bootmem allocator with all of the low
memory that it assumes is available, but does not check for reserved
memory block, which can lead to corruption of data that may be stored
there.
Move bootmem's allocation map to a location that does not cross any
reserved regions

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/14609/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
---
 arch/mips/kernel/setup.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 71 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 8acae316f26b..1acaf0939cb5 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -152,6 +152,35 @@ void __init detect_memory_region(phys_addr_t start, phys_addr_t sz_min, phys_add
 	add_memory_region(start, size, BOOT_MEM_RAM);
 }
 
+bool __init memory_region_available(phys_addr_t start, phys_addr_t size)
+{
+	int i;
+	bool in_ram = false, free = true;
+
+	for (i = 0; i < boot_mem_map.nr_map; i++) {
+		phys_addr_t start_, end_;
+
+		start_ = boot_mem_map.map[i].addr;
+		end_ = boot_mem_map.map[i].addr + boot_mem_map.map[i].size;
+
+		switch (boot_mem_map.map[i].type) {
+		case BOOT_MEM_RAM:
+			if (start >= start_ && start + size <= end_)
+				in_ram = true;
+			break;
+		case BOOT_MEM_RESERVED:
+			if ((start >= start_ && start < end_) ||
+			    (start < start_ && start + size >= start_))
+				free = false;
+			break;
+		default:
+			continue;
+		}
+	}
+
+	return in_ram && free;
+}
+
 static void __init print_memory_map(void)
 {
 	int i;
@@ -300,11 +329,19 @@ static void __init bootmem_init(void)
 
 #else  /* !CONFIG_SGI_IP27 */
 
+static unsigned long __init bootmap_bytes(unsigned long pages)
+{
+	unsigned long bytes = DIV_ROUND_UP(pages, 8);
+
+	return ALIGN(bytes, sizeof(long));
+}
+
 static void __init bootmem_init(void)
 {
 	unsigned long reserved_end;
 	unsigned long mapstart = ~0UL;
 	unsigned long bootmap_size;
+	bool bootmap_valid = false;
 	int i;
 
 	/*
@@ -385,11 +422,42 @@ static void __init bootmem_init(void)
 #endif
 
 	/*
-	 * Initialize the boot-time allocator with low memory only.
+	 * check that mapstart doesn't overlap with any of
+	 * memory regions that have been reserved through eg. DTB
 	 */
-	bootmap_size = init_bootmem_node(NODE_DATA(0), mapstart,
-					 min_low_pfn, max_low_pfn);
+	bootmap_size = bootmap_bytes(max_low_pfn - min_low_pfn);
+
+	bootmap_valid = memory_region_available(PFN_PHYS(mapstart),
+						bootmap_size);
+	for (i = 0; i < boot_mem_map.nr_map && !bootmap_valid; i++) {
+		unsigned long mapstart_addr;
+
+		switch (boot_mem_map.map[i].type) {
+		case BOOT_MEM_RESERVED:
+			mapstart_addr = PFN_ALIGN(boot_mem_map.map[i].addr +
+						boot_mem_map.map[i].size);
+			if (PHYS_PFN(mapstart_addr) < mapstart)
+				break;
+
+			bootmap_valid = memory_region_available(mapstart_addr,
+								bootmap_size);
+			if (bootmap_valid)
+				mapstart = PHYS_PFN(mapstart_addr);
+			break;
+		default:
+			break;
+		}
+	}
 
+	if (!bootmap_valid)
+		panic("No memory area to place a bootmap bitmap");
+
+	/*
+	 * Initialize the boot-time allocator with low memory only.
+	 */
+	if (bootmap_size != init_bootmem_node(NODE_DATA(0), mapstart,
+					 min_low_pfn, max_low_pfn))
+		panic("Unexpected memory size required for bootmap");
 
 	for (i = 0; i < boot_mem_map.nr_map; i++) {
 		unsigned long start, end;
-- 
2.11.0
