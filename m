Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Sep 2017 17:53:55 +0200 (CEST)
Received: from fldsmtpe03.verizon.com ([140.108.26.142]:7884 "EHLO
        fldsmtpe03.verizon.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994730AbdINPwjqtWAc convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 14 Sep 2017 17:52:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1505404359; x=1536940359;
  h=from:cc:to:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jUhVEeyq3V3y5FEPBskooRH2JZMn1huJn8IGNJTpMOM=;
  b=tdOuFdIBR9F/G7BnkfoMcqULwtYV/sMsOQOpjpMEtRcp9eSIBedLEpXv
   YhmATeiEEKK7vpxg/9ax5u6xEasf+yWbuUry0QluDjt20rzCR6ZYn4q5H
   k0acK4Uk20djTS0XiKNMp2OjSSyuFB8XwgcsJhcupMRrVdRKUNRRiaUNy
   c=;
Received: from unknown (HELO fldsmtpi02.verizon.com) ([166.68.71.144])
  by fldsmtpe03.verizon.com with ESMTP; 14 Sep 2017 15:52:29 +0000
From:   "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>
Cc:     Paul Burton <paul.burton@imgtec.com>,
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
  bh=jUhVEeyq3V3y5FEPBskooRH2JZMn1huJn8IGNJTpMOM=;
  b=T+vhrkRIUZYS1n6sKcWeJmjCANSuEQxRksZR/ZHA4PKUAFH/SiPyIL1n
   lQRcKazDJOixqyQcl2ZUYg5Ys2g0wM7Iy5O/oA1jMxgfrXlh5ZIL2fK0P
   nkkbrnCOSeGzzl6JPORyfopSLehWjo9hDkyqISlEspsa1X+6dnnidkdQS
   c=;
Received: from challenger.odc.vzwcorp.com (HELO mercury.verizonwireless.com) ([10.255.240.24])
  by apollo.verizonwireless.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Sep 2017 11:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1505404283; x=1536940283;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jUhVEeyq3V3y5FEPBskooRH2JZMn1huJn8IGNJTpMOM=;
  b=T+vhrkRIUZYS1n6sKcWeJmjCANSuEQxRksZR/ZHA4PKUAFH/SiPyIL1n
   lQRcKazDJOixqyQcl2ZUYg5Ys2g0wM7Iy5O/oA1jMxgfrXlh5ZIL2fK0P
   nkkbrnCOSeGzzl6JPORyfopSLehWjo9hDkyqISlEspsa1X+6dnnidkdQS
   c=;
X-Host: challenger.odc.vzwcorp.com
Received: from casac1exh001.uswin.ad.vzwcorp.com ([10.11.218.43])
  by mercury.verizonwireless.com with ESMTP/TLS/AES128-SHA256; 14 Sep 2017 15:51:23 +0000
Received: from scwexch12apd.uswin.ad.vzwcorp.com (153.114.130.31) by
 CASAC1EXH001.uswin.ad.vzwcorp.com (10.11.218.43) with Microsoft SMTP Server
 (TLS) id 14.3.248.2; Thu, 14 Sep 2017 08:51:12 -0700
Received: from OMZP1LUMXCA20.uswin.ad.vzwcorp.com (144.8.22.198) by
 scwexch12apd.uswin.ad.vzwcorp.com (153.114.130.31) with Microsoft SMTP Server
 (TLS) id 15.0.1263.5; Thu, 14 Sep 2017 08:51:11 -0700
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com (144.8.22.195) by
 OMZP1LUMXCA20.uswin.ad.vzwcorp.com (144.8.22.198) with Microsoft SMTP Server
 (TLS) id 15.0.1263.5; Thu, 14 Sep 2017 10:51:10 -0500
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com ([144.8.22.195]) by
 OMZP1LUMXCA17.uswin.ad.vzwcorp.com ([144.8.22.195]) with mapi id
 15.00.1263.000; Thu, 14 Sep 2017 10:51:10 -0500
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH for 4.9 10/59] MIPS: Ensure bss section ends on a long-aligned
 address
Thread-Topic: [PATCH for 4.9 10/59] MIPS: Ensure bss section ends on a
 long-aligned address
Thread-Index: AQHTLXFHcO+koevglk6BO8QsYtCUPg==
Date:   Thu, 14 Sep 2017 15:51:07 +0000
Message-ID: <20170914155051.8289-10-alexander.levin@verizon.com>
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
X-archive-position: 59999
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
index d5de67591735..f0a0e6d62be3 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -182,7 +182,7 @@ SECTIONS
 	 * Force .bss to 64K alignment so that .bss..swapper_pg_dir
 	 * gets that alignment.	 .sbss should be empty, so there will be
 	 * no holes after __init_end. */
-	BSS_SECTION(0, 0x10000, 0)
+	BSS_SECTION(0, 0x10000, 8)
 
 	_end = . ;
 
-- 
2.11.0
