Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Jun 2006 04:19:45 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:59082 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8126483AbWFRDTg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 18 Jun 2006 04:19:36 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k5I3JbIR022383
	for <linux-mips@linux-mips.org>; Sun, 18 Jun 2006 04:19:37 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k5I3Jaup022382
	for linux-mips@linux-mips.org; Sun, 18 Jun 2006 04:19:36 +0100
Date:	Sun, 18 Jun 2006 04:19:36 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: 2.4 fixes in git
Message-ID: <20060618031936.GA21492@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11754
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Contrary to earlier announcements I commited a few Linux 2.4 fixes into
git.  The fixes are:

 o Crash fixes for kernels built with gcc 3.4.
   This does not fix all issues with gcc 3.4.  Some configuration might
   fail to link and there might be other, yet unknown problems so using
   an older compiler stays the safe bet.
 o Fix ordering of serial interfaces for Malta.  This makes sure the
   onboard serial really will be the console.
 o Support for a few CPU cards for Atlas and Malta that are supported
   in Linux 2.6.  Probably few people care but it's a big item for me,
   my usual Malta configuration didn't run 2.4 ...

  Ralf
