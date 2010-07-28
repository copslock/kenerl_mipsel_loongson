Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jul 2010 00:12:44 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:48778 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492164Ab0G1WMj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Jul 2010 00:12:39 +0200
Received: by wyb32 with SMTP id 32so876653wyb.36
        for <multiple recipients>; Wed, 28 Jul 2010 15:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:reply-to:content-type
         :content-transfer-encoding:message-id;
        bh=uFmvFdfMalQ3l6Ry6Fe8Wixf2f3krXSYBpD3KEV3f/E=;
        b=b0v1GpSLqSTWCyU9RXLwmyKHNy3IdrijuFjhiSSXPUPSiXEmA7duM6dGiamdXDrXct
         4GbcU8lUfkp0TDqNDA/VN/Y3WgoDsL7ygZwVfpgl/lXIyQyYdIjcCChYAxsUXg19EY1f
         0s3+1iGbVqvcY/AaQ+Z78Hryu7vtkXTAddijE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:reply-to
         :content-type:content-transfer-encoding:message-id;
        b=YoBfGqM+SXLZKWGcAClLVzBlBu4TbTI3y9bSEFA8cQ+qYYjF6Nl3QNW60tNTmyMHSo
         0037GWnFk1RrAV1czIDeSI04VX8IIUF6vuJC477hFpu/twnbam2l6gzuDsFJzAWACraj
         AENX4iDwcfElzgUwEbKkpxI2yGLZvEPNv8LuU=
Received: by 10.216.178.146 with SMTP id f18mr11199737wem.101.1280355154118;
        Wed, 28 Jul 2010 15:12:34 -0700 (PDT)
Received: from lenovo.localnet (florian.mimichou.net [88.178.11.95])
        by mx.google.com with ESMTPS id h37sm43897wej.23.2010.07.28.15.12.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Jul 2010 15:12:32 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
Date:   Thu, 29 Jul 2010 00:13:07 +0200
Subject: [PATCH] OCTEON: workaround linking failures with gcc-4.4.x 32-bits toolchains
MIME-Version: 1.0
X-UID:  141
X-Length: 2174
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        David Daney <ddaney@caviumnetworks.com>
Reply-To: Florian Fainelli <florian@openwrt.org>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201007290013.08797.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27513
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

When building with a gcc-4.4.x toolchain that is configured to produce 32-bits
executables by default, we will produce __lshrti3 in sched_clock() which is
never resolved so the kernel fails to link. Unconditionally use the inline
assembly version as suggested by David Daney, which works around the issue.

CC: David Daney <ddaney@caviumnetworks.com>
Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/cavium-octeon/csrc-octeon.c b/arch/mips/cavium-octeon/csrc-octeon.c
index 0bf4bbe..36400d2 100644
--- a/arch/mips/cavium-octeon/csrc-octeon.c
+++ b/arch/mips/cavium-octeon/csrc-octeon.c
@@ -53,7 +53,6 @@ static struct clocksource clocksource_mips = {
 unsigned long long notrace sched_clock(void)
 {
 	/* 64-bit arithmatic can overflow, so use 128-bit.  */
-#if (__GNUC__ < 4) || ((__GNUC__ == 4) && (__GNUC_MINOR__ <= 3))
 	u64 t1, t2, t3;
 	unsigned long long rv;
 	u64 mult = clocksource_mips.mult;
@@ -73,13 +72,6 @@ unsigned long long notrace sched_clock(void)
 		: [cnt] "r" (cnt), [mult] "r" (mult), [shift] "r" (shift)
 		: "hi", "lo");
 	return rv;
-#else
-	/* GCC > 4.3 do it the easy way.  */
-	unsigned int __attribute__((mode(TI))) t;
-	t = read_c0_cvmcount();
-	t = t * clocksource_mips.mult;
-	return (unsigned long long)(t >> clocksource_mips.shift);
-#endif
 }
 
 void __init plat_time_init(void)
