Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Aug 2003 09:25:44 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:5647
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225207AbTHAIZl>; Fri, 1 Aug 2003 09:25:41 +0100
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 1 Aug 2003 08:25:40 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.9/8.12.9) with ESMTP id h718P5DV076264;
	Fri, 1 Aug 2003 17:25:05 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Fri, 01 Aug 2003 17:26:23 +0900 (JST)
Message-Id: <20030801.172623.85417982.nemoto@toshiba-tops.co.jp>
To: jsun@mvista.com
Cc: macro@ds2.pg.gda.pl, linux-mips@linux-mips.org
Subject: Re: Malta + USB on 2.4, anyone?
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20030731111506.F14914@mvista.com>
References: <Pine.GSO.3.96.1030731121705.17497D-100000@delta.ds2.pg.gda.pl>
	<20030731103629.D14914@mvista.com>
	<20030731111506.F14914@mvista.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2956
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Thu, 31 Jul 2003 11:15:06 -0700, Jun Sun <jsun@mvista.com> said:
jsun> I suspect the main UHCI driver does not get cache flushing or
jsun> bus/virt address right.

It seems usb_control_msg is not safe with an unaligned buffer.  Is
this patch solve your problem?

diff -u linux-2.4.21/drivers/usb/usb.c linux/drivers/usb/usb.c
--- linux-2.4.21/drivers/usb/usb.c	Tue Jul 15 13:49:34 2003
+++ linux/drivers/usb/usb.c	Tue Jul 15 21:20:44 2003
@@ -1172,9 +1172,24 @@
 {
 	struct usb_ctrlrequest *dr = kmalloc(sizeof(struct usb_ctrlrequest), GFP_KERNEL);
 	int ret;
+#ifdef __mips__ /* BUG??? */
+	void *tmpdata = NULL;
+#endif
 	
 	if (!dr)
 		return -ENOMEM;
+#ifdef __mips__ /* BUG??? */
+	if (size) {
+		tmpdata = kmalloc(size, GFP_KERNEL);
+		if (!data) {
+			kfree(dr);
+			return -ENOMEM;
+		}
+		memcpy(tmpdata, data, size);
+	} else {
+		tmpdata = data;
+	}
+#endif
 
 	dr->bRequestType = requesttype;
 	dr->bRequest = request;
@@ -1184,7 +1199,15 @@
 
 	//dbg("usb_control_msg");	
 
+#ifdef __mips__ /* BUG??? */
+	ret = usb_internal_control_msg(dev, pipe, dr, tmpdata, size, timeout);
+	if (size) {
+		memcpy(data, tmpdata, size);
+		kfree(tmpdata);
+	}
+#else
 	ret = usb_internal_control_msg(dev, pipe, dr, data, size, timeout);
+#endif
 
 	kfree(dr);
 
---
Atsushi Nemoto
