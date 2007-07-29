Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Jul 2007 11:42:37 +0100 (BST)
Received: from baikonur.stro.at ([213.239.196.228]:8709 "EHLO baikonur.stro.at")
	by ftp.linux-mips.org with ESMTP id S20022728AbXG2Kmf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 29 Jul 2007 11:42:35 +0100
Received: from stro.at (localhost [127.0.0.1])
	by baikonur.stro.at (Postfix) with ESMTP id B9C715C011;
	Sun, 29 Jul 2007 12:19:44 +0200 (CEST)
Received: by stro.at (Postfix, from userid 1000)
	id 85839181E6; Sun, 29 Jul 2007 11:52:17 +0200 (CEST)
Date:	Sun, 29 Jul 2007 11:52:17 +0200
From:	maximilian attems <max@stro.at>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, klibc@zytor.com, tbm@cyrius.com
Subject: klibc kernelheaders build failure on mips/mipsel
Message-ID: <20070729095217.GE7448@stro.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by Amavis (ClamAV) at stro.at
Return-Path: <max@stro.at>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15920
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: max@stro.at
Precedence: bulk
X-list: linux-mips

 switching to newer linux-libc-dev linux-2.6 provided kernel
 headers worked fine beside on mips mipsel:

  In file included from usr/klibc/arch/mips/crt0.S:11:
  usr/include/arch/mips/machine/asm.h:8:24: error: asm/regdef.h: No such
  file or directory
  usr/include/arch/mips/machine/asm.h:9:21: error: asm/asm.h: No such file
  or directory

  i'm not sure if you want to export both headers in the make
  kernelheaders target or if it is the fault of klibc to assume
  that those are available?

-- 
maks
