Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Apr 2004 05:58:50 +0100 (BST)
Received: from [IPv6:::ffff:213.188.213.77] ([IPv6:::ffff:213.188.213.77]:39324
	"EHLO server1.navynet.it") by linux-mips.org with ESMTP
	id <S8225766AbUDLE6s>; Mon, 12 Apr 2004 05:58:48 +0100
Received: from localhost (server1 [127.0.0.1])
	by server1.navynet.it (Postfix) with ESMTP id A831F84008
	for <linux-mips@linux-mips.org>; Mon, 12 Apr 2004 06:58:39 +0200 (CEST)
Received: from server1.navynet.it ([127.0.0.1])
 by localhost (server1 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 17933-05 for <linux-mips@linux-mips.org>;
 Mon, 12 Apr 2004 06:58:37 +0200 (CEST)
Received: from guendalin (host12-150.pool8175.interbusiness.it [81.75.150.12])
	by server1.navynet.it (Postfix) with ESMTP id CFC7B84029
	for <linux-mips@linux-mips.org>; Mon, 12 Apr 2004 06:58:23 +0200 (CEST)
From: "Massimo Cetra" <mcetra@navynet.it>
To: <linux-mips@linux-mips.org>
Subject: Raq2 & 2.6.4 : Strange output fro msomewhere
Date: Mon, 12 Apr 2004 06:58:20 +0100
Message-ID: <000301c42053$2ae67fe0$e60a0a0a@guendalin>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Virus-Scanned: by amavisd-new-20030616-p3 (Navynet) at navynet.it
Return-Path: <mcetra@navynet.it>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4751
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcetra@navynet.it
Precedence: bulk
X-list: linux-mips

Hi!

(i'm new here).
I have managed to compile CVS kernels for 2.6.4 and 2.4.25 trees on my
Raq2... And they work great.

Now...
Under heavy load (generating kernel_headers debian package), i saw the
following:

-cobalt:/proc# uptime
Unknown HZ value! (79) Assume 100.
 06:54:27 up 14 min,  2 users,  load average: 1.77, 1.37, 0.69
cobalt:/proc# sar 2 2
Linux 2.6.4 (cobalt)    04/12/04

06:54:32          CPU     %user     %nice   %system     %idle
06:54:34          all     18.31      0.00     81.69      0.00
06:54:36          all     16.67      0.00     83.33      0.00
Average:          all     17.60      0.00     82.40      0.00
cobalt:/proc# uname -a
Linux cobalt 2.6.4 #2 Mon Apr 12 05:50:49 CEST 2004 mips unknown
cobalt:/proc#


What is : "Unknown HZ value! (79) Assume 100." ????????????????????????

Thanks..

 Massimo
