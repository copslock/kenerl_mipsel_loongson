Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Sep 2017 06:47:39 +0200 (CEST)
Received: from omzsmtpe03.verizonbusiness.com ([199.249.25.208]:33057 "EHLO
        omzsmtpe03.verizonbusiness.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992079AbdITEqeUFCo9 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 20 Sep 2017 06:46:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1505882794; x=1537418794;
  h=from:cc:to:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x3YgxNEfv101HJGSPV9Drpm9fy68Io1AoqCJNGQKJBI=;
  b=GAS5rFtRVdQw6uA2kl4nSTSZEpf0AJUAFhnEAjXLyFWazxwvLglKEcZG
   tbIog8+Mr/czaAt9DDmuTIepXDrmi6OqeGa2V7eRCHDe2oHXC5bkxH8DN
   /H/wP3mVa2r9BSCiKDOaDu1/oGkA0SpD03l6UF/W9Q2lnq/2NTouVWzU/
   0=;
Received: from unknown (HELO fldsmtpi02.verizon.com) ([166.68.71.144])
  by omzsmtpe03.verizonbusiness.com with ESMTP; 20 Sep 2017 04:46:27 +0000
From:   "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>
Cc:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>
Received: from rogue-10-255-192-101.rogue.vzwcorp.com (HELO atlantis.verizonwireless.com) ([10.255.192.101])
  by fldsmtpi02.verizon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 Sep 2017 04:46:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1505882764; x=1537418764;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x3YgxNEfv101HJGSPV9Drpm9fy68Io1AoqCJNGQKJBI=;
  b=BK7O/+3Myf72VuYR1/dwNcunTQTvlDKiTkBuS/vcf+nBJzXr4APpOiPz
   zBehSHChHkTuOwVn0JyNUfEgB7XRzsDvPkJ3kx7USKIs8THj7k4pl1QZ4
   7YZPCj0190Hu7A98xc4LlpDKE6vO/0vzQjDipmoQ4ediTnOnaaJULQ+/4
   8=;
Received: from challenger.odc.vzwcorp.com (HELO mercury.verizonwireless.com) ([10.255.240.24])
  by atlantis.verizonwireless.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 Sep 2017 00:46:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1505882764; x=1537418764;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x3YgxNEfv101HJGSPV9Drpm9fy68Io1AoqCJNGQKJBI=;
  b=BK7O/+3Myf72VuYR1/dwNcunTQTvlDKiTkBuS/vcf+nBJzXr4APpOiPz
   zBehSHChHkTuOwVn0JyNUfEgB7XRzsDvPkJ3kx7USKIs8THj7k4pl1QZ4
   7YZPCj0190Hu7A98xc4LlpDKE6vO/0vzQjDipmoQ4ediTnOnaaJULQ+/4
   8=;
X-Host: challenger.odc.vzwcorp.com
Received: from casac1exh003.uswin.ad.vzwcorp.com ([10.11.218.45])
  by mercury.verizonwireless.com with ESMTP/TLS/AES128-SHA256; 20 Sep 2017 04:46:03 +0000
Received: from scwexch08apd.uswin.ad.vzwcorp.com (153.114.130.27) by
 CASAC1EXH003.uswin.ad.vzwcorp.com (10.11.218.45) with Microsoft SMTP Server
 (TLS) id 14.3.248.2; Tue, 19 Sep 2017 21:46:03 -0700
Received: from OMZP1LUMXCA19.uswin.ad.vzwcorp.com (144.8.22.197) by
 scwexch08apd.uswin.ad.vzwcorp.com (153.114.130.27) with Microsoft SMTP Server
 (TLS) id 15.0.1263.5; Tue, 19 Sep 2017 21:46:02 -0700
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com (144.8.22.195) by
 OMZP1LUMXCA19.uswin.ad.vzwcorp.com (144.8.22.197) with Microsoft SMTP Server
 (TLS) id 15.0.1263.5; Tue, 19 Sep 2017 23:46:01 -0500
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com ([144.8.22.195]) by
 OMZP1LUMXCA17.uswin.ad.vzwcorp.com ([144.8.22.195]) with mapi id
 15.00.1263.000; Tue, 19 Sep 2017 23:46:01 -0500
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH review for 3.18 04/30] MIPS: kexec: Do not reserve invalid
 crashkernel memory on boot
Thread-Topic: [PATCH review for 3.18 04/30] MIPS: kexec: Do not reserve
 invalid crashkernel memory on boot
Thread-Index: AQHTMctV/kYI9S3pBUuJ5Rxr0PLvDg==
Date:   Wed, 20 Sep 2017 04:45:51 +0000
Message-ID: <20170920044542.7571-4-alexander.levin@verizon.com>
References: <20170920044542.7571-1-alexander.levin@verizon.com>
In-Reply-To: <20170920044542.7571-1-alexander.levin@verizon.com>
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
X-archive-position: 60080
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
index f3b635f86c39..e3f552642a68 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -585,6 +585,11 @@ static void __init mips_parse_crashkernel(void)
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
