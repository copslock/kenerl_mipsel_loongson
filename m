Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Nov 2017 21:57:58 +0100 (CET)
Received: from fldsmtpe03.verizon.com ([140.108.26.142]:58707 "EHLO
        fldsmtpe03.verizon.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993906AbdKHUxn1763C convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 8 Nov 2017 21:53:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=one.verizon.com; i=@one.verizon.com; q=dns/txt;
  s=corp; t=1510174423; x=1541710423;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KKBSpxbLMKQQzEwUUTcjsTKbuVREDRYFQlKXWXpfSJE=;
  b=Csex/KGJjRrylOQvXfh6EuOj8ED3Y00Mc59hJ1/+wnDpkITaNlV7RJCT
   VB2jtUC9yQ7z6KTscMDr/iStJdxySreGNmC0cXL94uVd1zIkmgJwIFLXR
   1wYokOOcLXthbpJb6GGbhsDgZXYGCQmQNlO789Tq9EZxIkeFYG7l5T931
   U=;
Received: from unknown (HELO fldsmtpi01.verizon.com) ([166.68.71.143])
  by fldsmtpe03.verizon.com with ESMTP; 08 Nov 2017 20:53:32 +0000
Received: from rogue-10-255-192-101.rogue.vzwcorp.com (HELO apollo.verizonwireless.com) ([10.255.192.101])
  by fldsmtpi01.verizon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 Nov 2017 20:50:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1510174258; x=1541710258;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KKBSpxbLMKQQzEwUUTcjsTKbuVREDRYFQlKXWXpfSJE=;
  b=BcCpLseaAPhLf4fKMXn0F24nrqEeOrUdvw5EafyrIBgtfnEfKgksCOtK
   4mEmmNwtGw2Z7mW3wSdn2kXdiheKaigvK1QJD4sCh2NvKJwUlBphxDOw6
   1sQIfbbi5+YIrH+n8qMbvh8tXs0KImxRDl2Vm99Bak07RkGuvT+rLGSGN
   0=;
Received: from endeavour.tdc.vzwcorp.com (HELO eris.verizonwireless.com) ([10.254.88.163])
  by apollo.verizonwireless.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 Nov 2017 15:50:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=verizon.com; i=@verizon.com; q=dns/txt; s=corp;
  t=1510174258; x=1541710258;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KKBSpxbLMKQQzEwUUTcjsTKbuVREDRYFQlKXWXpfSJE=;
  b=BcCpLseaAPhLf4fKMXn0F24nrqEeOrUdvw5EafyrIBgtfnEfKgksCOtK
   4mEmmNwtGw2Z7mW3wSdn2kXdiheKaigvK1QJD4sCh2NvKJwUlBphxDOw6
   1sQIfbbi5+YIrH+n8qMbvh8tXs0KImxRDl2Vm99Bak07RkGuvT+rLGSGN
   0=;
X-Host: endeavour.tdc.vzwcorp.com
Received: from ohtwi1exh003.uswin.ad.vzwcorp.com ([10.144.218.45])
  by eris.verizonwireless.com with ESMTP/TLS/AES128-SHA256; 08 Nov 2017 20:50:57 +0000
Received: from tbwexch11apd.uswin.ad.vzwcorp.com (153.114.162.35) by
 OHTWI1EXH003.uswin.ad.vzwcorp.com (10.144.218.45) with Microsoft SMTP Server
 (TLS) id 14.3.248.2; Wed, 8 Nov 2017 15:50:58 -0500
Received: from OMZP1LUMXCA16.uswin.ad.vzwcorp.com (144.8.22.194) by
 tbwexch11apd.uswin.ad.vzwcorp.com (153.114.162.35) with Microsoft SMTP Server
 (TLS) id 15.0.1263.5; Wed, 8 Nov 2017 15:50:57 -0500
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com (144.8.22.195) by
 OMZP1LUMXCA16.uswin.ad.vzwcorp.com (144.8.22.194) with Microsoft SMTP Server
 (TLS) id 15.0.1263.5; Wed, 8 Nov 2017 14:50:56 -0600
Received: from OMZP1LUMXCA17.uswin.ad.vzwcorp.com ([144.8.22.195]) by
 OMZP1LUMXCA17.uswin.ad.vzwcorp.com ([144.8.22.195]) with mapi id
 15.00.1263.000; Wed, 8 Nov 2017 14:50:56 -0600
From:   "Levin, Alexander (Sasha Levin)" <alexander.levin@one.verizon.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Levin, Alexander (Sasha Levin)" <alexander.levin@one.verizon.com>
Subject: [PATCH AUTOSEL for-4.9 51/53] MIPS: traps: Ensure L1 & L2 ECC
 checking match for CM3 systems
Thread-Topic: [PATCH AUTOSEL for-4.9 51/53] MIPS: traps: Ensure L1 & L2 ECC
 checking match for CM3 systems
Thread-Index: AQHTWNMpP8yWTbKH/EypxOJcEUbBhA==
Date:   Wed, 8 Nov 2017 20:50:07 +0000
Message-ID: <20171108204940.27321-51-alexander.levin@verizon.com>
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
X-archive-position: 60774
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

From: Paul Burton <paul.burton@imgtec.com>

[ Upstream commit 35e6de38858f59b6b65dcfeaf700b5d06fc2b93d ]

On systems with CM3, we must ensure that the L1 & L2 ECC enables are set
to the same value. This is presumed by the hardware & cache corruption
can occur when it is not the case. Support enabling & disabling the L2
ECC checking on CM3 systems where this is controlled via a GCR, and
ensure that it matches the state of L1 ECC checking. Remove I6400 from
the switch statement it will no longer hit, and which was incorrect
since the L2 ECC enable bit isn't in the CP0 ErrCtl register.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/14413/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
---
 arch/mips/include/asm/mips-cm.h |  7 +++++
 arch/mips/kernel/traps.c        | 63 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 67 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
index 2e4180797b21..cfdbab015769 100644
--- a/arch/mips/include/asm/mips-cm.h
+++ b/arch/mips/include/asm/mips-cm.h
@@ -187,6 +187,7 @@ BUILD_CM_R_(config,		MIPS_CM_GCB_OFS + 0x00)
 BUILD_CM_RW(base,		MIPS_CM_GCB_OFS + 0x08)
 BUILD_CM_RW(access,		MIPS_CM_GCB_OFS + 0x20)
 BUILD_CM_R_(rev,		MIPS_CM_GCB_OFS + 0x30)
+BUILD_CM_RW(err_control,	MIPS_CM_GCB_OFS + 0x38)
 BUILD_CM_RW(error_mask,		MIPS_CM_GCB_OFS + 0x40)
 BUILD_CM_RW(error_cause,	MIPS_CM_GCB_OFS + 0x48)
 BUILD_CM_RW(error_addr,		MIPS_CM_GCB_OFS + 0x50)
@@ -266,6 +267,12 @@ BUILD_CM_Cx_R_(tcid_8_priority,	0x80)
 #define CM_REV_CM2_5				CM_ENCODE_REV(7, 0)
 #define CM_REV_CM3				CM_ENCODE_REV(8, 0)
 
+/* GCR_ERR_CONTROL register fields */
+#define CM_GCR_ERR_CONTROL_L2_ECC_EN_SHF	1
+#define CM_GCR_ERR_CONTROL_L2_ECC_EN_MSK	(_ULCAST_(0x1) << 1)
+#define CM_GCR_ERR_CONTROL_L2_ECC_SUPPORT_SHF	0
+#define CM_GCR_ERR_CONTROL_L2_ECC_SUPPORT_MSK	(_ULCAST_(0x1) << 0)
+
 /* GCR_ERROR_CAUSE register fields */
 #define CM_GCR_ERROR_CAUSE_ERRTYPE_SHF		27
 #define CM_GCR_ERROR_CAUSE_ERRTYPE_MSK		(_ULCAST_(0x1f) << 27)
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index b0b29cb6f3d8..bb1d9ff1be5c 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -51,6 +51,7 @@
 #include <asm/idle.h>
 #include <asm/mips-cm.h>
 #include <asm/mips-r2-to-r6-emul.h>
+#include <asm/mips-cm.h>
 #include <asm/mipsregs.h>
 #include <asm/mipsmtregs.h>
 #include <asm/module.h>
@@ -1646,6 +1647,65 @@ __setup("nol2par", nol2parity);
  */
 static inline void parity_protection_init(void)
 {
+#define ERRCTL_PE	0x80000000
+#define ERRCTL_L2P	0x00800000
+
+	if (mips_cm_revision() >= CM_REV_CM3) {
+		ulong gcr_ectl, cp0_ectl;
+
+		/*
+		 * With CM3 systems we need to ensure that the L1 & L2
+		 * parity enables are set to the same value, since this
+		 * is presumed by the hardware engineers.
+		 *
+		 * If the user disabled either of L1 or L2 ECC checking,
+		 * disable both.
+		 */
+		l1parity &= l2parity;
+		l2parity &= l1parity;
+
+		/* Probe L1 ECC support */
+		cp0_ectl = read_c0_ecc();
+		write_c0_ecc(cp0_ectl | ERRCTL_PE);
+		back_to_back_c0_hazard();
+		cp0_ectl = read_c0_ecc();
+
+		/* Probe L2 ECC support */
+		gcr_ectl = read_gcr_err_control();
+
+		if (!(gcr_ectl & CM_GCR_ERR_CONTROL_L2_ECC_SUPPORT_MSK) ||
+		    !(cp0_ectl & ERRCTL_PE)) {
+			/*
+			 * One of L1 or L2 ECC checking isn't supported,
+			 * so we cannot enable either.
+			 */
+			l1parity = l2parity = 0;
+		}
+
+		/* Configure L1 ECC checking */
+		if (l1parity)
+			cp0_ectl |= ERRCTL_PE;
+		else
+			cp0_ectl &= ~ERRCTL_PE;
+		write_c0_ecc(cp0_ectl);
+		back_to_back_c0_hazard();
+		WARN_ON(!!(read_c0_ecc() & ERRCTL_PE) != l1parity);
+
+		/* Configure L2 ECC checking */
+		if (l2parity)
+			gcr_ectl |= CM_GCR_ERR_CONTROL_L2_ECC_EN_MSK;
+		else
+			gcr_ectl &= ~CM_GCR_ERR_CONTROL_L2_ECC_EN_MSK;
+		write_gcr_err_control(gcr_ectl);
+		gcr_ectl = read_gcr_err_control();
+		gcr_ectl &= CM_GCR_ERR_CONTROL_L2_ECC_EN_MSK;
+		WARN_ON(!!gcr_ectl != l2parity);
+
+		pr_info("Cache parity protection %sabled\n",
+			l1parity ? "en" : "dis");
+		return;
+	}
+
 	switch (current_cpu_type()) {
 	case CPU_24K:
 	case CPU_34K:
@@ -1656,11 +1716,8 @@ static inline void parity_protection_init(void)
 	case CPU_PROAPTIV:
 	case CPU_P5600:
 	case CPU_QEMU_GENERIC:
-	case CPU_I6400:
 	case CPU_P6600:
 		{
-#define ERRCTL_PE	0x80000000
-#define ERRCTL_L2P	0x00800000
 			unsigned long errctl;
 			unsigned int l1parity_present, l2parity_present;
 
-- 
2.11.0
