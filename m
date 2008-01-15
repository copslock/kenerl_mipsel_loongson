Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jan 2008 22:30:28 +0000 (GMT)
Received: from mail-dub.bigfish.com ([213.199.154.10]:42100 "EHLO
	mail17-dub-R.bigfish.com") by ftp.linux-mips.org with ESMTP
	id S20039257AbYAOWaS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 15 Jan 2008 22:30:18 +0000
Received: from mail17-dub (localhost.localdomain [127.0.0.1])
	by mail17-dub-R.bigfish.com (Postfix) with ESMTP id 98FF412E0408;
	Tue, 15 Jan 2008 22:30:12 +0000 (UTC)
X-BigFish: V
X-MS-Exchange-Organization-Antispam-Report: OrigIP: 160.33.98.75;Service: EHS
Received: by mail17-dub (MessageSwitch) id 1200436211182596_5489; Tue, 15 Jan 2008 22:30:11 +0000 (UCT)
Received: from mail8.fw-bc.sony.com (mail8.fw-bc.sony.com [160.33.98.75])
	by mail17-dub.bigfish.com (Postfix) with ESMTP id 06E6C1330083;
	Tue, 15 Jan 2008 22:30:09 +0000 (UTC)
Received: from mail1.bc.in.sel.sony.com (mail1.bc.in.sel.sony.com [43.144.65.111])
	by mail8.fw-bc.sony.com (8.12.11/8.12.11) with ESMTP id m0FMU0Sb015173;
	Tue, 15 Jan 2008 22:30:00 GMT
Received: from USBMAXIM02.am.sony.com ([43.145.108.26])
	by mail1.bc.in.sel.sony.com (8.12.11/8.12.11) with ESMTP id m0FMU0ZE003413;
	Tue, 15 Jan 2008 22:30:00 GMT
Received: from usbmaxms05.am.sony.com ([43.145.108.36]) by USBMAXIM02.am.sony.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Tue, 15 Jan 2008 17:30:00 -0500
Received: from [43.135.148.120] ([43.135.148.120]) by usbmaxms05.am.sony.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 15 Jan 2008 17:29:59 -0500
Subject: [PATCH 0/4] implement KGDB on Toshiba RBTX4927, 2.6.24-rc7
From:	Frank Rowand <frank.rowand@am.sony.com>
Reply-To: frank.rowand@am.sony.com
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
Content-Type: text/plain
Date:	Tue, 15 Jan 2008 14:28:59 -0800
Message-Id: <1200436139.4092.30.camel@bx740>
Mime-Version: 1.0
X-Mailer: Evolution 2.12.1 (2.12.1-3.fc8) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Jan 2008 22:29:59.0723 (UTC) FILETIME=[29D81FB0:01C857C6]
Return-Path: <Frank_Rowand@sonyusa.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18068
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: frank.rowand@am.sony.com
Precedence: bulk
X-list: linux-mips

From: Frank Rowand <frank.rowand@am.sony.com>

This set of patches adds support of KGDB on Toshiba RBTX4927 board.

Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
---
