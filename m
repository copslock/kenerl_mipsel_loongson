Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Feb 2005 19:57:27 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:29178 "EHLO
	prometheus.mvista.com") by linux-mips.org with ESMTP
	id <S8225266AbVBAT5L>; Tue, 1 Feb 2005 19:57:11 +0000
Received: from prometheus.mvista.com (localhost.localdomain [127.0.0.1])
	by prometheus.mvista.com (8.12.8/8.12.8) with ESMTP id j11JvAdh005504;
	Tue, 1 Feb 2005 11:57:10 -0800
Received: (from mlachwani@localhost)
	by prometheus.mvista.com (8.12.8/8.12.8/Submit) id j11Jv9wK005502;
	Tue, 1 Feb 2005 11:57:09 -0800
Date:	Tue, 1 Feb 2005 11:57:09 -0800
From:	Manish Lachwani <mlachwani@mvista.com>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, mlachwani@mvista.com
Subject: [PATCH] Fix compile errors for Sibyte
Message-ID: <20050201195709.GA4206@prometheus.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <mlachwani@prometheus.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7102
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ralf,

With the latest CVS, when compiling for Sibyte:

In file included from arch/mips/mm/cex-sb1.S:25:
include/asm/sibyte/board.h:19:1: unterminated #ifndef
make[1]: *** [arch/mips/mm/cex-sb1.o] Error 1
make: *** [arch/mips/mm] Error 2

Attached patch fixes it.

Thanks
Manish Lachwani

--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="common_mips_sibyte_compile.patch"

Index: linux/include/asm-mips/sibyte/board.h
===================================================================
--- linux.orig/include/asm-mips/sibyte/board.h
+++ linux/include/asm-mips/sibyte/board.h
@@ -52,4 +52,6 @@
 #define setleds(t0,t1,c0,c1,c2,c3)
 #endif /* LEDS_PHYS */
 
+#endif /* __ASSEMBLY__ */
+
 #endif /* _SIBYTE_BOARD_H */

--HcAYCG3uE/tztfnV--
