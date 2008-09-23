Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Sep 2008 08:02:30 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.134]:7046 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20183260AbYIWHCX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 23 Sep 2008 08:02:23 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 8D41A3213C0
	for <linux-mips@linux-mips.org>; Tue, 23 Sep 2008 07:02:13 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [173.8.135.205])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP
	for <linux-mips@linux-mips.org>; Tue, 23 Sep 2008 07:02:13 +0000 (UTC)
Received: from silver64.hq2.avtrex.com ([192.168.7.229]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 23 Sep 2008 00:02:08 -0700
Message-ID: <48D89470.5090404@avtrex.com>
Date:	Tue, 23 Sep 2008 00:02:08 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Patch 0/6] MIPS: Hardware watch register support for gdb (version
 5).
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Sep 2008 07:02:08.0780 (UTC) FILETIME=[4B795CC0:01C91D4A]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20593
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Esteemed kernel hackers,

To follow is my fifth pass at MIPS watch register support.

The differences from the previous version: 
http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=48C8ADEF.9020305%40avtrex.com

* Respun against linux-queue.

* Clear the WP bit in cause register on watch exception.

The corresponding GDB patch is here:

http://sourceware.org/ml/gdb-patches/2008-09/msg00230.html

Six patches to follow.

Thanks
David Daney
