Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Apr 2008 00:21:06 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.144]:5603 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20042941AbYDUXVD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 22 Apr 2008 00:21:03 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 93131318CA0;
	Mon, 21 Apr 2008 23:22:30 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Mon, 21 Apr 2008 23:22:30 +0000 (UTC)
Received: from [192.168.7.54] ([192.168.7.54]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 21 Apr 2008 16:20:50 -0700
Message-ID: <480D2151.2020701@avtrex.com>
Date:	Mon, 21 Apr 2008 16:20:49 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 1.5.0.12 (X11/20071019)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Cc:	linux-kernel@vger.kernel.org
Subject: [Patch 0/6] MIPS Hardware watchpoint support for gdb.
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Apr 2008 23:20:50.0131 (UTC) FILETIME=[56193230:01C8A406]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18985
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

This series of patches adds hardware watch register support for MIPS to
the kernel.  This is kind of a chicken-and-egg type of problem as you
need gdb support to test it, but you cannot test gdb until the kernel
support is present.  These kernel patches are preliminary and
undoubtedly will need some tweaking.

If you want to test this out, you will need to build a suitable gdb
using the patch here:

http://sourceware.org/ml/gdb-patches/2008-04/msg00439.html

The patches are against current linux-mips.org (commit
096bc9f852d4e782b318218d82181f4b09bac63f)

My main test platform only runs 2.6.15, so I could not fully test them
in the current kernel.  I did test under Qemu, but since it lacks full
watch register support in mips, I could not verify that it really works
there.

Well without further ado, here they come.

David Daney
