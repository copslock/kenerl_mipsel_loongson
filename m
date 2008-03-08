Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Mar 2008 08:46:05 +0000 (GMT)
Received: from mo31.po.2iij.NET ([210.128.50.54]:51779 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S28644323AbYCHIp5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 8 Mar 2008 08:45:57 +0000
Received: by mo.po.2iij.net (mo31) id m288joOc076462; Sat, 8 Mar 2008 17:45:50 +0900 (JST)
Received: from delta (224.24.30.125.dy.iij4u.or.jp [125.30.24.224])
	by mbox.po.2iij.net (po-mbox303) id m288jmNa004540
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 8 Mar 2008 17:45:49 +0900
Date:	Sat, 8 Mar 2008 17:45:48 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>,
	Martin Michlmayr <tbm@cyrius.com>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org
Subject: [PATCH] Input: fix cobalt_btns loadable keymaps support
Message-Id: <20080308174548.c1de590f.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20080308074413.GA2581@deprecation.cyrius.com>
References: <20080307153256.GA8851@linux-mips.org>
	<20080308091947.4dc7a756.yoichi_yuasa@tripeaks.co.jp>
	<20080308074413.GA2581@deprecation.cyrius.com>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.12.0; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18362
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi,

On Sat, 8 Mar 2008 08:44:13 +0100
Martin Michlmayr <tbm@cyrius.com> wrote:

> * Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> [2008-03-08 09:19]:
> > > Maybe some Cobalt hacker can sort out these issues in the latest kernel.
> > > I could try to fix the build but don't have any Cobalt kit for testing ...
> > 
> > I already sent the patch to Dmitry Torokhov.
> > He said I will apply it.
> > But, it has not been applied yet.
> 
> That was quite a while ago, wasn't it?  Maybe you could ping him again
> or ask Ralf or Andrew to send the patch to Linus.

I sent a mail to him 10 days ago.
But, there is no reply.

Ralf,
Could you send the patch to Linus?

Yoichi

Fix cobalt_btns loadable keymaps support.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/drivers/input/misc/cobalt_btns.c linux/drivers/input/misc/cobalt_btns.c
--- linux-orig/drivers/input/misc/cobalt_btns.c	2008-02-10 20:16:54.621304697 +0900
+++ linux/drivers/input/misc/cobalt_btns.c	2008-02-10 23:02:30.875539556 +0900
@@ -1,7 +1,7 @@
 /*
  *  Cobalt button interface driver.
  *
- *  Copyright (C) 2007  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
+ *  Copyright (C) 2007-2008  Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -15,7 +15,7 @@
  *
  *  You should have received a copy of the GNU General Public License
  *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
+ *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 #include <linux/init.h>
 #include <linux/input-polldev.h>
@@ -55,7 +55,7 @@ static void handle_buttons(struct input_
 	status = ~readl(bdev->reg) >> 24;
 
 	for (i = 0; i < ARRAY_SIZE(bdev->keymap); i++) {
-		if (status & (1UL << i)) {
+		if (status & (1U << i)) {
 			if (++bdev->count[i] == BUTTONS_COUNT_THRESHOLD) {
 				input_event(input, EV_MSC, MSC_SCAN, i);
 				input_report_key(input, bdev->keymap[i], 1);
@@ -97,16 +97,16 @@ static int __devinit cobalt_buttons_prob
 	input->name = "Cobalt buttons";
 	input->phys = "cobalt/input0";
 	input->id.bustype = BUS_HOST;
-	input->cdev.dev = &pdev->dev;
+	input->dev.parent = &pdev->dev;
 
-	input->keycode = pdev->keymap;
-	input->keycodemax = ARRAY_SIZE(pdev->keymap);
+	input->keycode = bdev->keymap;
+	input->keycodemax = ARRAY_SIZE(bdev->keymap);
 	input->keycodesize = sizeof(unsigned short);
 
 	input_set_capability(input, EV_MSC, MSC_SCAN);
 	__set_bit(EV_KEY, input->evbit);
-	for (i = 0; i < ARRAY_SIZE(buttons_map); i++)
-		__set_bit(input->keycode[i], input->keybit);
+	for (i = 0; i < ARRAY_SIZE(cobalt_map); i++)
+		__set_bit(bdev->keymap[i], input->keybit);
 	__clear_bit(KEY_RESERVED, input->keybit);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
