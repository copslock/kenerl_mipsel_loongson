Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Dec 2004 23:57:00 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:25587 "EHLO
	prometheus.mvista.com") by linux-mips.org with ESMTP
	id <S8225311AbULOX4q>; Wed, 15 Dec 2004 23:56:46 +0000
Received: from prometheus.mvista.com (localhost.localdomain [127.0.0.1])
	by prometheus.mvista.com (8.12.8/8.12.8) with ESMTP id iBFNuXdh012392;
	Wed, 15 Dec 2004 15:56:33 -0800
Received: (from mlachwani@localhost)
	by prometheus.mvista.com (8.12.8/8.12.8/Submit) id iBFNuWju012380;
	Wed, 15 Dec 2004 15:56:32 -0800
Date: Wed, 15 Dec 2004 15:56:32 -0800
From: Manish Lachwani <mlachwani@mvista.com>
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org, mlachwani@mvista.com
Subject: [PATCH] Avoid compile warnings on Sibyte using 2.6.10-rc3
Message-ID: <20041215235632.GA11386@prometheus.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <mlachwani@prometheus.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6684
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ralf,

The attached patch is needed to prevent the compilation warnings that
occur when using 2.6.10-rc3 on Sibyte. Please review 

Thanks
Manish Lachwani


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=patch-2610rc3-sibyte

--- include/asm-mips/cpu-features.h.orig	2004-12-15 11:18:23.000000000 -0800
+++ include/asm-mips/cpu-features.h	2004-12-15 11:18:43.000000000 -0800
@@ -92,8 +92,10 @@
 #define cpu_icache_snoops_remote_store	(cpu_data[0].icache.flags & MIPS_IC_SNOOPS_REMOTE)
 #endif
 #else
+#ifndef cpu_icache_snoops_remote_store
 #define cpu_icache_snoops_remote_store	1
 #endif
+#endif
 
 /*
  * Certain CPUs may throw bizarre exceptions if not the whole cacheline

--OXfL5xGRrasGEqWY--
