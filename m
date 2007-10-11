Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Oct 2007 15:01:35 +0100 (BST)
Received: from mo32.po.2iij.NET ([210.128.50.17]:40754 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20021626AbXJKOB1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 11 Oct 2007 15:01:27 +0100
Received: by mo.po.2iij.net (mo32) id l9BE1On8028109; Thu, 11 Oct 2007 23:01:24 +0900 (JST)
Received: from delta (221.25.30.125.dy.iij4u.or.jp [125.30.25.221])
	by mbox.po.2iij.net (po-mbox303) id l9BE1F96030955
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 11 Oct 2007 23:01:17 +0900
Date:	Thu, 11 Oct 2007 23:01:15 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] fix wrong variable in rtc_mips_set_time() for
 yosemite
Message-Id: <20071011230115.2e2b86df.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.0 (GTK+ 2.10.11; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16965
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Fix wrong variable in rtc_mips_set_time() for yosemite.

arch/mips/pmc-sierra/yosemite/setup.c: In function 'rtc_mips_set_time':
arch/mips/pmc-sierra/yosemite/setup.c:107: error: 'sec' undeclared (first use in this function)
arch/mips/pmc-sierra/yosemite/setup.c:107: error: (Each undeclared identifier is reported only once
arch/mips/pmc-sierra/yosemite/setup.c:107: error: for each function it appears in.)
make[1]: *** [arch/mips/pmc-sierra/yosemite/setup.o] Error 1

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/pmc-sierra/yosemite/setup.c mips/arch/mips/pmc-sierra/yosemite/setup.c
--- mips-orig/arch/mips/pmc-sierra/yosemite/setup.c	2007-10-03 15:50:23.465579250 +0900
+++ mips/arch/mips/pmc-sierra/yosemite/setup.c	2007-10-04 10:04:04.988276750 +0900
@@ -104,7 +104,7 @@ int rtc_mips_set_time(unsigned long tim)
 	 * Convert to a more useful format -- note months count from 0
 	 * and years from 1900
 	 */
-	rtc_time_to_tm(sec, &tm);
+	rtc_time_to_tm(tim, &tm);
 	tm.tm_year += 1900;
 	tm.tm_mon += 1;
 
