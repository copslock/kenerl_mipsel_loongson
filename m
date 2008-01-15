Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jan 2008 22:28:05 +0000 (GMT)
Received: from outbound-sin.frontbridge.com ([207.46.51.80]:16589 "EHLO
	outbound9-sin-R.bigfish.com") by ftp.linux-mips.org with ESMTP
	id S20039182AbYAOW14 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 15 Jan 2008 22:27:56 +0000
Received: from outbound9-sin.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound9-sin-R.bigfish.com (Postfix) with ESMTP id 7C95E1129BE4;
	Tue, 15 Jan 2008 22:27:47 +0000 (UTC)
Received: from mail63-sin-R.bigfish.com (unknown [10.3.40.3])
	by outbound9-sin.bigfish.com (Postfix) with ESMTP id 7A80844004C;
	Tue, 15 Jan 2008 22:27:47 +0000 (UTC)
Received: from mail63-sin (localhost.localdomain [127.0.0.1])
	by mail63-sin-R.bigfish.com (Postfix) with ESMTP id 4087912A01D9;
	Tue, 15 Jan 2008 22:27:47 +0000 (UTC)
X-BigFish: V
X-MS-Exchange-Organization-Antispam-Report: OrigIP: 160.33.66.75;Service: EHS
Received: by mail63-sin (MessageSwitch) id 1200436067248809_13784; Tue, 15 Jan 2008 22:27:47 +0000 (UCT)
Received: from mail8.fw-sd.sony.com (mail8.fw-sd.sony.com [160.33.66.75])
	by mail63-sin.bigfish.com (Postfix) with ESMTP id 70A331408060;
	Tue, 15 Jan 2008 22:27:46 +0000 (UTC)
Received: from mail1.bc.in.sel.sony.com (mail1.bc.in.sel.sony.com [43.144.65.111])
	by mail8.fw-sd.sony.com (8.12.11/8.12.11) with ESMTP id m0FMRiGu025399;
	Tue, 15 Jan 2008 22:27:45 GMT
Received: from USBMAXIM01.am.sony.com (us-east-xims.am.sony.com [43.145.108.25])
	by mail1.bc.in.sel.sony.com (8.12.11/8.12.11) with ESMTP id m0FMRh5O002058;
	Tue, 15 Jan 2008 22:27:44 GMT
Received: from usbmaxms05.am.sony.com ([43.145.108.36]) by USBMAXIM01.am.sony.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Tue, 15 Jan 2008 17:27:43 -0500
Received: from [43.135.148.120] ([43.135.148.120]) by usbmaxms05.am.sony.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 15 Jan 2008 17:27:43 -0500
Subject: [PATCH] kernel make error - smtc_ipi.h irq flags, 2.6.24-rc7
From:	Frank Rowand <frank.rowand@am.sony.com>
Reply-To: frank.rowand@am.sony.com
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
Content-Type: text/plain
Date:	Tue, 15 Jan 2008 14:26:44 -0800
Message-Id: <1200436004.4092.26.camel@bx740>
Mime-Version: 1.0
X-Mailer: Evolution 2.12.1 (2.12.1-3.fc8) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Jan 2008 22:27:43.0817 (UTC) FILETIME=[D8D68390:01C857C5]
Return-Path: <Frank_Rowand@sonyusa.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18067
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: frank.rowand@am.sony.com
Precedence: bulk
X-list: linux-mips

From: Frank Rowand <frank.rowand@am.sony.com>

Fix compile warning (which becomes compile error due to -Werror).  Type of
argument "flags" for spin_lock_irqsave() was incorrect in some functions.

Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
---
 include/asm-mips/smtc_ipi.h |    6 	3 +	3 -	0 !
 1 files changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6.24-rc7/include/asm-mips/smtc_ipi.h
===================================================================
--- linux-2.6.24-rc7.orig/include/asm-mips/smtc_ipi.h
+++ linux-2.6.24-rc7/include/asm-mips/smtc_ipi.h
@@ -49,7 +49,7 @@ struct smtc_ipi_q {
 
 static inline void smtc_ipi_nq(struct smtc_ipi_q *q, struct smtc_ipi *p)
 {
-	long flags;
+	unsigned long flags;
 
 	spin_lock_irqsave(&q->lock, flags);
 	if (q->head == NULL)
@@ -98,7 +98,7 @@ static inline struct smtc_ipi *smtc_ipi_
 
 static inline void smtc_ipi_req(struct smtc_ipi_q *q, struct smtc_ipi *p)
 {
-	long flags;
+	unsigned long flags;
 
 	spin_lock_irqsave(&q->lock, flags);
 	if (q->head == NULL) {
@@ -114,7 +114,7 @@ static inline void smtc_ipi_req(struct s
 
 static inline int smtc_ipi_qdepth(struct smtc_ipi_q *q)
 {
-	long flags;
+	unsigned long flags;
 	int retval;
 
 	spin_lock_irqsave(&q->lock, flags);
