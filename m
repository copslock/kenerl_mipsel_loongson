Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Mar 2008 07:38:51 +0000 (GMT)
Received: from mo31.po.2iij.NET ([210.128.50.54]:62260 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20021872AbYCSHit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 19 Mar 2008 07:38:49 +0000
Received: by mo.po.2iij.net (mo31) id m2J7cjRB077153; Wed, 19 Mar 2008 16:38:45 +0900 (JST)
Received: from localhost (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox304) id m2J7choL017852
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 19 Mar 2008 16:38:44 +0900
Message-Id: <200803190738.m2J7choL017852@po-mbox304.hop.2iij.net>
Date:	Wed, 19 Mar 2008 16:38:47 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH][MIPS] add CP0 hazard to CP0 compare register accesses
In-Reply-To: <20080318132709.GC11382@linux-mips.org>
References: <20080317234740.705a8a34.yoichi_yuasa@tripeaks.co.jp>
	<20080317161635.GA25549@linux-mips.org>
	<200803180447.m2I4lJ40005091@po-mbox301.hop.2iij.net>
	<20080318132709.GC11382@linux-mips.org>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18438
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi,

On Tue, 18 Mar 2008 13:27:09 +0000
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Tue, Mar 18, 2008 at 01:47:20PM +0900, Yoichi Yuasa wrote:
> 
> > On Mon, 17 Mar 2008 16:16:35 +0000
> > Ralf Baechle <ralf@linux-mips.org> wrote:
> > 
> > > On Mon, Mar 17, 2008 at 11:47:40PM +0900, Yoichi Yuasa wrote:
> > > 
> > > > VR41xx, CP0 hazard is necessary between read_c0_count() and write_c0_compare().
> > > 
> > > Interesting.  I wonder why you need this patch but nobody else?
> > 
> > Three NOP are necessary on the TB0287(VR4131 board).
> 
> That much was obvious from your patch.  I was more wondering about this
> change:
> 
> -               write_c0_compare(read_c0_count());
> +               c0_timer_ack();
> 
> c0_timer_ack is defined as
> 
> static void c0_timer_ack(void)
> {
>         write_c0_compare(read_c0_compare());
> }
> 
> so your patch does a functional change there - even though it should not
> actually matter.  So I was wondering if for some reason you need that
> change.

OK, update my patch.
Two patches have been brought together in one.

How about this?

VR41xx, CP0 hazard is necessary between read_c0_count() and write_c0_compare()
(or read_c0_cause()).

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/arch/mips/kernel/cevt-r4k.c linux/arch/mips/kernel/cevt-r4k.c
--- linux-orig/arch/mips/kernel/cevt-r4k.c	2008-03-19 11:35:53.017749179 +0900
+++ linux/arch/mips/kernel/cevt-r4k.c	2008-03-19 16:31:29.617938142 +0900
@@ -186,7 +186,9 @@ static int c0_compare_int_usable(void)
 	 * IP7 already pending?  Try to clear it by acking the timer.
 	 */
 	if (c0_compare_int_pending()) {
-		write_c0_compare(read_c0_count());
+		cnt = read_c0_count();
+		back_to_back_c0_hazard();
+		write_c0_compare(cnt);
 		irq_disable_hazard();
 		if (c0_compare_int_pending())
 			return 0;
@@ -205,10 +207,13 @@ static int c0_compare_int_usable(void)
 	while ((int)(read_c0_count() - cnt) <= 0)
 		;	/* Wait for expiry  */
 
+	back_to_back_c0_hazard();
 	if (!c0_compare_int_pending())
 		return 0;
 
-	write_c0_compare(read_c0_count());
+	cnt = read_c0_count();
+	back_to_back_c0_hazard();
+	write_c0_compare(cnt);
 	irq_disable_hazard();
 	if (c0_compare_int_pending())
 		return 0;
