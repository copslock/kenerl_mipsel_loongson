Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Sep 2017 17:53:33 +0200 (CEST)
Received: from fldsmtpe03.verizon.com ([140.108.26.142]:7884 "EHLO
        fldsmtpe03.verizon.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994729AbdINPwjKaMXc convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 14 Sep 2017 17:52:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1505404359; x=1536940359;
  h=from:cc:to:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bFa6w9k5Tyhq62oq2fZGUxwd7gI0HGo0BGHo1dALF/s=;
  b=Kkmost8TlFtqPY+YhFzwxmb74exkNT/T55bPinAp3BhTUivTlR2LiybY
   iI98M5JH1feqE+fp9WHAzcJh7iYSy+Lf3UcXK6gA3dNGVl3uHvS+OSzZR
   cARJ9ijNKiAvJRQsQCXpCP8Cv5xehicvZM11lSOfRlww755Bv/CTnEXzs
   g=;
Received: from unknown (HELO fldsmtpi02.verizon.com) ([166.68.71.144])
  by fldsmtpe03.verizon.com with ESMTP; 14 Sep 2017 15:52:29 +0000
From:   "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>
Cc:     John Crispin <john@phrozen.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>
Received: from rogue-10-255-192-101.rogue.vzwcorp.com (HELO apollo.verizonwireless.com) ([10.255.192.101])
  by fldsmtpi02.verizon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Sep 2017 15:52:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1505404324; x=1536940324;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bFa6w9k5Tyhq62oq2fZGUxwd7gI0HGo0BGHo1dALF/s=;
  b=FmHtmc/TQu6sk9yAkRTeFA6Jy12jtCz4DH1HExxVm7v3H4+5kuPlVmJb
   XZqTUaIx1Ac8U3XxYJYa3refw1Yp4vRpZxBWIPuBvyrkyabrSo2GHKoE9
   dyX1VXveD0pdEp5lgXKK96H6NKk/IJW2gAw2yr7XqJc9+6XK7RQcRfLjb
   k=;
Received: from ranger.odc.vzwcorp.com (HELO mercury.verizonwireless.com) ([10.255.240.27])
  by apollo.verizonwireless.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Sep 2017 11:52:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1505404324; x=1536940324;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bFa6w9k5Tyhq62oq2fZGUxwd7gI0HGo0BGHo1dALF/s=;
  b=FmHtmc/TQu6sk9yAkRTeFA6Jy12jtCz4DH1HExxVm7v3H4+5kuPlVmJb
   XZqTUaIx1Ac8U3XxYJYa3refw1Yp4vRpZxBWIPuBvyrkyabrSo2GHKoE9
   dyX1VXveD0pdEp5lgXKK96H6NKk/IJW2gAw2yr7XqJc9+6XK7RQcRfLjb
   k=;
X-Host: ranger.odc.vzwcorp.com
Received: from casac1exh002.uswin.ad.vzwcorp.com ([10.11.218.44])
  by mercury.verizonwireless.com with ESMTP/TLS/AES128-SHA256; 14 Sep 2017 15:51:46 +0000
Received: from scwexch13apd.uswin.ad.vzwcorp.com (153.114.130.32) by
 CASAC1EXH002.uswin.ad.vzwcorp.com (10.11.218.44) with Microsoft SMTP Server
 (TLS) id 14.3.248.2; Thu, 14 Sep 2017 08:51:27 -0700
Received: from OMZP1LUMXCA13.uswin.ad.vzwcorp.com (144.8.22.188) by
 scwexch13apd.uswin.ad.vzwcorp.com (153.114.130.32) with Microsoft SMTP Server
 (TLS) id 15.0.1263.5; Thu, 14 Sep 2017 08:51:26 -0700
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com (144.8.22.195) by
 OMZP1LUMXCA13.uswin.ad.vzwcorp.com (144.8.22.188) with Microsoft SMTP Server
 (TLS) id 15.0.1263.5; Thu, 14 Sep 2017 10:51:12 -0500
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com ([144.8.22.195]) by
 OMZP1LUMXCA17.uswin.ad.vzwcorp.com ([144.8.22.195]) with mapi id
 15.00.1263.000; Thu, 14 Sep 2017 10:51:12 -0500
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH for 4.9 13/59] MIPS: ralink: Fix a typo in the pinmux setup.
Thread-Topic: [PATCH for 4.9 13/59] MIPS: ralink: Fix a typo in the pinmux
 setup.
Thread-Index: AQHTLXFH7CzyMwlt6UyMcRErWHDq6Q==
Date:   Thu, 14 Sep 2017 15:51:08 +0000
Message-ID: <20170914155051.8289-13-alexander.levin@verizon.com>
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
X-archive-position: 59998
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

From: John Crispin <john@phrozen.org>

[ Upstream commit 58181a117d353427127a2e7afc7cf1ab44759828 ]

There is a typo inside the pinmux setup code. The function is really
called utif and not util. This was recently discovered when people were
trying to make the UTIF interface work.

Signed-off-by: John Crispin <john@phrozen.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/14899/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
---
 arch/mips/ralink/mt7620.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
index 3c7c9bf57bf3..6f892c1f3ad7 100644
--- a/arch/mips/ralink/mt7620.c
+++ b/arch/mips/ralink/mt7620.c
@@ -176,7 +176,7 @@ static struct rt2880_pmx_func spi_cs1_grp_mt7628[] = {
 
 static struct rt2880_pmx_func spis_grp_mt7628[] = {
 	FUNC("pwm_uart2", 3, 14, 4),
-	FUNC("util", 2, 14, 4),
+	FUNC("utif", 2, 14, 4),
 	FUNC("gpio", 1, 14, 4),
 	FUNC("spis", 0, 14, 4),
 };
@@ -190,28 +190,28 @@ static struct rt2880_pmx_func gpio_grp_mt7628[] = {
 
 static struct rt2880_pmx_func p4led_kn_grp_mt7628[] = {
 	FUNC("jtag", 3, 30, 1),
-	FUNC("util", 2, 30, 1),
+	FUNC("utif", 2, 30, 1),
 	FUNC("gpio", 1, 30, 1),
 	FUNC("p4led_kn", 0, 30, 1),
 };
 
 static struct rt2880_pmx_func p3led_kn_grp_mt7628[] = {
 	FUNC("jtag", 3, 31, 1),
-	FUNC("util", 2, 31, 1),
+	FUNC("utif", 2, 31, 1),
 	FUNC("gpio", 1, 31, 1),
 	FUNC("p3led_kn", 0, 31, 1),
 };
 
 static struct rt2880_pmx_func p2led_kn_grp_mt7628[] = {
 	FUNC("jtag", 3, 32, 1),
-	FUNC("util", 2, 32, 1),
+	FUNC("utif", 2, 32, 1),
 	FUNC("gpio", 1, 32, 1),
 	FUNC("p2led_kn", 0, 32, 1),
 };
 
 static struct rt2880_pmx_func p1led_kn_grp_mt7628[] = {
 	FUNC("jtag", 3, 33, 1),
-	FUNC("util", 2, 33, 1),
+	FUNC("utif", 2, 33, 1),
 	FUNC("gpio", 1, 33, 1),
 	FUNC("p1led_kn", 0, 33, 1),
 };
@@ -232,28 +232,28 @@ static struct rt2880_pmx_func wled_kn_grp_mt7628[] = {
 
 static struct rt2880_pmx_func p4led_an_grp_mt7628[] = {
 	FUNC("jtag", 3, 39, 1),
-	FUNC("util", 2, 39, 1),
+	FUNC("utif", 2, 39, 1),
 	FUNC("gpio", 1, 39, 1),
 	FUNC("p4led_an", 0, 39, 1),
 };
 
 static struct rt2880_pmx_func p3led_an_grp_mt7628[] = {
 	FUNC("jtag", 3, 40, 1),
-	FUNC("util", 2, 40, 1),
+	FUNC("utif", 2, 40, 1),
 	FUNC("gpio", 1, 40, 1),
 	FUNC("p3led_an", 0, 40, 1),
 };
 
 static struct rt2880_pmx_func p2led_an_grp_mt7628[] = {
 	FUNC("jtag", 3, 41, 1),
-	FUNC("util", 2, 41, 1),
+	FUNC("utif", 2, 41, 1),
 	FUNC("gpio", 1, 41, 1),
 	FUNC("p2led_an", 0, 41, 1),
 };
 
 static struct rt2880_pmx_func p1led_an_grp_mt7628[] = {
 	FUNC("jtag", 3, 42, 1),
-	FUNC("util", 2, 42, 1),
+	FUNC("utif", 2, 42, 1),
 	FUNC("gpio", 1, 42, 1),
 	FUNC("p1led_an", 0, 42, 1),
 };
-- 
2.11.0
