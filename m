Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Dec 2006 09:15:27 +0000 (GMT)
Received: from david.siemens.com.cn ([194.138.202.53]:3809 "EHLO
	david.siemens.com.cn") by ftp.linux-mips.org with ESMTP
	id S20038753AbWLCJPV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 3 Dec 2006 09:15:21 +0000
Received: from ns.siemens.com.cn (ns.siemens.com.cn [194.138.237.52])
	by david.siemens.com.cn (8.11.7/8.11.7) with ESMTP id kB39FCJ10774
	for <linux-mips@linux-mips.org>; Sun, 3 Dec 2006 17:15:17 +0800 (CST)
Received: from pekw905a.cn001.siemens.net (localhost [127.0.0.1])
	by ns.siemens.com.cn (8.11.7/8.11.7) with ESMTP id kB39FA111959
	for <linux-mips@linux-mips.org>; Sun, 3 Dec 2006 17:15:12 +0800 (CST)
Received: from PEKW934A.cn001.siemens.net ([139.24.236.66]) by pekw905a.cn001.siemens.net with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 3 Dec 2006 17:15:09 +0800
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: The difference between mips*-gnu and mips*-linux when configure tool-chain
Date:	Sun, 3 Dec 2006 17:15:07 +0800
Message-ID: <96E7D5519FC3D741BEE27AB88C7387970162312C@PEKW934A.cn001.siemens.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: The difference between mips*-gnu and mips*-linux when configure tool-chain
Thread-Index: AccWu4aqDG6I9o1bQbac0KZMM452qQ==
From:	"Fu, He Wei PSE NKG" <hewei.fu@siemens.com>
To:	<linux-mips@linux-mips.org>
X-OriginalArrivalTime: 03 Dec 2006 09:15:10.0124 (UTC) FILETIME=[8816CEC0:01C716BB]
Return-Path: <hewei.fu@siemens.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13326
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hewei.fu@siemens.com
Precedence: bulk
X-list: linux-mips

Hello everyone.At the time of building tool-chain for mips machine,we
can choose mips*-gnu or mips*-linux, I want to know what's the
difference between them? The original idea is that mips*-gnu for
developing firmware which has not OS-surport, and mips*-linux for
developing software on Linux, but it is not suitable for firmware such
as bootloaders.But now I think I'm not right,it seems that configure
with mips*-linux suit for both linux and bootloader, and configure with
mips*-gnu means build for OS such as IRIX surport, I'm not very
clearly,can anybody help me figour out the difference between them?
Thanks
