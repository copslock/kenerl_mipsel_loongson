Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2009 13:41:56 +0100 (WEST)
Received: from hera.kernel.org ([140.211.167.34]:58660 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20022565AbZFDMlt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 Jun 2009 13:41:49 +0100
Received: from [192.168.1.220] (triband-del-59.180.95.155.bol.net.in [59.180.95.155] (may be forged))
	(authenticated bits=0)
	by hera.kernel.org (8.14.2/8.13.8) with ESMTP id n54Cf0bc012138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Thu, 4 Jun 2009 12:41:03 GMT
Subject: [PATCH 4/6] headers_check fix: mips, ioctl.h
From:	Jaswinder Singh Rajput <jaswinder@kernel.org>
To:	Sam Ravnborg <sam@ravnborg.org>
Cc:	Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>,
	Michael Abbott <michael@araneidae.co.uk>
In-Reply-To: <1244118714.5172.33.camel@ht.satnam>
References: <1244118232.5172.26.camel@ht.satnam>
	 <1244118476.5172.29.camel@ht.satnam>  <1244118599.5172.31.camel@ht.satnam>
	 <1244118714.5172.33.camel@ht.satnam>
Content-Type: text/plain
Date:	Thu, 04 Jun 2009 18:05:49 +0530
Message-Id: <1244118949.5172.37.camel@ht.satnam>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.5 (2.24.5-1.fc10) 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV 0.93.3/9419/Thu Jun  4 02:47:46 2009 on hera.kernel.org
X-Virus-Status:	Clean
Return-Path: <jaswinder@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23242
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaswinder@kernel.org
Precedence: bulk
X-list: linux-mips

Make ioctl.h compatible with asm-generic/ioctl.h and userspace

fix the following 'make headers_check' warning:

  usr/include/asm-mips/ioctl.h:64: extern's make no sense in userspace

Signed-off-by: Jaswinder Singh Rajput <jaswinderrajput@gmail.com>
---
 arch/mips/include/asm/ioctl.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/ioctl.h
b/arch/mips/include/asm/ioctl.h
index 85067e2..9161634 100644
--- a/arch/mips/include/asm/ioctl.h
+++ b/arch/mips/include/asm/ioctl.h
@@ -60,12 +60,16 @@
 	 ((nr)   << _IOC_NRSHIFT) | \
 	 ((size) << _IOC_SIZESHIFT))
 
+#ifdef __KERNEL__
 /* provoke compile error for invalid uses of size argument */
 extern unsigned int __invalid_size_argument_for_IOC;
 #define _IOC_TYPECHECK(t) \
 	((sizeof(t) == sizeof(t[1]) && \
 	  sizeof(t) < (1 << _IOC_SIZEBITS)) ? \
 	  sizeof(t) : __invalid_size_argument_for_IOC)
+#else
+#define _IOC_TYPECHECK(t)	(sizeof(t))
+#endif
 
 /* used to create numbers */
 #define _IO(type, nr)		_IOC(_IOC_NONE, (type), (nr), 0)
-- 
1.6.0.6
