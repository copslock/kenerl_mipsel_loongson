Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jan 2006 19:21:52 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:2317 "EHLO sorrow.cyrius.com")
	by ftp.linux-mips.org with ESMTP id S3468182AbWASTVe (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 19 Jan 2006 19:21:34 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 5719664D54; Thu, 19 Jan 2006 19:24:38 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 03380854A; Thu, 19 Jan 2006 19:24:14 +0000 (GMT)
Date:	Thu, 19 Jan 2006 19:24:14 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Fix a CPU definition for Cobalt
Message-ID: <20060119192414.GA26798@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10002
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

[mips] Fix a CPU definition for Cobalt

If cpu_icache_snoops_remote_store is not set, Cobalt will crash
immediately when starting the kernel.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>

--- a/include/asm-mips/mach-cobalt/cpu-feature-overrides.h~	2006-01-19 19:21:35.000000000 +0000
+++ b/include/asm-mips/mach-cobalt/cpu-feature-overrides.h	2006-01-19 19:21:41.000000000 +0000
@@ -45,7 +45,7 @@
 #define cpu_has_smartmips	0
 #define cpu_has_vtag_icache	0
 #define cpu_has_ic_fills_f_dc	0
-#define cpu_icache_snoops_remote_store	0
+#define cpu_icache_snoops_remote_store	1
 #define cpu_has_dsp		0
 
 #define cpu_has_mips32r1	0

-- 
Martin Michlmayr
http://www.cyrius.com/
