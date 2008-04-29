Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Apr 2008 02:22:15 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.144]:6552 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20204203AbYD2BWM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 29 Apr 2008 02:22:12 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id EB041319F7D;
	Tue, 29 Apr 2008 01:26:03 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Tue, 29 Apr 2008 01:26:03 +0000 (UTC)
Received: from dl2.hq2.avtrex.com ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 28 Apr 2008 18:21:55 -0700
Message-ID: <48167832.3090103@avtrex.com>
Date:	Mon, 28 Apr 2008 18:21:54 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Cc:	"Linux kernel" <linux-kernel@vger.kernel.org>
Subject: [Patch 0/6] MIPS Hardware watchpoint support for gdb (version 2).
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Apr 2008 01:21:55.0735 (UTC) FILETIME=[69A0A270:01C8A997]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19043
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

This is my second take at MIPS watch register support.

Changes from the previous version include:

* Change layout of structures used by ptrace to eliminate holes.

* Use [set|clear]_tsk_thread_flag() and friends instead of racy direct 
access.

* mips64 support (untested).

* Fix sparse warnings.

For this version of the patch you will need the corresponding gdb patch 
which can be found here:

http://sourceware.org/ml/gdb-patches/2008-04/msg00642.html

David Daney
