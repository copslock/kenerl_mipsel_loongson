Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Aug 2008 22:38:54 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.134]:1202 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S28575103AbYH1Viu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 28 Aug 2008 22:38:50 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id D7B9A320C3B;
	Thu, 28 Aug 2008 21:38:54 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [173.8.135.205])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Thu, 28 Aug 2008 21:38:54 +0000 (UTC)
Received: from silver64.hq2.avtrex.com ([192.168.7.14]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 28 Aug 2008 14:38:38 -0700
Message-ID: <48B71ADD.601@avtrex.com>
Date:	Thu, 28 Aug 2008 14:38:37 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Cc:	linux-kernel@vger.kernel.org
Subject: [Patch 0/6] MIPS: Hardware watch register support for gdb (version
 3).
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Aug 2008 21:38:38.0209 (UTC) FILETIME=[6E79E710:01C90956]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20379
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Esteemed kernel hackers,

To follow is my third pass at MIPS watch register support.

This version has been tested on:

* MIPS 4KEc (mips32) with a single set of watch registers watchhi not
  reporting I, R, and W conditions.

* MIPS 4KEc (mips32r2) with four sets of watch registers.

* R5000 SGI O2 (mips4 64bit) with no watch register support.

The patches are against 2.6.27-rc4


Changes from the previous version:

* Agreement from gdb maintainers that the ptrace interface is
  workable.

* Work around for watchhi registers that do not report the I, R, and W
  condition bits.

* General cleanup, including making much less code conditionally
  compiled.

To really test the patch you will need a patched gdb.  My current gdb
patch is here:

http://sourceware.org/ml/gdb-patches/2008-08/msg00650.html

If you have any comments or questions please let me know.

David Daney
