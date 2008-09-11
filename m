Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Sep 2008 06:34:56 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.134]:10430 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20135194AbYIKFey (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 11 Sep 2008 06:34:54 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id D8F7D320898;
	Thu, 11 Sep 2008 05:34:43 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [173.8.135.205])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Thu, 11 Sep 2008 05:34:43 +0000 (UTC)
Received: from silver64.hq2.avtrex.com ([192.168.7.222]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 10 Sep 2008 22:34:40 -0700
Message-ID: <48C8ADEF.9020305@avtrex.com>
Date:	Wed, 10 Sep 2008 22:34:39 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Cc:	linux-kernel@vger.kernel.org
Subject: [Patch 0/6] MIPS: Hardware watch register support for gdb (version
 4).
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Sep 2008 05:34:41.0024 (UTC) FILETIME=[169C5800:01C913D0]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20448
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Esteemed kernel hackers,

To follow is my forth pass at MIPS watch register support.

This version has been tested on:

* MIPS 4KEc (mips32) with a single set of watch registers watchhi not
  reporting I, R, and W conditions.

* MIPS 4KEc (mips32r2) with four sets of watch registers.

* R5000 SGI O2 (mips4 64bit) with no watch register support.

The patches are against 2.6.27-rc6

To use the patch you will need a suitably patched version of gdb.  The
patch against the HEAD of gdb's cvs can be found here:

http://sourceware.org/ml/gdb-patches/2008-09/msg00230.html

The previous version of this patch is here:
http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=48B71ADD.601%40avtrex.com

The main changes from the previous version are as follows...

* The characteristics of each watch register set are communicated via
  ptrace because according to the mips32 reference, each set can have
  different masks and I, R, W bit support.  Previously only the
  characteristics of the first set were returned.

* The alignment of the structures passed via ptrace are explicitly
  specified as various versions of gcc align 64-bit objects
  differently.

Six patches to follow.

Thanks
David Daney
