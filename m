Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Mar 2008 14:50:11 +0000 (GMT)
Received: from mo30.po.2iij.net ([210.128.50.53]:15669 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S28579760AbYCLOuJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 12 Mar 2008 14:50:09 +0000
Received: by mo.po.2iij.net (mo30) id m2CEo5MC045702; Wed, 12 Mar 2008 23:50:05 +0900 (JST)
Received: from delta (224.24.30.125.dy.iij4u.or.jp [125.30.24.224])
	by mbox.po.2iij.net (po-mbox304) id m2CEo2dI031739
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 12 Mar 2008 23:50:03 +0900
Date:	Wed, 12 Mar 2008 23:50:02 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] fix the installation condition of MIPS clocksource
Message-Id: <20080312235002.c717dde3.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20080312140201.GA25986@linux-mips.org>
References: <20080218230459.35c2204b.yoichi_yuasa@tripeaks.co.jp>
	<20080312140201.GA25986@linux-mips.org>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.12.0; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18380
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

On Wed, 12 Mar 2008 14:02:01 +0000
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Mon, Feb 18, 2008 at 11:04:59PM +0900, Yoichi Yuasa wrote:
> 
> > MIPS clocksource has been installed on DEC 5000/200(R3000).
> > The installation condition of MIPS clocksource is wrong.
> 
> A bug indeed but I figured it was cleaner to have init_mips_clocksource()
> itself check for the presence of an r4k style counter like other
> device initialitation functions.  So I went for a different fix for
> both 2.6.24 and master.
> 
> Thanks for raising the issue,

I think it has a one more bug.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/kernel/time.c linux/arch/mips/kernel/time.c
--- linux-orig/arch/mips/kernel/time.c	2008-03-12 23:42:37.492242141 +0900
+++ linux/arch/mips/kernel/time.c	2008-03-12 23:44:47.819669076 +0900
@@ -157,6 +157,6 @@ void __init time_init(void)
 {
 	plat_time_init();
 
-	if (mips_clockevent_init() || !cpu_has_mfc0_count_bug())
+	if (!mips_clockevent_init() || !cpu_has_mfc0_count_bug())
 		init_mips_clocksource();
 }
