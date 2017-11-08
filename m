Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Nov 2017 21:57:36 +0100 (CET)
Received: from fldsmtpe03.verizon.com ([140.108.26.142]:58707 "EHLO
        fldsmtpe03.verizon.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993924AbdKHUxmsM6RC convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 8 Nov 2017 21:53:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=one.verizon.com; i=@one.verizon.com; q=dns/txt;
  s=corp; t=1510174422; x=1541710422;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zh7Wcy8UQCqCWoYvvaxSKrLvsnrjGH+PzT/2uKTwZvQ=;
  b=uA60UCQ0we6HswMBIbdDLS5zQTDgrj2szRIH82uJE2L5+Rj0xKl5AGxb
   Oc450r4GbrH3YwPn2RZtmwIUY/LhXh6ixCTEYMjO1m9mUezO33a1auBim
   jlYKM0I7gjtOZ5FAL3U6P0NgZzHclu4Y+JwbSIXuLje1POjKfyWbbU4xS
   E=;
Received: from unknown (HELO fldsmtpi01.verizon.com) ([166.68.71.143])
  by fldsmtpe03.verizon.com with ESMTP; 08 Nov 2017 20:53:32 +0000
Received: from rogue-10-255-192-101.rogue.vzwcorp.com (HELO apollo.verizonwireless.com) ([10.255.192.101])
  by fldsmtpi01.verizon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 Nov 2017 20:50:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1510174256; x=1541710256;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zh7Wcy8UQCqCWoYvvaxSKrLvsnrjGH+PzT/2uKTwZvQ=;
  b=bAqxgNzTeyrR+3+gZB2/BA8qOZ5gCEh19GkAdQM57IT1DJVz+FBCSnBs
   8w9m/WQGC1RIXr8QlTR50h7VcTnHhpkYksEzGzq3NxbbWl/7pn+d9Dc++
   Njm3v2AMYIp/1/cOUu+fQaEluKgT3sDxOst3QSeE9yLE9Cf8Sb05fg6nk
   Y=;
Received: from surveyor.tdc.vzwcorp.com (HELO eris.verizonwireless.com) ([10.254.88.83])
  by apollo.verizonwireless.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 Nov 2017 15:50:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1510174256; x=1541710256;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zh7Wcy8UQCqCWoYvvaxSKrLvsnrjGH+PzT/2uKTwZvQ=;
  b=bAqxgNzTeyrR+3+gZB2/BA8qOZ5gCEh19GkAdQM57IT1DJVz+FBCSnBs
   8w9m/WQGC1RIXr8QlTR50h7VcTnHhpkYksEzGzq3NxbbWl/7pn+d9Dc++
   Njm3v2AMYIp/1/cOUu+fQaEluKgT3sDxOst3QSeE9yLE9Cf8Sb05fg6nk
   Y=;
X-Host: surveyor.tdc.vzwcorp.com
Received: from ohtwi1exh001.uswin.ad.vzwcorp.com ([10.144.218.43])
  by eris.verizonwireless.com with ESMTP/TLS/AES128-SHA256; 08 Nov 2017 20:50:56 +0000
Received: from tbwexch17apd.uswin.ad.vzwcorp.com (153.114.162.41) by
 OHTWI1EXH001.uswin.ad.vzwcorp.com (10.144.218.43) with Microsoft SMTP Server
 (TLS) id 14.3.248.2; Wed, 8 Nov 2017 15:50:56 -0500
Received: from OMZP1LUMXCA11.uswin.ad.vzwcorp.com (144.8.22.186) by
 tbwexch17apd.uswin.ad.vzwcorp.com (153.114.162.41) with Microsoft SMTP Server
 (TLS) id 15.0.1263.5; Wed, 8 Nov 2017 15:50:56 -0500
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com (144.8.22.195) by
 OMZP1LUMXCA11.uswin.ad.vzwcorp.com (144.8.22.186) with Microsoft SMTP Server
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
Subject: [PATCH AUTOSEL for-4.9 49/53] MIPS: init: Ensure bootmem does not
 corrupt reserved memory
Thread-Topic: [PATCH AUTOSEL for-4.9 49/53] MIPS: init: Ensure bootmem does
 not corrupt reserved memory
Thread-Index: AQHTWNMoMuOp5tLLAUmyiM7i3iaOXw==
Date:   Wed, 8 Nov 2017 20:50:06 +0000
Message-ID: <20171108204940.27321-49-alexander.levin@verizon.com>
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
X-archive-position: 60773
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
index f66e5ce505b2..265605771fb9 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -153,6 +153,35 @@ void __init detect_memory_region(phys_addr_t start, phys_addr_t sz_min, phys_add
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
@@ -332,11 +361,19 @@ static void __init bootmem_init(void)
 
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
@@ -430,11 +467,42 @@ static void __init bootmem_init(void)
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
