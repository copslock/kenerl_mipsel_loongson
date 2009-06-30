Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Jun 2009 10:24:19 +0200 (CEST)
Received: from mailout01.rmx.de ([217.111.120.9]:49926 "EHLO mailout01.rmx.de"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492172AbZF3IYM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 30 Jun 2009 10:24:12 +0200
Received: from [172.19.17.48] (HELO kdin01.retarus.de)
  by mailout01.rmx.de (CommuniGate Pro SMTP 5.2.13 _community_)
  with ESMTP id 41009566; Tue, 30 Jun 2009 10:19:01 +0200
Received: from bzvsmg91.dmzext.sys.sphairon.com (mail01.pmns.de [195.243.125.132])
	by kdin01.retarus.de (8.14.2/8.14.2/retarus.custom) with SMTP id n5U8J0rE017521;
	Tue, 30 Jun 2009 10:19:00 +0200
Received: from bzsvex01.sas.sys.sphairon.com (bzsvex01.sas.sys.sphairon.com [10.158.5.101])
	by bzvsmg91.dmzext.sys.sphairon.com (Postfix) with ESMTP id DE27660566;
	Tue, 30 Jun 2009 10:17:43 +0200 (CEST)
Received: from [10.158.7.50] (10.158.7.50) by bzsvex01.sas.sys.sphairon.com
 (10.158.5.101) with Microsoft SMTP Server (TLS) id 8.1.358.0; Tue, 30 Jun
 2009 10:18:59 +0200
Message-ID: <4A49CA71.9000604@sphairon.com>
Date:	Tue, 30 Jun 2009 10:18:57 +0200
From:	Frank Seidel <Frank.Seidel@sphairon.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090318)
MIME-Version: 1.0
To:	Willy Tarreau <w@1wt.eu>
CC:	"Seidel, Frank" <Frank.Seidel@sphairon.com>,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: [PATCH] linux-2.4: usb: pr_debug ehci structure bug
X-Enigmail-Version: 0.95.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-RMX-ID: 20090630-101900-n5U8J0rE017521-0@kdin01
X-RMX-TRACE: 2009-06-30 10:19:01 RmxMSO@kdin01/mailcc08 [0.1s] 20090630-101900-n5U8J0rE017521-0@kdin01 0:00:01
X-RMX-TRACE: 2009-06-30 10:19:01 KdIn@kdin01/mailcc01 [0.7s] 20090630-101900-n5U8J0rE017521-0@kdin01 0:00:00
Return-Path: <Frank.Seidel@sphairon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23541
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Frank.Seidel@sphairon.com
Precedence: bulk
X-list: linux-mips

From: Mario Witkowski <witkowsm@sphairon.com>

Ehci structure bug on pr_debug.

Signed-off-by: Mario Witkowski <witkowsm@sphairon.com>
Signed-off-by: Frank Seidel <Frank.Seidel@sphairon.com>
---
 drivers/usb/host/ehci-sched.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/host/ehci-sched.c
+++ b/drivers/usb/host/ehci-sched.c
@@ -888,7 +888,7 @@ itd_stream_schedule (
 				stream->rescheduled++;
 				pr_debug ("ehci %s devpath %d "
 					"iso%d%s %d.%d skip %d.%d\n",
-					ehci->pdev->slot_name,
+					ehci->hcd.pdev->slot_name,
 					urb->dev->devpath,
 					stream->bEndpointAddress & 0x0f,
 					(stream->bEndpointAddress & USB_DIR_IN)
