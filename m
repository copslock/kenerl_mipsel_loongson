Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Sep 2017 06:46:26 +0200 (CEST)
Received: from omzsmtpe01.verizonbusiness.com ([199.249.25.210]:28137 "EHLO
        omzsmtpe01.verizonbusiness.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991599AbdITEp4OeRj9 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 20 Sep 2017 06:45:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1505882755; x=1537418755;
  h=from:cc:to:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RCTJcZhoXmE8z6CilK9WoCAGbzSVZzwjApYYOp/YkBI=;
  b=bEt6kv3rJ9hGQv0IxU2xy15jPUEgsuxybcWTTzjD110gzlxMGq1+1FSW
   fZXbkZTIbo/EZ5XMMtXCbpimqnJj3Rk8+f0AwE2x2CGRVRucDSzHClSFy
   Us7ap15Ipx26oyIUmQ2ipW9gQNhh2V78k6UVNQ6xcF7r1sFF3kyiW+3DN
   Y=;
Received: from unknown (HELO fldsmtpi03.verizon.com) ([166.68.71.145])
  by omzsmtpe01.verizonbusiness.com with ESMTP; 20 Sep 2017 04:45:48 +0000
From:   "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>
Cc:     Paul Burton <paul.burton@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>
Received: from rogue-10-255-192-101.rogue.vzwcorp.com (HELO atlantis.verizonwireless.com) ([10.255.192.101])
  by fldsmtpi03.verizon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 Sep 2017 04:45:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1505882706; x=1537418706;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RCTJcZhoXmE8z6CilK9WoCAGbzSVZzwjApYYOp/YkBI=;
  b=XNYUPC918/KFisgj/q1RLksl8OtNrDEvJzjOeSdGhdDlcjepqt4qjAAU
   1YyXt4z0U20nUB0BWPAAKN3MDRSmgqO6Dsvxj3hL9EGUBMEv8grgjqck0
   jnTy2MEG+UlvzTVBG8gF+ANhSBExw5pd246t+fnx3vn3nNLQBwbQixQ51
   Q=;
Received: from discovery.odc.vzwcorp.com (HELO mercury.verizonwireless.com) ([10.255.240.25])
  by atlantis.verizonwireless.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 Sep 2017 00:45:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1505882706; x=1537418706;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RCTJcZhoXmE8z6CilK9WoCAGbzSVZzwjApYYOp/YkBI=;
  b=XNYUPC918/KFisgj/q1RLksl8OtNrDEvJzjOeSdGhdDlcjepqt4qjAAU
   1YyXt4z0U20nUB0BWPAAKN3MDRSmgqO6Dsvxj3hL9EGUBMEv8grgjqck0
   jnTy2MEG+UlvzTVBG8gF+ANhSBExw5pd246t+fnx3vn3nNLQBwbQixQ51
   Q=;
X-Host: discovery.odc.vzwcorp.com
Received: from casac1exh003.uswin.ad.vzwcorp.com ([10.11.218.45])
  by mercury.verizonwireless.com with ESMTP/TLS/AES128-SHA256; 20 Sep 2017 04:45:05 +0000
Received: from scwexch25apd.uswin.ad.vzwcorp.com (153.114.130.44) by
 CASAC1EXH003.uswin.ad.vzwcorp.com (10.11.218.45) with Microsoft SMTP Server
 (TLS) id 14.3.248.2; Tue, 19 Sep 2017 21:45:04 -0700
Received: from OMZP1LUMXCA19.uswin.ad.vzwcorp.com (144.8.22.197) by
 scwexch25apd.uswin.ad.vzwcorp.com (153.114.130.44) with Microsoft SMTP Server
 (TLS) id 15.0.1263.5; Tue, 19 Sep 2017 21:45:03 -0700
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com (144.8.22.195) by
 OMZP1LUMXCA19.uswin.ad.vzwcorp.com (144.8.22.197) with Microsoft SMTP Server
 (TLS) id 15.0.1263.5; Tue, 19 Sep 2017 23:45:02 -0500
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com ([144.8.22.195]) by
 OMZP1LUMXCA17.uswin.ad.vzwcorp.com ([144.8.22.195]) with mapi id
 15.00.1263.000; Tue, 19 Sep 2017 23:45:02 -0500
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH review for 4.4 06/47] MIPS: Ensure bss section ends on a
 long-aligned address
Thread-Topic: [PATCH review for 4.4 06/47] MIPS: Ensure bss section ends on a
 long-aligned address
Thread-Index: AQHTMcs3xFA2V0kFwU+TgkC35BD+Nw==
Date:   Wed, 20 Sep 2017 04:45:01 +0000
Message-ID: <20170920044445.7392-6-alexander.levin@verizon.com>
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
X-archive-position: 60077
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

From: Paul Burton <paul.burton@imgtec.com>

[ Upstream commit 3f00f4d8f083bc61005d0a1ef592b149f5c88bbd ]

When clearing the .bss section in kernel_entry we do so using LONG_S
instructions, and branch whilst the current write address doesn't equal
the end of the .bss section minus the size of a long integer. The .bss
section always begins at a long-aligned address and we always increment
the write pointer by the size of a long integer - we therefore rely upon
the .bss section ending at a long-aligned address. If this is not the
case then the long-aligned write address can never be equal to the
non-long-aligned end address & we will continue to increment past the
end of the .bss section, attempting to zero the rest of memory.

Despite this requirement that .bss end at a long-aligned address we pass
0 as the end alignment requirement to the BSS_SECTION macro and thus
don't guarantee any particular alignment, allowing us to hit the error
condition described above.

Fix this by instead passing 8 bytes as the end alignment argument to
the BSS_SECTION macro, ensuring that the end of the .bss section is
always at least long-aligned.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/14526/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
---
 arch/mips/kernel/vmlinux.lds.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index 0a93e83cd014..2026203c41e2 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -159,7 +159,7 @@ SECTIONS
 	 * Force .bss to 64K alignment so that .bss..swapper_pg_dir
 	 * gets that alignment.	 .sbss should be empty, so there will be
 	 * no holes after __init_end. */
-	BSS_SECTION(0, 0x10000, 0)
+	BSS_SECTION(0, 0x10000, 8)
 
 	_end = . ;
 
-- 
2.11.0
